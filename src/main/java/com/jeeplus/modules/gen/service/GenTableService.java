// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) fieldsfirst 
// Source File Name:   GenTableService.java

package com.jeeplus.modules.gen.service;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.BaseService;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.modules.gen.dao.*;
import com.jeeplus.modules.gen.entity.GenTable;
import com.jeeplus.modules.gen.entity.GenTableColumn;
import com.jeeplus.modules.gen.util.GenTableConf;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Iterator;
import java.util.List;
@Service
@Transactional(readOnly = true)
public class GenTableService extends BaseService
{
    @Autowired
    private GenTableDao genTableDao;
    @Autowired
    private GenTableColumnDao genTableColumnDao;
    @Autowired
    private GenDataBaseDictDao genDataBaseDictDao;

    public GenTableService()
    {
    }

    public GenTable get(String id)
    {
        GenTable genTable = (GenTable)genTableDao.get(id);
        GenTableColumn genTableColumn;
        (genTableColumn = new GenTableColumn()).setGenTable(new GenTable(genTable.getId()));
        genTable.setColumnList(genTableColumnDao.findList(genTableColumn));
        return genTable;
    }

    public Page find(Page page, GenTable genTable)
    {
        genTable.setPage(page);
        page.setList(genTableDao.findList(genTable));
        return page;
    }

    public List findAll()
    {
        return genTableDao.findAllList(new GenTable());
    }

    public List findTableListFormDb(GenTable genTable)
    {
        return genDataBaseDictDao.findTableList(genTable);
    }

    public boolean checkTableName(String tableName)
    {
        if(StringUtils.isBlank(tableName))
            return true;
        GenTable genTable;
        (genTable = new GenTable()).setName(tableName);
        return genTableDao.findList(genTable).size() == 0;
    }

    public boolean checkTableNameFromDB(String tableName)
    {
        if(StringUtils.isBlank(tableName))
            return true;
        GenTable genTable;
        (genTable = new GenTable()).setName(tableName);

        return genDataBaseDictDao.findTableList(genTable).size() == 0;
    }

    public GenTable getTableFormDb(GenTable genTable)
    {
        List list;
        if(StringUtils.isNotBlank(genTable.getName()) && (list = genDataBaseDictDao.findTableList(genTable)).size() > 0)
        {
            if(StringUtils.isBlank(genTable.getId()))
            {
                if(StringUtils.isBlank((genTable = (GenTable)list.get(0)).getComments()))
                    genTable.setComments(genTable.getName());
                genTable.setClassName(StringUtils.toCapitalizeCamelCase(genTable.getName()));
            }
            List columnList;
            for(Iterator iterator = (columnList = genDataBaseDictDao.findTableColumnList(genTable)).iterator(); iterator.hasNext();)
            {
                GenTableColumn column = (GenTableColumn)iterator.next();
                boolean b = false;
                GenTableColumn e;
                for(Iterator iterator2 = genTable.getColumnList().iterator(); iterator2.hasNext();)
                    if((e = (GenTableColumn)iterator2.next()).getName() != null && e.getName().equals(column.getName()))
                        b = true;

                if(!b)
                    genTable.getColumnList().add(column);
            }

            for(Iterator iterator1 = genTable.getColumnList().iterator(); iterator1.hasNext();)
            {
                GenTableColumn e = (GenTableColumn)iterator1.next();
                boolean b = false;
                GenTableColumn gentablecolumn;
                for(Iterator iterator3 = columnList.iterator(); iterator3.hasNext();)
                    if((gentablecolumn = (GenTableColumn)iterator3.next()).getName().equals(e.getName()))
                        b = true;

                if(!b)
                    e.setDelFlag("1");
            }

            genTable.setPkList(genDataBaseDictDao.findTablePK(genTable));
            GenTableConf.a(genTable);
        }
        return genTable;
    }
    @Transactional(readOnly = false)
    public void save(GenTable genTable)
    {
        boolean isSync = true;
        GenTable oldTable;
        if(StringUtils.isBlank(genTable.getId()))
            isSync = false;
        else
        if((oldTable = get(genTable.getId())).getColumnList().size() != genTable.getColumnList().size() || !oldTable.getName().equals(genTable.getName()) || !oldTable.getComments().equals(genTable.getComments()))
        {
            isSync = false;
        } else
        {
            GenTableColumn column;
            GenTableColumn oldColumn;
            for(Iterator iterator = genTable.getColumnList().iterator(); iterator.hasNext();)
                if(StringUtils.isBlank((column = (GenTableColumn)iterator.next()).getId()) || !(oldColumn = (GenTableColumn)genTableColumnDao.get(column.getId())).getName().equals(column.getName()) || !oldColumn.getJdbcType().equals(column.getJdbcType()) || !oldColumn.getIsPk().equals(column.getIsPk()) || !oldColumn.getComments().equals(column.getComments()))
                    isSync = false;

        }
        if(!isSync)
            genTable.setIsSync("0");
        if(StringUtils.isBlank(genTable.getId()))
        {
            genTable.preInsert();
            genTableDao.insert(genTable);
        } else
        {
            genTable.preUpdate();
            genTableDao.update(genTable);
        }
        genTableColumnDao.deleteByGenTable(genTable);
        GenTableColumn column;
        for(Iterator iterator1 = genTable.getColumnList().iterator(); iterator1.hasNext(); genTableColumnDao.insert(column))
        {
            (column = (GenTableColumn)iterator1.next()).setGenTable(genTable);
            column.setId(null);
            column.preInsert();
        }

    }
    @Transactional(readOnly = false)
    public void syncSave(GenTable genTable)
    {
        genTable.setIsSync("1");
        genTableDao.update(genTable);
    }
    @Transactional(readOnly = false)
    public void saveFromDB(GenTable genTable)
    {
        genTable.preInsert();
        genTableDao.insert(genTable);
        GenTableColumn column;
        for(Iterator iterator = genTable.getColumnList().iterator(); iterator.hasNext(); )
        {
            column = (GenTableColumn)iterator.next();
            column.setGenTable(genTable);
            column.setId(null);
            column.preInsert();
            genTableColumnDao.insert(column);
        }

    }
    @Transactional(readOnly = false)
    public void delete(GenTable genTable)
    {
        genTableDao.delete(genTable);
        genTableColumnDao.deleteByGenTable(genTable);
    }

    public void buildTable(String sql)
    {
        genTableDao.buildTable(sql);
    }
}
