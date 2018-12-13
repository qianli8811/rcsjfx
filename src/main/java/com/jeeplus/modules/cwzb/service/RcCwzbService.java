/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.cwzb.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.cwzb.entity.RcCwzb;
import com.jeeplus.modules.cwzb.dao.RcCwzbDao;

/**
 * 财务指标参数设置Service
 * @author admin
 * @version 2018-04-10
 */
@Service
@Transactional(readOnly = true)
public class RcCwzbService extends CrudService<RcCwzbDao, RcCwzb> {

	public RcCwzb get(String id) {
		return super.get(id);
	}
	
	public List<RcCwzb> findList(RcCwzb rcCwzb) {
		return super.findList(rcCwzb);
	}
	
	public Page<RcCwzb> findPage(Page<RcCwzb> page, RcCwzb rcCwzb) {
		return super.findPage(page, rcCwzb);
	}
	
	@Transactional(readOnly = false)
	public void save(RcCwzb rcCwzb) {
		super.save(rcCwzb);
	}
	
	@Transactional(readOnly = false)
	public void delete(RcCwzb rcCwzb) {
		super.delete(rcCwzb);
	}
	
	
	
	
}