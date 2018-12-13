/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.fptj.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.fptj.entity.XxCy;
import com.jeeplus.modules.fptj.dao.XxCyDao;

/**
 * 销项抽样统计Service
 * @author admin
 * @version 2018-03-12
 */
@Service
@Transactional(readOnly = true)
public class XxCyService extends CrudService<XxCyDao, XxCy> {

	public XxCy get(String id) {
		return super.get(id);
	}
	
	public List<XxCy> findList(XxCy xxCy) {
		return super.findList(xxCy);
	}
	
	public Page<XxCy> findPage(Page<XxCy> page, XxCy xxCy) {
		return super.findPage(page, xxCy);
	}
	
	@Transactional(readOnly = false)
	public void save(XxCy xxCy) {
		super.save(xxCy);
	}
	
	@Transactional(readOnly = false)
	public void delete(XxCy xxCy) {
		super.delete(xxCy);
	}
	
	
	
	
}