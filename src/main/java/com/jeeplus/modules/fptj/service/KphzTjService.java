/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.fptj.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.fptj.entity.KphzTj;
import com.jeeplus.modules.fptj.dao.KphzTjDao;

/**
 * 开票汇总统计Service
 * @author admin
 * @version 2018-03-12
 */
@Service
@Transactional(readOnly = true)
public class KphzTjService extends CrudService<KphzTjDao, KphzTj> {

	public KphzTj get(String id) {
		return super.get(id);
	}
	
	public List<KphzTj> findList(KphzTj kphzTj) {
		return super.findList(kphzTj);
	}
	
	public Page<KphzTj> findPage(Page<KphzTj> page, KphzTj kphzTj) {
		return super.findPage(page, kphzTj);
	}
	
	@Transactional(readOnly = false)
	public void save(KphzTj kphzTj) {
		super.save(kphzTj);
	}
	
	@Transactional(readOnly = false)
	public void delete(KphzTj kphzTj) {
		super.delete(kphzTj);
	}
	
	
	
	
}