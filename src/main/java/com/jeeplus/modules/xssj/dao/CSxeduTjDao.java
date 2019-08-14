/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.xssj.dao;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.xssj.entity.CSxeduTj;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 授信额度统计DAO接口
 * @author admin
 * @version 2018-05-03
 */
@MyBatisDao
public interface CSxeduTjDao extends CrudDao<CSxeduTj> {
	
	public List<CSxeduTj> getCSxeduTj(CSxeduTj cSxeduTj);

	public void deleteCSxeduTj(CSxeduTj cSxeduTj);
	
	public void insertBatchCSxeduTj(List<CSxeduTj> list);
	
	public Map<String,Object> getZt(CSxeduTj cSxeduTj);

	public String getMaxDate();
	
	public List<List<HashMap<?,?>>>  getKeHuTj(CSxeduTj cSxeduTj);
	
}