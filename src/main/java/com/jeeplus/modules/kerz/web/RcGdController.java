/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.kerz.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.modules.kerz.entity.RcKhzl;
import com.jeeplus.modules.kerz.service.RcKhzlService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jeeplus.common.utils.MyBeanUtils;
import com.jeeplus.common.config.Global;
import com.jeeplus.common.web.BaseController;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.modules.kerz.entity.RcGd;
import com.jeeplus.modules.kerz.service.RcGdService;

/**
 * 股东管理Controller
 * @author admin
 * @version 2018-03-16
 */
@Controller
@RequestMapping(value = "${adminPath}/kerz/rcGd")
public class RcGdController extends BaseController {

	@Autowired
	private RcGdService rcGdService;
	
	@Autowired
	private RcKhzlService rcKhzlService;
	
	@ModelAttribute
	public RcGd get(@RequestParam(required=false) String id) {
		RcGd entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = rcGdService.get(id);
		}
		if (entity == null){
			entity = new RcGd();
		}
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value = "getGdxm")
	public List<RcKhzl> getGdxm(){
		List<RcKhzl> gdxm = rcKhzlService.getGdxm();
		return gdxm;
	}
	
	/**
	 * 股东管理列表页面
	 */
	/*@RequiresPermissions("kerz:rcGd:list")*/
	@RequestMapping(value = {"list", ""})
	public String list(RcGd rcGd, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		Page<RcGd> page = rcGdService.findPage(new Page<RcGd>(request, response), rcGd);
//		List<RcGd> list = page.getList();
//		List<RcGd> list1 = new ArrayList<RcGd>();
//		if (null != list && list.size() > 0) {
//			for (RcGd rcGd1 : list) {
//				list1.add(rcGd1);
//			}
//			page.setList(list1);
//		}
		
		model.addAttribute("page", page).addAttribute("rcGd", rcGd);
		return "modules/kerz/rcGdList";
	}

	/**
	 * 查看，增加，编辑股东管理表单页面
	 */
	/*@RequiresPermissions(value={"kerz:rcGd:view","kerz:rcGd:add","kerz:rcGd:edit"},logical=Logical.OR)*/
	@RequestMapping(value = "form")
	public String form(RcGd rcGd, Model model) {
		if(null!=rcGd && null!=rcGd.getRcKhzl() && StringUtils.isNotBlank(rcGd.getRcKhzl().getId())){
			rcGd.setRcKhzl(rcKhzlService.get(rcGd.getRcKhzl().getId()));
		}
		if (rcGd.getParent()!=null && StringUtils.isNotBlank(rcGd.getParent().getId())){
			rcGd.setParent(rcGdService.get(rcGd.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(rcGd.getId())){
				RcGd rcGdChild = new RcGd();
				rcGdChild.setParent(new RcGd(rcGd.getParent().getId()));
				List<RcGd> list = rcGdService.findList(rcGd); 
				if (list.size() > 0){
					rcGd.setSort(list.get(list.size()-1).getSort());
					if (rcGd.getSort() != null){
						rcGd.setSort(rcGd.getSort() + 30);
					}
				}
			}
		}
		if (rcGd.getSort() == null){
			rcGd.setSort(30);
		}
		model.addAttribute("rcGd", rcGd);
		return "modules/kerz/rcGdForm";
	}

	/**
	 * 保存股东管理
	 */
	/*@RequiresPermissions(value={"kerz:rcGd:add","kerz:rcGd:edit"},logical=Logical.OR)*/
	@RequestMapping(value = "save")
	public String save(RcGd rcGd, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, rcGd)){
			return form(rcGd, model);
		}
		if(!rcGd.getIsNewRecord()){//编辑表单保存
			RcGd t = rcGdService.get(rcGd.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(rcGd, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			rcGdService.save(t);//保存
		}else{//新增表单保存
			rcGdService.save(rcGd);//保存
		}
		addMessage(redirectAttributes, "保存股东管理成功");
		return "redirect:"+Global.getAdminPath()+"/kerz/rcGd/?repage";
		
	}
	
	/**
	 * 删除股东管理
	 */
	/*@RequiresPermissions("kerz:rcGd:del")*/
	@RequestMapping(value = "delete")
	public String delete(RcGd rcGd, RedirectAttributes redirectAttributes) {
		rcGdService.delete(rcGd);
		addMessage(redirectAttributes, "删除股东成功");
		return "redirect:"+Global.getAdminPath()+"/kerz/rcGd/?repage";
	}

	/*@RequiresPermissions("user")*/
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId,RcGd rcGd,Model model, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		if(null == rcGd || null == rcGd.getRcKhzl() || StringUtils.isBlank(rcGd.getRcKhzl().getId())){
			RcGd parent = new RcGd();
			parent.setId("0");
			rcGd.setParent(parent);//根节点
		}
		List<RcGd> list = rcGdService.findList(rcGd);

		for (int i=0; i<list.size(); i++){
			RcGd e = list.get(i);
			
//			Map<String, Object> map = Maps.newHashMap();
//			map.put("id", e.getId());
//			map.put("pId", e.getParentId());
//
//			if(StringUtils.isBlank(e.getName())){
//				e.setName(e.getGdxm());
//			}
//			map.put("name", e.getName());
//			mapList.add(map);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				
				if(StringUtils.isBlank(e.getName())){
					e.setName(e.getGdxm());
				}
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		
		return mapList;
	}
	
}