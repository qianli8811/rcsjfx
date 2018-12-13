/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.kerz.service;

import java.util.List;
import java.util.Map;

import com.jeeplus.modules.kerz.entity.Gdfxtj;
import com.jeeplus.modules.kerz.entity.RcGdxx;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.kerz.entity.RcKhzl;
import com.jeeplus.modules.kerz.dao.RcKhzlDao;

/**
 * 客户管理Service
 * @author admin
 * @version 2018-03-13
 */
@Service
@Transactional(readOnly = true)
public class RcKhzlService extends CrudService<RcKhzlDao, RcKhzl> {

	public RcKhzl get(String id) {
		return super.get(id);
	}
	
	public List<RcKhzl> findList(RcKhzl rcKhzl) {
		return super.findList(rcKhzl);
	}
	
	public Page<RcKhzl> findPage(Page<RcKhzl> page, RcKhzl rcKhzl) {
		return super.findPage(page, rcKhzl);
	}
	
	@Transactional(readOnly = false)
	public void save(RcKhzl rcKhzl) {
		super.save(rcKhzl);
	}
	
	@Transactional(readOnly = false)
	public void delete(RcKhzl rcKhzl) {
		super.delete(rcKhzl);
	}
	
	/**
	 * 查询最大的客户简码
	 */
	public RcKhzl getMaxKhjm() {
		return dao.getMaxKhjm();
	}
	
	/**
	 * 查询所有股东姓名
	 */
	public List<RcKhzl> getGdxm(){
		
		return dao.getGdxm();
	}
	
	public List<Map<String,Object>> getCityNum(){
		return dao.getCityNum();
	}
	
	/**
	 * 股东结构
	 * @return
	 */
	public Page<Gdfxtj> getGdjg(Page page, Gdfxtj gdfxtj){
		gdfxtj.setPage(page);
		List<Gdfxtj> list = dao.getGdjg(gdfxtj);
		page.setList(list);
		return page;
	}
	public List<RcKhzl> getAllRcKhzl(RcKhzl rcKhzl) {
		return dao.getAllRcKhzl(rcKhzl);
	}
}