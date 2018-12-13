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
import com.jeeplus.modules.fpsj.entity.JxfpItem;
import com.jeeplus.modules.fpsj.dao.JxfpItemDao;

/**
 * 发票数据Service
 * @author admin
 * @version 2018-02-24
 */
@Service
@Transactional(readOnly = true)
public class JxfpItemService extends CrudService<JxfpItemDao, JxfpItem> {

	public JxfpItem get(String id) {
		return super.get(id);
	}
	
	public List<JxfpItem> findList(JxfpItem jxfpItem) {
		return super.findList(jxfpItem);
	}
	
	public Page<JxfpItem> findPage(Page<JxfpItem> page, JxfpItem jxfpItem) {
		return super.findPage(page, jxfpItem);
	}
	
	@Transactional(readOnly = false)
	public void save(JxfpItem jxfpItem) {
		super.save(jxfpItem);
	}
	
	@Transactional(readOnly = false)
	public void delete(JxfpItem jxfpItem) {
		super.delete(jxfpItem);
	}
	
	public List<Map<String,Object>> getGyskpsj(CCustsaleTj cCustsaleTj){
		return dao.getGyskpsj(cCustsaleTj);
	}
	
	
}