/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.kerz.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.kerz.entity.RcGdjs;
import com.jeeplus.modules.kerz.dao.RcGdjsDao;

/**
 * 股东家属信息Service
 * @author admin
 * @version 2018-04-18
 */
@Service
@Transactional(readOnly = true)
public class RcGdjsService extends CrudService<RcGdjsDao, RcGdjs> {

	public RcGdjs get(String id) {
		return super.get(id);
	}
	
	public List<RcGdjs> findList(RcGdjs rcGdjs) {
		return super.findList(rcGdjs);
	}
	
	public Page<RcGdjs> findPage(Page<RcGdjs> page, RcGdjs rcGdjs) {
		return super.findPage(page, rcGdjs);
	}
	
	@Transactional(readOnly = false)
	public void save(RcGdjs rcGdjs) {
		super.save(rcGdjs);
	}
	
	@Transactional(readOnly = false)
	public void delete(RcGdjs rcGdjs) {
		super.delete(rcGdjs);
	}
	
	
	
	
}