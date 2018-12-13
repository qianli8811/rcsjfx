
package com.jeeplus.modules.gen.service;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.BaseService;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.modules.gen.dao.GenDataBaseDictDao;
import com.jeeplus.modules.gen.dao.GenTableColumnDao;
import com.jeeplus.modules.gen.dao.GenTableDao;
import com.jeeplus.modules.gen.entity.GenScheme;
import com.jeeplus.modules.gen.entity.GenTable;
import com.jeeplus.modules.gen.entity.GenTableColumn;
import com.jeeplus.modules.gen.util.GenUtils;
import com.jeeplus.modules.sys.dao.DictDao;
import com.jeeplus.modules.sys.entity.Dict;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service
@Transactional(readOnly = true)
public class CgAutoListService extends BaseService
{

    @Autowired
    private GenTableDao genTableDao;
    @Autowired
    private GenTableColumnDao genTableColumnDao;
    @Autowired
    private GenDataBaseDictDao genDataBaseDictDao;

    public CgAutoListService()
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
        GenTable genTable = new GenTable();
        genTable.setName(tableName);
        List<GenTable> genTables =   genTableDao.findList(genTable);
        return  genTables.size()==0;
    }

    public boolean checkTableNameFromDB(String tableName)
    {
        if(StringUtils.isBlank(tableName))
            return true;
        GenTable genTable;
        (genTable = new GenTable()).setName(tableName);
        int tableSize = genDataBaseDictDao.findTableList(genTable).size();
        return tableSize == 0;
    }

    public String generateCode(GenScheme genScheme)
    {
        new StringBuilder();
        GenTable genTable;
        (genTable = (GenTable)genTableDao.get(genScheme.getGenTable().getId())).setColumnList(genTableColumnDao.findList(new GenTableColumn(new GenTable(genTable.getId()))));
        genScheme.setGenTable(genTable);
        String viewList = null;
        try {
            viewList = GenUtils.fileToObject("viewList", Class.forName(genTable.getClassName()));
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return viewList;
    }

    public String generateListCode(GenScheme genScheme)
    {
        new StringBuilder();
        GenTable genTable;
        (genTable = (GenTable)genTableDao.get(genScheme.getGenTable().getId())).setColumnList(genTableColumnDao.findList(new GenTableColumn(new GenTable(genTable.getId()))));
        genScheme.setGenTable(genTable);

        String findList = null;
        try {
            findList = GenUtils.fileToObject("findList", Class.forName(genTable.getClassName()));
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return findList;

    }
}
