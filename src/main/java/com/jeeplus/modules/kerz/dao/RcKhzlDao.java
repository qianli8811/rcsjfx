/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.kerz.dao;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.kerz.entity.Gdfxtj;
import com.jeeplus.modules.kerz.entity.RcKhzl;

import java.util.List;
import java.util.Map;

/**
 * 客户管理DAO接口
 * @author admin
 * @version 2018-03-13
 */
@MyBatisDao
public interface RcKhzlDao extends CrudDao<RcKhzl> {
	
	public RcKhzl getMaxKhjm();//查询最大的客户简码
	
	public List<RcKhzl> getGdxm();//查询所有股东姓名
	
	public List<Map<String,Object>> getCityNum();//查询客户分布情况
	
	public List<Gdfxtj> getGdjg(Gdfxtj gdfxtj);//股东结构
	
	public List<RcKhzl> getAllRcKhzl(RcKhzl rcKhzl);//查询公司名称
	
}