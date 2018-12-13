/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.kerz.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import com.jeeplus.modules.kerz.entity.RcGdjs;
import com.jeeplus.modules.kerz.entity.RcKhzl;
import com.jeeplus.modules.kerz.service.RcGdjsService;
import com.jeeplus.modules.kerz.service.RcKhzlService;
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
import com.jeeplus.modules.kerz.entity.RcGdxx;
import com.jeeplus.modules.kerz.service.RcGdxxService;

/**
 * 股东信息Controller
 * @author admin
 * @version 2018-04-18
 */
@Controller
@RequestMapping(value = "${adminPath}/kerz/rcGdxx")
public class RcGdxxController extends BaseController {

	@Autowired
	private RcGdxxService rcGdxxService;
	
	@Autowired
	private RcKhzlService rcKhzlService;
	
	@Autowired
	private RcGdjsService rcGdjsService;
	
	
	@ModelAttribute
	public RcGdxx get(@RequestParam(required=false) String id) {
		RcGdxx entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = rcGdxxService.get(id);
		}
		if (entity == null){
			entity = new RcGdxx();
		}
		return entity;
	}
	
	/**
	 * 股东信息列表页面
	 */
	@RequiresPermissions("kerz:rcGdxx:list")
	@RequestMapping(value = {"list", ""})
	public String list(RcGdxx rcGdxx, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<RcGdxx> page = rcGdxxService.findPage(new Page<RcGdxx>(request, response), rcGdxx);
		if(null!=page && null != page.getList() && page.getList().size()>0){
			List<RcGdxx> list = page.getList();
			for(RcGdxx rcGdxx1 : list){
				RcKhzl rcKhzl = rcGdxx1.getRcKhzl();
				rcGdxx1.setRcKhzl(rcKhzlService.get(rcKhzl));
			}
		}
		model.addAttribute("page", page);
		return "modules/kerz/rcGdxxList";
	}

	/**
	 * 查看，增加，编辑股东信息表单页面
	 */
	@RequiresPermissions(value={"kerz:rcGdxx:view","kerz:rcGdxx:add","kerz:rcGdxx:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(RcGdxx rcGdxx, Model model) {
		model.addAttribute("rcGdxx", rcGdxx);
		return "modules/kerz/rcGdxxForm";
	}
	
	/**
	 * 查看，增加，编辑股东家属信息表单页面
	 */
	@RequiresPermissions(value={"kerz:rcGdxx:view","kerz:rcGdxx:add","kerz:rcGdxx:edit"},logical=Logical.OR)
	@RequestMapping(value = "rcGdjsform")
	public String gdjsform(RcGdxx rcGdxx, RcGdjs rcGdjs, Model model) {
		model.addAttribute("rcGdxx", rcGdxx);
		model.addAttribute("rcGdjs", rcGdjs);
		return "modules/kerz/rcGdjsform";
	}
	/**
	 * 保存股东信息
	 */
	@RequiresPermissions(value={"kerz:rcGdxx:add","kerz:rcGdxx:edit"},logical=Logical.OR)
	@RequestMapping(value = "saveRcGdjs")
	public String saveRcGdjs(RcGdjs rcGdjs, Model model, RedirectAttributes redirectAttributes) throws Exception{
		
		rcGdjsService.save(rcGdjs);//保存
		addMessage(redirectAttributes, "保存股东信息成功");
		return "redirect:"+Global.getAdminPath()+"/kerz/rcGdjs/list?id="+rcGdjs.getId();
	}
	
	/**
	 * 保存股东信息
	 */
	@RequiresPermissions(value={"kerz:rcGdxx:add","kerz:rcGdxx:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(RcGdxx rcGdxx, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, rcGdxx)){
			return form(rcGdxx, model);
		}
		if(!rcGdxx.getIsNewRecord()){//编辑表单保存
			RcGdxx t = rcGdxxService.get(rcGdxx.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(rcGdxx, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			rcGdxxService.save(t);//保存
		}else{//新增表单保存
			rcGdxxService.save(rcGdxx);//保存
		}
		addMessage(redirectAttributes, "保存股东信息成功");
		return "redirect:"+Global.getAdminPath()+"/kerz/rcGdxx/?repage";
	}
	
	/**
	 * 删除股东信息
	 */
	@RequiresPermissions("kerz:rcGdxx:del")
	@RequestMapping(value = "delete")
	public String delete(RcGdxx rcGdxx, RedirectAttributes redirectAttributes) {
		rcGdxxService.delete(rcGdxx);
		addMessage(redirectAttributes, "删除股东信息成功");
		return "redirect:"+Global.getAdminPath()+"/kerz/rcGdxx/?repage";
	}
	
	/**
	 * 批量删除股东信息
	 */
	@RequiresPermissions("kerz:rcGdxx:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			rcGdxxService.delete(rcGdxxService.get(id));
		}
		addMessage(redirectAttributes, "删除股东信息成功");
		return "redirect:"+Global.getAdminPath()+"/kerz/rcGdxx/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("kerz:rcGdxx:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(RcGdxx rcGdxx, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "股东信息"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<RcGdxx> page = rcGdxxService.findPage(new Page<RcGdxx>(request, response, -1), rcGdxx);
    		new ExportExcel("股东信息", RcGdxx.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出股东信息记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/kerz/rcGdxx/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("kerz:rcGdxx:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<RcGdxx> list = ei.getDataList(RcGdxx.class);
			for (RcGdxx rcGdxx : list){
				try{
					rcGdxxService.save(rcGdxx);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条股东信息记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条股东信息记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入股东信息失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/kerz/rcGdxx/?repage";
    }
	
	/**
	 * 下载导入股东信息数据模板
	 */
	@RequiresPermissions("kerz:rcGdxx:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "股东信息数据导入模板.xlsx";
    		List<RcGdxx> list = Lists.newArrayList(); 
    		new ExportExcel("股东信息数据", RcGdxx.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/kerz/rcGdxx/?repage";
    }
	
	
	

}