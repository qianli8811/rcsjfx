/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.kerz.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import com.jeeplus.common.mapper.JsonMapper;
import com.jeeplus.modules.kerz.entity.RcKhzl;
import com.jeeplus.modules.kerz.service.RcKhzlService;
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
import com.jeeplus.modules.kerz.entity.KeRz;
import com.jeeplus.modules.kerz.service.KeRzService;

/**
 * 客户融资Controller
 * @author admin
 * @version 2018-03-10
 */
@Controller
@RequestMapping(value = "${adminPath}/kerz/keRz")
public class KeRzController extends BaseController {

	@Autowired
	private KeRzService keRzService;
	@Autowired
	private RcKhzlService  rcKhzlService;
	
	@ModelAttribute
	public KeRz get(@RequestParam(required=false) String id) {
		KeRz entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = keRzService.get(id);
		}
		if (entity == null){
			entity = new KeRz();
		}
		return entity;
	}
	
	/**
	 * 客户融资列表页面
	 */
	@RequiresPermissions("kerz:keRz:list")
	@RequestMapping(value = {"list", ""})
	public String list(KeRz keRz, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<KeRz> page = keRzService.findPage(new Page<KeRz>(request, response), keRz);
		
		model.addAttribute("page", page);
		return "modules/kerz/keRzList";
	}

	/**
	 * 查看，增加，编辑客户融资表单页面
	 */
	@RequiresPermissions(value={"kerz:keRz:view","kerz:keRz:add","kerz:keRz:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(KeRz keRz, Model model) {
		
		model.addAttribute("keRz", keRz);
		return "modules/kerz/keRzForm";
	}

	/**
	 * 保存客户融资
	 */
	@RequiresPermissions(value={"kerz:keRz:add","kerz:keRz:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(KeRz keRz, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, keRz)){
			return form(keRz, model);
		}
		if(!keRz.getIsNewRecord()){//编辑表单保存
			KeRz t = keRzService.get(keRz.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(keRz, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			keRzService.save(t);//保存
		}else{//新增表单保存
			if(keRz != null && null != keRz.getRckhzl() &&  StringUtils.isNotBlank(keRz.getRckhzl().getKhjm())){
				RcKhzl rcKhzl1 = rcKhzlService.get(keRz.getRckhzl());
				keRz.setRckhzl(rcKhzl1);
				keRzService.save(keRz);//保存
				addMessage(redirectAttributes, "保存客户融资成功");
			}else{
				addMessage(redirectAttributes, "保存客户融资失败");
			}
		}
		
		return "redirect:"+Global.getAdminPath()+"/kerz/keRz/?repage";
	}
	/**
	 * 保存客户融资
	 */
	@RequestMapping(value = "getRckhzl")
	@ResponseBody
	public String getRckhzl(RcKhzl rcKhzl, Model model, RedirectAttributes redirectAttributes) throws Exception{
		RcKhzl rcKhzl1 = rcKhzlService.get(rcKhzl);
		Map<String,String> map = new HashMap<String,String>();
		if(null != rcKhzl1 && StringUtils.isNotBlank(rcKhzl1.getId()) ){
			map.put("resultFlag","1");
			map.put("rcKhzlId",rcKhzl1.getId());
		}else {
			map.put("resultFlag","0");
		}
		
		return JsonMapper.toJsonString(map);
	}
	/**
	 * 删除客户融资
	 */
	@RequiresPermissions("kerz:keRz:del")
	@RequestMapping(value = "delete")
	public String delete(KeRz keRz, RedirectAttributes redirectAttributes) {
		keRzService.delete(keRz);
		addMessage(redirectAttributes, "删除客户融资成功");
		return "redirect:"+Global.getAdminPath()+"/kerz/keRz/?repage";
	}
	
	/**
	 * 批量删除客户融资
	 */
	@RequiresPermissions("kerz:keRz:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			keRzService.delete(keRzService.get(id));
		}
		addMessage(redirectAttributes, "删除客户融资成功");
		return "redirect:"+Global.getAdminPath()+"/kerz/keRz/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("kerz:keRz:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(KeRz keRz, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "客户融资"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<KeRz> page = keRzService.findPage(new Page<KeRz>(request, response, -1), keRz);
    		new ExportExcel("客户融资", KeRz.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出客户融资记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/kerz/keRz/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("kerz:keRz:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<KeRz> list = ei.getDataList(KeRz.class);
			for (KeRz keRz : list){
				try{
					keRzService.save(keRz);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条客户融资记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条客户融资记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入客户融资失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/kerz/keRz/?repage";
    }
	
	/**
	 * 下载导入客户融资数据模板
	 */
	@RequiresPermissions("kerz:keRz:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "客户融资数据导入模板.xlsx";
    		List<KeRz> list = Lists.newArrayList(); 
    		new ExportExcel("客户融资数据", KeRz.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/kerz/keRz/?repage";
    }
	
	
	

}