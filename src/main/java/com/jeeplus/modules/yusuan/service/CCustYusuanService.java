/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.yusuan.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.yusuan.entity.CCustYusuan;
import com.jeeplus.modules.yusuan.dao.CCustYusuanDao;

/**
 * 客户预算Service
 * @author admin
 * @version 2018-04-21
 */
@Service
@Transactional(readOnly = true)
public class CCustYusuanService extends CrudService<CCustYusuanDao, CCustYusuan> {

	public CCustYusuan get(String id) {
		return super.get(id);
	}
	
	public List<CCustYusuan> findList(CCustYusuan cCustYusuan) {
		return super.findList(cCustYusuan);
	}
	
	public Page<CCustYusuan> findPage(Page<CCustYusuan> page, CCustYusuan cCustYusuan) {
		return super.findPage(page, cCustYusuan);
	}
	
	@Transactional(readOnly = false)
	public void save(CCustYusuan cCustYusuan) {
		super.save(cCustYusuan);
	}
	
	@Transactional(readOnly = false)
	public void delete(CCustYusuan cCustYusuan) {
		super.delete(cCustYusuan);
	}
	
	
	
	
}