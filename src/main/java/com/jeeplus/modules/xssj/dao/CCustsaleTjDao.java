/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.xssj.dao;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.xssj.entity.CCustsaleTj;
import com.jeeplus.modules.xssj.entity.CSxeduTj;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 企业核心销售数据统计DAO接口
 * @author admin
 * @version 2018-03-20
 */
@MyBatisDao
public interface CCustsaleTjDao extends CrudDao<CCustsaleTj> {
	public List<CCustsaleTj> getXssjtj(CCustsaleTj CCustsaleTj);//统计每个公司，每年月的销售收入，净值，税额，战略价金额
	public List<CSxeduTj> getSxedu(CSxeduTj csxeduTj);//授信额度
	public void deleteAll();//删除所有
	public void deleteByNianfen(CCustsaleTj cCustsaleTj);//删除本年度的数据
	public void insertBatch(List<CCustsaleTj> list);//批量插入
	public void creatBenNianTable(@Param("tableName") String tableName);//创建表
	
}