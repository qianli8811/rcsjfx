/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.fpsj.dao;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.fpsj.entity.XxfpHead;
import com.jeeplus.modules.xssj.entity.CCustsaleTj;

import java.util.List;
import java.util.Map;

/**
 * 发票数据DAO接口
 * @author admin
 * @version 2018-02-24
 */
@MyBatisDao
public interface XxfpHeadDao extends CrudDao<XxfpHead> {
	public List<String> getXxGsName();
	public List<Map<String,Object>> getJsyqw(CCustsaleTj cCustsaleTj);
	public List<Map<String,Object>> getGysKptjqnjnby(CCustsaleTj cCustsaleTj);
}