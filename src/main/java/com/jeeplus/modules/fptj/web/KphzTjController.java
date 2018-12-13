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
import com.jeeplus.modules.fptj.entity.KphzTj;
import com.jeeplus.modules.fptj.service.KphzTjService;

/**
 * 开票汇总统计Controller
 * @author admin
 * @version 2018-03-12
 */
@Controller
@RequestMapping(value = "${adminPath}/fptj/kphzTj")
public class KphzTjController extends BaseController {

	@Autowired
	private KphzTjService kphzTjService;
	
	@ModelAttribute
	public KphzTj get(@RequestParam(required=false) String id) {
		KphzTj entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = kphzTjService.get(id);
		}
		if (entity == null){
			entity = new KphzTj();
		}
		return entity;
	}
	
	/**
	 * 开票汇总统计列表页面
	 */
	@RequiresPermissions("fptj:kphzTj:list")
	@RequestMapping(value = {"list", ""})
	public String list(KphzTj kphzTj, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<KphzTj> page = kphzTjService.findPage(new Page<KphzTj>(request, response), kphzTj); 
		model.addAttribute("page", page);
		return "modules/fptj/kphzTjList";
	}

	/**
	 * 查看，增加，编辑开票汇总统计表单页面
	 */
	@RequiresPermissions(value={"fptj:kphzTj:view","fptj:kphzTj:add","fptj:kphzTj:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(KphzTj kphzTj, Model model) {
		model.addAttribute("kphzTj", kphzTj);
		return "modules/fptj/kphzTjForm";
	}

	/**
	 * 保存开票汇总统计
	 */
	@RequiresPermissions(value={"fptj:kphzTj:add","fptj:kphzTj:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(KphzTj kphzTj, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, kphzTj)){
			return form(kphzTj, model);
		}
		if(!kphzTj.getIsNewRecord()){//编辑表单保存
			KphzTj t = kphzTjService.get(kphzTj.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(kphzTj, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			kphzTjService.save(t);//保存
		}else{//新增表单保存
			kphzTjService.save(kphzTj);//保存
		}
		addMessage(redirectAttributes, "保存开票汇总统计成功");
		return "redirect:"+Global.getAdminPath()+"/fptj/kphzTj/?repage";
	}
	
	/**
	 * 删除开票汇总统计
	 */
	@RequiresPermissions("fptj:kphzTj:del")
	@RequestMapping(value = "delete")
	public String delete(KphzTj kphzTj, RedirectAttributes redirectAttributes) {
		kphzTjService.delete(kphzTj);
		addMessage(redirectAttributes, "删除开票汇总统计成功");
		return "redirect:"+Global.getAdminPath()+"/fptj/kphzTj/?repage";
	}
	
	/**
	 * 批量删除开票汇总统计
	 */
	@RequiresPermissions("fptj:kphzTj:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			kphzTjService.delete(kphzTjService.get(id));
		}
		addMessage(redirectAttributes, "删除开票汇总统计成功");
		return "redirect:"+Global.getAdminPath()+"/fptj/kphzTj/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("fptj:kphzTj:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(KphzTj kphzTj, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "开票汇总统计"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<KphzTj> page = kphzTjService.findPage(new Page<KphzTj>(request, response, -1), kphzTj);
    		new ExportExcel("开票汇总统计", KphzTj.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出开票汇总统计记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/fptj/kphzTj/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("fptj:kphzTj:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<KphzTj> list = ei.getDataList(KphzTj.class);
			for (KphzTj kphzTj : list){
				try{
					kphzTjService.save(kphzTj);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条开票汇总统计记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条开票汇总统计记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入开票汇总统计失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/fptj/kphzTj/?repage";
    }
	
	/**
	 * 下载导入开票汇总统计数据模板
	 */
	@RequiresPermissions("fptj:kphzTj:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "开票汇总统计数据导入模板.xlsx";
    		List<KphzTj> list = Lists.newArrayList(); 
    		new ExportExcel("开票汇总统计数据", KphzTj.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/fptj/kphzTj/?repage";
    }
	
	
	

}