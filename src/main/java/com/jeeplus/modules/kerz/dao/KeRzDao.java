/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.kerz.dao;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.kerz.entity.KeRz;

import java.util.List;
import java.util.Map;

/**
 * 客户融资DAO接口
 * @author admin
 * @version 2018-03-10
 */
@MyBatisDao
public interface KeRzDao extends CrudDao<KeRz> {
	
	public List<Map<String,Object>> getSyzjgc(KeRz keRz);//统计生意资金构成
	
}