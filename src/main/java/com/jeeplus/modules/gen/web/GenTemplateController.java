// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) fieldsfirst 
// Source File Name:   GenTemplateController.java

package com.jeeplus.modules.gen.web;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.common.web.BaseController;
import com.jeeplus.modules.gen.entity.GenTemplate;
import com.jeeplus.modules.gen.service.GenTemplateService;
import com.jeeplus.modules.sys.entity.User;
import com.jeeplus.modules.sys.utils.UserUtils;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

public class GenTemplateController extends BaseController
{

    private GenTemplateService a;

    public GenTemplateController()
    {
    }

    private GenTemplate a(String id)
    {
        if(StringUtils.isNotBlank(id))
            return a.get(id);
        else
            return new GenTemplate();
    }

    private String a(GenTemplate genTemplate, HttpServletRequest request, HttpServletResponse response, Model model)
    {
        User user;
        if(!(user = UserUtils.getUser()).isAdmin())
            genTemplate.setCreateBy(user);
        Page<GenTemplate> pages = a.find(new Page(request, response), genTemplate);
        model.addAttribute("page", pages);
        return "modules/gen/genTemplateList";
    }

    private static String a(GenTemplate genTemplate, Model model1)
    {
        model1.addAttribute("genTemplate", genTemplate);
        return "modules/gen/genTemplateForm";
    }

    private String a(GenTemplate genTemplate, Model model, RedirectAttributes redirectAttributes)
    {
        if(!beanValidator(model, genTemplate, new Class[0]))
        {
            model = model;
            genTemplate = genTemplate;
            model.addAttribute("genTemplate", genTemplate);
            return "modules/gen/genTemplateForm";
        } else
        {
            a.save(genTemplate);
            addMessage(redirectAttributes, new String[]{"保存代码模板'" + genTemplate.getName() + "'成功"});
            return (new StringBuilder("redirect:")).append(adminPath).append("/gen/genTemplate/?repage").toString();
        }
    }

    private String a(GenTemplate genTemplate, RedirectAttributes redirectAttributes)
    {
        a.delete(genTemplate);
        addMessage(redirectAttributes, new String[] {
            "删除成功"
        });
        return (new StringBuilder("redirect:")).append(adminPath).append("/gen/genTemplate/?repage").toString();
    }
}
