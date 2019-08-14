/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.kerz.web;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import com.jeeplus.common.mapper.JsonMapper;
import com.jeeplus.common.utils.CacheUtils;
import com.jeeplus.modules.fpsj.entity.JxfpHead;
import com.jeeplus.modules.fpsj.entity.JxfpItem;
import com.jeeplus.modules.fpsj.service.JxfpHeadService;
import com.jeeplus.modules.fpsj.service.JxfpItemService;
import com.jeeplus.modules.fpsj.service.XxfpHeadService;
import com.jeeplus.modules.kerz.entity.*;
import com.jeeplus.modules.kerz.service.*;
import com.jeeplus.modules.xssj.entity.CCustsaleTj;
import com.jeeplus.modules.xssj.service.CCustsaleTjService;
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

/**
 * 客户管理Controller
 * @author admin
 * @version 2018-03-13
 */
@Controller
@RequestMapping(value = "${adminPath}/kerz/rcKhzl")
public class RcKhzlController extends BaseController {

	@Autowired
	private RcKhzlService rcKhzlService;
	

	
	@Autowired
	private KeRzService keRzService;
	
	@Autowired
	private CCustsaleTjService cCustsaleTjService;
	
	@Autowired
	private JxfpHeadService jxfpHeadService;
	@Autowired
	private JxfpItemService jxfpItemService;
	@Autowired
	private XxfpHeadService xxfpHeadService;

	@Autowired
	private RcGdjsService rcGdjsService;
	@Autowired
	private RcGdxxService rcGdxxService;

	@ModelAttribute
	public RcKhzl get(@RequestParam(required=false) String id) {
		RcKhzl entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = rcKhzlService.get(id);
		}
		if (entity == null){
			entity = new RcKhzl();
		}
		return entity;
	}
	
	/**
	 * 客户管理列表页面
	 */
	@RequiresPermissions("kerz:rcKhzl:list")
	@RequestMapping(value = {"list", ""})
	public String list(RcKhzl rcKhzl, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<RcKhzl> page = rcKhzlService.findPage(new Page<RcKhzl>(request, response), rcKhzl);
		/*List<RcKhzl> list = page.getList();
		if(null != list && list.size()>0){
			for (RcKhzl rcKhzl1 :list ){
				RcGd rcGd = new RcGd();
				rcGd.setKhzl(rcKhzl1);
				rcKhzl1.setRcGdList(rcGdService.findList(rcGd));
			}
		}
		*/
		model.addAttribute("page", page);
		return "modules/kerz/rcKhzlList";
	}

	/**
	 * 查看，增加，编辑客户管理表单页面
	 */
	@RequiresPermissions(value={"kerz:rcKhzl:view","kerz:rcKhzl:add","kerz:rcKhzl:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(RcKhzl rcKhzl, Model model) {
		
		/*
		 * 获取数据库中最大的简码，如果没有，则设置简码为：RG00000001
		 */
		RcKhzl maxKhjm = rcKhzlService.getMaxKhjm();
		String str = "";
		if(null != maxKhjm && StringUtils.isNotBlank(maxKhjm.getKhjm())){
			String substring = maxKhjm.getKhjm().substring(2, maxKhjm.getKhjm().length() - 1);
			String subPre = maxKhjm.getKhjm().substring(0, 2);
			if(StringUtils.isNotBlank(substring)){
				Integer kjnum = Integer.valueOf(substring);
				String str1 = (kjnum+1) + "";
				int t = 8 - str1.length();
				for(int i=0;i<t; i++){
					str1 = "0" + str1;
				}
				str = "RG"+ str1;
			}
		}else {
			str ="RG00000001" ;
		}
		
		
		if(rcKhzl != null ){
			if(StringUtils.isBlank(rcKhzl.getKhjm())){
				rcKhzl.setKhjm(str);
			}
		}
		
		RcGd rcGd = new RcGd();
		rcGd.setKhzl(rcKhzl);
		//rcKhzl.setRcGdList(rcGdService.findList(rcGd));
		
		model.addAttribute("rcKhzl", rcKhzl);
		return "modules/kerz/rcKhzlForm";
	}

	/**
	 * 保存客户管理
	 */
	@RequiresPermissions(value={"kerz:rcKhzl:add","kerz:rcKhzl:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(RcKhzl rcKhzl, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, rcKhzl)){
			return form(rcKhzl, model);
		}
		/*List<RcGd> rcGdList = rcKhzl.getRcGdList();
		
		if(!rcKhzl.getIsNewRecord()){//编辑表单保存
			RcKhzl t = rcKhzlService.get(rcKhzl.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(rcKhzl, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			rcKhzlService.save(t);//保存
		}else{//新增表单保存
			rcKhzlService.save(rcKhzl);//保存
		}
		if(null != rcGdList && rcGdList.size()>0){
			for(RcGd rcGd : rcGdList){
				RcGd rcGd1 = rcGdService.get(rcGd);
				if(null != rcGd1 && StringUtils.isNotBlank(rcGd1.getId())){
					rcGd.setId(rcGd1.getId());
				}
				rcGd.setKhzl(rcKhzl);
				rcGdService.save(rcGd);
			}
		}
		*/
		addMessage(redirectAttributes, "保存客户信息成功");
		return "redirect:"+Global.getAdminPath()+"/kerz/rcKhzl/?repage";
	}
	/**
	 * 查看，增加，编辑客户融资表单页面
	 */
	@RequiresPermissions(value={"kerz:keRz:view","kerz:keRz:add","kerz:keRz:edit"},logical=Logical.OR)
	@RequestMapping(value = "keRzzlForm")
	public String form(KeRz keRz, Model model) {
		if(null != keRz && null != keRz.getRckhzl() && StringUtils.isNotBlank(keRz.getRckhzl().getId())){
			keRz.setRckhzl(rcKhzlService.get(keRz.getRckhzl().getId()));
		}
		
		model.addAttribute("keRz", keRz);
		return "modules/kerz/keRzzlForm";
	}
	
	/**
	 * 保存客户融资
	 */
	@RequiresPermissions(value={"kerz:keRz:add","kerz:keRz:edit"},logical=Logical.OR)
	@RequestMapping(value = "saveKeRzzl")
	public String saveKeRzzl(KeRz keRz, Model model, RedirectAttributes redirectAttributes) throws Exception{
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
		
		return "modules/kerz/keRzzlForm?rckhzl.id="+keRz.getRckhzl().getId();
	}
	/**
	 * 删除客户管理
	 */
	@RequiresPermissions("kerz:rcKhzl:del")
	@RequestMapping(value = "delete")
	public String delete(RcKhzl rcKhzl, RedirectAttributes redirectAttributes) {
		rcKhzlService.delete(rcKhzl);
		addMessage(redirectAttributes, "删除客户管理成功");
		return "redirect:"+Global.getAdminPath()+"/kerz/rcKhzl/?repage";
	}
	
	/**
	 * 批量删除客户管理
	 */
	@RequiresPermissions("kerz:rcKhzl:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			rcKhzlService.delete(rcKhzlService.get(id));
		}
		addMessage(redirectAttributes, "删除客户管理成功");
		return "redirect:"+Global.getAdminPath()+"/kerz/rcKhzl/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("kerz:rcKhzl:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(RcKhzl rcKhzl, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "客户管理"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<RcKhzl> page = rcKhzlService.findPage(new Page<RcKhzl>(request, response, -1), rcKhzl);
    		new ExportExcel("客户管理", RcKhzl.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出客户管理记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/kerz/rcKhzl/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("kerz:rcKhzl:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<RcKhzl> list = ei.getDataList(RcKhzl.class);
			for (RcKhzl rcKhzl : list){
				try{
					rcKhzlService.save(rcKhzl);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条客户管理记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条客户管理记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入客户管理失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/kerz/rcKhzl/?repage";
    }
	
	/**
	 * 下载导入客户管理数据模板
	 */
	@RequiresPermissions("kerz:rcKhzl:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "客户管理数据导入模板.xlsx";
    		List<RcKhzl> list = Lists.newArrayList(); 
    		new ExportExcel("", RcKhzl.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/kerz/rcKhzl/?repage";
    }
	
	
	@RequestMapping(value = "getCityNum")
	@ResponseBody
	public List getCityNum() {
		List<Map<String,Object>> cityNum = rcKhzlService.getCityNum();
		return cityNum;
	}
	@RequestMapping(value = "getRcKhzlmc")
	@ResponseBody
	public String getRcKhzlmc(RcKhzl rcKhzl) {
		List<RcKhzl> rcKhzls = (List<RcKhzl>)CacheUtils.get("");
		if(null == rcKhzls || rcKhzls.size()<=0){
			rcKhzls = rcKhzlService.getAllRcKhzl(rcKhzl);
			CacheUtils.put("rcKhzlsGsMX",rcKhzls);
		}
		
		return JsonMapper.toJsonString(rcKhzls);
	}
	
	
	@RequestMapping(value = "getGdjg")
	public String getGdjg(Gdfxtj gdfxtj, Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		Page<Gdfxtj> page1 = rcKhzlService.getGdjg(new Page<Gdfxtj>(request, response),gdfxtj);
		
		
		model.addAttribute("page", page1);
		model.addAttribute("gdfxtj", gdfxtj);
		return "modules/kerz/getGdjg";
	}
	
	
	@RequestMapping(value = "getKhfx")
	public String getKhfx(RcKhzl rcKhzl, Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		
		//查询客户资料
		RcKhzl rcKhzl1 = rcKhzlService.get(rcKhzl);
		if(null != rcKhzl1 ){
			model.addAttribute("rcKhzl1", rcKhzl1);

			RcGdxx rcGdxx = new RcGdxx();

			/*RcGd rc = new RcGd();
			//rcGdxx.setKhzl(rcKhzl1);*/
			rcGdxx.setRcKhzl(rcKhzl1);

			//获取股东信息
			List<RcGdxx> rcGdList = rcGdxxService.findList(rcGdxx);

			Map<RcGdxx,List<RcGdjs>> gdMap = new HashMap<RcGdxx,List<RcGdjs>>();
			if(null != rcGdList && rcGdList.size()>0){
				for(RcGdxx rcGdxx1 : rcGdList){
					/**
					 * 股东家属信息
					 */
					List<RcGdjs> rcgdList = new ArrayList<RcGdjs>();
					/*String id = rcGd.getId();*/
					RcGdjs rcGdjs = new RcGdjs();
					rcGdjs.setRcGdxx(rcGdxx1);
					List<RcGdjs> list = rcGdjsService.findList(rcGdjs);
					gdMap.put(rcGdxx1,list);


					/*for(RcGd rcGd1 : rcGdList){
						if(rcGd.getId().equals(rcGd1.getParentId())){
							rcgdList.add(rcGd1);
						}
					}
					gdMap.put(rcGd,rcgdList);*/
				}
			}
			model.addAttribute("gdMap", gdMap);
			
			
			
			
			KeRz keRz = new KeRz();
			keRz.setRckhzl(rcKhzl1);
			keRz.setIsJq("0");
			//生意资金构成
			List<Map<String, Object>> syzjgc = keRzService.getSyzjgc(keRz);
			
			
			
			
			//未结清款项明细
			List<KeRz> keRzlist = keRzService.findList(keRz);
			model.addAttribute("keRzlist", keRzlist);
			
			
			
			//客户销售数据汇总
			String beginNianfen = request.getParameter("beginNianfen");
			String endNianfen = request.getParameter("endNianfen");
			String tjName = request.getParameter("tjName");
			CCustsaleTj cCustsaleTj = new CCustsaleTj();
			//统计字段
			if(StringUtils.isNotBlank(tjName)){
				cCustsaleTj.setTjname(Integer.valueOf(tjName));
			}
			//公司名称
			cCustsaleTj.setCkname(rcKhzl1.getKhmc());
			//时间段,默认为去年至现在的时间
			Calendar date = Calendar.getInstance();	//当前年份
			if(StringUtils.isNotBlank(beginNianfen) && StringUtils.isNotBlank(endNianfen)){
				cCustsaleTj.setBeginNianfen(beginNianfen);//开始时间
				cCustsaleTj.setEndNianfen(endNianfen);//结束时间
			}else{
				String year = String.valueOf(date.get(Calendar.YEAR));
				Integer bgNian = Integer.valueOf(year);
				cCustsaleTj.setBeginNianfen((bgNian-1)+"");
				cCustsaleTj.setEndNianfen(year);//结束时间
			}
			
			
			
			CCustsaleTj cCustsaleTj1 = new CCustsaleTj();
			cCustsaleTj1.setTjname(1);
			cCustsaleTj1.setCkname(rcKhzl1.getKhmc());
			List<CCustsaleTj> xse = cCustsaleTjService.findList(cCustsaleTj);
			Double num = 0.00;
			if(null != xse && xse.size()>0){
				num = xse.get(0).getNum();
			}
			
			//推算生意资金构成：中粮销售额/周转次数除以销售占比减去银行融资，民间借贷，保理融资
			Integer zjzzcs = rcKhzl1.getZjzzcs();//资金周转次数
			Double flmzb = rcKhzl1.getFlmzb();//福临门销售占比
			Double ynrz = 0.00;//银行融资
			Double mjjd = 0.00;//民间借贷
			Double blrz = 0.00;//保理融资
			Double zyzj = 0.00;//自有资金
			List<Map<String,Object>> shzjjg = new ArrayList<Map<String,Object>>();
			List<Map<String,Object>> tshzjjg = new ArrayList<Map<String,Object>>();
			for(int i = 0;i < syzjgc.size();i++){
				Map<String, Object> map = syzjgc.get(i);
				Object name = map.get("name");
				
				if(null != name){
					if("1".equals(name.toString())){
						//银行融资
						
						Map<String,Object> map1 = new HashMap<String,Object>();
						map1.put("name","银行融资");
						
						for(Iterator<Map.Entry<String, Object>> iterator = map.entrySet().iterator();iterator.hasNext();){
							Object value = iterator.next().getValue();
							ynrz = Double.valueOf(value.toString());
						}
						map1.put("value",ynrz);
						shzjjg.add(map1);
						tshzjjg.add(map1);
					}else if("2".equals(name.toString())){
						//民间借贷
						for(Iterator<Map.Entry<String, Object>> iterator = map.entrySet().iterator();iterator.hasNext();){
							Object value = iterator.next().getValue();
							mjjd = Double.valueOf(value.toString());
						}
						
						Map<String,Object> map1 = new HashMap<String,Object>();
						map1.put("name","民间借贷");
						map1.put("value",mjjd);
						shzjjg.add(map1);
						tshzjjg.add(map1);
					}
					if("3".equals(name.toString())){
						//保理融资
						for(Iterator<Map.Entry<String, Object>> iterator = map.entrySet().iterator();iterator.hasNext();){
							Object value = iterator.next().getValue();
							blrz = Double.valueOf(value.toString());
						}
						Map<String,Object> map1 = new HashMap<String,Object>();
						map1.put("name","保理融资");
						map1.put("value",blrz);
						shzjjg.add(map1);
						tshzjjg.add(map1);
					}
					if("4".equals(name.toString())){
						//自有资金
						for(Iterator<Map.Entry<String, Object>> iterator = map.entrySet().iterator();iterator.hasNext();){
							Object value = iterator.next().getValue();
							zyzj = Double.valueOf(name.toString());
						}
						Map<String,Object> map1 = new HashMap<String,Object>();
						map1.put("name","自有资金");
						map1.put("value",zyzj);
						shzjjg.add(map1);
					}
				}
				
			}
			//自有资金:推算
			zyzj = ((num/zjzzcs)/flmzb)-(ynrz+mjjd+blrz);
			Map<String,Object> map2 = new HashMap<String,Object>();
			map2.put("name","自有资金");
			map2.put("value",zyzj);
			tshzjjg.add(map2);
			
			String syzjgcJson = JsonMapper.toJsonString(shzjjg);
			model.addAttribute("syzjgcJson", syzjgcJson);
			
			String tshzjjgJson = JsonMapper.toJsonString(tshzjjg);
			model.addAttribute("tshzjjgJson", tshzjjgJson);
			//客户销售数据年月统计
			List<CCustsaleTj> xssjhzlist = cCustsaleTjService.findList(cCustsaleTj);
			model.addAttribute("xssjhzlist", xssjhzlist);
			//封装json格式：[
			//        {
			//            name:'蒸发量',
			//            type:'line',
			//
			//            data:[2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3]
			//        },
			//        {
			//            name:'降水量',
			//            type:'bar',
			//            data:[2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3]
			//        },
			//        {
			//            name:'平均温度',
			//            type:'line',
			//            yAxisIndex: 1,
			//            data:[2.0, 2.2, 3.3, 4.5, 6.3, 10.2, 20.3, 23.4, 23.0, 16.5, 12.0, 6.2]
			//        }
			//    ]
			List<String> strxssjhzNian = new ArrayList<String>();
			
			StringBuffer strxssjhzJson = new StringBuffer("[");
			if(null != xssjhzlist && xssjhzlist.size()>0){
				for(int i=0;i<xssjhzlist.size();i++){
					CCustsaleTj cCustsaleTj2 = xssjhzlist.get(i);
					strxssjhzNian.add(cCustsaleTj2.getNianfen()+"");
					
					strxssjhzJson.append("{");
					strxssjhzJson.append("name:'"+cCustsaleTj2.getNianfen()+"',");
					strxssjhzJson.append("type:'bar',");
					strxssjhzJson.append("data:["+
							cCustsaleTj2.getYiyue()+","+
							cCustsaleTj2.getEryue()+","+
							cCustsaleTj2.getSanyue()+","+
							cCustsaleTj2.getSiyue()+","+
							cCustsaleTj2.getWuyue()+","+
							cCustsaleTj2.getLiuyue()+","+
							cCustsaleTj2.getQiyue()+","+
							cCustsaleTj2.getBayue()+","+
							cCustsaleTj2.getJiuyue()+","+
							cCustsaleTj2.getShiyue()+","+
							cCustsaleTj2.getSyyyue()+","+
							cCustsaleTj2.getSeyyue()+"]");
					
					strxssjhzJson.append("},");
					strxssjhzJson.append("{");
					strxssjhzJson.append("name:'"+cCustsaleTj2.getNianfen()+"',");
					strxssjhzJson.append("type:'line',");
					strxssjhzJson.append("data:["+
							cCustsaleTj2.getYiyue()+","+
							cCustsaleTj2.getEryue()+","+
							cCustsaleTj2.getSanyue()+","+
							cCustsaleTj2.getSiyue()+","+
							cCustsaleTj2.getWuyue()+","+
							cCustsaleTj2.getLiuyue()+","+
							cCustsaleTj2.getQiyue()+","+
							cCustsaleTj2.getBayue()+","+
							cCustsaleTj2.getJiuyue()+","+
							cCustsaleTj2.getShiyue()+","+
							cCustsaleTj2.getSyyyue()+","+
							cCustsaleTj2.getSeyyue()+"]");
					if(i==(xssjhzlist.size()-1)){
						strxssjhzJson.append("}");
					}else{
						strxssjhzJson.append("},");
					}
				}
			}
			strxssjhzJson.append("]");
			System.out.println(strxssjhzJson.toString());
			model.addAttribute("strxssjhzNian", JsonMapper.toJsonString(strxssjhzNian));
			model.addAttribute("khxssjmxtbJson", strxssjhzJson.toString());
			/*
			 目标核心企业进货未开票数据情况： 中粮福临门
			 */
			CCustsaleTj cCustsaleTj2 = new CCustsaleTj();
			int yearInt = date.get(Calendar.YEAR);
			int monthInt = date.get(Calendar.MONTH)+1;
			cCustsaleTj2.setNianfen(yearInt);
			cCustsaleTj2.setYuefen(monthInt);
			cCustsaleTj2.setCkname(rcKhzl1.getKhmc());
			List<CCustsaleTj> kptj = jxfpHeadService.getKptj(cCustsaleTj2);//开票数据
			
			cCustsaleTj2.setBeginNianfen(yearInt+"");
			cCustsaleTj2.setEndNianfen(yearInt+"");
			cCustsaleTj2.setTjname(1);
			List<CCustsaleTj> cCustsaleTjlist = cCustsaleTjService.findList(cCustsaleTj2);//进货数据
			//未开票数据
			model.addAttribute("kpshuju", kptj).addAttribute("jhshuju", cCustsaleTjlist).addAttribute("wkpshuju", null);
			
			/*
			 * 销售客户明细：时间段：2018-1-1至今    销售额降序排列
			 */
			JxfpHead jxfpHead = new JxfpHead();
			jxfpHead.setXsfmc(rcKhzl1.getKhmc());//销售方名称（中粮福临门）
			
			Calendar calendar1 = Calendar.getInstance();
			calendar1.clear();
			calendar1.set(Calendar.YEAR, date.get(Calendar.YEAR));
			Date currYearFirst = calendar1.getTime();
			
			jxfpHead.setBeginKprq(currYearFirst);
			jxfpHead.setEndKprq(new Date());
			List<JxfpHead> jxfpHeadlist = jxfpHeadService.findList(jxfpHead);
			model.addAttribute("xskhmxjxfpHeadlist", jxfpHeadlist);
			/*
			 *近3个月前5大客户开票数据（数据取自发票数据金税发票接口-销项）
			 */
			List<Map<String, Object>> jsyqw = xxfpHeadService.getJsyqw(cCustsaleTj2);
			model.addAttribute("jsyqwMap", jsyqw);
			model.addAttribute("currentMonth", date.get(Calendar.MONTH)+1);
			model.addAttribute("currentYear", date.get(Calendar.YEAR));
			/*
			 *	供应商明细
			 */
			JxfpHead jxfpHead1 = new JxfpHead();
			jxfpHead1.setGmfmc(rcKhzl1.getKhmc());
			jxfpHead1.setBeginKprq(currYearFirst);
			jxfpHead1.setEndKprq(new Date());
			List<JxfpHead> gysjxfpHeadlist = jxfpHeadService.findList(jxfpHead1);
			model.addAttribute("gysjxfpHeadlist", gysjxfpHeadlist);
			
			/*
			 *	供应商开票数据
			 */
			CCustsaleTj cCustsaleTj3 = new CCustsaleTj();
			cCustsaleTj3.setCkname(rcKhzl1.getKhmc());
			List<Map<String, Object>> gyskpshujxfpItemlist = jxfpItemService.getGyskpsj(cCustsaleTj3);
			model.addAttribute("gyskpshujxfpItemlist", gyskpshujxfpItemlist);
			/*
			 * 供应商开票数据（数据取自发票数据金税发票接口-进项 :去年、今年、本月
			 */
			cCustsaleTj3.setNianfen(date.get(Calendar.YEAR));
			cCustsaleTj3.setYuefen(date.get(Calendar.MONTH)+1);
			List<Map<String, Object>> gyskpqnjnbn = jxfpHeadService.getGysKptjqnjnby(cCustsaleTj3);
			model.addAttribute("gyskpqnjnbnList", gyskpqnjnbn);
			/*
			开给各供应商的费用发票情况：（来源：发票接口-销项）
			 */
			List<Map<String, Object>> gyskpqnjnbnXX = xxfpHeadService.getGysKptjqnjnby(cCustsaleTj3);
			model.addAttribute("gyskpqnjnbnXX", gyskpqnjnbnXX);
			
			/*
			授信额度建议
			 */
//			CSxeduTj csxeduTj = new CSxeduTj();
//			csxeduTj.setNianfen(date.get(Calendar.YEAR));
//			csxeduTj.setYuefen(date.get(Calendar.MONTH)+1);
//			/.setTjName("1");
//			/.setKhmc(rcKhzl1.getKhmc());
//			/.setSfhz("1");
//
//			Page<CsxeduTj> page  = cCustsaleTjService.getSxedu(new Page<CsxeduTj>(request, response),csxeduTj);
//			model.addAttribute("csxeduTj", csxeduTj);
//			model.addAttribute("page", page);
			
			
			
		}
		
		
		return "modules/kerz/getKhfx";
	}
	

}