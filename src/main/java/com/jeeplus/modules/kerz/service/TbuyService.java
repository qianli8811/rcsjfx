/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.kerz.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.modules.kerz.entity.Tbuy;
import com.jeeplus.modules.kerz.dao.TbuyDao;



/**
 * 小狐狸系统客户资料Service
 * @author admin
 * @version 2018-05-13
 */
@Service
@Transactional(readOnly = true)
public class TbuyService extends CrudService<TbuyDao, Tbuy> {

	
	public Tbuy get(String id) {
		Tbuy tbuy = super.get(id);
		return tbuy;
	}
	
	public List<Tbuy> findList(Tbuy tbuy) {
		return super.findList(tbuy);
	}
	
	public Page<Tbuy> findPage(Page<Tbuy> page, Tbuy tbuy) {
		return super.findPage(page, tbuy);
	}
	
	@Transactional(readOnly = false)
	public void save(Tbuy tbuy) {
		super.save(tbuy);
	}
	
	@Transactional(readOnly = false)
	public void delete(Tbuy tbuy) {
		super.delete(tbuy);
	}
	
	
}