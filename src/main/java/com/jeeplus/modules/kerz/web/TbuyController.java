/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.kerz.web;

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
import com.jeeplus.modules.kerz.entity.Tbuy;
import com.jeeplus.modules.kerz.service.TbuyService;

/**
 * 小狐狸系统客户资料Controller
 * @author admin
 * @version 2018-05-13
 */
@Controller
@RequestMapping(value = "${adminPath}/kerz/tbuy")
public class TbuyController extends BaseController {

	@Autowired
	private TbuyService tbuyService;
	
	@ModelAttribute
	public Tbuy get(@RequestParam(required=false) String id) {
		Tbuy entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = tbuyService.get(id);
		}
		if (entity == null){
			entity = new Tbuy();
		}
		return entity;
	}
	
	/**
	 * 小狐狸系统客户资料列表页面
	 */
	@RequiresPermissions("kerz:tbuy:list")
	@RequestMapping(value = {"list", ""})
	public String list(Tbuy tbuy, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Tbuy> page = tbuyService.findPage(new Page<Tbuy>(request, response), tbuy); 
		model.addAttribute("page", page);
		return "modules/kerz/tbuyList";
	}

	/**
	 * 查看，增加，编辑小狐狸系统客户资料表单页面
	 */
	@RequiresPermissions(value={"kerz:tbuy:view","kerz:tbuy:add","kerz:tbuy:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(Tbuy tbuy, Model model) {
		model.addAttribute("tbuy", tbuy);
		return "modules/kerz/tbuyForm";
	}

	/**
	 * 保存小狐狸系统客户资料
	 */
	@RequiresPermissions(value={"kerz:tbuy:add","kerz:tbuy:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(Tbuy tbuy, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, tbuy)){
			return form(tbuy, model);
		}
		if(!tbuy.getIsNewRecord()){//编辑表单保存
			Tbuy t = tbuyService.get(tbuy.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(tbuy, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			tbuyService.save(t);//保存
		}else{//新增表单保存
			tbuyService.save(tbuy);//保存
		}
		addMessage(redirectAttributes, "保存小狐狸系统客户资料成功");
		return "redirect:"+Global.getAdminPath()+"/kerz/tbuy/?repage";
	}
	
	/**
	 * 删除小狐狸系统客户资料
	 */
	@RequiresPermissions("kerz:tbuy:del")
	@RequestMapping(value = "delete")
	public String delete(Tbuy tbuy, RedirectAttributes redirectAttributes) {
		tbuyService.delete(tbuy);
		addMessage(redirectAttributes, "删除小狐狸系统客户资料成功");
		return "redirect:"+Global.getAdminPath()+"/kerz/tbuy/?repage";
	}
	
	/**
	 * 批量删除小狐狸系统客户资料
	 */
	@RequiresPermissions("kerz:tbuy:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			tbuyService.delete(tbuyService.get(id));
		}
		addMessage(redirectAttributes, "删除小狐狸系统客户资料成功");
		return "redirect:"+Global.getAdminPath()+"/kerz/tbuy/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("kerz:tbuy:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(Tbuy tbuy, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "小狐狸系统客户资料"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<Tbuy> page = tbuyService.findPage(new Page<Tbuy>(request, response, -1), tbuy);
    		new ExportExcel("小狐狸系统客户资料", Tbuy.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出小狐狸系统客户资料记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/kerz/tbuy/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("kerz:tbuy:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<Tbuy> list = ei.getDataList(Tbuy.class);
			for (Tbuy tbuy : list){
				try{
					tbuyService.save(tbuy);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条小狐狸系统客户资料记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条小狐狸系统客户资料记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入小狐狸系统客户资料失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/kerz/tbuy/?repage";
    }
	
	/**
	 * 下载导入小狐狸系统客户资料数据模板
	 */
	@RequiresPermissions("kerz:tbuy:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "小狐狸系统客户资料数据导入模板.xlsx";
    		List<Tbuy> list = Lists.newArrayList(); 
    		new ExportExcel("小狐狸系统客户资料数据", Tbuy.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/kerz/tbuy/?repage";
    }
	
	
	

}