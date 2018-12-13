/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.common.utils;

import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.Map;

import com.jeeplus.common.mapper.JsonMapper;
import freemarker.template.TemplateExceptionHandler;
import org.apache.log4j.Logger;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;

import freemarker.template.Configuration;
import freemarker.template.Template;

/**
 * FreeMarkers工具类
 * @author jeeplus
 * @version 2013-01-15
 */
public class FreeMarkers {

	public static Logger logger = Logger.getLogger(FreeMarkers.class);
	public static String renderString(String templateString, Map<String, ?> model) {
		Template t = null;
		StringWriter result = new StringWriter();
		try {
			
			t = new Template("name", new StringReader(templateString), new Configuration());
			
			t.setTemplateExceptionHandler(TemplateExceptionHandler.HTML_DEBUG_HANDLER);
			t.process(model, result);
			return result.toString();
		} catch (Exception e) {
			logger.error("生成文件错误："+e);
			e.printStackTrace();
		} finally{
			try{
				result.close();
			}catch (IOException e){
				e.printStackTrace();
			}
		}
		return null;
	}

	public static String renderTemplate(Template template, Object model) {
		try {
			StringWriter result = new StringWriter();
			template.process(model, result);
			return result.toString();
		} catch (Exception e) {
			throw Exceptions.unchecked(e);
		}
	}

	public static Configuration buildConfiguration(String directory) throws IOException {
		Configuration cfg = new Configuration();
		Resource path = new DefaultResourceLoader().getResource(directory);
		cfg.setDirectoryForTemplateLoading(path.getFile());
		return cfg;
	}
	
	public static void main(String[] args) throws IOException {
//		// renderString
//		Map<String, String> model = com.google.common.collect.Maps.newHashMap();
//		model.put("userName", "calvin");
//		String result = FreeMarkers.renderString("hello ${userName}", model);
//		System.out.println(result);
//		// renderTemplate
//		Configuration cfg = FreeMarkers.buildConfiguration("classpath:/");
//		Template template = cfg.getTemplate("testTemplate.ftl");
//		String result2 = FreeMarkers.renderTemplate(template, model);
//		System.out.println(result2);
		
//		Map<String, String> model = com.google.common.collect.Maps.newHashMap();
//		model.put("userName", "calvin");
//		String result = FreeMarkers.renderString("hello ${userName} ${r'${userName}'}", model);
//		System.out.println(result);
	}
	
}
