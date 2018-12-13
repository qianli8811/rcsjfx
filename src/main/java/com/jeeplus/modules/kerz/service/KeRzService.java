/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.kerz.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.kerz.entity.KeRz;
import com.jeeplus.modules.kerz.dao.KeRzDao;

/**
 * 客户融资Service
 * @author admin
 * @version 2018-03-10
 */
@Service
@Transactional(readOnly = true)
public class KeRzService extends CrudService<KeRzDao, KeRz> {

	public KeRz get(String id) {
		return super.get(id);
	}
	
	public List<KeRz> findList(KeRz keRz) {
		return super.findList(keRz);
	}
	
	public Page<KeRz> findPage(Page<KeRz> page, KeRz keRz) {
		return super.findPage(page, keRz);
	}
	
	@Transactional(readOnly = false)
	public void save(KeRz keRz) {
		super.save(keRz);
	}
	
	@Transactional(readOnly = false)
	public void delete(KeRz keRz) {
		super.delete(keRz);
	}
	
	/**
	 * 统计生意资金构成
	 * @param keRz
	 * @return
	 */
	public List<Map<String,Object>> getSyzjgc(KeRz keRz){
		return  dao.getSyzjgc(keRz);
	}
	
	
}