/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.xssj.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import com.alibaba.excel.EasyExcelFactory;
import com.alibaba.excel.metadata.Sheet;
import com.jeeplus.common.utils.CacheUtils;
import com.jeeplus.modules.xssj.entity.CCustsaleTj;
import com.jeeplus.modules.xssj.utils.CCustSaleListener;
import com.jeeplus.modules.xssj.utils.ListUtils;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
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
import com.jeeplus.modules.xssj.entity.CCustSale;
import com.jeeplus.modules.xssj.service.CCustSaleService;

/**
 * 企业核心数据Controller
 * @author admin
 * @version 2018-03-03
 */
@Controller
@RequestMapping(value = "${adminPath}/xssj/cCustSale")
public class CCustSaleController extends BaseController {
	@Autowired
	private CCustSaleService cCustSaleService;
	
	@ModelAttribute
	public CCustSale get(@RequestParam(required=false) String id) {
		CCustSale entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cCustSaleService.get(id);
		}
		if (entity == null){
			entity = new CCustSale();
		}
		return entity;
	}
	
	/**
	 * 企业核心数据列表页面
	 */
	@RequiresPermissions("xssj:cCustSale:list")
	@RequestMapping(value = {"list", ""})
	public String list(CCustSale cCustSale, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		if(null != cCustSale){
			Date beginFapiaoshiqi = cCustSale.getBeginFapiaoshiqi();
			Date endFapiaoshiqi = cCustSale.getEndFapiaoshiqi();
			if(null == beginFapiaoshiqi){
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(new Date());
				calendar.set(Calendar.DAY_OF_MONTH, 1);
				calendar.set(Calendar.HOUR_OF_DAY, 0);
				calendar.set(Calendar.MINUTE, 0);
				calendar.set(Calendar.SECOND, 0);
				Date time = calendar.getTime();
				cCustSale.setBeginFapiaoshiqi(time);
			}
			if(null==endFapiaoshiqi){
				Date date = new Date();
				cCustSale.setEndFapiaoshiqi(date);
			}
		}
		
		Page<CCustSale> page = cCustSaleService.findPage(new Page<CCustSale>(request, response), cCustSale);
		model.addAttribute("page", page).addAttribute("cCustSale",cCustSale);
		return "modules/xssj/cCustSaleList";
	}

	/**
	 * 查看，增加，编辑企业核心数据表单页面
	 */
	@RequiresPermissions(value={"xssj:cCustSale:view","xssj:cCustSale:add","xssj:cCustSale:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(CCustSale cCustSale, Model model) {
		model.addAttribute("cCustSale", cCustSale);
		return "modules/xssj/cCustSaleForm";
	}

	/**
	 * 保存企业核心数据
	 */
	@RequiresPermissions(value={"xssj:cCustSale:add","xssj:cCustSale:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(CCustSale cCustSale, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, cCustSale)){
			return form(cCustSale, model);
		}
		if(!cCustSale.getIsNewRecord()){//编辑表单保存
			CCustSale t = cCustSaleService.get(cCustSale.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(cCustSale, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			cCustSaleService.save(t);//保存
		}else{//新增表单保存
			cCustSaleService.save(cCustSale);//保存
		}
		addMessage(redirectAttributes, "保存企业核心数据成功");
		return "redirect:"+Global.getAdminPath()+"/xssj/cCustSale/?repage";
	}
	
	/**
	 * 删除企业核心数据
	 */
	@RequiresPermissions("xssj:cCustSale:del")
	@RequestMapping(value = "delete")
	public String delete(CCustSale cCustSale, RedirectAttributes redirectAttributes) {
		cCustSaleService.delete(cCustSale);
		addMessage(redirectAttributes, "删除企业核心数据成功");
		return "redirect:"+Global.getAdminPath()+"/xssj/cCustSale/?repage";
	}
	
	/**
	 * 批量删除企业核心数据
	 */
	@RequiresPermissions("xssj:cCustSale:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			cCustSaleService.delete(cCustSaleService.get(id));
		}
		addMessage(redirectAttributes, "删除企业核心数据成功");
		return "redirect:"+Global.getAdminPath()+"/xssj/cCustSale/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("xssj:cCustSale:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(CCustSale cCustSale, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "企业核心数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<CCustSale> page = cCustSaleService.findPage(new Page<CCustSale>(request, response, -1), cCustSale);
    		new ExportExcel("企业核心数据", CCustSale.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出企业核心数据记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xssj/cCustSale/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("xssj:cCustSale:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<CCustSale> list = ei.getDataList(CCustSale.class);
			for (CCustSale cCustSale : list){
				try{
					CCustSale cCustSale1 = cCustSaleService.get(cCustSale);
					if(null == cCustSale1){
						cCustSaleService.save(cCustSale);
						successNum++;
					}else {
						failureNum++;
					}
					
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条企业核心数据记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条企业核心数据记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入企业核心数据失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xssj/cCustSale/?repage";
    }
	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("xssj:cCustSale:import")
	@RequestMapping(value = "import2", method=RequestMethod.POST)
	@ResponseBody
	public String importFile2(MultipartFile file, RedirectAttributes redirectAttributes) throws IOException {
		InputStream inputStream = file.getInputStream();
		CCustSaleListener excelListener = new CCustSaleListener();
		EasyExcelFactory.readBySax(inputStream,new Sheet(1, 1), excelListener);
		List<String> errorMsg = excelListener.getErrorMsg();
		if(errorMsg!=null && errorMsg.size()>0){
			addMessage(redirectAttributes, "导入企业核心数据失败！失败信息："+errorMsg.toString());
			return "redirect:"+Global.getAdminPath()+"/xssj/cCustSale/?repage";
		}
		List<CCustSale> data = excelListener.getData();

		Map<String, Integer> countMap = (Map<String, Integer>)CacheUtils.get("c_cust_sale_import_count");
		//切割，每10000条插入一次
		List<List<CCustSale>> lists = ListUtils.splitList(data, 10000);
		int sum = 0;
		long startTime = System.currentTimeMillis();
		for(int i=0;i<lists.size();i++){
			long startTime1 = System.currentTimeMillis();
			int count = cCustSaleService.insertBatch(lists.get(i));
			sum += count;
			long endTime2 = System.currentTimeMillis();
			String result = "第"+sum+"条数据导入数据库完毕，用时："+(endTime2-startTime1)/1000+"s";
		}
		long endTime3 = System.currentTimeMillis();
		String result = "第"+sum+"条数据导入数据库完毕，用时："+(endTime3-startTime)/1000+"s";
		return "redirect:"+Global.getAdminPath()+"/xssj/cCustSale/?repage";
	}
	/**
	 * 下载导入企业核心数据数据模板
	 */
	@RequiresPermissions("xssj:cCustSale:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "企业核心数据数据导入模板.xlsx";
    		List<CCustSale> list = Lists.newArrayList(); 
    		new ExportExcel("", CCustSale.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xssj/cCustSale/?repage";
    }
	
	
	/**
	 * 下载导入企业核心数据数据模板
	 */
	@RequiresPermissions("xssj:cCustSale:view")
	@RequestMapping(value = "getXssjtj")
	public String getXssjtj(CCustsaleTj cCustsaleTj, Model model) {
		Date date = new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.set(date.getYear(), 0, 0);
		/*calendar.set(Calendar.DAY_OF_MONTH, 0);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);*/
		if (null != cCustsaleTj) {
			String beginNianfen = cCustsaleTj.getBeginNianfen();
			String endNianfen = cCustsaleTj.getEndNianfen();
			if (null == beginNianfen) {
				calendar.set(Calendar.YEAR, -1);
				Date time1 = calendar.getTime();
				//	CCustsaleTj.setBeginNianfen(time1);
			}
			if (null == endNianfen) {
				//	CCustsaleTj.setEndNianfen(new Date());
			}
			
			
		} else {
			cCustsaleTj = new CCustsaleTj();
			Date time2 = calendar.getTime();
			//CCustsaleTj.setEndNianfen(date);
			//CCustsaleTj.setBeginNianfen(time2);
		}
		if (null != cCustsaleTj.getTjname()) {
			cCustsaleTj.setTjname(1);//默认查询销售收入
		}
		if (StringUtils.isBlank(cCustsaleTj.getCkname())) {
		
			
		} else {
			List<CCustsaleTj> lists = cCustSaleService.getXssjtj(cCustsaleTj);
			
			model.addAttribute("cctjList", lists);
		}
		model.addAttribute("cCustsaleTj", cCustsaleTj);
		return "modules/xssj/getXssjtj";
	}
	/**
	 * 词汇联想
	 */
	
	/**
	 * @param searchName ajax提交上来的输入框的值
	 * @return  返回装有user对象的list的json字串
	 */
	@RequestMapping("/search")
	@ResponseBody
	public List<String> search(String searchName){
		
		List<Map<String,String>> lists = (List<Map<String,String>>)CacheUtils.get("cCustSaleAllNames");
		List<String> lists1 = new ArrayList<String>();
		if(null == lists || lists.size()<=0){
			lists = cCustSaleService.searchByLike(searchName);
			CacheUtils.put("cCustSaleAllNames",lists);
			
		}
		if(null != lists && lists.size()>0){
			lists.forEach(stringStringMap -> {
				stringStringMap.forEach((k,v)->{
					lists1.add(v);
				});
			});
		}
		return  lists1;
	}
}