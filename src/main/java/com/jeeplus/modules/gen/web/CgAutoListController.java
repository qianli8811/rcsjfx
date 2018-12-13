// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) fieldsfirst 
// Source File Name:   CgAutoListController.java

package com.jeeplus.modules.gen.web;

import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.common.web.BaseController;
import com.jeeplus.modules.gen.entity.GenScheme;
import com.jeeplus.modules.gen.service.CgAutoListService;
import com.jeeplus.modules.gen.service.GenSchemeService;
import com.jeeplus.modules.gen.service.GenTableService;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;

import com.jeeplus.modules.gen.util.GenTableConf;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;

public class CgAutoListController extends BaseController
{

    private static Logger a = Logger.getLogger(CgAutoListController.class);
    private GenSchemeService b;
    private GenTableService c;
    private CgAutoListService d;

    public CgAutoListController()
    {
    }

    private GenScheme a(String id)
    {
        if(StringUtils.isNotBlank(id))
            return b.get(id);
        else
            return new GenScheme();
    }

    private void a(GenScheme genScheme, HttpServletResponse response)
    {
        long start;
        String html;
        start = System.currentTimeMillis();
        Map<String, Object> map =  GenTableConf.getModel(genScheme);
        html = d.generateCode(genScheme);
        d.generateListCode(genScheme);
        response.setContentType("text/html");
        response.setHeader("Cache-Control", "no-store");
        PrintWriter writer;
        try {
            (writer = response.getWriter()).println(html);
            writer.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
        long end = System.currentTimeMillis();
        a.debug("动态列表生成耗时：" + (end - start) + " ms");
        return;
    }

    private static ModelAndView a()
    {
        return new ModelAndView("com${ctx}/modules/gen/template/viewList");
    }

}
