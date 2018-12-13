package com.jeeplus.modules.gen.service;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.BaseService;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.modules.gen.dao.*;
import com.jeeplus.modules.gen.entity.*;
import com.jeeplus.modules.gen.util.GenTableConf;
import com.jeeplus.modules.sys.entity.Menu;
import com.jeeplus.modules.sys.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
@Service
@Transactional(readOnly = true)
public class GenSchemeService extends BaseService
{

    @Autowired
    private GenSchemeDao genSchemeDao;
    @Autowired
    private GenTableDao genTableDao;
    @Autowired
    private GenTableColumnDao genTableColumnDao;
    @Autowired
    private SystemService systemService;

    public GenSchemeService()
    {
    }

    public GenScheme get(String id)
    {
        return (GenScheme)genSchemeDao.get(id);
    }

    public Page find(Page page, GenScheme genScheme)
    {
        genScheme.setPage(page);
        page.setList(genSchemeDao.findList(genScheme));
        return page;
    }
    @Transactional(readOnly = false)
    public String save(GenScheme genScheme)
    {


        if(StringUtils.isBlank(genScheme.getId()))
        {
            genScheme.preInsert();
            genSchemeDao.insert(genScheme);
        } else
        {
            genScheme.preUpdate();
            genSchemeDao.update(genScheme);
        }
        return generateCode(genScheme);
    }
    @Transactional(readOnly = false)
    public void createMenu(GenScheme genScheme, Menu topMenu)
    {
        String permissionPrefix = (new StringBuilder(String.valueOf(StringUtils.lowerCase(genScheme.getModuleName())))).append(StringUtils.isNotBlank(genScheme.getSubModuleName()) ? (new StringBuilder(":")).append(StringUtils.lowerCase(genScheme.getSubModuleName())).toString() : "").append(":").append(StringUtils.uncapitalize(genScheme.getGenTable().getClassName())).toString();
        String url = (new StringBuilder("/")).append(StringUtils.lowerCase(genScheme.getModuleName())).append(StringUtils.isNotBlank(genScheme.getSubModuleName()) ? (new StringBuilder("/")).append(StringUtils.lowerCase(genScheme.getSubModuleName())).toString() : "").append("/").append(StringUtils.uncapitalize(genScheme.getGenTable().getClassName())).toString();
        //topMenu.setName(genScheme.getFunctionName());
        topMenu.setHref(url);
        topMenu.setIsShow("1");
        topMenu.setPermission((new StringBuilder(String.valueOf(permissionPrefix))).append(":list").toString());
        systemService.saveMenu(topMenu);

    }
    @Transactional(readOnly = false)
    public void delete(GenScheme genScheme)
    {
        genSchemeDao.delete(genScheme);
    }
    
    
    private String generateCode(GenScheme genScheme)
    {
        StringBuilder result = new StringBuilder();
        GenTable genTable = genTableDao.get(genScheme.getGenTable().getId());
        genTable.setColumnList(genTableColumnDao.findList(new GenTableColumn(new GenTable(genTable.getId()))));
        //.setColumnList(genTableColumnDao.findList(new GenTableColumn(new GenTable(genTable.getId()))));
        //(genTable = (GenTable)genTableDao.get(genScheme.getGenTable().getId())).setColumnList(genTableColumnDao.findList(new GenTableColumn(new GenTable(genTable.getId()))));
        GenConfig config = GenTableConf.getGenConfig();
        List templateList = GenTableConf.genTemplateList(config, genScheme.getCategory(), false);


        List childTableTemplateList;
        if((childTableTemplateList = GenTableConf.genTemplateList(config, genScheme.getCategory(), true)).size() > 0)
        {
            GenTable parentTable;
            (parentTable = new GenTable()).setParentTable(genTable.getName());
            genTable.setChildList(genTableDao.findList(parentTable));
        }
        for(Iterator iterator = genTable.getChildList().iterator(); iterator.hasNext();)
        {
            GenTable childTable;
            (childTable = (GenTable)iterator.next()).setParent(genTable);
            childTable.setColumnList(genTableColumnDao.findList(new GenTableColumn(new GenTable(childTable.getId()))));
            genScheme.setGenTable(childTable);
            Map childTableModel = GenTableConf.getModel(genScheme);
            GenTemplate tpl;
            for(Iterator iterator2 = childTableTemplateList.iterator(); iterator2.hasNext(); result.append(GenTableConf.genFtl(tpl, childTableModel, true)))
                tpl = (GenTemplate)iterator2.next();

        }

        genScheme.setGenTable(genTable);
        Map model = GenTableConf.getModel(genScheme);
        
        GenTemplate tpl;
        for(Iterator iterator1 = templateList.iterator(); iterator1.hasNext(); result.append(GenTableConf.genFtl(tpl, model, true)))
            tpl = (GenTemplate)iterator1.next();

        return result.toString();
    }

    public GenScheme findUniqueByProperty(String propertyName, String value)
    {
        return (GenScheme)genSchemeDao.findUniqueByProperty(propertyName, value);
    }
}
