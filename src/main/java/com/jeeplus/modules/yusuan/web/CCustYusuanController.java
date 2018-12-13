/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.yusuan.web;

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
import com.jeeplus.modules.yusuan.entity.CCustYusuan;
import com.jeeplus.modules.yusuan.service.CCustYusuanService;

/**
 * 客户预算Controller
 * @author admin
 * @version 2018-04-21
 */
@Controller
@RequestMapping(value = "${adminPath}/yusuan/cCustYusuan")
public class CCustYusuanController extends BaseController {

	@Autowired
	private CCustYusuanService cCustYusuanService;
	
	@ModelAttribute
	public CCustYusuan get(@RequestParam(required=false) String id) {
		CCustYusuan entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cCustYusuanService.get(id);
		}
		if (entity == null){
			entity = new CCustYusuan();
		}
		return entity;
	}
	
	/**
	 * 客户预算列表页面
	 */
	@RequiresPermissions("yusuan:cCustYusuan:list")
	@RequestMapping(value = {"list", ""})
	public String list(CCustYusuan cCustYusuan, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CCustYusuan> page = cCustYusuanService.findPage(new Page<CCustYusuan>(request, response), cCustYusuan); 
		model.addAttribute("page", page);
		return "modules/yusuan/cCustYusuanList";
	}

	/**
	 * 查看，增加，编辑客户预算表单页面
	 */
	@RequiresPermissions(value={"yusuan:cCustYusuan:view","yusuan:cCustYusuan:add","yusuan:cCustYusuan:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(CCustYusuan cCustYusuan, Model model) {
		model.addAttribute("cCustYusuan", cCustYusuan);
		return "modules/yusuan/cCustYusuanForm";
	}

	/**
	 * 保存客户预算
	 */
	@RequiresPermissions(value={"yusuan:cCustYusuan:add","yusuan:cCustYusuan:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(CCustYusuan cCustYusuan, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, cCustYusuan)){
			return form(cCustYusuan, model);
		}
		if(!cCustYusuan.getIsNewRecord()){//编辑表单保存
			CCustYusuan t = cCustYusuanService.get(cCustYusuan.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(cCustYusuan, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			cCustYusuanService.save(t);//保存
		}else{//新增表单保存
			cCustYusuanService.save(cCustYusuan);//保存
		}
		addMessage(redirectAttributes, "保存客户预算成功");
		return "redirect:"+Global.getAdminPath()+"/yusuan/cCustYusuan/?repage";
	}
	
	/**
	 * 删除客户预算
	 */
	@RequiresPermissions("yusuan:cCustYusuan:del")
	@RequestMapping(value = "delete")
	public String delete(CCustYusuan cCustYusuan, RedirectAttributes redirectAttributes) {
		cCustYusuanService.delete(cCustYusuan);
		addMessage(redirectAttributes, "删除客户预算成功");
		return "redirect:"+Global.getAdminPath()+"/yusuan/cCustYusuan/?repage";
	}
	
	/**
	 * 批量删除客户预算
	 */
	@RequiresPermissions("yusuan:cCustYusuan:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			cCustYusuanService.delete(cCustYusuanService.get(id));
		}
		addMessage(redirectAttributes, "删除客户预算成功");
		return "redirect:"+Global.getAdminPath()+"/yusuan/cCustYusuan/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("yusuan:cCustYusuan:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(CCustYusuan cCustYusuan, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "客户预算"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<CCustYusuan> page = cCustYusuanService.findPage(new Page<CCustYusuan>(request, response, -1), cCustYusuan);
    		new ExportExcel("", CCustYusuan.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出客户预算记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/yusuan/cCustYusuan/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("yusuan:cCustYusuan:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 0, 0);
			List<CCustYusuan> list = ei.getDataList(CCustYusuan.class);
			for (CCustYusuan cCustYusuan : list){
				try{
					cCustYusuanService.save(cCustYusuan);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条客户预算记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条客户预算记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入客户预算失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/yusuan/cCustYusuan/?repage";
    }
	
	/**
	 * 下载导入客户预算数据模板
	 */
	@RequiresPermissions("yusuan:cCustYusuan:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "客户预算数据导入模板.xlsx";
    		List<CCustYusuan> list = Lists.newArrayList(); 
    		new ExportExcel("", CCustYusuan.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/yusuan/cCustYusuan/?repage";
    }
	
	
	

}