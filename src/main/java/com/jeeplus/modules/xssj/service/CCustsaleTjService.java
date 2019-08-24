/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.xssj.service;

import java.text.SimpleDateFormat;
import java.util.*;

import com.jeeplus.common.utils.IdGen;
import com.jeeplus.common.utils.ListUtils;
import com.jeeplus.modules.sys.entity.User;
import com.jeeplus.modules.xssj.entity.CSxeduTj;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.xssj.entity.CCustsaleTj;
import com.jeeplus.modules.xssj.dao.CCustsaleTjDao;

/**
 * 企业核心销售数据统计Service
 * @author admin
 * @version 2018-03-20
 */
@Service
@Transactional(readOnly = true)
public class CCustsaleTjService extends CrudService<CCustsaleTjDao, CCustsaleTj> {
	
	

	public CCustsaleTj get(String id) {
		return super.get(id);
	}
	
	public List<CCustsaleTj> findList(CCustsaleTj CCustsaleTj) {
		return super.findList(CCustsaleTj);
	}
	
	public Page<CCustsaleTj> findPage(Page<CCustsaleTj> page, CCustsaleTj CCustsaleTj) {
		return super.findPage(page, CCustsaleTj);
	}
	
	@Transactional(readOnly = false)
	public void save(CCustsaleTj CCustsaleTj) {
		super.save(CCustsaleTj);
	}
	
	@Transactional(readOnly = false)
	public void delete(CCustsaleTj CCustsaleTj) {
		super.delete(CCustsaleTj);
	}
	
	/**
	 * 授信额度
	 */
	public Page getSxedu(Page page,CSxeduTj csxeduTj){
		csxeduTj.setPage(page);
		List<CSxeduTj> list = dao.getSxedu(csxeduTj);
		page.setList(list);
		return page;
	}
	private void getCCustsaleTj(CCustsaleTj cCustsaleTj){
		
		User user4 = new User();
		user4.setId("1");
		cCustsaleTj.setId(IdGen.uuid());
		cCustsaleTj.setCreateBy(user4);
		cCustsaleTj.setCreateDate(new Date());
		cCustsaleTj.setUpdateBy(user4);
		cCustsaleTj.setUpdateDate(new Date());
		//return cCustsaleTj;
	}
	
	/**
	 * c_cust_sale表数据量比较大，每年一个表，表名为c_cust_sale_2014,c_cust_sale_2015
	 * 每年的最后一天，23:59:59秒创建下一年的表结构
	 */
	@Transactional(readOnly = false)
	@Scheduled(cron = "59 59 23 31 12 ?")
	public void createTable(){
		Calendar date = Calendar.getInstance();
		String tableName = "c_cust_sale"+date.get(Calendar.YEAR);
		dao.creatBenNianTable(tableName);
	}
	
	/**
	 * 销售数据统计，为授信额度做准备，每天晚上11:59:59分执行
	 */
	@Transactional(readOnly = false)
	@Scheduled(cron = "59 59 23 * * ?")
//	@Scheduled(fixedRate = 1000 * 60000,initialDelay = 3000)
	public void sxeduTjTask(){
		Long startTime = System.currentTimeMillis();

		
		Calendar tableNamedate = Calendar.getInstance();
		String tableName = "c_cust_sale_"+tableNamedate.get(Calendar.YEAR);
	
		//tableName = "c_cust_sale_2014";
		
		CCustsaleTj cCustsaleTj = new CCustsaleTj();
		cCustsaleTj.setTableName(tableName);//表名：默认当前年份
		cCustsaleTj.setNianfen(tableNamedate.get(Calendar.YEAR));
		//cCustsaleTj.setNianfen(2018);
		
		dao.deleteByNianfen(cCustsaleTj);//删除本年度的数据
		
		cCustsaleTj.setBeginNianfen("2013-01-01");//开始时间
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String dateStr = sdf.format(date);
		cCustsaleTj.setEndNianfen(dateStr);//结束时间

		/*List<CCustsaleTj> lists1 = new ArrayList<CCustsaleTj>();
		List<CCustsaleTj> lists2 = new ArrayList<CCustsaleTj>();
		List<CCustsaleTj> lists3 = new ArrayList<CCustsaleTj>();
		List<CCustsaleTj> lists4 = new ArrayList<CCustsaleTj>();
		List<CCustsaleTj> lists5 = new ArrayList<CCustsaleTj>();*/
		cCustsaleTj.setTjname(1);//销售收入
		List<CCustsaleTj> xssr = dao.getXssjtj(cCustsaleTj);

		List<List<CCustsaleTj>> lists = ListUtils.splitList(xssr, 5000);
		for (int i=0;i<lists.size();i++){
			List<CCustsaleTj> cCustsaleTjs = lists.get(i);
			for(int j=0;j<cCustsaleTjs.size();j++){
				getCCustsaleTj(cCustsaleTjs.get(j));
			}
			dao.insertBatch(cCustsaleTjs);
		}

		/*for(int i = 0;i<xssr.size();i++){
			CCustsaleTj cCustsaleTj1 = xssr.get(i);
			*//*if(cCustsaleTj1.getCkname().equals("临汾丰华油脂有限公司")){
				System.out.println(cCustsaleTj1.toString());
			}*//*
			CCustsaleTj cCustsaleTj2 = getCCustsaleTj(cCustsaleTj1);
			if(i>=0 && i <= 1000){
				lists1.add(cCustsaleTj2);
			}
			if(i >= 1001 && i <= 2000){
				lists2.add(cCustsaleTj2);
			}
			if(i >= 2001 && i <= 3000){
				lists3.add(cCustsaleTj2);
			}
			if(i >= 3001 && i <= 4000){
				lists4.add(cCustsaleTj2);
			}else{
				lists5.add(cCustsaleTj2);
			}
			
		}*/
		
		/*if(lists1.size()>0){
			dao.insertBatch(lists1);
		}
		if(lists2.size()>0){
			dao.insertBatch(lists2);
		}
		if(lists3.size()>0){
			dao.insertBatch(lists3);
		}
		if(lists4.size()>0){
			dao.insertBatch(lists4);
		}if(lists5.size()>0){
			dao.insertBatch(lists5);
		}*/
		/*lists = new ArrayList<CCustsaleTj>();
		cCustsaleTj.setTjname(2);//净值
		List<CCustsaleTj> jingzhi = dao.getXssjtj(cCustsaleTj);
		for(CCustsaleTj cCustsaleTj2 : jingzhi){
			cCustsaleTj2 = getCCustsaleTj(cCustsaleTj2);
			lists.add(cCustsaleTj2);
		}
		if(lists.size()>0){
			dao.insertBatch(lists);
		}
		
		lists = new ArrayList<CCustsaleTj>();
		cCustsaleTj.setTjname(3);//税额
		List<CCustsaleTj> shuie = dao.getXssjtj(cCustsaleTj);
		for(CCustsaleTj cCustsaleTj3 : shuie){
			cCustsaleTj3 = getCCustsaleTj(cCustsaleTj3);
			lists.add(cCustsaleTj3);
		}
		if(lists.size()>0){
			dao.insertBatch(lists);
		}
		
		lists = new ArrayList<CCustsaleTj>();
		cCustsaleTj.setTjname(4);//战略价金额
		List<CCustsaleTj> zhanlvjiajine = dao.getXssjtj(cCustsaleTj);
		for(CCustsaleTj cCustsaleTj4 : zhanlvjiajine){
			cCustsaleTj4 = getCCustsaleTj(cCustsaleTj4);
			lists.add(cCustsaleTj4);
		}
		if(lists.size()>0){
			dao.insertBatch(lists);
		}*/
		Long endtTime = System.currentTimeMillis();
		System.out.println("共耗时："+(endtTime-startTime)/1000+"秒");
	}
	/**
	 * 统计每个公司，每年月的销售收入，净值，税额，战略价金额
	 */
	public List<CCustsaleTj> getXssjtj(CCustsaleTj cCustsaleTj){
		return dao.getXssjtj(cCustsaleTj);

	}

	
}