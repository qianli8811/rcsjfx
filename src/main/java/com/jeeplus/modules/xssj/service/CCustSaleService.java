/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.xssj.service;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import com.jeeplus.modules.xssj.entity.CCustsaleTj;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.xssj.entity.CCustSale;
import com.jeeplus.modules.xssj.dao.CCustSaleDao;

/**
 * 企业核心数据Service
 * @author admin
 * @version 2018-03-03
 */
@Service
@Transactional(readOnly = true)
public class CCustSaleService extends CrudService<CCustSaleDao, CCustSale> {
	
	private String getBenNianTable(){
		Calendar date = Calendar.getInstance();
		return "c_cust_sale"+date.get(Calendar.YEAR);
	}
	public CCustSale get(String id) {
		return super.get(id);
	}
	
	public List<CCustSale> findList(CCustSale cCustSale) {
		cCustSale.setTableName(getBenNianTable());
		return super.findList(cCustSale);
	}
	
	public Page<CCustSale> findPage(Page<CCustSale> page, CCustSale cCustSale) {
		cCustSale.setTableName(getBenNianTable());
		return super.findPage(page, cCustSale);
	}
	
	@Transactional(readOnly = false)
	public void save(CCustSale cCustSale) {
		cCustSale.setTableName(getBenNianTable());
		super.save(cCustSale);
	}
	
	@Transactional(readOnly = false)
	public void delete(CCustSale cCustSale) {
		cCustSale.setTableName(getBenNianTable());
		super.delete(cCustSale);
	}
	
	public List<CCustsaleTj> getXssjtj(CCustsaleTj cCustsaleTj){
		cCustsaleTj.setTableName(getBenNianTable());
		return dao.getXssjtj(cCustsaleTj);
	}
	
	/**
	 * 词汇联想
	 */
	public List<Map<String,String>> searchByLike(String name){
		return dao.searchByLike(name);
	}
	
	
	
	
}