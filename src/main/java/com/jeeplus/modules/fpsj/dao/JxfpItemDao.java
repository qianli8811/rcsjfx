/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.fpsj.dao;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.fpsj.entity.JxfpItem;
import com.jeeplus.modules.xssj.entity.CCustsaleTj;

import java.util.List;
import java.util.Map;

/**
 * 发票数据DAO接口
 * @author admin
 * @version 2018-02-24
 */
@MyBatisDao
public interface JxfpItemDao extends CrudDao<JxfpItem> {
	public List<Map<String,Object>> getGyskpsj(CCustsaleTj cCustsaleTj);
}