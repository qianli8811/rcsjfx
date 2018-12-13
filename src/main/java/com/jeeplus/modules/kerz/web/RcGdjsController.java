/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.kerz.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import com.jeeplus.modules.kerz.entity.RcGdxx;
import com.jeeplus.modules.kerz.entity.RcKhzl;
import com.jeeplus.modules.kerz.service.RcGdxxService;
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
import com.jeeplus.modules.kerz.entity.RcGdjs;
import com.jeeplus.modules.kerz.service.RcGdjsService;

/**
 * 股东家属信息Controller
 * @author admin
 * @version 2018-04-18
 */
@Controller
@RequestMapping(value = "${adminPath}/kerz/rcGdjs")
public class RcGdjsController extends BaseController {

	@Autowired
	private RcGdjsService rcGdjsService;
	@Autowired
	private RcGdxxService rcGdxxService;
	
	@ModelAttribute
	public RcGdjs get(@RequestParam(required=false) String id) {
		RcGdjs entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = rcGdjsService.get(id);
		}
		if (entity == null){
			entity = new RcGdjs();
		}
		return entity;
	}
	
	/**
	 * 股东家属列表页面
	 */
	@RequiresPermissions("kerz:rcGdjs:list")
	@RequestMapping(value = {"list", ""})
	public String list(RcGdjs rcGdjs, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<RcGdjs> page = rcGdjsService.findPage(new Page<RcGdjs>(request, response), rcGdjs);
		if(null!=page && null != page.getList() && page.getList().size()>0){
			List<RcGdjs> list = page.getList();
			for(RcGdjs RcGdjs1 : list){
				RcGdxx rcGdxx = RcGdjs1.getRcGdxx();
				RcGdjs1.setRcGdxx(rcGdxxService.get(rcGdxx));
			}
		}
		
		model.addAttribute("page", page);
		return "modules/kerz/rcGdjsList";
	}

	/**
	 * 查看，增加，编辑股东家属表单页面
	 */
	@RequiresPermissions(value={"kerz:rcGdjs:view","kerz:rcGdjs:add","kerz:rcGdjs:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(RcGdjs rcGdjs, Model model) {
		model.addAttribute("rcGdjs", rcGdjs);
		return "modules/kerz/rcGdjsForm";
	}

	/**
	 * 保存股东家属
	 */
	@RequiresPermissions(value={"kerz:rcGdjs:add","kerz:rcGdjs:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(RcGdjs rcGdjs, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, rcGdjs)){
			return form(rcGdjs, model);
		}
		if(!rcGdjs.getIsNewRecord()){//编辑表单保存
			RcGdjs t = rcGdjsService.get(rcGdjs.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(rcGdjs, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			rcGdjsService.save(t);//保存
		}else{//新增表单保存
			rcGdjsService.save(rcGdjs);//保存
		}
		addMessage(redirectAttributes, "保存股东家属成功");
		return "redirect:"+Global.getAdminPath()+"/kerz/rcGdjs/?repage";
	}
	
	/**
	 * 删除股东家属
	 */
	@RequiresPermissions("kerz:rcGdjs:del")
	@RequestMapping(value = "delete")
	public String delete(RcGdjs rcGdjs, RedirectAttributes redirectAttributes) {
		rcGdjsService.delete(rcGdjs);
		addMessage(redirectAttributes, "删除股东家属成功");
		return "redirect:"+Global.getAdminPath()+"/kerz/rcGdjs/?repage";
	}
	
	/**
	 * 批量删除股东家属
	 */
	@RequiresPermissions("kerz:rcGdjs:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			rcGdjsService.delete(rcGdjsService.get(id));
		}
		addMessage(redirectAttributes, "删除股东家属成功");
		return "redirect:"+Global.getAdminPath()+"/kerz/rcGdjs/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("kerz:rcGdjs:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(RcGdjs rcGdjs, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "股东家属"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<RcGdjs> page = rcGdjsService.findPage(new Page<RcGdjs>(request, response, -1), rcGdjs);
    		new ExportExcel("股东家属", RcGdjs.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出股东家属记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/kerz/rcGdjs/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("kerz:rcGdjs:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<RcGdjs> list = ei.getDataList(RcGdjs.class);
			for (RcGdjs rcGdjs : list){
				try{
					rcGdjsService.save(rcGdjs);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条股东家属记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条股东家属记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入股东家属失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/kerz/rcGdjs/?repage";
    }
	
	/**
	 * 下载导入股东家属数据模板
	 */
	@RequiresPermissions("kerz:rcGdjs:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "股东家属数据导入模板.xlsx";
    		List<RcGdjs> list = Lists.newArrayList(); 
    		new ExportExcel("股东家属数据", RcGdjs.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/kerz/rcGdjs/?repage";
    }
	
	
	

}