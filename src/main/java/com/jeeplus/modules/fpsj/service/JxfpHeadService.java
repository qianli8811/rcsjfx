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
import com.jeeplus.modules.fpsj.entity.JxfpHead;
import com.jeeplus.modules.fpsj.dao.JxfpHeadDao;

/**
 * 发票数据Service
 * @author admin
 * @version 2018-02-24
 */
@Service
@Transactional(readOnly = true)
public class JxfpHeadService extends CrudService<JxfpHeadDao, JxfpHead> {

	public JxfpHead get(String id) {
		return super.get(id);
	}
	
	public List<JxfpHead> findList(JxfpHead jxfpHead) {
		return super.findList(jxfpHead);
	}
	
	public Page<JxfpHead> findPage(Page<JxfpHead> page, JxfpHead jxfpHead) {
		return super.findPage(page, jxfpHead);
	}
	
	@Transactional(readOnly = false)
	public void save(JxfpHead jxfpHead) {
		super.save(jxfpHead);
	}
	
	@Transactional(readOnly = false)
	public void delete(JxfpHead jxfpHead) {
		super.delete(jxfpHead);
	}
	
	public List<String> getJxGsName(){
		return  dao.getJxGsName();
	}
	
	public List<CCustsaleTj> getKptj(CCustsaleTj cCustsaleTj){
		return  dao.getKptj(cCustsaleTj);
	}
	public List<Map<String,Object>> getGysKptjqnjnby(CCustsaleTj cCustsaleTj){
		return  dao.getGysKptjqnjnby(cCustsaleTj);
	}
}