// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) fieldsfirst 
// Source File Name:   GenTable.java

package com.jeeplus.modules.gen.entity;

import com.google.common.collect.Lists;
import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.common.utils.StringUtils;
import org.hibernate.validator.constraints.Length;

import java.util.Iterator;
import java.util.List;

public class GenTable extends DataEntity<GenTable> {
    private static final long serialVersionUID = 1L;
    private String name;
    private String comments;
    private String tableType;
    private String className;
    private String parentTable;
    private String parentTableFk;
    private String isSync;
    private List<GenTableColumn> columnList = (List)Lists.newArrayList();
    private String nameLike;
    private List<String> pkList;
    private GenTable parent;
    private List<GenTable> childList = (List)Lists.newArrayList();

    public GenTable() {
    }

    public GenTable(String id) {
        super(id);
    }

    @Length(
            min = 1,
            max = 200
    )
    public String getName() {
        return StringUtils.lowerCase(this.name);
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getComments() {
        return this.comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public String getClassName() {
        return this.className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getParentTable() {
        return StringUtils.lowerCase(this.parentTable);
    }

    public void setParentTable(String parentTable) {
        this.parentTable = parentTable;
    }

    public String getParentTableFk() {
        return StringUtils.lowerCase(this.parentTableFk);
    }

    public void setParentTableFk(String parentTableFk) {
        this.parentTableFk = parentTableFk;
    }

    public List<String> getPkList() {
        return this.pkList;
    }

    public void setPkList(List<String> pkList) {
        this.pkList = pkList;
    }

    public String getNameLike() {
        return this.nameLike;
    }

    public void setNameLike(String nameLike) {
        this.nameLike = nameLike;
    }

    public GenTable getParent() {
        return this.parent;
    }

    public void setParent(GenTable parent) {
        this.parent = parent;
    }

    public List<GenTableColumn> getColumnList() {
        return this.columnList;
    }

    public void setColumnList(List<GenTableColumn> columnList) {
        this.columnList = columnList;
    }

    public List<GenTable> getChildList() {
        return this.childList;
    }

    public void setChildList(List<GenTable> childList) {
        this.childList = childList;
    }

    public String getNameAndComments() {
        return this.getName() + (this.comments == null ? "" : "  :  " + this.comments);
    }

    public List<String> getImportList() {
        List<String> importList = (List)Lists.newArrayList();
        Iterator var3 = this.getColumnList().iterator();

        while(true) {
            GenTableColumn column;
            do {
                if (!var3.hasNext()) {
                    if (this.getChildList() != null && this.getChildList().size() > 0) {
                        if (!importList.contains("java.util.List")) {
                            importList.add("java.util.List");
                        }

                        if (!importList.contains("com.google.common.collect.Lists")) {
                            importList.add("com.google.common.collect.Lists");
                        }
                    }

                    return importList;
                }

                column = (GenTableColumn)var3.next();
                if ((column.getIsNotBaseField() || "1".equals(column.getIsQuery()) && "between".equals(column.getQueryType()) && ("createDate".equals(column.getSimpleJavaField()) || "updateDate".equals(column.getSimpleJavaField()))) && StringUtils.indexOf(column.getJavaType(), ".") != -1 && !importList.contains(column.getJavaType())) {
                    importList.add(column.getJavaType());
                }
            } while(!column.getIsNotBaseField());

            Iterator var5 = column.getAnnotationList().iterator();

            while(var5.hasNext()) {
                String ann = (String)var5.next();
                if (!importList.contains(StringUtils.substringBeforeLast(ann, "("))) {
                    importList.add(StringUtils.substringBefore(ann, "("));
                }
            }
        }
    }

    public List<String> getImportGridJavaList() {
        List<String> importList = (List)Lists.newArrayList();
        Iterator var3 = this.getColumnList().iterator();

        while(var3.hasNext()) {
            GenTableColumn column = (GenTableColumn)var3.next();
            if (column.getTableName() != null && !column.getTableName().equals("") && StringUtils.indexOf(column.getJavaType(), ".") != -1 && !importList.contains(column.getJavaType())) {
                importList.add(column.getJavaType());
            }
        }

        return importList;
    }

    public List<String> getImportGridJavaDaoList() {
        boolean isNeedList = false;
        List<String> importList = (List)Lists.newArrayList();
        Iterator var4 = this.getColumnList().iterator();

        while(var4.hasNext()) {
            GenTableColumn column = (GenTableColumn)var4.next();
            if (column.getTableName() != null && !column.getTableName().equals("") && StringUtils.indexOf(column.getJavaType(), ".") != -1 && !importList.contains(column.getJavaType())) {
                importList.add(column.getJavaType());
                isNeedList = true;
            }
        }

        if (isNeedList && !importList.contains("java.util.List")) {
            importList.add("java.util.List");
        }

        return importList;
    }

    public Boolean getParentExists() {
        return this.parent != null && StringUtils.isNotBlank(this.parentTable) && StringUtils.isNotBlank(this.parentTableFk) ? true : false;
    }

    public Boolean getCreateDateExists() {
        Iterator var2 = this.columnList.iterator();

        while(var2.hasNext()) {
            GenTableColumn c = (GenTableColumn)var2.next();
            if ("create_date".equals(c.getName())) {
                return true;
            }
        }

        return false;
    }

    public Boolean getUpdateDateExists() {
        Iterator var2 = this.columnList.iterator();

        while(var2.hasNext()) {
            GenTableColumn c = (GenTableColumn)var2.next();
            if ("update_date".equals(c.getName())) {
                return true;
            }
        }

        return false;
    }

    public Boolean getDelFlagExists() {
        Iterator var2 = this.columnList.iterator();

        while(var2.hasNext()) {
            GenTableColumn c = (GenTableColumn)var2.next();
            if ("del_flag".equals(c.getName())) {
                return true;
            }
        }

        return false;
    }

    public void setIsSync(String isSync) {
        this.isSync = isSync;
    }

    public String getIsSync() {
        return this.isSync;
    }

    public void setTableType(String tableType) {
        this.tableType = tableType;
    }

    public String getTableType() {
        return this.tableType;
    }
}
