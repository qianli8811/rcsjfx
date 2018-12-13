// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) fieldsfirst 
// Source File Name:   GenTemplateService.java

package com.jeeplus.modules.gen.service;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.BaseService;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.modules.gen.dao.GenTemplateDao;
import com.jeeplus.modules.gen.entity.GenTemplate;
import com.jeeplus.modules.sys.dao.DictDao;
import com.jeeplus.modules.sys.entity.Dict;
import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class GenTemplateService extends BaseService
{

    @Autowired
    private GenTemplateDao genTemplateDao;

    public GenTemplateService()
    {
    }

    public GenTemplate get(String id)
    {
        return (GenTemplate)genTemplateDao.get(id);
    }

    public Page find(Page page, GenTemplate genTemplate)
    {
        genTemplate.setPage(page);
        page.setList(genTemplateDao.findList(genTemplate));
        return page;
    }
    @Transactional(readOnly = false)
    public void save(GenTemplate genTemplate)
    {
        if(genTemplate.getContent() != null)
            genTemplate.setContent(StringEscapeUtils.unescapeHtml4(genTemplate.getContent()));
        if(StringUtils.isBlank(genTemplate.getId()))
        {
            genTemplate.preInsert();
            genTemplateDao.insert(genTemplate);
            return;
        } else
        {
            genTemplate.preUpdate();
            genTemplateDao.update(genTemplate);
            return;
        }
    }
    @Transactional(readOnly = false)
    public void delete(GenTemplate genTemplate)
    {
        genTemplateDao.delete(genTemplate);
    }
}
