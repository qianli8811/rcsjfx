package com.jeeplus.modules.gen.util;

import freemarker.template.Configuration;
import java.io.StringWriter;
import java.util.Map;

public class GenTemplateConf {
    private static Configuration conf;

    static {
        (conf = new Configuration()).setClassForTemplateLoading(GenTemplateConf.class, "/");
    }

    public GenTemplateConf() {
    }

    public static String process(String tplName, String encoding, Map<String, Object> paras) {
        try {
            StringWriter swriter = new StringWriter();
            conf.getTemplate(tplName, encoding).process(paras, swriter);
            return swriter.toString();
        } catch (Exception var4) {
            var4.printStackTrace();
            return var4.toString();
        }
    }

    public final String process(String tplName, Map<String, Object> paras) {
        return process(tplName, "utf-8", paras);
    }
}
