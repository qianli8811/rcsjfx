/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.cwzb.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import com.jeeplus.common.utils.CacheUtils;
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
import com.jeeplus.modules.cwzb.entity.RcCwzb;
import com.jeeplus.modules.cwzb.service.RcCwzbService;

/**
 * 财务指标参数设置Controller
 * @author admin
 * @version 2018-04-10
 */
@Controller
@RequestMapping(value = "${adminPath}/cwzb/rcCwzb")
public class RcCwzbController extends BaseController {

	@Autowired
	private RcCwzbService rcCwzbService;
	
	@ModelAttribute
	public RcCwzb get(@RequestParam(required=false) String id) {
		RcCwzb entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = rcCwzbService.get(id);
		}
		if (entity == null){
			entity = new RcCwzb();
		}
		return entity;
	}
	
	/**
	 * admin列表页面
	 */
	@RequiresPermissions("cwzb:rcCwzb:list")
	@RequestMapping(value = {"list", ""})
	public String list(RcCwzb rcCwzb, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<RcCwzb> page = rcCwzbService.findPage(new Page<RcCwzb>(request, response), rcCwzb); 
		model.addAttribute("page", page);
		return "modules/cwzb/rcCwzbList";
	}

	/**
	 * 查看，增加，编辑admin表单页面
	 */
	@RequiresPermissions(value={"cwzb:rcCwzb:view","cwzb:rcCwzb:add","cwzb:rcCwzb:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(RcCwzb rcCwzb, Model model) {
		model.addAttribute("rcCwzb", rcCwzb);
		return "modules/cwzb/rcCwzbForm";
	}

	/**
	 * 保存admin
	 */
	@RequiresPermissions(value={"cwzb:rcCwzb:add","cwzb:rcCwzb:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(RcCwzb rcCwzb, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, rcCwzb)){
			return form(rcCwzb, model);
		}
		if(!rcCwzb.getIsNewRecord()){//编辑表单保存
			RcCwzb t = rcCwzbService.get(rcCwzb.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(rcCwzb, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			rcCwzbService.save(t);//保存
		}else{//新增表单保存
			rcCwzbService.save(rcCwzb);//保存
		}
		//清空缓存
		CacheUtils.remove("ysdcl");
		addMessage(redirectAttributes, "保存admin成功");
		return "redirect:"+Global.getAdminPath()+"/cwzb/rcCwzb/?repage";
	}
	
	/**
	 * 删除admin
	 */
	@RequiresPermissions("cwzb:rcCwzb:del")
	@RequestMapping(value = "delete")
	public String delete(RcCwzb rcCwzb, RedirectAttributes redirectAttributes) {
		rcCwzbService.delete(rcCwzb);
		//清空缓存
		CacheUtils.remove("ysdcl");
		addMessage(redirectAttributes, "删除admin成功");
		return "redirect:"+Global.getAdminPath()+"/cwzb/rcCwzb/?repage";
	}
	
	/**
	 * 批量删除admin
	 */
	@RequiresPermissions("cwzb:rcCwzb:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			rcCwzbService.delete(rcCwzbService.get(id));
		}
		addMessage(redirectAttributes, "删除admin成功");
		return "redirect:"+Global.getAdminPath()+"/cwzb/rcCwzb/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("cwzb:rcCwzb:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(RcCwzb rcCwzb, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "admin"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<RcCwzb> page = rcCwzbService.findPage(new Page<RcCwzb>(request, response, -1), rcCwzb);
    		new ExportExcel("admin", RcCwzb.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出admin记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/cwzb/rcCwzb/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("cwzb:rcCwzb:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<RcCwzb> list = ei.getDataList(RcCwzb.class);
			for (RcCwzb rcCwzb : list){
				try{
					rcCwzbService.save(rcCwzb);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条admin记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条admin记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入admin失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/cwzb/rcCwzb/?repage";
    }
	
	/**
	 * 下载导入admin数据模板
	 */
	@RequiresPermissions("cwzb:rcCwzb:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "admin数据导入模板.xlsx";
    		List<RcCwzb> list = Lists.newArrayList(); 
    		new ExportExcel("admin数据", RcCwzb.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/cwzb/rcCwzb/?repage";
    }
	
	
	

}