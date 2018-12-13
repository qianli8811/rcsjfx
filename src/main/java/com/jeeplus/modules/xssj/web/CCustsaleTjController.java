/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.xssj.web;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import com.jeeplus.modules.xssj.entity.CSxeduTj;
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
import com.jeeplus.modules.xssj.entity.CCustsaleTj;
import com.jeeplus.modules.xssj.service.CCustsaleTjService;

/**
 * 企业核心销售数据统计Controller
 * @author admin
 * @version 2018-03-20
 */
@Controller
@RequestMapping(value = "${adminPath}/xssj/cCustsaleTj")
public class CCustsaleTjController extends BaseController {

	@Autowired
	private CCustsaleTjService cCustsaleTjService;
	@ModelAttribute
	public CCustsaleTj get(@RequestParam(required=false) String id) {
		CCustsaleTj entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cCustsaleTjService.get(id);
		}
		if (entity == null){
			entity = new CCustsaleTj();
		}
		return entity;
	}
	
	/**
	 * 企业核心销售数据统计列表页面
	 */
	@RequiresPermissions("xssj:cCustsaleTj:list")
	@RequestMapping(value = {"list", ""})
	public String list(CCustsaleTj cCustsaleTj, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CCustsaleTj> page = cCustsaleTjService.findPage(new Page<CCustsaleTj>(request, response), cCustsaleTj);
		model.addAttribute("page", page);
		model.addAttribute("cCustsaleTj", cCustsaleTj);
		return "modules/xssj/cCustsaleTjList";
	}

	/**
	 * 查看，增加，编辑企业核心销售数据统计表单页面
	 */
	@RequiresPermissions(value={"xssj:cCustsaleTj:view","xssj:cCustsaleTj:add","xssj:cCustsaleTj:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(CCustsaleTj cCustsaleTj, Model model) {
		model.addAttribute("cCustsaleTj", cCustsaleTj);
		return "modules/xssj/cCustsaleTjForm";
	}

	/**
	 * 保存企业核心销售数据统计
	 */
	@RequiresPermissions(value={"xssj:cCustsaleTj:add","xssj:cCustsaleTj:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(CCustsaleTj cCustsaleTj, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, cCustsaleTj)){
			return form(cCustsaleTj, model);
		}
		if(!cCustsaleTj.getIsNewRecord()){//编辑表单保存
			CCustsaleTj t = cCustsaleTjService.get(cCustsaleTj.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(cCustsaleTj, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			cCustsaleTjService.save(t);//保存
		}else{//新增表单保存
			cCustsaleTjService.save(cCustsaleTj);//保存
		}
		addMessage(redirectAttributes, "保存企业核心销售数据统计成功");
		return "redirect:"+Global.getAdminPath()+"/xssj/cCustsaleTj/?repage";
	}
	
	/**
	 * 删除企业核心销售数据统计
	 */
	@RequiresPermissions("xssj:cCustsaleTj:del")
	@RequestMapping(value = "delete")
	public String delete(CCustsaleTj cCustsaleTj, RedirectAttributes redirectAttributes) {
		cCustsaleTjService.delete(cCustsaleTj);
		addMessage(redirectAttributes, "删除企业核心销售数据统计成功");
		return "redirect:"+Global.getAdminPath()+"/xssj/cCustsaleTj/?repage";
	}
	
	/**
	 * 批量删除企业核心销售数据统计
	 */
	@RequiresPermissions("xssj:cCustsaleTj:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			cCustsaleTjService.delete(cCustsaleTjService.get(id));
		}
		addMessage(redirectAttributes, "删除企业核心销售数据统计成功");
		return "redirect:"+Global.getAdminPath()+"/xssj/cCustsaleTj/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("xssj:cCustsaleTj:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(CCustsaleTj cCustsaleTj, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "企业核心销售数据统计"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<CCustsaleTj> page = cCustsaleTjService.findPage(new Page<CCustsaleTj>(request, response, -1), cCustsaleTj);
    		new ExportExcel("企业核心销售数据统计", CCustsaleTj.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出企业核心销售数据统计记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xssj/cCustsaleTj/?repage";
    }

	/**1
	 * 导入Excel数据

	 */
	@RequiresPermissions("xssj:cCustsaleTj:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<CCustsaleTj> list = ei.getDataList(CCustsaleTj.class);
			for (CCustsaleTj cCustsaleTj : list){
				try{
					cCustsaleTjService.save(cCustsaleTj);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条企业核心销售数据统计记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条企业核心销售数据统计记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入企业核心销售数据统计失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xssj/cCustsaleTj/?repage";
    }
	
	/**
	 * 下载导入企业核心销售数据统计数据模板
	 */
	@RequiresPermissions("xssj:cCustsaleTj:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "企业核心销售数据统计数据导入模板.xlsx";
    		List<CCustsaleTj> list = Lists.newArrayList();
    		new ExportExcel("企业核心销售数据统计数据", CCustsaleTj.class).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/xssj/cCustsaleTj/?repage";
    }
	
	@RequestMapping(value = "getSxedu")
	public String getSxedu(CSxeduTj csxeduTj, HttpServletRequest request, HttpServletResponse response, Model model) {
//		if(null == csxeduTj ){
//			csxeduTj = new CSxeduTj();
//		}
//		Calendar date = Calendar.getInstance();
//		int year = date.get(Calendar.YEAR);
//		csxeduTj.setNianfen(year);
//		String sfhz = csxeduTj.getSfhz();
//		if(StringUtils.isBlank(sfhz)){
//			csxeduTj.setSfhz("1");//已经合作的客户
//		}
//		String tjName = csxeduTj.getTjName();
//		if(StringUtils.isBlank(tjName)){
//			csxeduTj.setTjName("1");//统计字段,1年销售收入，2净值，3税额，4战略价金额
//		}
//		Integer yuefen = csxeduTj.getYuefen();
//		if(null == yuefen){
//			csxeduTj.setYuefen(date.get(Calendar.MONTH)+1);
//		}
//		Page<CsxeduTj> page  = cCustsaleTjService.getSxedu(new Page<CsxeduTj>(request, response),csxeduTj);
//		model.addAttribute("csxeduTj", csxeduTj);
//		model.addAttribute("page", page);
		return "modules/xssj/getSxedu";
	}
	
	
	
	
}