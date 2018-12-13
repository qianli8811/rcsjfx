/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.kerz.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.kerz.entity.RcGdxx;
import com.jeeplus.modules.kerz.dao.RcGdxxDao;

/**
 * 股东信息Service
 * @author admin
 * @version 2018-04-18
 */
@Service
@Transactional(readOnly = true)
public class RcGdxxService extends CrudService<RcGdxxDao, RcGdxx> {

	public RcGdxx get(String id) {
		return super.get(id);
	}
	
	public List<RcGdxx> findList(RcGdxx rcGdxx) {
		return super.findList(rcGdxx);
	}
	
	public Page<RcGdxx> findPage(Page<RcGdxx> page, RcGdxx rcGdxx) {
		return super.findPage(page, rcGdxx);
	}
	
	@Transactional(readOnly = false)
	public void save(RcGdxx rcGdxx) {
		super.save(rcGdxx);
	}
	
	@Transactional(readOnly = false)
	public void delete(RcGdxx rcGdxx) {
		super.delete(rcGdxx);
	}
	

	
	
	
}