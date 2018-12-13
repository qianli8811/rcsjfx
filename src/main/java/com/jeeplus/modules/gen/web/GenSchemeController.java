package com.jeeplus.modules.gen.web;

import com.google.common.collect.Lists;
import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.common.web.BaseController;
import com.jeeplus.modules.gen.entity.GenScheme;
import com.jeeplus.modules.gen.service.GenSchemeService;
import com.jeeplus.modules.gen.service.GenTableService;
import com.jeeplus.modules.gen.util.GenTableConf;
import com.jeeplus.modules.gen.util.GenTemplateConf;
import com.jeeplus.modules.sys.entity.Menu;
import com.jeeplus.modules.sys.entity.User;
import com.jeeplus.modules.sys.service.SystemService;
import com.jeeplus.modules.sys.utils.UserUtils;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping({"${adminPath}/gen/genScheme"})
public class GenSchemeController extends BaseController {
    @Autowired
    public GenSchemeService genSchemeService;
    @Autowired
    public GenTableService genTableService;
    @Autowired
    public SystemService systemService;

    public GenSchemeController() {
    }

    @ModelAttribute
    private GenScheme a(@RequestParam(required = false) String id) {
        return StringUtils.isNotBlank(id) ? this.genSchemeService.get(id) : new GenScheme();
    }

    @RequiresPermissions({"gen:genScheme:view"})
    @RequestMapping({"list", ""})
    private String a(GenScheme genScheme, HttpServletRequest request, HttpServletResponse response, Model model) {
        User user;
        if (!(user = UserUtils.getUser()).isAdmin()) {
            genScheme.setCreateBy(user);
        }

        Page<GenScheme> page = this.genSchemeService.find(new Page(request, response), genScheme);
        model.addAttribute("page", page);
        return "modules/gen/genSchemeList";
    }

    @RequiresPermissions({"gen:genScheme:view"})
    @RequestMapping({"form"})
    private String a(GenScheme genScheme, Model model) {
        if (StringUtils.isBlank(genScheme.getPackageName())) {
            genScheme.setPackageName("com.jeeplus.modules");
        }

        model.addAttribute("genScheme", genScheme);
        model.addAttribute("config", GenTableConf.getGenConfig());
        model.addAttribute("tableList", this.genTableService.findAll());
        return "modules/gen/genSchemeForm";
    }

    @RequiresPermissions({"gen:genScheme:edit"})
    @RequestMapping({"save"})
    private String a(GenScheme genScheme, Model model, RedirectAttributes redirectAttributes) {
        if (!this.beanValidator(model, genScheme, new Class[0])) {
            if (StringUtils.isBlank(genScheme.getPackageName())) {
                genScheme.setPackageName("com.jeeplus.modules");
            }

            model.addAttribute("genScheme", genScheme);
            model.addAttribute("config", GenTableConf.getGenConfig());
            model.addAttribute("tableList", this.genTableService.findAll());
            return "modules/gen/genSchemeForm";
        } else {
            String result = this.genSchemeService.save(genScheme);
            this.addMessage(redirectAttributes, new String[]{"操作生成方案'" + genScheme.getName() + "'成功<br/>" + result});
            return "redirect:" + this.adminPath + "/gen/genScheme/?repage";
        }
    }

    @RequiresPermissions({"gen:genScheme:edit"})
    @RequestMapping({"delete"})
    private String a(GenScheme genScheme, RedirectAttributes redirectAttributes) {
        this.genSchemeService.delete(genScheme);
        this.addMessage(redirectAttributes, new String[]{"删除生成方案成功"});
        return "redirect:" + this.adminPath + "/gen/genScheme/?repage";
    }

    @RequestMapping({"menuForm"})
    private String a(String gen_table_id, Menu menu, Model model) {
        if (menu.getParent() == null || menu.getParent().getId() == null) {
            menu.setParent(new Menu(Menu.getRootId()));
        }

        menu.setParent(this.systemService.getMenu(menu.getParent().getId()));
        if (StringUtils.isBlank(menu.getId())) {
            List<Menu> list = (List)Lists.newArrayList();
            List<Menu> sourcelist = this.systemService.findAllMenu();
            Menu.sortList(list, sourcelist, menu.getParentId(), false);
            if (list.size() > 0) {
                menu.setSort(((Menu)list.get(list.size() - 1)).getSort() + 30);
            }
        }

        GenScheme genScheme;
        if ((genScheme = this.genSchemeService.findUniqueByProperty("gen_table_id", gen_table_id)) != null) {
            menu.setName(genScheme.getFunctionName());
        }

        model.addAttribute("menu", menu);
        model.addAttribute("gen_table_id", gen_table_id);
        model.addAttribute("genTable", genScheme.getGenTable());
        return "modules/gen/genMenuForm";
    }

    @RequestMapping({"createMenu"})
    private String a(String gen_table_id, Menu menu, RedirectAttributes redirectAttributes) {
        GenScheme genScheme;
        if ((genScheme = this.genSchemeService.findUniqueByProperty("gen_table_id", gen_table_id)) == null) {
            this.addMessage(redirectAttributes, new String[]{"创建菜单失败,请先生成代码!"});
            return "redirect:" + this.adminPath + "/gen/genTable/?repage";
        } else {
            genScheme.setGenTable(this.genTableService.get(gen_table_id));
            this.genSchemeService.createMenu(genScheme, menu);
            this.addMessage(redirectAttributes, new String[]{"创建菜单'" + genScheme.getFunctionName() + "'成功<br/>"});
            return "redirect:" + this.adminPath + "/gen/genTable/?repage";
        }
    }
}
