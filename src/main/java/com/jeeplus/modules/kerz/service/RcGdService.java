/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.kerz.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.service.TreeService;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.modules.kerz.entity.RcGd;
import com.jeeplus.modules.kerz.dao.RcGdDao;

/**
 * 客户管理Service
 * @author admin
 * @version 2018-03-16
 */
@Service
@Transactional(readOnly = true)
public class RcGdService extends TreeService<RcGdDao, RcGd> {

	public RcGd get(String id) {
		return super.get(id);
	}
	
	public List<RcGd> findList(RcGd rcGd) {
		if (StringUtils.isNotBlank(rcGd.getParentIds())){
			rcGd.setParentIds(","+rcGd.getParentIds()+",");
		}
		return super.findList(rcGd);
	}
	
	@Transactional(readOnly = false)
	public void save(RcGd rcGd) {
		super.save(rcGd);
	}
	
	@Transactional(readOnly = false)
	public void delete(RcGd rcGd) {
		super.delete(rcGd);
	}
	
}