/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.fptj.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.fptj.entity.JxCy;
import com.jeeplus.modules.fptj.dao.JxCyDao;

/**
 * 进项抽样统计Service
 * @author admin
 * @version 2018-03-12
 */
@Service
@Transactional(readOnly = true)
public class JxCyService extends CrudService<JxCyDao, JxCy> {

	public JxCy get(String id) {
		return super.get(id);
	}
	
	public List<JxCy> findList(JxCy jxCy) {
		return super.findList(jxCy);
	}
	
	public Page<JxCy> findPage(Page<JxCy> page, JxCy jxCy) {
		return super.findPage(page, jxCy);
	}
	
	@Transactional(readOnly = false)
	public void save(JxCy jxCy) {
		super.save(jxCy);
	}
	
	@Transactional(readOnly = false)
	public void delete(JxCy jxCy) {
		super.delete(jxCy);
	}
	
	
	
	
}