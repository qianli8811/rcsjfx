/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.fpsj.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.fpsj.entity.XxfpItem;
import com.jeeplus.modules.fpsj.dao.XxfpItemDao;

/**
 * 发票数据Service
 * @author admin
 * @version 2018-02-24
 */
@Service
@Transactional(readOnly = true)
public class XxfpItemService extends CrudService<XxfpItemDao, XxfpItem> {

	public XxfpItem get(String id) {
		return super.get(id);
	}
	
	public List<XxfpItem> findList(XxfpItem xxfpItem) {
		return super.findList(xxfpItem);
	}
	
	public Page<XxfpItem> findPage(Page<XxfpItem> page, XxfpItem xxfpItem) {
		return super.findPage(page, xxfpItem);
	}
	
	@Transactional(readOnly = false)
	public void save(XxfpItem xxfpItem) {
		super.save(xxfpItem);
	}
	
	@Transactional(readOnly = false)
	public void delete(XxfpItem xxfpItem) {
		super.delete(xxfpItem);
	}
	
	
	
	
}