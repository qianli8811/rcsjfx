package com.jeeplus.modules.gen.util;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jeeplus.common.config.Global;
import com.jeeplus.common.mapper.JaxbMapper;
import com.jeeplus.common.utils.DateUtils;
import com.jeeplus.common.utils.FileUtils;
import com.jeeplus.common.utils.FreeMarkers;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.modules.gen.entity.GenCategory;
import com.jeeplus.modules.gen.entity.GenConfig;
import com.jeeplus.modules.gen.entity.GenScheme;
import com.jeeplus.modules.gen.entity.GenTable;
import com.jeeplus.modules.gen.entity.GenTableColumn;
import com.jeeplus.modules.gen.entity.GenTemplate;
import com.jeeplus.modules.sys.entity.Area;
import com.jeeplus.modules.sys.entity.Office;
import com.jeeplus.modules.sys.entity.User;
import com.jeeplus.modules.sys.utils.UserUtils;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.UnknownHostException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.DefaultResourceLoader;

public class GenTableConf {
    private static Logger logger = LoggerFactory.getLogger(GenTableConf.class);
   /* private static final String e = "http://www.jeeplus.org";
    public static String a = "jeeplus";
    public static String b = "2.5";
    public static String c = null;
*/

    public GenTableConf() {
    }



    public static void a(GenTable genTable) {
        Iterator var2 = genTable.getColumnList().iterator();

        while(true) {
            while(true) {
                GenTableColumn column;
                do {
                    if (!var2.hasNext()) {
                        return;
                    }
                } while(StringUtils.isNotBlank((column = (GenTableColumn)var2.next()).getId()));

                if (StringUtils.isBlank(column.getComments())) {
                    column.setComments(column.getName());
                }

                if (!StringUtils.startsWithIgnoreCase(column.getJdbcType(), "CHAR") && !StringUtils.startsWithIgnoreCase(column.getJdbcType(), "VARCHAR") && !StringUtils.startsWithIgnoreCase(column.getJdbcType(), "NARCHAR")) {
                    if (!StringUtils.startsWithIgnoreCase(column.getJdbcType(), "DATETIME") && !StringUtils.startsWithIgnoreCase(column.getJdbcType(), "DATE") && !StringUtils.startsWithIgnoreCase(column.getJdbcType(), "TIMESTAMP")) {
                        if (StringUtils.startsWithIgnoreCase(column.getJdbcType(), "BIGINT") || StringUtils.startsWithIgnoreCase(column.getJdbcType(), "NUMBER")) {
                            String[] ss;
                            if ((ss = StringUtils.split(StringUtils.substringBetween(column.getJdbcType(), "(", ")"), ",")) != null && ss.length == 2 && Integer.parseInt(ss[1]) > 0) {
                                column.setJavaType("Double");
                            } else if (ss != null && ss.length == 1 && Integer.parseInt(ss[0]) <= 10) {
                                column.setJavaType("Integer");
                            } else {
                                column.setJavaType("Long");
                            }
                        }
                    } else {
                        column.setJavaType("java.util.Date");
                        column.setShowType("dateselect");
                    }
                } else {
                    column.setJavaType("String");
                }

                column.setJavaField(StringUtils.toCamelCase(column.getName()));
                column.setIsPk(genTable.getPkList().contains(column.getName()) ? "1" : "0");
                column.setIsInsert("1");
                if (!StringUtils.equalsIgnoreCase(column.getName(), "id") && !StringUtils.equalsIgnoreCase(column.getName(), "create_by") && !StringUtils.equalsIgnoreCase(column.getName(), "create_date") && !StringUtils.equalsIgnoreCase(column.getName(), "del_flag")) {
                    column.setIsEdit("1");
                } else {
                    column.setIsEdit("0");
                }

                if (!StringUtils.equalsIgnoreCase(column.getName(), "name") && !StringUtils.equalsIgnoreCase(column.getName(), "title") && !StringUtils.equalsIgnoreCase(column.getName(), "remarks") && !StringUtils.equalsIgnoreCase(column.getName(), "update_date")) {
                    column.setIsList("0");
                } else {
                    column.setIsList("1");
                }

                if (!StringUtils.equalsIgnoreCase(column.getName(), "name") && !StringUtils.equalsIgnoreCase(column.getName(), "title")) {
                    column.setIsQuery("0");
                } else {
                    column.setIsQuery("1");
                }

                if (!StringUtils.equalsIgnoreCase(column.getName(), "name") && !StringUtils.equalsIgnoreCase(column.getName(), "title")) {
                    column.setQueryType("=");
                } else {
                    column.setQueryType("like");
                }

                if (StringUtils.startsWithIgnoreCase(column.getName(), "user_id")) {
                    column.setJavaType(User.class.getName());
                    column.setJavaField(column.getJavaField().replaceAll("Id", ".id|name"));
                    column.setShowType("userselect");
                } else if (StringUtils.startsWithIgnoreCase(column.getName(), "office_id")) {
                    column.setJavaType(Office.class.getName());
                    column.setJavaField(column.getJavaField().replaceAll("Id", ".id|name"));
                    column.setShowType("officeselect");
                } else if (StringUtils.startsWithIgnoreCase(column.getName(), "area_id")) {
                    column.setJavaType(Area.class.getName());
                    column.setJavaField(column.getJavaField().replaceAll("Id", ".id|name"));
                    column.setShowType("areaselect");
                } else {
                    if (!StringUtils.startsWithIgnoreCase(column.getName(), "create_by") && !StringUtils.startsWithIgnoreCase(column.getName(), "update_by")) {
                        label144: {
                            if (!StringUtils.startsWithIgnoreCase(column.getName(), "create_date") && !StringUtils.startsWithIgnoreCase(column.getName(), "update_date")) {
                                if (!StringUtils.equalsIgnoreCase(column.getName(), "remarks") && !StringUtils.equalsIgnoreCase(column.getName(), "content")) {
                                    if (StringUtils.equalsIgnoreCase(column.getName(), "parent_id")) {
                                        column.setJavaType("This");
                                        column.setJavaField("parent.id|name");
                                        column.setShowType("treeselect");
                                        continue;
                                    }

                                    if (StringUtils.equalsIgnoreCase(column.getName(), "parent_ids")) {
                                        column.setShowType("input");
                                        column.setQueryType("like");
                                        continue;
                                    }

                                    if (StringUtils.equalsIgnoreCase(column.getName(), "del_flag")) {
                                        column.setShowType("radiobox");
                                        column.setDictType("del_flag");
                                        continue;
                                    }
                                    break label144;
                                }

                                column.setShowType("textarea");
                                continue;
                            }

                            column.setShowType("dateselect");
                            continue;
                        }
                    } else {
                        column.setJavaType(User.class.getName());
                        column.setJavaField(column.getJavaField() + ".id");
                    }

                    column.setShowType("input");
                }
            }
        }
    }

    public static String getFilePath() {
        try {
            File file;
            if ((file = (new DefaultResourceLoader()).getResource("").getFile()) != null) {
                return file.getAbsolutePath() + File.separator + StringUtils.replaceEach(GenTemplateConf.class.getName(), new String[]{"util." + GenTemplateConf.class.getSimpleName(), "."}, new String[]{"template", File.separator});
            }
        } catch (Exception var1) {
            logger.error("{}", var1);
        }

        return "";
    }

    private static <T> T toXml(String pathName, Class<?> clazz) {
        try {
            pathName = "/templates/modules/gen/" + pathName;
            InputStream is = (new ClassPathResource(pathName)).getInputStream();
            BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
            StringBuilder sb = new StringBuilder();

            String line;
            while((line = br.readLine()) != null) {
                sb.append(line).append("\r\n");
            }

            if (is != null) {
                is.close();
            }

            br.close();
            return (T) JaxbMapper.fromXml(sb.toString(), clazz);
        } catch (IOException var5) {
            logger.warn("Error file convert: {}", var5.getMessage());
            return null;
        }
    }

    public static GenConfig getGenConfig() {
        return (GenConfig)toXml("config.xml", GenConfig.class);
    }

    public static List<GenTemplate> genTemplateList(GenConfig config, String s, boolean isChildTable) {
        List<GenTemplate> templateList = (List)Lists.newArrayList();
        if (config != null && config.getCategoryList() != null && s != null) {
            Iterator var5 = config.getCategoryList().iterator();

            while(var5.hasNext()) {
                GenCategory e = (GenCategory)var5.next();
                if (s.equals(e.getValue())) {
                    List list;
                    if (!isChildTable) {
                        list = e.getTemplate();
                    } else {
                        list = e.getChildTableTemplate();
                    }

                    if (list != null) {
                        Iterator isChildTables = list.iterator();

                        while(isChildTables.hasNext()) {
                            if (StringUtils.startsWith(s = (String)isChildTables.next(), GenCategory.CATEGORY_REF)) {
                                templateList.addAll(genTemplateList(config, StringUtils.replace(s, GenCategory.CATEGORY_REF, ""), false));
                            } else {
                                GenTemplate template;
                                if ((template = (GenTemplate)toXml(s, GenTemplate.class)) != null) {
                                    templateList.add(template);
                                }
                            }
                        }
                    }
                    break;
                }
            }
        }

        return templateList;
    }

    public static Map<String, Object> getModel(GenScheme genScheme) {
        Map model;
        (model = new HashMap()).put("packageName", StringUtils.lowerCase(genScheme.getPackageName()));
        model.put("lastPackageName", StringUtils.substringAfterLast((String)model.get("packageName"), "."));
        model.put("moduleName", StringUtils.lowerCase(genScheme.getModuleName()));
        model.put("subModuleName", StringUtils.lowerCase(genScheme.getSubModuleName()));
        model.put("className", StringUtils.uncapitalize(genScheme.getGenTable().getClassName()));
        model.put("ClassName", StringUtils.capitalize(genScheme.getGenTable().getClassName()));
        model.put("functionName", genScheme.getFunctionName());
        model.put("functionNameSimple", genScheme.getFunctionNameSimple());
        model.put("functionAuthor", StringUtils.isNotBlank(genScheme.getFunctionAuthor()) ? genScheme.getFunctionAuthor() : UserUtils.getUser().getName());
        model.put("functionVersion", DateUtils.getDate());
        model.put("urlPrefix", model.get("moduleName") + (StringUtils.isNotBlank(genScheme.getSubModuleName()) ? "/" + StringUtils.lowerCase(genScheme.getSubModuleName()) : "") + "/" + model.get("className"));
        model.put("viewPrefix", model.get("urlPrefix"));
        model.put("permissionPrefix", model.get("moduleName") + (StringUtils.isNotBlank(genScheme.getSubModuleName()) ? ":" + StringUtils.lowerCase(genScheme.getSubModuleName()) : "") + ":" + model.get("className"));
        model.put("dbType", Global.getConfig("jdbc.type"));
        model.put("table", genScheme.getGenTable());
        
        return model;
    }

    public static String genFtl(GenTemplate tpl, Map<String, Object> model, boolean isReplaceFile) {
        String fileName = Global.getProjectPath() + File.separator + StringUtils.replaceEach(FreeMarkers.renderString(tpl.getFilePath() + "/", model), new String[]{"//", "/", "."}, new String[]{File.separator, File.separator, File.separator}) + FreeMarkers.renderString(tpl.getFileName(), model);
        logger.debug("--------- 生成fileName === " + fileName+"前的,content : \r\n"+tpl.getContent());
        String content = FreeMarkers.renderString(StringUtils.trimToEmpty(tpl.getContent()), model);
        logger.debug("fileName content === \r\n" + content);
        FileUtils.deleteFile(fileName);
        if (FileUtils.createFile(fileName)) {
            FileUtils.writeToFile(fileName, content, true);
            logger.debug(" file create === " + fileName);
            return "生成成功：" + fileName + "<br/>";
        } else {
            logger.debug(" file extents === " + fileName);
            return "文件已存在：" + fileName + "<br/>";
        }
    }

    private static void d() {
        try {
            GenConfig config = getGenConfig();
            System.out.println(config);
            System.out.println(JaxbMapper.toXml(config));
        } catch (Exception var1) {
            var1.printStackTrace();
        }
    }

    private static String a(Date date, String str) {
        return (new SimpleDateFormat(str)).format(date);
    }




}
