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
import com.jeeplus.modules.fptj.entity.JxCy;
import com.jeeplus.modules.fptj.service.JxCyService;

/**
 * 进项抽样统计Controller
 * @author admin
 * @version 2018-03-12
 */
@Controller
@RequestMapping(value = "${adminPath}/fptj/jxCy")
public class JxCyController extends BaseController {

	@Autowired
	private JxCyService jxCyService;
	
	@ModelAttribute
	public JxCy get(@RequestParam(required=false) String id) {
		JxCy entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = jxCyService.get(id);
		}
		if (entity == null){
			entity = new JxCy();
		}
		return entity;
	}
	
	/**
	 * 进项抽样统计列表页面
	 */
	@RequiresPermissions("fptj:jxCy:list")
	@RequestMapping(value = {"list", ""})
	public String list(JxCy jxCy, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<JxCy> page = jxCyService.findPage(new Page<JxCy>(request, response), jxCy); 
		model.addAttribute("page", page);
		return "modules/fptj/jxCyList";
	}

	/**
	 * 查看，增加，编辑进项抽样统计表单页面
	 */
	@RequiresPermissions(value={"fptj:jxCy:view","fptj:jxCy:add","fptj:jxCy:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(JxCy jxCy, Model model) {
		model.addAttribute("jxCy", jxCy);
		return "modules/fptj/jxCyForm";
	}

	/**
	 * 保存进项抽样统计
	 */
	@RequiresPermissions(value={"fptj:jxCy:add","fptj:jxCy:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(JxCy jxCy, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, jxCy)){
			return form(jxCy, model);
		}
		if(!jxCy.getIsNewRecord()){//编辑表单保存
			JxCy t = jxCyService.get(jxCy.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(jxCy, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			jxCyService.save(t);//保存
		}else{//新增表单保存
			jxCyService.save(jxCy);//保存
		}
		addMessage(redirectAttributes, "保存进项抽样统计成功");
		return "redirect:"+Global.getAdminPath()+"/fptj/jxCy/?repage";
	}
	
	/**
	 * 删除进项抽样统计
	 */
	@RequiresPermissions("fptj:jxCy:del")
	@RequestMapping(value = "delete")
	public String delete(JxCy jxCy, RedirectAttributes redirectAttributes) {
		jxCyService.delete(jxCy);
		addMessage(redirectAttributes, "删除进项抽样统计成功");
		return "redirect:"+Global.getAdminPath()+"/fptj/jxCy/?repage";
	}
	
	/**
	 * 批量删除进项抽样统计
	 */
	@RequiresPermissions("fptj:jxCy:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			jxCyService.delete(jxCyService.get(id));
		}
		addMessage(redirectAttributes, "删除进项抽样统计成功");
		return "redirect:"+Global.getAdminPath()+"/fptj/jxCy/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("fptj:jxCy:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(JxCy jxCy, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "进项抽样统计"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<JxCy> page = jxCyService.findPage(new Page<JxCy>(request, response, -1), jxCy);
    		new ExportExcel("进项抽样统计", JxCy.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出进项抽样统计记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/fptj/jxCy/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("fptj:jxCy:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<JxCy> list = ei.getDataList(JxCy.class);
			for (JxCy jxCy : list){
				try{
					jxCyService.save(jxCy);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条进项抽样统计记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条进项抽样统计记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入进项抽样统计失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/fptj/jxCy/?repage";
    }
	
	/**
	 * 下载导入进项抽样统计数据模板
	 */
	@RequiresPermissions("fptj:jxCy:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "进项抽样统计数据导入模板.xlsx";
    		List<JxCy> list = Lists.newArrayList(); 
    		new ExportExcel("进项抽样统计数据", JxCy.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/fptj/jxCy/?repage";
    }
	
	
	

}