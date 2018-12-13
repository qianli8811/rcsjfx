/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.fptj.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

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
import com.jeeplus.modules.fptj.entity.XxCy;
import com.jeeplus.modules.fptj.service.XxCyService;

/**
 * 销项抽样统计Controller
 * @author admin
 * @version 2018-03-12
 */
@Controller
@RequestMapping(value = "${adminPath}/fptj/xxCy")
public class XxCyController extends BaseController {

	@Autowired
	private XxCyService xxCyService;
	
	@ModelAttribute
	public XxCy get(@RequestParam(required=false) String id) {
		XxCy entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xxCyService.get(id);
		}
		if (entity == null){
			entity = new XxCy();
		}
		return entity;
	}
	
	/**
	 * 销项抽样统计列表页面
	 */
	@RequiresPermissions("fptj:xxCy:list")
	@RequestMapping(value = {"list", ""})
	public String list(XxCy xxCy, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XxCy> page = xxCyService.findPage(new Page<XxCy>(request, response), xxCy); 
		model.addAttribute("page", page);
		return "modules/fptj/xxCyList";
	}

	/**
	 * 查看，增加，编辑销项抽样统计表单页面
	 */
	@RequiresPermissions(value={"fptj:xxCy:view","fptj:xxCy:add","fptj:xxCy:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(XxCy xxCy, Model model) {
		model.addAttribute("xxCy", xxCy);
		return "modules/fptj/xxCyForm";
	}

	/**
	 * 保存销项抽样统计
	 */
	@RequiresPermissions(value={"fptj:xxCy:add","fptj:xxCy:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(XxCy xxCy, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xxCy)){
			return form(xxCy, model);
		}
		if(!xxCy.getIsNewRecord()){//编辑表单保存
			XxCy t = xxCyService.get(xxCy.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(xxCy, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			xxCyService.save(t);//保存
		}else{//新增表单保存
			xxCyService.save(xxCy);//保存
		}
		addMessage(redirectAttributes, "保存销项抽样统计成功");
		return "redirect:"+Global.getAdminPath()+"/fptj/xxCy/?repage";
	}
	
	/**
	 * 删除销项抽样统计
	 */
	@RequiresPermissions("fptj:xxCy:del")
	@RequestMapping(value = "delete")
	public String delete(XxCy xxCy, RedirectAttributes redirectAttributes) {
		xxCyService.delete(xxCy);
		addMessage(redirectAttributes, "删除销项抽样统计成功");
		return "redirect:"+Global.getAdminPath()+"/fptj/xxCy/?repage";
	}
	
	/**
	 * 批量删除销项抽样统计
	 */
	@RequiresPermissions("fptj:xxCy:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			xxCyService.delete(xxCyService.get(id));
		}
		addMessage(redirectAttributes, "删除销项抽样统计成功");
		return "redirect:"+Global.getAdminPath()+"/fptj/xxCy/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("fptj:xxCy:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(XxCy xxCy, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "销项抽样统计"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<XxCy> page = xxCyService.findPage(new Page<XxCy>(request, response, -1), xxCy);
    		new ExportExcel("销项抽样统计", XxCy.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出销项抽样统计记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/fptj/xxCy/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("fptj:xxCy:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<XxCy> list = ei.getDataList(XxCy.class);
			for (XxCy xxCy : list){
				try{
					xxCyService.save(xxCy);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条销项抽样统计记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条销项抽样统计记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入销项抽样统计失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/fptj/xxCy/?repage";
    }
	
	/**
	 * 下载导入销项抽样统计数据模板
	 */
	@RequiresPermissions("fptj:xxCy:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "销项抽样统计数据导入模板.xlsx";
    		List<XxCy> list = Lists.newArrayList(); 
    		new ExportExcel("销项抽样统计数据", XxCy.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/fptj/xxCy/?repage";
    }
	
	
	

}