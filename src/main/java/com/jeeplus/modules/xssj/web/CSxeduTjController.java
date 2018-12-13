/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.xssj.web;
import java.util.*;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import com.jeeplus.common.utils.CacheUtils;
import com.jeeplus.modules.xssj.schedule.CacheThread;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.jeeplus.common.utils.DateUtils;
import com.jeeplus.common.utils.MyBeanUtils;
import com.jeeplus.common.config.Global;
import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.web.BaseController;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.common.utils.excel.ExportExcel;
import com.jeeplus.common.utils.excel.ImportExcel;
import com.jeeplus.modules.xssj.entity.CSxeduTj;
import com.jeeplus.modules.xssj.service.CSxeduTjService;

/**
 * 授信额度统计Controller
 * @author admin
 * @version 2018-05-03
 */
@Controller
@RequestMapping(value = "${adminPath}/xssj/cSxeduTj")
public class CSxeduTjController extends BaseController {

	@Autowired
	private CSxeduTjService cSxeduTjService;

	private ScheduledExecutorService threadPoolService = Executors.newScheduledThreadPool(5);
	
	@ModelAttribute
	public CSxeduTj get(@RequestParam(required=false) String id) {
		CSxeduTj entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cSxeduTjService.get(id);
		}
		if (entity == null){
			entity = new CSxeduTj();
		}
		return entity;
	}
	/**
	 * 授信额度统计列表页面,不用存储过程计算授信的
	 */
	//@RequiresPermissions("xssj:cSxeduTj:getSxedu")
	@RequestMapping(value = {"getSxedu", ""})
	public String getSxedu(CSxeduTj cSxeduTj, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		if(null == cSxeduTj ){
			cSxeduTj = new CSxeduTj();
		}
		Calendar date = Calendar.getInstance();
		int year = date.get(Calendar.YEAR);
		cSxeduTj.setNianfen(year);
		Integer sfhz = cSxeduTj.getSfhz();
		if(null == sfhz || (sfhz != 0 && sfhz != 1)){
			cSxeduTj.setSfhz(1);//已经合作的客户
		}
		Integer yuefen = cSxeduTj.getYuefen();
		if(null == yuefen){
			yuefen = date.get(Calendar.MONTH)+1;
			//默认查询截止到当前月
			cSxeduTj.setYuefen(yuefen);
		}
		//授信额度
		
		Page<CSxeduTj> page1 = new Page<CSxeduTj>(request, response);
		String cSxeduKey = cSxeduTj.getCkName()+"_"+cSxeduTj.getNianfen()+"_"+cSxeduTj.getYuefen()+"_"+page1.getPageNo()+"_"+page1.getPageSize();
		Page<CSxeduTj> page = (Page<CSxeduTj>)CacheUtils.get(cSxeduKey);
		if(page==null || page.getList()==null || page.getList().size()<=0){
			page = cSxeduTjService.findPage(new Page<CSxeduTj>(request, response), cSxeduTj);
			CacheUtils.put(cSxeduKey,page);
			threadPoolService.schedule(new CacheThread(cSxeduKey),20, TimeUnit.MINUTES);//20分钟
		}

		String  maxDate = (String)CacheUtils.get("maxDate");
		if(StringUtils.isEmpty(maxDate)){
			maxDate= cSxeduTjService.getMaxDate();
			CacheUtils.put("maxDate",maxDate);
			threadPoolService.schedule(new CacheThread(cSxeduKey),10, TimeUnit.DAYS);//10天
		}
		String[] split = maxDate.split("-");
		int maxYueFen = Integer.valueOf(split[1]);
		/**
		 * 求只有数据的月份，例如数据库中的数据 发票最新时间为 11月，当前月份为12月，那么计算到11月份的数据
		 *
		 */
		if(yuefen > maxYueFen){
			cSxeduTj.setYuefen(maxYueFen);
		}
		//预算达成率
		Map<String, Object> ysdcl = (Map<String, Object>)CacheUtils.get("ysdcl");
		if(ysdcl == null || ysdcl.isEmpty()){
			ysdcl = cSxeduTjService.getZt(cSxeduTj);
			CacheUtils.put("ysdcl",ysdcl);
			threadPoolService.schedule(new CacheThread("ysdcl"),20, TimeUnit.MINUTES);
		}else {
			ysdcl = (Map<String, Object>)CacheUtils.get("ysdcl");
		}
		cSxeduTj.setYuefen(yuefen);
		model.addAttribute("cSxeduTj", cSxeduTj);
		model.addAttribute("page", page);
		model.addAttribute("ztds", ysdcl);
		return "modules/xssj/getSxedu";
	}
	/**
	 * 授信额度统计列表页面，使用存储过程计算授信额度
	 */
	@RequiresPermissions("xssj:cSxeduTj:list")
	@RequestMapping(value = {"list", ""})
	public String list(CSxeduTj cSxeduTj, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		if(null == cSxeduTj ){
			cSxeduTj = new CSxeduTj();
		}
		Calendar date = Calendar.getInstance();
		int year = date.get(Calendar.YEAR);
		cSxeduTj.setNianfen(year);
		Integer sfhz = cSxeduTj.getSfhz();
		if(null == sfhz || (sfhz != 0 && sfhz != 1)){
			cSxeduTj.setSfhz(1);//已经合作的客户
		}
//		String tjName = csxeduTj.getTjName();
//		if(StringUtils.isBlank(tjName)){
//			csxeduTj.setTjName("1");//统计字段,1年销售收入，2净值，3税额，4战略价金额
//		}
		Integer yuefen = cSxeduTj.getYuefen();
		
		if(null == yuefen){
			//默认查询截止到当前月
			cSxeduTj.setYuefen(date.get(Calendar.MONTH)+1);
		}
		/*Map<String, Object>  kehuztds = (Map<String, Object> )UserUtils.getCache("kehuztds_"+cSxeduTj.getYuefen());
		if(null == kehuztds || kehuztds.isEmpty()){
			kehuztds = cSxeduTjService.getZt(cSxeduTj);
			UserUtils.putCache("kehuztds_"+cSxeduTj.getYuefen(),kehuztds);
		}*/
		/*Object jzrq = kehuztds.get("jzrq");
		if(null != jzrq){
			String s = jzrq.toString();//日期
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			try {
				Date parse = sdf.parse(s);
				cSxeduTj.setYuefen(parse.getMonth()+1);//实际的销售数据最大日期（单位月）
			} catch (ParseException e) {
				e.printStackTrace();
				
			}
		}*/
		
		
		
		//Page<CSxeduTj> page = cSxeduTjService.findPage(new Page<CSxeduTj>(request, response), cSxeduTj);
		
		Page<CSxeduTj> cSxeduTjPage = new Page<>(request, response);
		
		
		Page page = new Page(cSxeduTjPage.getPageNo()-1,cSxeduTjPage.getPageSize());
		if(page.getPageNo() <= 0){
			page.setPageNo(1);
		}
		if(page.getPageSize() <= 0){
			page.setPageSize(Integer.valueOf(Global.getConfig("page.pageSize")));
		}
		page.setCall(true);
		cSxeduTj.setPage(page);
		
		
		List<List<HashMap<?,?>>> list = cSxeduTjService.getKeHuTj(cSxeduTj);
		
		Page page2 = new Page(page.getPageNo(),page.getPageSize(),Long.valueOf(list.get(1).get(0).get("count")+""),list.get(0));
		page2.initialize();
		
		model.addAttribute("cSxeduTj", cSxeduTj);
		model.addAttribute("ztds", list.get(2));
		model.addAttribute("page", page2);
		
		return "modules/xssj/cSxeduTjList";
	}

	/**
	 * 查看，增加，编辑授信额度统计表单页面
	 */
	@RequiresPermissions(value={"xssj:cSxeduTj:view","xssj:cSxeduTj:add","xssj:cSxeduTj:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(CSxeduTj cSxeduTj, Model model) {
		model.addAttribute("cSxeduTj", cSxeduTj);
		return "modules/xssj/cSxeduTjForm";
	}

	/**
	 * 保存授信额度统计
	 */
	@RequiresPermissions(value={"xssj:cSxeduTj:add","xssj:cSxeduTj:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(CSxeduTj cSxeduTj, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, cSxeduTj)){
			return form(cSxeduTj, model);
		}
		if(!cSxeduTj.getIsNewRecord()){//编辑表单保存
			CSxeduTj t = cSxeduTjService.get(cSxeduTj.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(cSxeduTj, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			cSxeduTjService.save(t);//保存
		}else{//新增表单保存
			cSxeduTjService.save(cSxeduTj);//保存
		}
		addMessage(redirectAttributes, "保存授信额度统计成功");
		return "redirect:"+Global.getAdminPath()+"/xssj/cSxeduTj/?repage";
	}
	
	/**
	 * 删除授信额度统计
	 */
	@RequiresPermissions("xssj:cSxeduTj:del")
	@RequestMapping(value = "delete")
	public String delete(CSxeduTj cSxeduTj, RedirectAttributes redirectAttributes) {
		cSxeduTjService.delete(cSxeduTj);
		addMessage(redirectAttributes, "删除授信额度统计成功");
		return "redirect:"+Global.getAdminPath()+"/xssj/cSxeduTj/?repage";
	}
	
	/**
	 * 批量删除授信额度统计
	 */
	@RequiresPermissions("xssj:cSxeduTj:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			cSxeduTjService.delete(cSxeduTjService.get(id));
		}
		addMessage(redirectAttributes, "删除授信额度统计成功");
		return "redirect:"+Global.getAdminPath()+"/xssj/cSxeduTj/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("xssj:cSxeduTj:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(CSxeduTj cSxeduTj, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			Calendar date = Calendar.getInstance();
			int year = date.get(Calendar.YEAR);
			cSxeduTj.setNianfen(year);
			
            String fileName = "授信额度统计"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<CSxeduTj> page = cSxeduTjService.findPage(new Page<CSxeduTj>(request, response, -1), cSxeduTj);
    		new ExportExcel("", CSxeduTj.class,1,cSxeduTj.getNianfen()).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出授信额度统计记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xssj/cSxeduTj/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("xssj:cSxeduTj:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<CSxeduTj> list = ei.getDataList(CSxeduTj.class);
			for (CSxeduTj cSxeduTj : list){
				try{
					cSxeduTjService.save(cSxeduTj);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条授信额度统计记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条授信额度统计记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入授信额度统计失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xssj/cSxeduTj/?repage";
    }
	
	/**
	 * 下载导入授信额度统计数据模板
	 */
	@RequiresPermissions("xssj:cSxeduTj:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "授信额度统计数据导入模板.xlsx";
    		List<CSxeduTj> list = Lists.newArrayList(); 
    		new ExportExcel("授信额度统计数据", CSxeduTj.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xssj/cSxeduTj/?repage";
    }
	
	
	

}