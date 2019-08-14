/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.xssj.service;

import java.util.*;

import com.jeeplus.common.utils.IdGen;
import com.jeeplus.common.utils.StringUtils;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.xssj.entity.CSxeduTj;
import com.jeeplus.modules.xssj.dao.CSxeduTjDao;

/**
 * 授信额度统计Service
 * @author admin
 * @version 2018-05-03
 */
@Service
@Transactional(readOnly = true)
public class CSxeduTjService extends CrudService<CSxeduTjDao, CSxeduTj> {

	public CSxeduTj get(String id) {
		return super.get(id);
	}
	
	public List<CSxeduTj> findList(CSxeduTj cSxeduTj) {
		return super.findList(cSxeduTj);
	}
	
	public Page<CSxeduTj> findPage(Page<CSxeduTj> page, CSxeduTj cSxeduTj) {
		return super.findPage(page, cSxeduTj);
	}
	
	@Transactional(readOnly = false)
	public void save(CSxeduTj cSxeduTj) {
		super.save(cSxeduTj);
	}
	
	@Transactional(readOnly = false)
	public void delete(CSxeduTj cSxeduTj) {
		super.delete(cSxeduTj);
	}
	
	public List<CSxeduTj> getCSxeduTj(CSxeduTj cSxeduTj){
		return dao.getCSxeduTj(cSxeduTj);
	}
	@Transactional(readOnly = false)
	public void insertBatchCSxeduTj(List<CSxeduTj> list){
		dao.insertBatchCSxeduTj(list);
	}
	
	@Cacheable(value="getKeHuTj",key ="T(String).valueOf(#cSxeduTj.ckName)")
	public Map<String,Object> getZt(CSxeduTj cSxeduTj){
		return dao.getZt(cSxeduTj);
	}
	public String getMaxDate(){
		return dao.getMaxDate();
	}
	@Transactional(readOnly = false)
	@Cacheable(value="getKeHuTj",key ="T(String).valueOf(#cSxeduTj.page.pageNo).concat('-').concat(#cSxeduTj.page.pageSize).concat('-').concat(#cSxeduTj.ckName).concat('-').concat(#cSxeduTj.nianfen).concat('-').concat(#cSxeduTj.yuefen)")
	public List<List<HashMap<?,?>>>  getKeHuTj(CSxeduTj cSxeduTj){
		return dao.getKeHuTj(cSxeduTj);
	}

	/**
	 * 授信额度，每天晚上  01:30:30执行
	 */
	@Transactional(readOnly = false)
	@Scheduled(cron = "30 30 1 * * ?")
	public void getSX() {
		Calendar date = Calendar.getInstance();
		int year = date.get(Calendar.YEAR);//当前年份
		int month = date.get(Calendar.MONTH);//当前月

		CSxeduTj cSxeduTj = new CSxeduTj();
		cSxeduTj.setNianfen(year);
		cSxeduTj.setYuefen(month);
		dao.deleteCSxeduTj(cSxeduTj);//清除当月的数据
		List<CSxeduTj> list1 = dao.getCSxeduTj(cSxeduTj);

		List<CSxeduTj> list2 = new ArrayList<>();
		for(CSxeduTj cSxeduTj1: list1){
			if(StringUtils.isBlank(cSxeduTj1.getId())){
				cSxeduTj1.setId(IdGen.uuid());
				if(null == cSxeduTj1.getYuefen()){
					cSxeduTj1.setNianfen(year);
				}
				if(null == cSxeduTj1.getYuefen()){
					cSxeduTj1.setYuefen(month);
				}
				list2.add(cSxeduTj1);
			}
		}
		dao.insertBatchCSxeduTj(list2);
	}
	@Transactional(readOnly = false)
	public void deleteCSxeduTj(CSxeduTj cSxeduTj){
		dao.deleteCSxeduTj(cSxeduTj);
	}
}