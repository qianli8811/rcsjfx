/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.fpsj.web;

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
import com.jeeplus.modules.fpsj.entity.JxfpItem;
import com.jeeplus.modules.fpsj.service.JxfpItemService;

/**
 * 发票数据Controller
 * @author admin
 * @version 2018-02-24
 */
@Controller
@RequestMapping(value = "${adminPath}/fpsj/jxfpItem")
public class JxfpItemController extends BaseController {

	@Autowired
	private JxfpItemService jxfpItemService;
	
	@ModelAttribute
	public JxfpItem get(@RequestParam(required=false) String id) {
		JxfpItem entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = jxfpItemService.get(id);
		}
		if (entity == null){
			entity = new JxfpItem();
		}
		return entity;
	}
	
	/**
	 * 发票数据列表页面
	 */
	@RequiresPermissions("fpsj:jxfpItem:list")
	@RequestMapping(value = {"list", ""})
	public String list(JxfpItem jxfpItem, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<JxfpItem> page = jxfpItemService.findPage(new Page<JxfpItem>(request, response), jxfpItem); 
		model.addAttribute("page", page);
		return "modules/fpsj/jxfpItemList";
	}

	/**
	 * 查看，增加，编辑发票数据表单页面
	 */
	@RequiresPermissions(value={"fpsj:jxfpItem:view","fpsj:jxfpItem:add","fpsj:jxfpItem:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(JxfpItem jxfpItem, Model model) {
		model.addAttribute("jxfpItem", jxfpItem);
		return "modules/fpsj/jxfpItemForm";
	}

	/**
	 * 保存发票数据
	 */
	@RequiresPermissions(value={"fpsj:jxfpItem:add","fpsj:jxfpItem:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(JxfpItem jxfpItem, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, jxfpItem)){
			return form(jxfpItem, model);
		}
		if(!jxfpItem.getIsNewRecord()){//编辑表单保存
			JxfpItem t = jxfpItemService.get(jxfpItem.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(jxfpItem, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			jxfpItemService.save(t);//保存
		}else{//新增表单保存
			jxfpItemService.save(jxfpItem);//保存
		}
		addMessage(redirectAttributes, "保存发票数据成功");
		return "redirect:"+Global.getAdminPath()+"/fpsj/jxfpItem/?repage";
	}
	
	/**
	 * 删除发票数据
	 */
	@RequiresPermissions("fpsj:jxfpItem:del")
	@RequestMapping(value = "delete")
	public String delete(JxfpItem jxfpItem, RedirectAttributes redirectAttributes) {
		jxfpItemService.delete(jxfpItem);
		addMessage(redirectAttributes, "删除发票数据成功");
		return "redirect:"+Global.getAdminPath()+"/fpsj/jxfpItem/?repage";
	}
	
	/**
	 * 批量删除发票数据
	 */
	@RequiresPermissions("fpsj:jxfpItem:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			jxfpItemService.delete(jxfpItemService.get(id));
		}
		addMessage(redirectAttributes, "删除发票数据成功");
		return "redirect:"+Global.getAdminPath()+"/fpsj/jxfpItem/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("fpsj:jxfpItem:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(JxfpItem jxfpItem, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "发票数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<JxfpItem> page = jxfpItemService.findPage(new Page<JxfpItem>(request, response, -1), jxfpItem);
    		new ExportExcel("发票数据", JxfpItem.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出发票数据记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/fpsj/jxfpItem/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("fpsj:jxfpItem:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<JxfpItem> list = ei.getDataList(JxfpItem.class);
			for (JxfpItem jxfpItem : list){
				try{
					jxfpItemService.save(jxfpItem);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条发票数据记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条发票数据记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入发票数据失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/fpsj/jxfpItem/?repage";
    }
	
	/**
	 * 下载导入发票数据数据模板
	 */
	@RequiresPermissions("fpsj:jxfpItem:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "发票数据数据导入模板.xlsx";
    		List<JxfpItem> list = Lists.newArrayList(); 
    		new ExportExcel("发票数据数据", JxfpItem.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/fpsj/jxfpItem/?repage";
    }
	
	
	

}