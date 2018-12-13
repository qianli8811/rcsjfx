/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.fpsj.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import com.jeeplus.common.mapper.JsonMapper;
import com.jeeplus.modules.fpsj.entity.XxfpItem;
import com.jeeplus.modules.fpsj.service.XxfpItemService;
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
import com.jeeplus.modules.fpsj.entity.XxfpHead;
import com.jeeplus.modules.fpsj.service.XxfpHeadService;

/**
 * 发票数据Controller
 * @author admin
 * @version 2018-02-24
 */
@Controller
@RequestMapping(value = "${adminPath}/fpsj/xxfpHead")
public class XxfpHeadController extends BaseController {

	@Autowired
	private XxfpHeadService xxfpHeadService;
	
	@Autowired
	private XxfpItemService xxfpItemService;
	
	@ModelAttribute
	public XxfpHead get(@RequestParam(required=false) String id) {
		XxfpHead entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xxfpHeadService.get(id);
		}
		if (entity == null){
			entity = new XxfpHead();
		}
		return entity;
	}
	
	/**
	 * 发票数据列表页面
	 */
	@RequiresPermissions("fpsj:xxfpHead:list")
	@RequestMapping(value = {"list", ""})
	public String list(XxfpHead xxfpHead, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XxfpHead> page = xxfpHeadService.findPage(new Page<XxfpHead>(request, response), xxfpHead); 
		model.addAttribute("page", page);
		return "modules/fpsj/xxfpHeadList";
	}
	/**
	 * 发票数据列表页面
	 */
	@RequiresPermissions("fpsj:xxfpHead:list")
	@RequestMapping(value = {"listxq", ""})
	public String listxq(XxfpHead xxfpHead, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XxfpHead> page = xxfpHeadService.findPage(new Page<XxfpHead>(request, response), xxfpHead);
		model.addAttribute("page", page);
		return "modules/fpsj/xxfpHeadList_xq";
	}
	/**
	 * 查看，增加，编辑发票数据表单页面
	 */
	@RequiresPermissions(value={"fpsj:xxfpHead:view","fpsj:xxfpHead:add","fpsj:xxfpHead:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(XxfpHead xxfpHead, Model model) {
		if(null!=xxfpHead && StringUtils.isNotBlank(xxfpHead.getId())){
			XxfpItem xxfpItem = new XxfpItem();
			xxfpItem.setXxfpHead(xxfpHead);
			List<XxfpItem> list = xxfpItemService.findList(xxfpItem);
			model.addAttribute("xxfpItemList", list);
		}
		
		model.addAttribute("xxfpHead", xxfpHead);
		return "modules/fpsj/xxfpHeadForm";
	}
	/**
	 * 查看，增加，编辑发票数据表单页面
	 */
	@RequiresPermissions(value={"fpsj:xxfpHead:view","fpsj:xxfpHead:add","fpsj:xxfpHead:edit"},logical=Logical.OR)
	@RequestMapping(value = "formxx")
	public String formxx(XxfpHead xxfpHead, Model model) {
		if(null!=xxfpHead && StringUtils.isNotBlank(xxfpHead.getId())){
			XxfpItem xxfpItem = new XxfpItem();
			xxfpItem.setXxfpHead(xxfpHead);
			List<XxfpItem> list = xxfpItemService.findList(xxfpItem);
			model.addAttribute("xxfpItemList", list);
		}
		
		model.addAttribute("xxfpHead", xxfpHead);
		return "modules/fpsj/xxfpHeadForm_xx";
	}
	/**
	 * 保存发票数据
	 */
	@RequiresPermissions(value={"fpsj:xxfpHead:add","fpsj:xxfpHead:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(XxfpHead xxfpHead, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, xxfpHead)){
			return form(xxfpHead, model);
		}
		if(!xxfpHead.getIsNewRecord()){//编辑表单保存
			XxfpHead t = xxfpHeadService.get(xxfpHead.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(xxfpHead, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			xxfpHeadService.save(t);//保存
		}else{//新增表单保存
			xxfpHeadService.save(xxfpHead);//保存
		}
		addMessage(redirectAttributes, "保存发票数据成功");
		return "redirect:"+Global.getAdminPath()+"/fpsj/xxfpHead/?repage";
	}
	
	/**
	 * 删除发票数据
	 */
	@RequiresPermissions("fpsj:xxfpHead:del")
	@RequestMapping(value = "delete")
	public String delete(XxfpHead xxfpHead, RedirectAttributes redirectAttributes) {
		xxfpHeadService.delete(xxfpHead);
		addMessage(redirectAttributes, "删除发票数据成功");
		return "redirect:"+Global.getAdminPath()+"/fpsj/xxfpHead/?repage";
	}
	
	/**
	 * 批量删除发票数据
	 */
	@RequiresPermissions("fpsj:xxfpHead:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			xxfpHeadService.delete(xxfpHeadService.get(id));
		}
		addMessage(redirectAttributes, "删除发票数据成功");
		return "redirect:"+Global.getAdminPath()+"/fpsj/xxfpHead/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("fpsj:xxfpHead:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(XxfpHead xxfpHead, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "发票数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<XxfpHead> page = xxfpHeadService.findPage(new Page<XxfpHead>(request, response, -1), xxfpHead);
    		new ExportExcel("发票数据", XxfpHead.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出发票数据记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/fpsj/xxfpHead/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("fpsj:xxfpHead:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<XxfpHead> list = ei.getDataList(XxfpHead.class);
			for (XxfpHead xxfpHead : list){
				try{
					xxfpHeadService.save(xxfpHead);
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
		return "redirect:"+Global.getAdminPath()+"/fpsj/xxfpHead/?repage";
    }
	
	/**
	 * 下载导入发票数据数据模板
	 */
	@RequiresPermissions("fpsj:xxfpHead:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "发票数据数据导入模板.xlsx";
    		List<XxfpHead> list = Lists.newArrayList(); 
    		new ExportExcel("发票数据数据", XxfpHead.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/fpsj/xxfpHead/?repage";
    }
	
	
	@RequestMapping(value = "getXxGsName", method=RequestMethod.POST)
	@ResponseBody
	public String getXxGsName(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		
		
		List<String> lists = xxfpHeadService.getXxGsName();
		
		
		return JsonMapper.toJsonString(lists);
	}
	
	

}