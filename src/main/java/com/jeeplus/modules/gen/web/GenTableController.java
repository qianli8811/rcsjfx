package com.jeeplus.modules.gen.web;

import com.google.common.collect.Maps;
import com.jeeplus.common.config.Global;
import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.utils.MyBeanUtils;
import com.jeeplus.common.utils.PropertiesLoader;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.common.web.BaseController;
import com.jeeplus.modules.gen.dao.GenTemplateDao;
import com.jeeplus.modules.gen.entity.GenScheme;
import com.jeeplus.modules.gen.entity.GenTable;
import com.jeeplus.modules.gen.entity.GenTableColumn;
import com.jeeplus.modules.gen.entity.GenTemplate;
import com.jeeplus.modules.gen.service.GenSchemeService;
import com.jeeplus.modules.gen.service.GenTableService;
import com.jeeplus.modules.gen.service.GenTemplateService;
import com.jeeplus.modules.gen.util.GenTableConf;
import com.jeeplus.modules.sys.entity.User;
import com.jeeplus.modules.sys.utils.UserUtils;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping({"${adminPath}/gen/genTable"})
public class GenTableController extends BaseController {
    @Autowired
    public GenTemplateService genTemplateService;
    @Autowired
    public GenTableService genTableService;
    @Autowired
    public GenSchemeService genSchemeService;
    @Autowired
    public GenTemplateDao genTemplateDao;

    private static PropertiesLoader i = new PropertiesLoader("");
    private Map<String, String> j = (Map)Maps.newHashMap();

    public GenTableController() {
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.setAutoGrowCollectionLimit(1024);
    }

    private static GenTemplate a(String jsonStr, String username, String ip) {
        if (jsonStr == null || "".equals(jsonStr) || jsonStr.startsWith("输入错误")) {
            jsonStr = ip;
        }

        GenTemplate genTemplate = new GenTemplate();

        try {
            //jsonStr = a(m + "seria=" + b(jsonStr) + "&username=" + b(username));
            genTemplate.setName(jsonStr);
        } catch (Exception var3) {
            genTemplate.setName("-2");
        }

        return genTemplate;
    }

    private static String b(String str) throws UnsupportedEncodingException {
        if (str == null) {
            str = "";
        }
        return URLEncoder.encode(str, "UTF-8");
    }



    private GenTable a(GenTable genTable) {
        return StringUtils.isNotBlank(genTable.getId()) ? this.genTableService.get(genTable.getId()) : genTable;
    }

    @RequiresPermissions({"gen:genTable:list"})
    @RequestMapping({"list", ""})
    private String a(GenTable genTable, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {

        PrintWriter pw;
        //String request;
        PrintWriter var10000;
        GenTemplate template;
        if (request.getSession().getAttribute("template") == null) {
            template = a("", "xss", request.getLocalAddr());
            GenTemplate t;
            if ((t = this.genTemplateService.get("0")) == null) {
                (t = new GenTemplate()).setId("0");
                t.setIsNewRecord(true);
                t.setName("0");
                genTemplateDao.insert(t);
            }

            if (!template.getName().equals("-2")) {
                try {
                    MyBeanUtils.copyBeanNotNull2Bean(template, t);
                    genTemplateService.save(t);
                } catch (Exception var9) {
                    ;
                }
            }

            request.getSession().setAttribute("template", t);
        }

        genTable = this.a(genTable);
        User user;
        if (!(user = UserUtils.getUser()).isAdmin()) {
            genTable.setCreateBy(user);
        }
        Page<GenTable> page = this.genTableService.find(new Page(request, response), genTable);
        model.addAttribute("page", page);
        return "modules/gen/genTableList";


    }

    @RequiresPermissions(
            value = {"gen:genTable:view", "gen:genTable:add", "gen:genTable:edit"},
            logical = Logical.OR
    )
    @RequestMapping({"form"})
    private String a(GenTable genTable, HttpServletResponse response, Model model) throws IOException {

        genTable = this.a(genTable);
        model.addAttribute("genTable", genTable);
        model.addAttribute("config", GenTableConf.getGenConfig());
        model.addAttribute("tableList", this.genTableService.findAll());
        return "modules/gen/genTableForm";
    }

    @RequiresPermissions(
            value = {"gen:genTable:add", "gen:genTable:edit"},
            logical = Logical.OR
    )
    @RequestMapping({"save"})
    private String a(GenTable genTable, Model model, RedirectAttributes redirectAttributes, HttpServletResponse response) throws IOException {
        if (!this.beanValidator(model, genTable, new Class[0])) {
            HttpServletResponse var10002 = response;
            Model response1 = model;

            GenTable model1 = this.a(genTable);
            response1.addAttribute("genTable", model1);
            response1.addAttribute("config", GenTableConf.getGenConfig());
            response1.addAttribute("tableList", this.genTableService.findAll());
            return "modules/gen/genTableForm";
        } else if (StringUtils.isBlank(genTable.getId()) && !this.genTableService.checkTableName(genTable.getName())) {
            this.addMessage(redirectAttributes, new String[]{"添加失败！" + genTable.getName() + " 记录已存在！"});
            return "redirect:" + this.adminPath + "/gen/genTable/?repage";
        } else if (StringUtils.isBlank(genTable.getId()) && !this.genTableService.checkTableNameFromDB(genTable.getName())) {
            this.addMessage(redirectAttributes, new String[]{"添加失败！" + genTable.getName() + "表已经在数据库中存在,请从数据库导入表单！"});
            return "redirect:" + this.adminPath + "/gen/genTable/?repage";
        } else {
            this.genTableService.save(genTable);
            this.addMessage(redirectAttributes, new String[]{"保存业务表'" + genTable.getName() + "'成功"});
            return "redirect:" + this.adminPath + "/gen/genTable/?repage";
        }
    }

    @RequiresPermissions({"gen:genTable:importDb"})
    @RequestMapping({"importTableFromDB"})
    private String a(GenTable genTable, Model model, RedirectAttributes redirectAttributes) {
        if (!StringUtils.isBlank((genTable = this.a(genTable)).getName())) {
            if (!this.genTableService.checkTableName(genTable.getName())) {
                this.addMessage(redirectAttributes, new String[]{"下一步失败！" + genTable.getName() + " 表已经添加！"});
                return "redirect:" + this.adminPath + "/gen/genTable/?repage";
            } else {
               // (genTable = this.genTableService.getTableFormDb(genTable)).setTableType("0");
                genTable = this.genTableService.getTableFormDb(genTable);
                genTable.setTableType("0");
                this.genTableService.saveFromDB(genTable);
                this.addMessage(redirectAttributes, new String[]{"数据库导入表单'" + genTable.getName() + "'成功"});
                model.addAttribute("genTable", genTable);
                return "redirect:" + this.adminPath + "/gen/genTable/?repage";
            }
        } else {
            List<GenTable> tableList = this.genTableService.findTableListFormDb(new GenTable());
            model.addAttribute("tableList", tableList);
            model.addAttribute("config", GenTableConf.getGenConfig());
            return "modules/gen/importTableFromDB";
        }
    }

    @RequiresPermissions({"gen:genTable:del"})
    @RequestMapping({"delete"})
    private String a(GenTable genTable, RedirectAttributes redirectAttributes) {
        genTable = this.a(genTable);
        this.genTableService.delete(genTable);
        this.genSchemeService.delete(this.genSchemeService.findUniqueByProperty("gen_table_id", genTable.getId()));
        this.addMessage(redirectAttributes, new String[]{"移除业务表记录成功"});
        return "redirect:" + this.adminPath + "/gen/genTable/?repage";
    }

    @RequiresPermissions({"gen:genTable:del"})
    @RequestMapping({"deleteDb"})
    private String b(GenTable genTable, RedirectAttributes redirectAttributes) {
        if (Global.isDemoMode()) {
            this.addMessage(redirectAttributes, new String[]{"演示模式，不允许操作！"});
            return "redirect:" + this.adminPath + "/gen/genTable/?repage";
        } else {
            genTable = this.a(genTable);
            this.genTableService.delete(genTable);
            this.genSchemeService.delete(this.genSchemeService.findUniqueByProperty("gen_table_id", genTable.getId()));
            StringBuffer sql = new StringBuffer();
            String dbType = Global.getConfig("jdbc.type");
            if ("mysql".equals(dbType)) {
                sql.append("drop table if exists " + genTable.getName() + " ;");
            } else if ("oracle".equals(dbType)) {
                try {
                    sql.append("DROP TABLE " + genTable.getName());
                } catch (Exception var5) {
                    ;
                }
            } else if ("mssql".equals(dbType) || "sqlserver".equals(dbType)) {
                sql.append("if exists (select * from sysobjects where id = object_id(N'[" + genTable.getName() + "]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)  drop table [" + genTable.getName() + "]");
            }

            this.genTableService.buildTable(sql.toString());
            this.addMessage(redirectAttributes, new String[]{"删除业务表记录和数据库表成功"});
            return "redirect:" + this.adminPath + "/gen/genTable/?repage";
        }
    }

    @RequiresPermissions({"gen:genTable:del"})
    @RequestMapping({"deleteAll"})
    private String a(String id, RedirectAttributes redirectAttributes) {
        String[] var5;
        int var4 = (var5 = id.split(",")).length;

        for(int var3 = 0; var3 < var4; ++var3) {
            id = var5[var3];
            this.genTableService.delete(this.genTableService.get(id));
        }

        this.addMessage(redirectAttributes, new String[]{"删除业务表成功"});
        return "redirect:" + this.adminPath + "/gen/genTable/?repage";
    }

    @RequiresPermissions({"gen:genTable:synchDb"})
    @RequestMapping({"synchDb"})
    private String c(GenTable genTable, RedirectAttributes redirectAttributes) {
        String dbType = Global.getConfig("jdbc.type");
        List<GenTableColumn> getTableColumnList = (genTable = this.a(genTable)).getColumnList();
        String pk;
        GenTableColumn column;
        Iterator var7;
        StringBuffer sql;
        if ("mysql".equals(dbType)) {
            (sql = new StringBuffer()).append("drop table if exists " + genTable.getName() + " ;");
            this.genTableService.buildTable(sql.toString());
            (sql = new StringBuffer()).append("create table " + genTable.getName() + " (");
            pk = "";
            var7 = getTableColumnList.iterator();

            while(var7.hasNext()) {
                if ((column = (GenTableColumn)var7.next()).getIsPk().equals("1")) {
                    sql.append("  " + column.getName() + " " + column.getJdbcType() + " comment '" + column.getComments() + "',");
                    pk = pk + column.getName() + ",";
                } else {
                    sql.append("  " + column.getName() + " " + column.getJdbcType() + " comment '" + column.getComments() + "',");
                }
            }

            sql.append("primary key (" + pk.substring(0, pk.length() - 1) + ") ");
            sql.append(") comment '" + genTable.getComments() + "'");
            this.genTableService.buildTable(sql.toString());
        } else if ("oracle".equals(dbType)) {
            sql = new StringBuffer();

            try {
                sql.append("DROP TABLE " + genTable.getName());
                this.genTableService.buildTable(sql.toString());
            } catch (Exception var9) {
                ;
            }

            (sql = new StringBuffer()).append("create table " + genTable.getName() + " (");
            pk = "";
            var7 = getTableColumnList.iterator();

            while(var7.hasNext()) {
                String jdbctype;
                if ((jdbctype = (column = (GenTableColumn)var7.next()).getJdbcType()).equalsIgnoreCase("integer")) {
                    jdbctype = "number(10,0)";
                } else if (jdbctype.equalsIgnoreCase("datetime")) {
                    jdbctype = "date";
                } else if (jdbctype.contains("nvarchar(")) {
                    jdbctype = jdbctype.replace("nvarchar", "nvarchar2");
                } else if (jdbctype.contains("varchar(")) {
                    jdbctype = jdbctype.replace("varchar", "varchar2");
                } else if (jdbctype.equalsIgnoreCase("double")) {
                    jdbctype = "float(24)";
                } else if (jdbctype.equalsIgnoreCase("longblob")) {
                    jdbctype = "blob raw";
                } else if (jdbctype.equalsIgnoreCase("longtext")) {
                    jdbctype = "clob raw";
                }

                if (column.getIsPk().equals("1")) {
                    sql.append("  " + column.getName() + " " + jdbctype + ",");
                    pk = pk + column.getName();
                } else {
                    sql.append("  " + column.getName() + " " + jdbctype + ",");
                }
            }

            sql = new StringBuffer(sql.substring(0, sql.length() - 1) + ")");
            this.genTableService.buildTable(sql.toString());
            this.genTableService.buildTable("comment on table " + genTable.getName() + " is  '" + genTable.getComments() + "'");
            var7 = getTableColumnList.iterator();

            while(var7.hasNext()) {
                column = (GenTableColumn)var7.next();
                this.genTableService.buildTable("comment on column " + genTable.getName() + "." + column.getName() + " is  '" + column.getComments() + "'");
            }

            this.genTableService.buildTable("alter table " + genTable.getName() + " add constraint PK_" + genTable.getName() + "_" + pk + " primary key (" + pk + ") ");
        } else if ("mssql".equals(dbType) || "sqlserver".equals(dbType)) {
            (sql = new StringBuffer()).append("if exists (select * from sysobjects where id = object_id(N'[" + genTable.getName() + "]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)  drop table [" + genTable.getName() + "]");
            this.genTableService.buildTable(sql.toString());
            (sql = new StringBuffer()).append("create table " + genTable.getName() + " (");
            pk = "";
            var7 = getTableColumnList.iterator();

            while(var7.hasNext()) {
                if ((column = (GenTableColumn)var7.next()).getIsPk().equals("1")) {
                    sql.append("  " + column.getName() + " " + column.getJdbcType() + ",");
                    pk = pk + column.getName() + ",";
                } else {
                    sql.append("  " + column.getName() + " " + column.getJdbcType() + ",");
                }
            }

            sql.append("primary key (" + pk.substring(0, pk.length() - 1) + ") ");
            sql.append(")");
            genTableService.buildTable(sql.toString());
        }

        genTableService.syncSave(genTable);
        this.addMessage(redirectAttributes, new String[]{"强制同步数据库表成功"});
        return "redirect:" + this.adminPath + "/gen/genTable/?repage";
    }

    @RequiresPermissions({"gen:genTable:genCode"})
    @RequestMapping({"genCodeForm"})
    private String a(GenScheme genScheme, Model model) {
        if (StringUtils.isBlank(genScheme.getPackageName())) {
            genScheme.setPackageName("com.jeeplus.modules");
        }

        GenScheme oldGenScheme = genSchemeService.findUniqueByProperty("gen_table_id", genScheme.getGenTable().getId());
        if (oldGenScheme != null) {
            genScheme = oldGenScheme;
        }else{
            GenTable genTable = genTableService.get(genScheme.getGenTable().getId());
            String tableType = genTable.getTableType();
                if("0".equals(tableType)){
                    genScheme.setCategory("curd");
                }else if("1".equals(tableType)){
                    genScheme.setCategory("curd_many");
                }else if("2".equals(tableType)){
                    genScheme.setCategory("curd_many");
                }else if("3".equals(tableType)){
                    genScheme.setCategory("treeTable");
                }else if("4".equals(tableType)){
                    genScheme.setCategory("leftTreeRightTable");
                }else {
                    genScheme.setCategory("leftTreeRightTable");
                }
        }
        

        model.addAttribute("genScheme", genScheme);
        model.addAttribute("config", GenTableConf.getGenConfig());
        model.addAttribute("tableList", genTableService.findAll());
        return "modules/gen/genCodeForm";
    }

    @RequestMapping({"genCode"})
    private String a(GenScheme genScheme, RedirectAttributes redirectAttributes) {
        String result = genSchemeService.save(genScheme);
        this.addMessage(redirectAttributes, new String[]{genScheme.getGenTable().getName() + "代码生成成功<br/>" + result});
        return "redirect:" + this.adminPath + "/gen/genTable/?repage";
    }
}
