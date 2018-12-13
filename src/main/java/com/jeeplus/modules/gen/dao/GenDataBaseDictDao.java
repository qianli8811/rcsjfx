// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) fieldsfirst 
// Source File Name:   GenDataBaseDictDao.java

package com.jeeplus.modules.gen.dao;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.gen.entity.GenCategory;
import com.jeeplus.modules.gen.entity.GenTable;
import com.jeeplus.modules.gen.entity.GenTableColumn;

import java.util.List;

@MyBatisDao
public interface GenDataBaseDictDao extends CrudDao<GenTableColumn> {
    List<GenTable> findTableList(GenTable var1);

    List<GenTableColumn> findTableColumnList(GenTable var1);

    List<String> findTablePK(GenTable var1);
}

