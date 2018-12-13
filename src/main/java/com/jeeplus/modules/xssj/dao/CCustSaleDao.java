/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.xssj.dao;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.xssj.entity.CCustSale;
import com.jeeplus.modules.xssj.entity.CCustsaleTj;

import java.util.List;
import java.util.Map;

/**
 * 企业核心数据DAO接口
 * @author admin
 * @version 2018-03-03
 */
@MyBatisDao
public interface CCustSaleDao extends CrudDao<CCustSale> {

	public List<CCustsaleTj> getXssjtj(CCustsaleTj CCustsaleTj);
	/**
	 * 词汇联想
	 */
	public List<Map<String,String>> searchByLike(String name);
}