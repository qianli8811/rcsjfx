/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.fpsj.service;

import java.util.List;
import java.util.Map;

import com.jeeplus.modules.xssj.entity.CCustsaleTj;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.fpsj.entity.XxfpHead;
import com.jeeplus.modules.fpsj.dao.XxfpHeadDao;

/**
 * 发票数据Service
 * @author admin
 * @version 2018-02-24
 */
@Service
@Transactional(readOnly = true)
public class XxfpHeadService extends CrudService<XxfpHeadDao, XxfpHead> {

	public XxfpHead get(String id) {
		return super.get(id);
	}
	
	public List<XxfpHead> findList(XxfpHead xxfpHead) {
		return super.findList(xxfpHead);
	}
	
	public Page<XxfpHead> findPage(Page<XxfpHead> page, XxfpHead xxfpHead) {
		return super.findPage(page, xxfpHead);
	}
	
	@Transactional(readOnly = false)
	public void save(XxfpHead xxfpHead) {
		super.save(xxfpHead);
	}
	
	@Transactional(readOnly = false)
	public void delete(XxfpHead xxfpHead) {
		super.delete(xxfpHead);
	}
	
	public List<String> getXxGsName(){
		return  dao.getXxGsName();
	}
	
	public List<Map<String,Object>> getJsyqw(CCustsaleTj cCustsaleTj){
		return  dao.getJsyqw(cCustsaleTj);
	}
	
	public List<Map<String,Object>> getGysKptjqnjnby(CCustsaleTj cCustsaleTj){
		return  dao.getGysKptjqnjnby(cCustsaleTj);
	}
}