/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.fpsj.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import com.jeeplus.common.mapper.JsonMapper;
import com.jeeplus.modules.fpsj.entity.JxfpItem;
import com.jeeplus.modules.fpsj.service.JxfpItemService;
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
import com.jeeplus.modules.fpsj.entity.JxfpHead;
import com.jeeplus.modules.fpsj.service.JxfpHeadService;

/**
 * 发票数据Controller
 * @author admin
 * @version 2018-02-24
 */
@Controller
@RequestMapping(value = "${adminPath}/fpsj/jxfpHead")
public class JxfpHeadController extends BaseController {

	@Autowired
	private JxfpHeadService jxfpHeadService;
	
	@Autowired
	private JxfpItemService jxfpItemService;
	
	@ModelAttribute
	public JxfpHead get(@RequestParam(required=false) String id) {
		JxfpHead entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = jxfpHeadService.get(id);
		}
		if (entity == null){
			entity = new JxfpHead();
		}
		return entity;
	}
	
	/**
	 * 发票数据列表页面
	 */
	@RequiresPermissions("fpsj:jxfpHead:list")
	@RequestMapping(value = {"list", ""})
	public String list(JxfpHead jxfpHead, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		Page<JxfpHead> page = jxfpHeadService.findPage(new Page<JxfpHead>(request, response), jxfpHead);
		model.addAttribute("page", page);
		return "modules/fpsj/jxfpHeadList";
	}
	
	/**
	 * 发票数据列表页面:未勾选
	 */
	@RequiresPermissions("fpsj:jxfpHead:list")
	@RequestMapping(value = {"listwgx", ""})
	public String listwgx(JxfpHead jxfpHead, HttpServletRequest request, HttpServletResponse response, Model model) {
		jxfpHead.setRzbz("-1");
		Page<JxfpHead> page = jxfpHeadService.findPage(new Page<JxfpHead>(request, response), jxfpHead);
		model.addAttribute("page", page);
		model.addAttribute("jxfpHead", jxfpHead);
		return "modules/fpsj/jxfpHeadList_wgx";
	}
	/**
	 * 发票数据列表页面:已认证
	 */
	@RequiresPermissions("fpsj:jxfpHead:list")
	@RequestMapping(value = {"listygx", ""})
	public String listygx(JxfpHead jxfpHead, HttpServletRequest request, HttpServletResponse response, Model model) {
		jxfpHead.setRzbz("1");
		Page<JxfpHead> page = jxfpHeadService.findPage(new Page<JxfpHead>(request, response), jxfpHead);
		model.addAttribute("page", page);
		return "modules/fpsj/jxfpHeadList_ygx";
	}

	/**
	 * 查看，增加，编辑发票数据表单页面
	 */
	@RequiresPermissions(value={"fpsj:jxfpHead:view","fpsj:jxfpHead:add","fpsj:jxfpHead:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(JxfpHead jxfpHead, HttpServletRequest request, HttpServletResponse response,Model model) {
		
		if(null != jxfpHead && StringUtils.isNotBlank(jxfpHead.getId()) ){
			JxfpItem jxfpItem = new JxfpItem();
			jxfpItem.setJxfpHead(jxfpHead);
			
			List<JxfpItem> list  = jxfpItemService.findList(jxfpItem);
			model.addAttribute("jxfpItemList", list);
		}
		
		model.addAttribute("jxfpHead", jxfpHead);
		
		
		return "modules/fpsj/jxfpHeadForm";
	}
	
	
	/**
	 * 查看，增加，编辑发票数据表单页面
	 */
	@RequiresPermissions(value={"fpsj:jxfpHead:view","fpsj:jxfpHead:add","fpsj:jxfpHead:edit"},logical=Logical.OR)
	@RequestMapping(value = "formjx")
	public String formjx(JxfpHead jxfpHead, HttpServletRequest request, HttpServletResponse response,Model model) {
		
		if(null != jxfpHead && StringUtils.isNotBlank(jxfpHead.getId()) ){
			JxfpItem jxfpItem = new JxfpItem();
			jxfpItem.setJxfpHead(jxfpHead);
			
			List<JxfpItem> list  = jxfpItemService.findList(jxfpItem);
			model.addAttribute("jxfpItemList", list);
		}
		
		model.addAttribute("jxfpHead", jxfpHead);
		
		
		return "modules/fpsj/jxfpHeadForm_jx";
	}
	
	/**
	 * 保存发票数据
	 */
	@RequiresPermissions(value={"fpsj:jxfpHead:add","fpsj:jxfpHead:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(JxfpHead jxfpHead, Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, jxfpHead)){
			return form(jxfpHead,request,response, model);
		}
		if(!jxfpHead.getIsNewRecord()){//编辑表单保存
			JxfpHead t = jxfpHeadService.get(jxfpHead.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(jxfpHead, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			jxfpHeadService.save(t);//保存
		}else{//新增表单保存
			jxfpHeadService.save(jxfpHead);//保存
		}
		addMessage(redirectAttributes, "保存发票数据成功");
		return "redirect:"+Global.getAdminPath()+"/fpsj/jxfpHead/?repage";
	}
	
	/**
	 * 删除发票数据
	 */
	@RequiresPermissions("fpsj:jxfpHead:del")
	@RequestMapping(value = "delete")
	public String delete(JxfpHead jxfpHead, RedirectAttributes redirectAttributes) {
		jxfpHeadService.delete(jxfpHead);
		addMessage(redirectAttributes, "删除发票数据成功");
		return "redirect:"+Global.getAdminPath()+"/fpsj/jxfpHead/?repage";
	}
	
	/**
	 * 批量删除发票数据
	 */
	@RequiresPermissions("fpsj:jxfpHead:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			jxfpHeadService.delete(jxfpHeadService.get(id));
		}
		addMessage(redirectAttributes, "删除发票数据成功");
		return "redirect:"+Global.getAdminPath()+"/fpsj/jxfpHead/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("fpsj:jxfpHead:export")
    @RequestMapping(value = "export")
    public String exportFile(JxfpHead jxfpHead, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "发票数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<JxfpHead> page = jxfpHeadService.findPage(new Page<JxfpHead>(request, response, -1), jxfpHead);
    		new ExportExcel("发票数据", JxfpHead.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出发票数据记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/fpsj/jxfpHead/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("fpsj:jxfpHead:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<JxfpHead> list = ei.getDataList(JxfpHead.class);
			for (JxfpHead jxfpHead : list){
				try{
					jxfpHeadService.save(jxfpHead);
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
		return "redirect:"+Global.getAdminPath()+"/fpsj/jxfpHead/?repage";
    }
	
	/**
	 * 下载导入发票数据数据模板
	 */
	@RequiresPermissions("fpsj:jxfpHead:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "发票数据数据导入模板.xlsx";
    		List<JxfpHead> list = Lists.newArrayList(); 
    		new ExportExcel("发票数据数据", JxfpHead.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/fpsj/jxfpHead/?repage";
    }
	
	
	
	@RequestMapping(value = "getJxGsName", method=RequestMethod.POST)
	@ResponseBody
	public String getJxGsName(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		
		
		List<String> lists = jxfpHeadService.getJxGsName();
		
		
		return JsonMapper.toJsonString(lists);
	}
	
	
}