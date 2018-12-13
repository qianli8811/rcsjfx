<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>

<html>
<head>
    <title>表单管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        var validateForm;
        function doSubmit() {
            if(validateForm.form()){
                $("#inputForm").submit();
                return true;
            }
        };
        $(document).ready(function () {
            validateForm = $("#inputForm").validate({
                ignore: "", submitHandler: function (a) {
                    loading("正在提交，请稍等...");
                    $("input[type=checkbox]").each(function () {
                        $(this).after('<input type="hidden" name="' + $(this).attr("name") + '" value="' + ($(this).attr("checked") ? "1" : "0") + '"/>');
                        $(this).attr("name", "_" + $(this).attr("name"))
                    });
                    a.submit()
                }, errorContainer: "#messageBox", errorPlacement: function (a, b) {
                    $("#messageBox").text("输入有误，请先更正。");
                    b.is(":checkbox") || b.is(":radio") || b.parent().is(".input-append") ? a.appendTo(b.parent().parent()) : a.insertAfter(b)
                }
            });
            resetColumnNo();
            $("#tableType").change(function () {
                "3" == $("#tableType").val() ? addForTreeTable() : removeForTreeTable()
            });
            var b, c;
            $("#contentTable1").tableDnD({
                onDragClass: "myDragClass", onDrop: function (a, d) {
                    c = $(d).index();
                    var f = $("#tab-2 #contentTable2 tbody tr:eq(" + c + ")"),
                        e = $("#tab-2 #contentTable2 tbody tr:eq(" + b + ")");
                    b < c ? e.insertAfter(f) : e.insertBefore(f);
                    f = $("#tab-3 #contentTable3 tbody tr:eq(" + c + ")");
                    e = $("#tab-3 #contentTable3 tbody tr:eq(" + b + ")");
                    b < c ? e.insertAfter(f) : e.insertBefore(f);
                    f = $("#tab-4 #contentTable4 tbody tr:eq(" + c + ")");
                    e = $("#tab-4 #contentTable4 tbody tr:eq(" + b + ")");
                    b < c ? e.insertAfter(f) : e.insertBefore(f);
                    resetColumnNo()
                }, onDragStart: function (a, c) {
                    b = $(c).index()
                }
            })
        });

        function resetColumnNo() {
            $("#tab-4 #contentTable4 tbody tr").each(function (b, c) {
                $(this).find("span[name*=columnList],select[name*=columnList],input[name*=columnList]").each(function () {
                    var a = $(this).attr("name"), c = a.split(".")[1], c = "columnList[" + b + "]." + c;
                    $(this).attr("name", c);
                    0 <= a.indexOf(".sort") && ($(this).val(b), $(this).next().text(b))
                });
                $(this).find("label[id*=columnList]").each(function () {
                    var a = $(this).attr("id").split(".")[1], a = "columnList[" + b + "]." + a;
                    $(this).attr("id", a);
                    $(this).attr("for", "columnList[" + b + "].jdbcType")
                });
                $(this).find("input[name*=name]").each(function () {
                    var a = $(this).attr("name").split(".")[1], a = "page-columnList[" + b + "]." + a;
                    $(this).attr("name", a)
                });
                $(this).find("input[name*=comments]").each(function () {
                    var a = $(this).attr("name").split(".")[1], a = "page-columnList[" + b + "]." + a;
                    $(this).attr("name", a)
                })
            });
            $("#tab-3 #contentTable3 tbody tr").each(function (b, c) {
                $(this).find("span[name*=columnList],select[name*=columnList],input[name*=columnList]").each(function () {
                    var a = $(this).attr("name"), c = a.split(".")[1], c = "columnList[" + b + "]." + c;
                    $(this).attr("name", c);
                    0 <= a.indexOf(".sort") && ($(this).val(b), $(this).next().text(b))
                });
                $(this).find("label[id*=columnList]").each(function () {
                    var a = $(this).attr("id").split(".")[1], a = "columnList[" + b + "]." + a;
                    $(this).attr("id", a);
                    $(this).attr("for", "columnList[" + b + "].jdbcType")
                });
                $(this).find("input[name*=name]").each(function () {
                    var a = $(this).attr("name").split(".")[1], a = "page-columnList[" + b + "]." + a;
                    $(this).attr("name", a)
                });
                $(this).find("input[name*=comments]").each(function () {
                    var a = $(this).attr("name").split(".")[1], a = "page-columnList[" + b + "]." + a;
                    $(this).attr("name", a)
                })
            });
            $("#tab-2 #contentTable2 tbody tr").each(function (b, c) {
                $(this).find("span[name*=columnList],select[name*=columnList],input[name*=columnList]").each(function () {
                    var a = $(this).attr("name"), c = a.split(".")[1], c = "columnList[" + b + "]." + c;
                    $(this).attr("name", c);
                    0 <= a.indexOf(".sort") && ($(this).val(b), $(this).next().text(b))
                });
                $(this).find("label[id*=columnList]").each(function () {
                    var a = $(this).attr("id").split(".")[1], a = "columnList[" + b + "]." + a;
                    $(this).attr("id", a);
                    $(this).attr("for", "columnList[" + b + "].jdbcType")
                });
                $(this).find("input[name*=name]").each(function () {
                    var a = $(this).attr("name").split(".")[1], a = "page-columnList[" + b + "]." + a;
                    $(this).attr("name", a)
                });
                $(this).find("input[name*=comments]").each(function () {
                    var a = $(this).attr("name").split(".")[1], a = "page-columnList[" + b + "]." + a;
                    $(this).attr("name", a)
                })
            });
            $("#tab-1 #contentTable1 tbody tr").each(function (b, c) {
                $(this).find("span[name*=columnList],select[name*=columnList],input[name*=columnList]").each(function () {
                    var a = $(this).attr("name"), c = a.split(".")[1], c = "columnList[" + b + "]." + c;
                    $(this).attr("name", c);
                    0 <= a.indexOf(".sort") && ($(this).val(b), $(this).next().text(b))
                });
                $(this).find("label[id*=columnList]").each(function () {
                    var a = $(this).attr("id").split(".")[1], a = "columnList[" + b + "]." + a;
                    $(this).attr("id", a);
                    $(this).attr("for", "columnList[" + b + "].jdbcType")
                });
                $(this).find("input[name*=name]").change(function () {
                    var a = "page-" + $(this).attr("name");
                    $("#tab-2 #contentTable2 tbody tr input[name='" + a + "']").val($(this).val());
                    $("#tab-3 #contentTable3 tbody tr input[name='" + a + "']").val($(this).val());
                    $("#tab-4 #contentTable4 tbody tr input[name='" + a + "']").val($(this).val())
                });
                $(this).find("input[name*=comments]").change(function () {
                    var a = "page-" + $(this).attr("name");
                    $("#tab-2 #contentTable2 tbody tr input[name='" + a + "']").val($(this).val());
                    $("#tab-3 #contentTable3 tbody tr input[name='" + a + "']").val($(this).val());
                    $("#tab-4 #contentTable4 tbody tr input[name='" + a + "']").val($(this).val())
                })
            });
            $("#contentTable1 tbody tr span[name*=jdbcType]").combox({datas: "varchar(64) nvarchar(64) integer double datetime longblob longtext".split(" ")});
            $("#contentTable2 tbody tr select[name*=javaType]").change(function () {
                var b = $(this).children("option:selected").val(), c = $(this);
                if ("Custom" == b || "newadd" == $(this).children("option:selected").attr("class")) top.layer.open({
                    type: 1,
                    title: "\u8f93\u5165\u81ea\u5b9a\u4e49java\u5bf9\u8c61",
                    area: ["600px", "360px"],
                    shadeClose: !0,
                    content: '<div class="wrapper wrapper-content"><div class="col-md-12"><div class="form-group"> <label class="col-sm-3 control-label">\u5305\u540d\uff1a</label> <div class="col-sm-9"> <input type="text" id="packagePath" name="" class="form-control required" placeholder="\u8bf7\u8f93\u5165\u81ea\u5b9a\u4e49\u5bf9\u8c61\u6240\u5728\u7684\u5305\u8def\u5f84"> <span class="help-block m-b-none">\u5fc5\u987b\u662f\u5b58\u5728\u7684package</span> </div> </div> <div class="form-group"> <label class="col-sm-3 control-label">\u7c7b\u540d\uff1a</label> <div class="col-sm-9"> <input type="text" id="className" name="" class="form-control required" placeholder="\u8bf7\u8f93\u5165\u81ea\u5b9a\u4e49\u5bf9\u8c61\u7684\u7c7b\u540d"> <span class="help-block m-b-none">\u5fc5\u987b\u662f\u5b58\u5728\u7684class\u5bf9\u8c61</span> </div> </div></div></div>',
                    btn: ["\u786e\u5b9a", "\u5173\u95ed"],
                    yes: function (a, b) {
                        var f = top.$("#packagePath").val(), e = top.$("#className").val(), g = f + "." + e;
                        top.$("<option>").val(g).text(e);
                        "" == e.trim() || "" == f.trim() ? top.layer.alert("\u5305\u540d\u548c\u7c7b\u540d\u90fd\u4e0d\u5141\u8bb8\u4e3a\u7a7a!", {icon: 0}) : (c.children("option:selected").text(e), c.children("option:selected").val(g), c.children("option:selected").attr("class", "newadd"), top.layer.close(a))
                    },
                    cancel: function (a) {
                    }
                }), "Custom" != b && "newadd" == $(this).children("option:selected").attr("class") && (top.$("#packagePath").val($(this).children("option:selected").val().substring(0, $(this).children("option:selected").val().lastIndexOf("."))), top.$("#className").val($(this).children("option:selected").text()))
            })
        };

        function addColumn() {
            var b = $("#template1").clone();
            b.removeAttr("style");
            b.removeAttr("id");
            var c = $("#template2").clone();
            c.removeAttr("style");
            c.removeAttr("id");
            var a = $("#template3").clone();
            a.removeAttr("style");
            a.removeAttr("id");
            var d = $("#template4").clone();
            d.removeAttr("style");
            d.removeAttr("id");
            $("#tab-1 #contentTable1 tbody").append(b);
            $("#tab-2 #contentTable2 tbody").append(c);
            $("#tab-3 #contentTable3 tbody").append(a);
            $("#tab-4 #contentTable4 tbody").append(d);
            b.find("input:checkbox").iCheck({
                checkboxClass: "icheckbox_square-green",
                radioClass: "iradio_square-blue",
                increaseArea: "20%"
            });
            c.find("input:checkbox").iCheck({
                checkboxClass: "icheckbox_square-green",
                radioClass: "iradio_square-blue",
                increaseArea: "20%"
            });
            a.find("input:checkbox").iCheck({
                checkboxClass: "icheckbox_square-green",
                radioClass: "iradio_square-blue",
                increaseArea: "20%"
            });
            d.find("input:checkbox").iCheck({
                checkboxClass: "icheckbox_square-green",
                radioClass: "iradio_square-blue",
                increaseArea: "20%"
            });
            resetColumnNo();
            $("#contentTable1").tableDnD({
                onDragClass: "myDragClass", onDrop: function (a, b) {
                    toIndex = $(b).index();
                    var c = $("#tab-2 #contentTable2 tbody tr:eq(" + toIndex + ")"),
                        d = $("#tab-2 #contentTable2 tbody tr:eq(" + fromIndex + ")");
                    fromIndex < toIndex ? d.insertAfter(c) : d.insertBefore(c);
                    c = $("#tab-3 #contentTable3 tbody tr:eq(" + toIndex + ")");
                    d = $("#tab-3 #contentTable3 tbody tr:eq(" + fromIndex + ")");
                    fromIndex < toIndex ? d.insertAfter(c) : d.insertBefore(c);
                    c = $("#tab-4 #contentTable4 tbody tr:eq(" + toIndex + ")");
                    d = $("#tab-4 #contentTable4 tbody tr:eq(" + fromIndex + ")");
                    fromIndex < toIndex ? d.insertAfter(c) : d.insertBefore(c);
                    resetColumnNo()
                }, onDragStart: function (a, b) {
                    fromIndex = $(b).index()
                }
            });
            return !1
        };

        function removeForTreeTable() {
            $("#tab-1 #contentTable1 tbody").find("#tree_11,#tree_12,#tree_13,#tree_14").remove();
            $("#tab-2 #contentTable2 tbody").find("#tree_21,#tree_22,#tree_23,#tree_24").remove();
            $("#tab-3 #contentTable3 tbody").find("#tree_31,#tree_32,#tree_33,#tree_34").remove();
            $("#tab-4 #contentTable4 tbody").find("#tree_41,#tree_42,#tree_43,#tree_44").remove();
            resetColumnNo();
            return !1
        };

        function addForTreeTable() {
            if (!$("#tab-1 #contentTable1 tbody").find("input[name*=name][value=parent_id]").val()) {
                var b = $("#template1").clone();
                b.removeAttr("style");
                b.attr("id", "tree_11");
                b.find("input[name*=name]").val("parent_id");
                b.find("input[name*=comments]").val("\u7236\u7ea7\u7f16\u53f7");
                b.find("span[name*=jdbcType]").val("varchar(64)");
                var c = $("#template2").clone();
                c.removeAttr("style");
                c.attr("id", "tree_21");
                c.find("input[name*=name]").val("parent_id");
                c.find("select[name*=javaType]").val("This");
                c.find("input[name*=javaField]").val("parent.id|name");
                c.find("input[name*=isList]").removeAttr("checked");
                c.find("select[name*=showType]").val("treeselect");
                var a = $("#template3").clone();
                a.removeAttr("style");
                a.attr("id", "tree_31");
                a.find("input[name*=name]").val("parent_id");
                var d = $("#template4").clone();
                d.removeAttr("style");
                d.attr("id", "tree_41");
                d.find("input[name*=name]").val("parent_id");
                d.find("input[name*=isNull]").removeAttr("checked");
                $("#tab-1 #contentTable1 tbody").append(b);
                $("#tab-2 #contentTable2 tbody").append(c);
                $("#tab-3 #contentTable3 tbody").append(a);
                $("#tab-4 #contentTable4 tbody").append(d);
                b.find("input:checkbox").iCheck({
                    checkboxClass: "icheckbox_square-green",
                    radioClass: "iradio_square-blue",
                    increaseArea: "20%"
                });
                c.find("input:checkbox").iCheck({
                    checkboxClass: "icheckbox_square-green",
                    radioClass: "iradio_square-blue",
                    increaseArea: "20%"
                });
                a.find("input:checkbox").iCheck({
                    checkboxClass: "icheckbox_square-green",
                    radioClass: "iradio_square-blue",
                    increaseArea: "20%"
                });
                d.find("input:checkbox").iCheck({
                    checkboxClass: "icheckbox_square-green",
                    radioClass: "iradio_square-blue",
                    increaseArea: "20%"
                })
            }
            ;$("#tab-1 #contentTable1 tbody").find("input[name*=name][value=parent_ids]").val() || (b = $("#template1").clone(), b.removeAttr("style"), b.attr("id", "tree_12"), b.find("input[name*=name]").val("parent_ids"), b.find("input[name*=comments]").val("\u6240\u6709\u7236\u7ea7\u7f16\u53f7"), b.find("span[name*=jdbcType]").val("varchar(2000)"), c = $("#template2").clone(), c.removeAttr("style"), c.attr("id", "tree_22"), c.find("input[name*=name]").val("parent_ids"), c.find("select[name*=javaType]").val("String"), c.find("input[name*=javaField]").val("parentIds"), c.find("select[name*=queryType]").val("like"), c.find("input[name*=isList]").removeAttr("checked"), a = $("#template3").clone(), a.removeAttr("style"), a.attr("id", "tree_32"), a.find("input[name*=name]").val("parent_ids"), d = $("#template4").clone(), d.removeAttr("style"), d.attr("id", "tree_42"), d.find("input[name*=name]").val("parent_ids"), d.find("input[name*=isNull]").removeAttr("checked"), $("#tab-1 #contentTable1 tbody").append(b), $("#tab-2 #contentTable2 tbody").append(c), $("#tab-3 #contentTable3 tbody").append(a), $("#tab-4 #contentTable4 tbody").append(d), b.find("input:checkbox").iCheck({
                checkboxClass: "icheckbox_square-green",
                radioClass: "iradio_square-blue",
                increaseArea: "20%"
            }), c.find("input:checkbox").iCheck({
                checkboxClass: "icheckbox_square-green",
                radioClass: "iradio_square-blue",
                increaseArea: "20%"
            }), a.find("input:checkbox").iCheck({
                checkboxClass: "icheckbox_square-green",
                radioClass: "iradio_square-blue",
                increaseArea: "20%"
            }), d.find("input:checkbox").iCheck({
                checkboxClass: "icheckbox_square-green",
                radioClass: "iradio_square-blue",
                increaseArea: "20%"
            }));
            $("#tab-1 #contentTable1 tbody").find("input[name*=name][value=name]").val() || (b = $("#template1").clone(), b.removeAttr("style"), b.attr("id", "tree_13"), b.find("input[name*=name]").val("name"), b.find("input[name*=comments]").val("\u540d\u79f0"), b.find("span[name*=jdbcType]").val("varchar(100)"), c = $("#template2").clone(), c.removeAttr("style"), c.attr("id", "tree_23"), c.find("input[name*=name]").val("name"), c.find("select[name*=javaType]").val("String"), c.find("input[name*=javaField]").val("name"), c.find("input[name*=isQuery]").attr("checked", "checked"), c.find("select[name*=queryType]").val("like"), a = $("#template3").clone(), a.removeAttr("style"), a.attr("id", "tree_33"), a.find("input[name*=name]").val("name"), d = $("#template4").clone(), d.removeAttr("style"), d.attr("id", "tree_43"), d.find("input[name*=name]").val("name"), d.find("input[name*=isNull]").removeAttr("checked"), $("#tab-1 #contentTable1 tbody").append(b), $("#tab-2 #contentTable2 tbody").append(c), $("#tab-3 #contentTable3 tbody").append(a), $("#tab-4 #contentTable4 tbody").append(d), b.find("input:checkbox").iCheck({
                checkboxClass: "icheckbox_square-green",
                radioClass: "iradio_square-blue",
                increaseArea: "20%"
            }), c.find("input:checkbox").iCheck({
                checkboxClass: "icheckbox_square-green",
                radioClass: "iradio_square-blue",
                increaseArea: "20%"
            }), a.find("input:checkbox").iCheck({
                checkboxClass: "icheckbox_square-green",
                radioClass: "iradio_square-blue",
                increaseArea: "20%"
            }), d.find("input:checkbox").iCheck({
                checkboxClass: "icheckbox_square-green",
                radioClass: "iradio_square-blue",
                increaseArea: "20%"
            }));
            $("#tab-1 #contentTable1 tbody").find("input[name*=name][value=sort]").val() || (b = $("#template1").clone(), b.removeAttr("style"), b.attr("id", "tree_14"), b.find("input[name*=name]").val("sort"), b.find("input[name*=comments]").val("\u6392\u5e8f"), b.find("span[name*=jdbcType]").val("decimal(10,0)"), c = $("#template2").clone(), c.removeAttr("style"), c.attr("id", "tree_24"), c.find("input[name*=name]").val("sort"), c.find("select[name*=javaType]").val("Integer"), c.find("input[name*=javaField]").val("sort"), c.find("input[name*=isList]").removeAttr("checked"), a = $("#template3").clone(), a.removeAttr("style"), a.attr("id", "tree_34"), a.find("input[name*=name]").val("sort"), d = $("#template4").clone(), d.removeAttr("style"), d.attr("id", "tree_44"), d.find("input[name*=name]").val("sort"), d.find("input[name*=isNull]").removeAttr("checked"), $("#tab-1 #contentTable1 tbody").append(b), $("#tab-2 #contentTable2 tbody").append(c), $("#tab-3 #contentTable3 tbody").append(a), $("#tab-4 #contentTable4 tbody").append(d), b.find("input:checkbox").iCheck({
                checkboxClass: "icheckbox_square-green",
                radioClass: "iradio_square-blue",
                increaseArea: "20%"
            }), c.find("input:checkbox").iCheck({
                checkboxClass: "icheckbox_square-green",
                radioClass: "iradio_square-blue",
                increaseArea: "20%"
            }), a.find("input:checkbox").iCheck({
                checkboxClass: "icheckbox_square-green",
                radioClass: "iradio_square-blue",
                increaseArea: "20%"
            }), d.find("input:checkbox").iCheck({
                checkboxClass: "icheckbox_square-green",
                radioClass: "iradio_square-blue",
                increaseArea: "20%"
            }));
            resetColumnNo();
            return !1
        };

        function delColumn() {
            $("input[name='ck']:checked").closest("tr").each(function () {
                var b = $(this).find("input[name*=name]").attr("name");
                $(this).remove();
                $("#tab-2 #contentTable2 tbody tr input[name='page-" + b + "']").closest("tr").remove();
                $("#tab-3 #contentTable3 tbody tr input[name='page-" + b + "']").closest("tr").remove();
                $("#tab-4 #contentTable4 tbody tr input[name='page-" + b + "']").closest("tr").remove()
            });
            resetColumnNo();
            return !1
        };
    </script>

</head>
<body id="" class=""  style="">


<!-- 锁定 -->
<div class="wrapper wrapper-content">
    <table style="display:none">
        <tr id="template1" style="display:none">
            <td>
                <input type="hidden" name="columnList[0].sort" value="0"  maxlength="200" class="form-control required   digits"/>
                <label>0</label>
                <input type="hidden" class="form-control"  name="columnList[0].isInsert" value="1" />
                <input type="hidden" class="form-control"  name="columnList[0].isEdit" value="1"  />
            </td>
            <td>
                <input type="checkbox" class="form-control  " name="ck" value="1" />
            </td>
            <td>
                <input type="text" class="form-control required" name="columnList[0].name" value=""/>
            </td>
            <td>
                <input type="text" class="form-control required" name="columnList[0].comments" value="" maxlength="200" class="required" />
            </td>
            <td>
                <span  name="template_columnList[0].jdbcType" class="required" value="varchar(64)"/>
            </td>
            <td>
                <input type="checkbox" class="form-control" name="columnList[0].isPk" value="1"/>
            </td>
        </tr>
        <tr id="template2" style="display:none">
            <td>
                <input type="text" class="form-control" readOnly="readonly" name="page-columnList[0].name" value=""/>
            </td>
            <td>
                <input type="text" class="form-control" name="page-columnList[0].comments" value="" maxlength="200" readonly="readonly" />
            </td>
            <td>
                <select name="columnList[0].javaType" class="form-control required m-b">

                    <option value="String" selected title="">String</option>

                    <option value="Long"  title="">Long</option>

                    <option value="Integer"  title="">Integer</option>

                    <option value="Double"  title="">Double</option>

                    <option value="java.util.Date"  title="">Date</option>

                    <option value="com.jeeplus.modules.sys.entity.User"  title="">User</option>

                    <option value="com.jeeplus.modules.sys.entity.Office"  title="">Office</option>

                    <option value="com.jeeplus.modules.sys.entity.Area"  title="">Area</option>

                    <option value="This"  title="生成当前对象">ThisObj</option>


                    <option value="Custom"  class="newadd" >自定义输入</option>

                </select>
            </td>
            <td>
                <input type="text" name="columnList[0].javaField" value="" maxlength="200" class="form-control required "/>
            </td>
            <td>
                <input type="checkbox" class="form-control  " name="columnList[0].isForm" value="1" checked/>
            </td>
            <td>
                <input type="checkbox" class="form-control  " name="columnList[0].isList" value="1" checked/>
            </td>
            <td>
                <input type="checkbox" class="form-control  " name="columnList[0].isQuery" value="1"  />
            </td>
            <td>
                <select name="columnList[0].queryType" class="form-control required  m-b">

                    <option value="="  title="">=</option>

                    <option value="!="  title="">!=</option>

                    <option value="&gt;"  title="">&gt;</option>

                    <option value="&gt;="  title="">&gt;=</option>

                    <option value="&lt;"  title="">&lt;</option>

                    <option value="&lt;="  title="">&lt;=</option>

                    <option value="between"  title="">Between</option>

                    <option value="like"  title="">Like</option>

                    <option value="left_like"  title="">Left Like</option>

                    <option value="right_like"  title="">Right Like</option>

                </select>
            </td>
            <td>
                <select name="columnList[0].showType" class="form-control required  m-b">

                    <option value="input"  title="">单行文本</option>

                    <option value="textarea"  title="">多行文本</option>

                    <option value="umeditor"  title="">富文本编辑器</option>

                    <option value="select"  title="">下拉选项</option>

                    <option value="radiobox"  title="">单选按钮</option>

                    <option value="checkbox"  title="">复选框</option>

                    <option value="dateselect"  title="">日期选择</option>

                    <option value="userselect"  title="">人员选择</option>

                    <option value="officeselect"  title="">部门选择</option>

                    <option value="areaselect"  title="">区域选择</option>

                    <option value="cityselect"  title="">省市区三级联动</option>

                    <option value="treeselect"  title="">树选择控件</option>

                    <option value="fileselect"  title="">文件上传选择</option>

                    <option value="gridselect"  title="">grid选择框</option>

                </select>
            </td>
            <td>
                <input type="text" name="columnList[0].dictType" value="${column.dictType}" maxlength="200" class="form-control   "/>
            </td>
        </tr>

        <tr id="template3" style="display:none">
            <td>
                <input type="text" class="form-control" readOnly="readonly" name="page-columnList[0].name" value=""/>
            </td>
            <td>
                <input type="text" class="form-control" name="page-columnList[0].comments" value="" maxlength="200" readonly="readonly" />
            </td>
            <td>
                <input type="text" name="columnList[0].fieldLabels" value="" maxlength="200" class="form-control  "/>
            </td>
            <td>
                <input type="text" name="columnList[0].fieldKeys" value="" maxlength="200" class="form-control  "/>
            </td>
            <td>
                <input type="text" name="columnList[0].searchLabel" value="" maxlength="200" class="form-control  "/>
            </td>
            <td>
                <input type="text" name="columnList[0].searchKey" value="" maxlength="200" class="form-control  "/>
            </td>

        </tr>

        <tr id="template4" style="display:none">
            <td>
                <input type="text" class="form-control" readOnly="readonly" name="page-columnList[0].name" value=""/>
            </td>
            <td>
                <input type="text" class="form-control" name="page-columnList[0].comments" value="" maxlength="200" readonly="readonly" />
            </td>
            <td>
                <input type="checkbox" class="form-control " name="columnList[0].isNull" value="1" checked/>
            </td>
            <td>
                <select name="columnList[0].validateType" class="form-control  m-b">

                    <option value=""  title=""></option>

                    <option value="string"  title="">字符串</option>

                    <option value="email"  title="">电子邮件</option>

                    <option value="url"  title="">网址</option>

                    <option value="date"  title="">日期</option>

                    <option value="dateISO"  title="">日期(ISO)</option>

                    <option value="creditcard"  title="">信用卡号</option>

                    <option value="isMobile"  title="">手机号码</option>

                    <option value="isPhone"  title="">电话号码</option>

                    <option value="isTel"  title="">手机/电话</option>

                    <option value="isQq"  title="">QQ号码</option>

                    <option value="isIdCardNo"  title="">身份证号码</option>

                    <option value="number"  title="">数字</option>

                    <option value="digits"  title="">整数</option>

                    <option value="isIntGtZero"  title="">整数(大于0)</option>

                    <option value="isIntGteZero"  title="">整数(大于等于0)</option>

                    <option value="isIntLtZero"  title="">整数(小于0)</option>

                    <option value="isIntLteZero"  title="">整数(小于等于0)</option>

                    <option value="isFloatGtZero"  title="">浮点数(大于0)</option>

                    <option value="isFloatGteZero"  title="">浮点数(大于等于0)</option>

                    <option value="isFloatLtZero"  title="">浮点数(小于0)</option>

                    <option value="isFloatLteZero"  title="">浮点数(小于等于0)</option>

                    <option value="isZipCode"  title="">邮政编码</option>

                    <option value="isPwd"  title="以字母开头，长度在6-12之间，只能包含字符、数字和下划线">密码</option>

                    <option value="stringCheck"  title="只能包含中文、英文、数字、下划线等字符">中文/英文/数字/下划线</option>

                    <option value="isEnglish"  title="">英语</option>

                    <option value="isChinese"  title="">汉子</option>

                    <option value="isChineseChar"  title="匹配中文(包括汉字和字符)">汉英字符</option>

                    <option value="isRightfulString"  title="判断是否为合法字符(a-zA-Z0-9-_)">合法字符</option>

                </select>
            </td>
            <td>
                <input type="text" name="columnList[0].minLength" value="" maxlength="200" class="form-control  "/>
            </td>
            <td>
                <input type="text" name="columnList[0].maxLength" value="" maxlength="200" class="form-control  "/>
            </td>
            <td>
                <input type="text" name="columnList[0].minValue" value="" maxlength="200" class="form-control  "/>
            </td>
            <td>
                <input type="text" name="columnList[0].maxValue" value="" maxlength="200" class="form-control  "/>
            </td>

        </tr>


    </table>

    <!-- 业务表添加 -->
    <form id="inputForm" class="form-horizontal" action="${ctx}/gen/genTable/save" method="post">
        <input id="id" name="id" type="hidden" value="${genTable.id}"/>
        <input id="isSync" name="isSync" type="hidden" value="${genTable.isSync}"/>

        <!-- 0:隐藏tip, 1隐藏box,不设置显示全部 -->


        <script type="text/javascript">top.$.jBox.closeTip();</script>

        <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
            <tbody>
            <tr>
                <td class="width-15 active"><label class="pull-right"><font color="red">*</font>表名:</label></td>
                <td class="width-35">
                    <input id="name" name="name" class="form-control required" type="text" value="${genTable.name}" maxlength="200"/>
                </td>
                <td class="width-15 active"><label class="pull-right"><font color="red">*</font>说明:</label></td>
                <td class="width-35">
                    <input id="comments" name="comments" class="form-control required" type="text" value="${genTable.comments}" maxlength="200"/>
                </td>
            </tr>
            <tr>
                <td class="width-15 active"><label class="pull-right">表类型</label></td>
                <td class="width-35">
                    <select id="tableType" name="tableType" class="form-control m-b">
                        <c:if test="${genTable.tableType==0}">
                            <option value="0">单表</option>
                        </c:if>
                        <c:if test="${genTable.tableType==1}">
                            <option value="1">主表</option>
                        </c:if>
                        <c:if test="${genTable.tableType==2}">
                            <option value="2">附表</option>
                        </c:if>
                        <c:if test="${genTable.tableType==3}">
                            <option value="3">树结构表</option>
                        </c:if>
                        <c:if test="${genTable.tableType==4}">
                            <option value="4">左树(主表)</option>
                        </c:if>
                        <c:if test="${genTable.tableType==5}">
                            <option value="5">右表(附表)</option>
                        </c:if>

                        <c:if test="${ empty genTable }">
                            <option value="0">单表</option>
                            <option value="1">主表</option>
                            <option value="2">附表</option>
                            <option value="3">树结构表</option>
                            <option value="4">左树(主表)</option>
                            <option value="5">右表(附表)</option>
                        </c:if>

                    </select>
                    <span class="help-inline">如果是附表，请指定主表表名和当前表的外键</span>
                </td>
                <td class="width-15 active"><label class="pull-right"><font color="red">*</font>类名:</label></td>
                <td class="width-35">
                    <input id="className" name="className" class="form-control required" type="text" value="${genTable.className}" maxlength="200"/>
                </td>

            </tr>
            <tr>
                <td class="width-15 active"><label class="pull-right">主表表名:</label></td>
                <td class="width-35">
                    <select id="parentTable" name="parentTable" class="form-control">


                        <%--<c:if test="${not empty genTable.parent}">
                            <option value="${genTable.parent.name}">${genTable.parent.name}：${genTable.parent.comments}</option>
                        </c:if>--%>

                        <option value="" selected="selected">无</option>
                        <c:forEach items="${tableList}" var="genTable">
                            <option value="${genTable.name}">${genTable.name}：${genTable.comments}</option>
                        </c:forEach>


                    </select>
                </td>
                <td class="width-15 active"><label class="pull-right">当前表外键：</label></td>
                <td class="width-35">
                    <input id="parentTableFk" name="parentTableFk" class="form-control" type="text" value="${genTable.parentTableFk}" maxlength="200"/>
                </td>
            </tr>

            </tbody>
        </table>
        <button class="btn btn-white btn-sm" onclick="return addColumn()"><i class="fa fa-plus"> 增加</i></button>
        <button class="btn btn-white btn-sm" onclick="return delColumn()"><i class="fa fa-minus"> 删除</i> </button>
        <br/>

        <div class="tabs-container">
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true"> 数据库属性</a>
                </li>
                <li class=""><a data-toggle="tab" href="#tab-2" aria-expanded="false">页面属性</a>
                </li>
                <li class=""><a data-toggle="tab" href="#tab-4" aria-expanded="false">页面校验</a>
                </li>
                <li class=""><a data-toggle="tab" href="#tab-3" aria-expanded="false">grid选择框（自定义java对象）</a>
                </li>

            </ul>
            <div class="tab-content">
                <div id="tab-1" class="tab-pane active">
                    <div class="panel-body">
                        <table id="contentTable1" class="table table-striped table-bordered table-hover  dataTables-example dataTable">
                            <thead>
                            <tr>
                                <th width="40px">序号</th>
                                <th>操作</th>
                                <th title="数据库字段名">列名</th>
                                <th title="默认读取数据库字段备注">说明</th>
                                <th title="数据库中设置的字段类型及长度">物理类型</th>
                                <th title="是否是数据库主键">主键</th>
                                <!-- <th title="字段是否可为空值，不可为空字段自动进行空值验证">可空</th> -->
                                <!--<th title="选中后该字段被加入到insert语句里">插入</th>
                                <th title="选中后该字段被加入到update语句里">编辑</th>  -->
                            </tr>
                            </thead>
                            <tbody>
                                <c:if test="${empty genTable.columnList}">
                                    <!-- id -->
                                    <tr>
                                        <td>
                                            <input type="hidden" name="columnList[0].sort" value="0"  maxlength="200" class="form-control required   digits"/>
                                            <label>0</label>
                                            <input type="hidden"  name="columnList[0].isInsert" value="1"/>
                                            <input type="hidden"  name="columnList[0].isEdit" value="0" />
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks " name="ck" value="1" />
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="columnList[0].name" value="id"/>
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="columnList[0].comments" value="主键" maxlength="200" class="required" />
                                        </td>
                                        <td>
                                            <span  name="columnList[0].jdbcType" class="required " value="varchar(64)"/>
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks" name="columnList[0].isPk" value="1" checked/>
                                        </td>
                                    </tr>
                                    <!-- create_by -->
                                    <tr>
                                        <td>
                                            <input type="hidden" name="columnList[1].sort" value="1"  maxlength="200" class="form-control required   digits"/>
                                            <label>1</label>
                                            <input type="hidden" name="columnList[1].isInsert" value="1"/>
                                            <input type="hidden" name="columnList[1].isEdit" value="0" />
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks " name="ck" value="1" />
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="columnList[1].name" value="create_by"/>
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="columnList[1].comments" value="创建者" maxlength="200" class="required" />
                                        </td>
                                        <td>
                                            <span  name="columnList[1].jdbcType" class="required " value="varchar(64)"/>
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks" name="columnList[1].isPk" value="1" />
                                        </td>

                                    </tr>

                                    <!-- create_date -->
                                    <tr>
                                        <td>
                                            <input type="hidden" name="columnList[2].sort" value="2"  maxlength="200" class="form-control required   digits"/>
                                            <label>2</label>
                                            <input type="hidden" name="columnList[2].isInsert" value="1"/>
                                            <input type="hidden" name="columnList[2].isEdit" value="0" />
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks " name="ck" value="1" />
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="columnList[2].name" value="create_date"/>
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="columnList[2].comments" value="创建时间" maxlength="200" class="required" />
                                        </td>
                                        <td>
                                            <span  name="columnList[2].jdbcType" class="required " value="datetime"/>
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks" name="columnList[2].isPk" value="1" />
                                        </td>

                                    </tr>

                                    <!-- update_by -->
                                    <tr>
                                        <td>
                                            <input type="hidden" name="columnList[3].sort" value="3"  maxlength="200" class="form-control required   digits"/>
                                            <label>3</label>
                                            <input type="hidden"  name="columnList[3].isInsert" value="1"/>
                                            <input type="hidden"  name="columnList[3].isEdit" value="1"/>
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks " name="ck" value="1" />
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="columnList[3].name" value="update_by"/>
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="columnList[3].comments" value="更新者" maxlength="200" class="required" />
                                        </td>
                                        <td>
                                            <span  name="columnList[3].jdbcType" class="required " value="varchar(64)"/>
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks" name="columnList[3].isPk" value="1" />
                                        </td>
                                    </tr>

                                    <!-- update_date -->
                                    <tr>
                                        <td>
                                            <input type="hidden" name="columnList[4].sort" value="4"  maxlength="200" class="form-control required   digits"/>
                                            <label>4</label>
                                            <input type="hidden"  name="columnList[4].isInsert" value="1" />
                                            <input type="hidden"  name="columnList[4].isEdit" value="1" />
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks " name="ck" value="1" />
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="columnList[4].name" value="update_date"/>
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="columnList[4].comments" value="更新时间" maxlength="200" class="required" />
                                        </td>
                                        <td>
                                            <span  name="columnList[4].jdbcType" class="required " value="datetime"/>
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks" name="columnList[4].isPk" value="1" />
                                        </td>
                                    </tr>

                                    <!-- remarks -->
                                    <tr>
                                        <td>
                                            <input type="hidden" name="columnList[5].sort" value="5"  maxlength="200" class="form-control required   digits"/>
                                            <label>5</label>
                                            <input type="hidden"  name="columnList[5].isInsert" value="1"/>
                                            <input type="hidden" name="columnList[5].isEdit" value="1" />
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks " name="ck" value="1" />
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="columnList[5].name" value="remarks"/>
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="columnList[5].comments" value="备注信息" maxlength="200" class="required" />
                                        </td>
                                        <td>
                                            <span  name="columnList[5].jdbcType" class="required " value="nvarchar(255)"/>
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks" name="columnList[5].isPk" value="1" />
                                        </td>

                                    </tr>

                                    <!-- del_flag -->
                                    <tr>
                                        <td>
                                            <input type="hidden" name="columnList[6].sort" value="0"  maxlength="200" class="form-control required   digits"/>
                                            <label>6</label>
                                            <input type="hidden" name="columnList[6].isInsert" value="1" />
                                            <input type="hidden" name="columnList[6].isEdit" value="0" />
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks " name="ck" value="1" />
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="columnList[6].name" value="del_flag"/>
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="columnList[6].comments" value="逻辑删除标记（0：显示；1：隐藏）" maxlength="200" class="required" />
                                        </td>
                                        <td>
                                            <span  name="columnList[6].jdbcType" class="required " value="varchar(64)"/>
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks" name="columnList[6].isPk" value="1" />
                                        </td>
                                    </tr>
                                </c:if>
                                <c:forEach items="${genTable.columnList}" var="column"  varStatus="idx">
                                    <tr>
                                        <td>
                                            <input type="hidden" name="columnList[${idx.index}].sort" value="${idx.index}"  maxlength="200" class="form-control required   digits"/>
                                            <label>${idx.index}</label>
                                            <input type="hidden"  name="columnList[${idx.index}].isInsert" value="1"/>
                                            <input type="hidden"  name="columnList[${idx.index}].isEdit" value="0" />
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks " name="columnList[${idx.index}].ck" value="1" />
                                        </td>
                                        <td>
                                            <input type="hidden" name="columnList[${idx.index}].id" value="${column.id}"/>
                                            <input type="hidden" name="columnList[${idx.index}].delFlag" value="${column.delFlag}"/>
                                            <input type="hidden" name="columnList[${idx.index}].genTable.id" value="${column.genTable.id}"/>
                                            <input type="text" class="form-control" name="columnList[${idx.index}].name" value="${column.name}"/>
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="columnList[${idx.index}].comments" value="${column.comments}"/>
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="columnList[${idx.index}].jdbcType" value="${column.jdbcType}"/>
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks" name="columnList[${idx.index}].isPk" value="${column.isPk}" ${column.isPk eq '1' ? "checked":""} />
                                        </td>
                                    </tr>
                                </c:forEach>



                            </tbody>
                        </table>
                    </div>
                </div>
                <div id="tab-2" class="tab-pane">
                    <div class="panel-body">
                        <table id="contentTable2" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
                            <thead>
                            <tr>
                                <th title="数据库字段名"  width="15%">列名</th>
                                <th title="默认读取数据库字段备注">说明</th>
                                <th title="实体对象的属性字段类型" width="15%">Java类型</th>
                                <th title="实体对象的属性字段（对象名.属性名|属性名2|属性名3，例如：用户user.id|name|loginName，属性名2和属性名3为Join时关联查询的字段）">Java属性名称 <i class="icon-question-sign"></i></th>
                                <th title="选中后该字段被加入到查询列表里">表单</th>
                                <th title="选中后该字段被加入到查询列表里">列表</th>
                                <th title="选中后该字段被加入到查询条件里">查询</th>
                                <th title="该字段为查询字段时的查询匹配放松" width="15%">查询匹配方式</th>
                                <th title="字段在表单中显示的类型" width="15%">显示表单类型</th>
                                <th title="显示表单类型设置为“下拉框、复选框、点选框”时，需设置字典的类型">字典类型</th>
                            </tr>
                            </thead>
                            <tbody>
                                <c:if test="${ empty genTable.columnList}">
                                <!-- id -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[0].name" value="id"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[0].comments" value="主键" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <select name="columnList[0].javaType" class="form-control required m-b">

                                            <option value="String" selected title="">String</option>

                                            <option value="Long"  title="">Long</option>

                                            <option value="Integer"  title="">Integer</option>

                                            <option value="Double"  title="">Double</option>

                                            <option value="java.util.Date"  title="">Date</option>

                                            <option value="com.jeeplus.modules.sys.entity.User"  title="">User</option>

                                            <option value="com.jeeplus.modules.sys.entity.Office"  title="">Office</option>

                                            <option value="com.jeeplus.modules.sys.entity.Area"  title="">Area</option>

                                            <option value="This"  title="生成当前对象">ThisObj</option>

                                            <option value="com.jeeplus.modules.sys.entity.SysUserFriend"  title="">SysUserFriend</option>

                                            <option value="com.jeeplus.modules.test.entity.onetomanyform.TestDataMainForm"  title="">TestDataMainForm</option>

                                            <option value="com.jeeplus.modules.jinzhu.entity.ActEvtLog"  title="">ActEvtLog</option>

                                            <option value="com.jeeplus.modules.jinzhu.entity.ActEvtLog"  title="">ActEvtLog</option>

                                            <option value="com.jeeplus.modules.test.entity.ActHiActinst"  title="">ActHiActinst</option>

                                            <option value="com.jeeplus.modules.test.entity.child.GenCustomObj"  title="">GenCustomObj</option>

                                            <option value="com.jeeplus.modules.test.entity.manytoone.Category"  title="">Category</option>

                                            <option value="com.jeeplus.modules.tools.entity.datasource.SysDataSource"  title="">SysDataSource</option>

                                            <option value="com.jeeplus.modules.tools.entity.datasource.SysDataSource"  title="">SysDataSource</option>

                                            <option value="com.jeeplus.modules.test.entity.grid.TestContinent"  title="">TestContinent</option>

                                            <option value="com.jeeplus.modules.test.entity.manytomany.Course"  title="">Course</option>

                                            <option value="com.jeeplus.modules.test.entity.manytoone.Category"  title="">Category</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[0].javaField" value="id" maxlength="200" class="form-control required "/>
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[0].isForm" value="1" />
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[0].isList" value="1" />
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[0].isQuery" value="1"  />
                                    </td>
                                    <td>
                                        <select name="columnList[0].queryType" class="form-control required  m-b">

                                            <option value="="  title="">=</option>

                                            <option value="!="  title="">!=</option>

                                            <option value="&gt;"  title="">&gt;</option>

                                            <option value="&gt;="  title="">&gt;=</option>

                                            <option value="&lt;"  title="">&lt;</option>

                                            <option value="&lt;="  title="">&lt;=</option>

                                            <option value="between"  title="">Between</option>

                                            <option value="like"  title="">Like</option>

                                            <option value="left_like"  title="">Left Like</option>

                                            <option value="right_like"  title="">Right Like</option>

                                        </select>
                                    </td>
                                    <td>
                                        <select name="columnList[0].showType" class="form-control required  m-b">

                                            <option value="input" title="">单行文本</option>

                                            <option value="textarea" title="">多行文本</option>

                                            <option value="umeditor" title="">富文本编辑器</option>

                                            <option value="select" title="">下拉选项</option>

                                            <option value="radiobox" title="">单选按钮</option>

                                            <option value="checkbox" title="">复选框</option>

                                            <option value="dateselect" title="">日期选择</option>

                                            <option value="userselect" title="">人员选择</option>

                                            <option value="officeselect" title="">部门选择</option>

                                            <option value="areaselect" title="">区域选择</option>

                                            <option value="cityselect" title="">省市区三级联动</option>

                                            <option value="treeselect" title="">树选择控件</option>

                                            <option value="fileselect" title="">文件上传选择</option>

                                            <option value="gridselect" title="">grid选择框</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[0].dictType" value="" maxlength="200" class="form-control"/>
                                    </td>

                                </tr>
                                <!-- create_by -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[1].name" value="create_by"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[1].comments" value="创建者" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <select name="columnList[1].javaType" class="form-control required m-b">

                                            <option value="String" selected title="">String</option>

                                            <option value="Long"  title="">Long</option>

                                            <option value="Integer"  title="">Integer</option>

                                            <option value="Double"  title="">Double</option>

                                            <option value="java.util.Date"  title="">Date</option>

                                            <option value="com.jeeplus.modules.sys.entity.User"  title="">User</option>

                                            <option value="com.jeeplus.modules.sys.entity.Office"  title="">Office</option>

                                            <option value="com.jeeplus.modules.sys.entity.Area"  title="">Area</option>

                                            <option value="This"  title="生成当前对象">ThisObj</option>

                                            <option value="com.jeeplus.modules.sys.entity.SysUserFriend"  title="">SysUserFriend</option>

                                            <option value="com.jeeplus.modules.test.entity.onetomanyform.TestDataMainForm"  title="">TestDataMainForm</option>

                                            <option value="com.jeeplus.modules.jinzhu.entity.ActEvtLog"  title="">ActEvtLog</option>

                                            <option value="com.jeeplus.modules.jinzhu.entity.ActEvtLog"  title="">ActEvtLog</option>

                                            <option value="com.jeeplus.modules.test.entity.ActHiActinst"  title="">ActHiActinst</option>

                                            <option value="com.jeeplus.modules.test.entity.child.GenCustomObj"  title="">GenCustomObj</option>

                                            <option value="com.jeeplus.modules.test.entity.manytoone.Category"  title="">Category</option>

                                            <option value="com.jeeplus.modules.tools.entity.datasource.SysDataSource"  title="">SysDataSource</option>

                                            <option value="com.jeeplus.modules.tools.entity.datasource.SysDataSource"  title="">SysDataSource</option>

                                            <option value="com.jeeplus.modules.test.entity.grid.TestContinent"  title="">TestContinent</option>

                                            <option value="com.jeeplus.modules.test.entity.manytomany.Course"  title="">Course</option>

                                            <option value="com.jeeplus.modules.test.entity.manytoone.Category"  title="">Category</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[1].javaField" value="createBy.id" maxlength="200" class="form-control required "/>
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[1].isForm" value="1" />
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[1].isList" value="1" />
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[1].isQuery" value="1"  />
                                    </td>
                                    <td>
                                        <select name="columnList[1].queryType" class="form-control required  m-b">

                                            <option value="=" title="">=</option>

                                            <option value="!=" title="">!=</option>

                                            <option value="&gt;" title="">&gt;</option>

                                            <option value="&gt;=" title="">&gt;=</option>

                                            <option value="&lt;" title="">&lt;</option>

                                            <option value="&lt;=" title="">&lt;=</option>

                                            <option value="between" title="">Between</option>

                                            <option value="like" title="">Like</option>

                                            <option value="left_like" title="">Left Like</option>

                                            <option value="right_like" title="">Right Like</option>

                                        </select>
                                    </td>
                                    <td>
                                        <select name="columnList[1].showType" class="form-control required  m-b">

                                            <option value="input" selected title="">单行文本</option>

                                            <option value="textarea"  title="">多行文本</option>

                                            <option value="umeditor"  title="">富文本编辑器</option>

                                            <option value="select"  title="">下拉选项</option>

                                            <option value="radiobox"  title="">单选按钮</option>

                                            <option value="checkbox"  title="">复选框</option>

                                            <option value="dateselect"  title="">日期选择</option>

                                            <option value="userselect"  title="">人员选择</option>

                                            <option value="officeselect"  title="">部门选择</option>

                                            <option value="areaselect"  title="">区域选择</option>

                                            <option value="cityselect"  title="">省市区三级联动</option>

                                            <option value="treeselect"  title="">树选择控件</option>

                                            <option value="fileselect"  title="">文件上传选择</option>

                                            <option value="gridselect"  title="">grid选择框</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[1].dictType" value="" maxlength="200" class="form-control"/>
                                    </td>
                                </tr>

                                <!-- create_date -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[2].name" value="create_date"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[2].comments" value="创建日期" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <select name="columnList[2].javaType" class="form-control required m-b">

                                            <option value="String"  title="">String</option>

                                            <option value="Long"  title="">Long</option>

                                            <option value="Integer"  title="">Integer</option>

                                            <option value="Double"  title="">Double</option>

                                            <option value="java.util.Date" selected title="">Date</option>

                                            <option value="com.jeeplus.modules.sys.entity.User"  title="">User</option>

                                            <option value="com.jeeplus.modules.sys.entity.Office"  title="">Office</option>

                                            <option value="com.jeeplus.modules.sys.entity.Area"  title="">Area</option>

                                            <option value="This"  title="生成当前对象">ThisObj</option>

                                            <option value="com.jeeplus.modules.sys.entity.SysUserFriend"  title="">SysUserFriend</option>

                                            <option value="com.jeeplus.modules.test.entity.onetomanyform.TestDataMainForm"  title="">TestDataMainForm</option>

                                            <option value="com.jeeplus.modules.jinzhu.entity.ActEvtLog"  title="">ActEvtLog</option>

                                            <option value="com.jeeplus.modules.jinzhu.entity.ActEvtLog"  title="">ActEvtLog</option>

                                            <option value="com.jeeplus.modules.test.entity.ActHiActinst"  title="">ActHiActinst</option>

                                            <option value="com.jeeplus.modules.test.entity.child.GenCustomObj"  title="">GenCustomObj</option>

                                            <option value="com.jeeplus.modules.test.entity.manytoone.Category"  title="">Category</option>

                                            <option value="com.jeeplus.modules.tools.entity.datasource.SysDataSource"  title="">SysDataSource</option>

                                            <option value="com.jeeplus.modules.tools.entity.datasource.SysDataSource"  title="">SysDataSource</option>

                                            <option value="com.jeeplus.modules.test.entity.grid.TestContinent"  title="">TestContinent</option>

                                            <option value="com.jeeplus.modules.test.entity.manytomany.Course"  title="">Course</option>

                                            <option value="com.jeeplus.modules.test.entity.manytoone.Category"  title="">Category</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[2].javaField" value="createDate" maxlength="200" class="form-control required "/>
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[2].isForm" value="1" />
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[2].isList" value="1" />
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[2].isQuery" value="1"  />
                                    </td>
                                    <td>
                                        <select name="columnList[2].queryType" class="form-control required  m-b">

                                            <option value="=" title="">=</option>

                                            <option value="!=" title="">!=</option>

                                            <option value="&gt;" title="">&gt;</option>

                                            <option value="&gt;=" title="">&gt;=</option>

                                            <option value="&lt;" title="">&lt;</option>

                                            <option value="&lt;=" title="">&lt;=</option>

                                            <option value="between" title="">Between</option>

                                            <option value="like" title="">Like</option>

                                            <option value="left_like" title="">Left Like</option>

                                            <option value="right_like" title="">Right Like</option>

                                        </select>
                                    </td>
                                    <td>
                                        <select name="columnList[2].showType" class="form-control required  m-b">

                                            <option value="input"  title="">单行文本</option>

                                            <option value="textarea"  title="">多行文本</option>

                                            <option value="umeditor"  title="">富文本编辑器</option>

                                            <option value="select"  title="">下拉选项</option>

                                            <option value="radiobox"  title="">单选按钮</option>

                                            <option value="checkbox"  title="">复选框</option>

                                            <option value="dateselect" selected title="">日期选择</option>

                                            <option value="userselect"  title="">人员选择</option>

                                            <option value="officeselect"  title="">部门选择</option>

                                            <option value="areaselect"  title="">区域选择</option>

                                            <option value="cityselect"  title="">省市区三级联动</option>

                                            <option value="treeselect"  title="">树选择控件</option>

                                            <option value="fileselect"  title="">文件上传选择</option>

                                            <option value="gridselect"  title="">grid选择框</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[2].dictType" value="" maxlength="200" class="form-control"/>
                                    </td>
                                </tr>

                                <!-- update_by -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[3].name" value="update_by"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[3].comments" value="更新者" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <select name="columnList[3].javaType" class="form-control required m-b">

                                            <option value="String" selected title="">String</option>

                                            <option value="Long"  title="">Long</option>

                                            <option value="Integer"  title="">Integer</option>

                                            <option value="Double"  title="">Double</option>

                                            <option value="java.util.Date"  title="">Date</option>

                                            <option value="com.jeeplus.modules.sys.entity.User"  title="">User</option>

                                            <option value="com.jeeplus.modules.sys.entity.Office"  title="">Office</option>

                                            <option value="com.jeeplus.modules.sys.entity.Area"  title="">Area</option>

                                            <option value="This"  title="生成当前对象">ThisObj</option>

                                            <option value="com.jeeplus.modules.sys.entity.SysUserFriend"  title="">SysUserFriend</option>

                                            <option value="com.jeeplus.modules.test.entity.onetomanyform.TestDataMainForm"  title="">TestDataMainForm</option>

                                            <option value="com.jeeplus.modules.jinzhu.entity.ActEvtLog"  title="">ActEvtLog</option>

                                            <option value="com.jeeplus.modules.jinzhu.entity.ActEvtLog"  title="">ActEvtLog</option>

                                            <option value="com.jeeplus.modules.test.entity.ActHiActinst"  title="">ActHiActinst</option>

                                            <option value="com.jeeplus.modules.test.entity.child.GenCustomObj"  title="">GenCustomObj</option>

                                            <option value="com.jeeplus.modules.test.entity.manytoone.Category"  title="">Category</option>

                                            <option value="com.jeeplus.modules.tools.entity.datasource.SysDataSource"  title="">SysDataSource</option>

                                            <option value="com.jeeplus.modules.tools.entity.datasource.SysDataSource"  title="">SysDataSource</option>

                                            <option value="com.jeeplus.modules.test.entity.grid.TestContinent"  title="">TestContinent</option>

                                            <option value="com.jeeplus.modules.test.entity.manytomany.Course"  title="">Course</option>

                                            <option value="com.jeeplus.modules.test.entity.manytoone.Category"  title="">Category</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[3].javaField" value="updateBy.id" maxlength="200" class="form-control required "/>
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[3].isForm" value="1" />
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[3].isList" value="1" />
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[3].isQuery" value="1"  />
                                    </td>
                                    <td>
                                        <select name="columnList[3].queryType" class="form-control required  m-b">

                                            <option value="="  title="">=</option>

                                            <option value="!="  title="">!=</option>

                                            <option value="&gt;"  title="">&gt;</option>

                                            <option value="&gt;="  title="">&gt;=</option>

                                            <option value="&lt;"  title="">&lt;</option>

                                            <option value="&lt;="  title="">&lt;=</option>

                                            <option value="between"  title="">Between</option>

                                            <option value="like"  title="">Like</option>

                                            <option value="left_like"  title="">Left Like</option>

                                            <option value="right_like"  title="">Right Like</option>

                                        </select>
                                    </td>
                                    <td>
                                        <select name="columnList[3].showType" class="form-control required  m-b">

                                            <option value="input" selected title="">单行文本</option>

                                            <option value="textarea"  title="">多行文本</option>

                                            <option value="umeditor"  title="">富文本编辑器</option>

                                            <option value="select"  title="">下拉选项</option>

                                            <option value="radiobox"  title="">单选按钮</option>

                                            <option value="checkbox"  title="">复选框</option>

                                            <option value="dateselect"  title="">日期选择</option>

                                            <option value="userselect"  title="">人员选择</option>

                                            <option value="officeselect"  title="">部门选择</option>

                                            <option value="areaselect"  title="">区域选择</option>

                                            <option value="cityselect"  title="">省市区三级联动</option>

                                            <option value="treeselect"  title="">树选择控件</option>

                                            <option value="fileselect"  title="">文件上传选择</option>

                                            <option value="gridselect"  title="">grid选择框</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[3].dictType" value="" maxlength="200" class="form-control"/>
                                    </td>
                                </tr>

                                <!-- update_date -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[4].name" value="update_date"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[4].comments" value="更新日期" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <select name="columnList[4].javaType" class="form-control required m-b">

                                            <option value="String"  title="">String</option>

                                            <option value="Long"  title="">Long</option>

                                            <option value="Integer"  title="">Integer</option>

                                            <option value="Double"  title="">Double</option>

                                            <option value="java.util.Date" selected title="">Date</option>

                                            <option value="com.jeeplus.modules.sys.entity.User"  title="">User</option>

                                            <option value="com.jeeplus.modules.sys.entity.Office"  title="">Office</option>

                                            <option value="com.jeeplus.modules.sys.entity.Area"  title="">Area</option>

                                            <option value="This"  title="生成当前对象">ThisObj</option>

                                            <option value="com.jeeplus.modules.sys.entity.SysUserFriend"  title="">SysUserFriend</option>

                                            <option value="com.jeeplus.modules.test.entity.onetomanyform.TestDataMainForm"  title="">TestDataMainForm</option>

                                            <option value="com.jeeplus.modules.jinzhu.entity.ActEvtLog"  title="">ActEvtLog</option>

                                            <option value="com.jeeplus.modules.jinzhu.entity.ActEvtLog"  title="">ActEvtLog</option>

                                            <option value="com.jeeplus.modules.test.entity.ActHiActinst"  title="">ActHiActinst</option>

                                            <option value="com.jeeplus.modules.test.entity.child.GenCustomObj"  title="">GenCustomObj</option>

                                            <option value="com.jeeplus.modules.test.entity.manytoone.Category"  title="">Category</option>

                                            <option value="com.jeeplus.modules.tools.entity.datasource.SysDataSource"  title="">SysDataSource</option>

                                            <option value="com.jeeplus.modules.tools.entity.datasource.SysDataSource"  title="">SysDataSource</option>

                                            <option value="com.jeeplus.modules.test.entity.grid.TestContinent"  title="">TestContinent</option>

                                            <option value="com.jeeplus.modules.test.entity.manytomany.Course"  title="">Course</option>

                                            <option value="com.jeeplus.modules.test.entity.manytoone.Category"  title="">Category</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[4].javaField" value="updateDate" maxlength="200" class="form-control required "/>
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[4].isForm" value="1"  />
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[4].isList" value="1"  />
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[4].isQuery" value="1"  />
                                    </td>
                                    <td>
                                        <select name="columnList[4].queryType" class="form-control required  m-b">

                                            <option value="="  title="">=</option>

                                            <option value="!="  title="">!=</option>

                                            <option value="&gt;"  title="">&gt;</option>

                                            <option value="&gt;="  title="">&gt;=</option>

                                            <option value="&lt;"  title="">&lt;</option>

                                            <option value="&lt;="  title="">&lt;=</option>

                                            <option value="between"  title="">Between</option>

                                            <option value="like"  title="">Like</option>

                                            <option value="left_like"  title="">Left Like</option>

                                            <option value="right_like"  title="">Right Like</option>

                                        </select>
                                    </td>
                                    <td>
                                        <select name="columnList[4].showType" class="form-control required  m-b">

                                            <option value="input"  title="">单行文本</option>

                                            <option value="textarea"  title="">多行文本</option>

                                            <option value="umeditor"  title="">富文本编辑器</option>

                                            <option value="select"  title="">下拉选项</option>

                                            <option value="radiobox"  title="">单选按钮</option>

                                            <option value="checkbox"  title="">复选框</option>

                                            <option value="dateselect" selected title="">日期选择</option>

                                            <option value="userselect"  title="">人员选择</option>

                                            <option value="officeselect"  title="">部门选择</option>

                                            <option value="areaselect"  title="">区域选择</option>

                                            <option value="cityselect"  title="">省市区三级联动</option>

                                            <option value="treeselect"  title="">树选择控件</option>

                                            <option value="fileselect"  title="">文件上传选择</option>

                                            <option value="gridselect"  title="">grid选择框</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[4].dictType" value="" maxlength="200" class="form-control"/>
                                    </td>
                                </tr>

                                <!-- remarks -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[5].name" value="remarks"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[5].comments" value="备注信息" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <select name="columnList[5].javaType" class="form-control required m-b">

                                            <option value="String" selected title="">String</option>

                                            <option value="Long"  title="">Long</option>

                                            <option value="Integer"  title="">Integer</option>

                                            <option value="Double"  title="">Double</option>

                                            <option value="java.util.Date"  title="">Date</option>

                                            <option value="com.jeeplus.modules.sys.entity.User"  title="">User</option>

                                            <option value="com.jeeplus.modules.sys.entity.Office"  title="">Office</option>

                                            <option value="com.jeeplus.modules.sys.entity.Area"  title="">Area</option>

                                            <option value="This"  title="生成当前对象">ThisObj</option>

                                            <option value="com.jeeplus.modules.sys.entity.SysUserFriend"  title="">SysUserFriend</option>

                                            <option value="com.jeeplus.modules.test.entity.onetomanyform.TestDataMainForm"  title="">TestDataMainForm</option>

                                            <option value="com.jeeplus.modules.jinzhu.entity.ActEvtLog"  title="">ActEvtLog</option>

                                            <option value="com.jeeplus.modules.jinzhu.entity.ActEvtLog"  title="">ActEvtLog</option>

                                            <option value="com.jeeplus.modules.test.entity.ActHiActinst"  title="">ActHiActinst</option>

                                            <option value="com.jeeplus.modules.test.entity.child.GenCustomObj"  title="">GenCustomObj</option>

                                            <option value="com.jeeplus.modules.test.entity.manytoone.Category"  title="">Category</option>

                                            <option value="com.jeeplus.modules.tools.entity.datasource.SysDataSource"  title="">SysDataSource</option>

                                            <option value="com.jeeplus.modules.tools.entity.datasource.SysDataSource"  title="">SysDataSource</option>

                                            <option value="com.jeeplus.modules.test.entity.grid.TestContinent"  title="">TestContinent</option>

                                            <option value="com.jeeplus.modules.test.entity.manytomany.Course"  title="">Course</option>

                                            <option value="com.jeeplus.modules.test.entity.manytoone.Category"  title="">Category</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[5].javaField" value="remarks" maxlength="255" class="form-control required "/>
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[5].isForm" value="1" checked/>
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[5].isList" value="1" checked/>
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[5].isQuery" value="1"  />
                                    </td>
                                    <td>
                                        <select name="columnList[5].queryType" class="form-control required  m-b">

                                            <option value="="  title="">=</option>

                                            <option value="!="  title="">!=</option>

                                            <option value="&gt;"  title="">&gt;</option>

                                            <option value="&gt;="  title="">&gt;=</option>

                                            <option value="&lt;"  title="">&lt;</option>

                                            <option value="&lt;="  title="">&lt;=</option>

                                            <option value="between"  title="">Between</option>

                                            <option value="like"  title="">Like</option>

                                            <option value="left_like"  title="">Left Like</option>

                                            <option value="right_like"  title="">Right Like</option>

                                        </select>
                                    </td>
                                    <td>
                                        <select name="columnList[5].showType" class="form-control required  m-b">

                                            <option value="input"  title="">单行文本</option>

                                            <option value="textarea" selected title="">多行文本</option>

                                            <option value="umeditor"  title="">富文本编辑器</option>

                                            <option value="select"  title="">下拉选项</option>

                                            <option value="radiobox"  title="">单选按钮</option>

                                            <option value="checkbox"  title="">复选框</option>

                                            <option value="dateselect"  title="">日期选择</option>

                                            <option value="userselect"  title="">人员选择</option>

                                            <option value="officeselect"  title="">部门选择</option>

                                            <option value="areaselect"  title="">区域选择</option>

                                            <option value="cityselect"  title="">省市区三级联动</option>

                                            <option value="treeselect"  title="">树选择控件</option>

                                            <option value="fileselect"  title="">文件上传选择</option>

                                            <option value="gridselect"  title="">grid选择框</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[5].dictType" value="" maxlength="200" class="form-control"/>
                                    </td>
                                </tr>

                                <!-- del_flag -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[6].name" value="del_flag"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[6].comments" value="逻辑删除标记（0：显示；1：隐藏）" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <select name="columnList[6].javaType" class="form-control required m-b">

                                            <option value="String" selected title="">String</option>

                                            <option value="Long"  title="">Long</option>

                                            <option value="Integer"  title="">Integer</option>

                                            <option value="Double"  title="">Double</option>

                                            <option value="java.util.Date"  title="">Date</option>

                                            <option value="com.jeeplus.modules.sys.entity.User"  title="">User</option>

                                            <option value="com.jeeplus.modules.sys.entity.Office"  title="">Office</option>

                                            <option value="com.jeeplus.modules.sys.entity.Area"  title="">Area</option>

                                            <option value="This"  title="生成当前对象">ThisObj</option>

                                            <option value="com.jeeplus.modules.sys.entity.SysUserFriend"  title="">SysUserFriend</option>

                                            <option value="com.jeeplus.modules.test.entity.onetomanyform.TestDataMainForm"  title="">TestDataMainForm</option>

                                            <option value="com.jeeplus.modules.jinzhu.entity.ActEvtLog"  title="">ActEvtLog</option>

                                            <option value="com.jeeplus.modules.jinzhu.entity.ActEvtLog"  title="">ActEvtLog</option>

                                            <option value="com.jeeplus.modules.test.entity.ActHiActinst"  title="">ActHiActinst</option>

                                            <option value="com.jeeplus.modules.test.entity.child.GenCustomObj"  title="">GenCustomObj</option>

                                            <option value="com.jeeplus.modules.test.entity.manytoone.Category"  title="">Category</option>

                                            <option value="com.jeeplus.modules.tools.entity.datasource.SysDataSource"  title="">SysDataSource</option>

                                            <option value="com.jeeplus.modules.tools.entity.datasource.SysDataSource"  title="">SysDataSource</option>

                                            <option value="com.jeeplus.modules.test.entity.grid.TestContinent"  title="">TestContinent</option>

                                            <option value="com.jeeplus.modules.test.entity.manytomany.Course"  title="">Course</option>

                                            <option value="com.jeeplus.modules.test.entity.manytoone.Category"  title="">Category</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[6].javaField" value="delFlag" maxlength="255" class="form-control required "/>
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[6].isForm" value="1" />
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[6].isList" value="1" />
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[6].isQuery" value="1"  />
                                    </td>
                                    <td>
                                        <select name="columnList[6].queryType" class="form-control required  m-b">

                                            <option value="="  title="">=</option>

                                            <option value="!="  title="">!=</option>

                                            <option value="&gt;"  title="">&gt;</option>

                                            <option value="&gt;="  title="">&gt;=</option>

                                            <option value="&lt;"  title="">&lt;</option>

                                            <option value="&lt;="  title="">&lt;=</option>

                                            <option value="between"  title="">Between</option>

                                            <option value="like"  title="">Like</option>

                                            <option value="left_like"  title="">Left Like</option>

                                            <option value="right_like"  title="">Right Like</option>

                                        </select>
                                    </td>
                                    <td>
                                        <select name="columnList[6].showType" class="form-control required  m-b">

                                            <option value="input"  title="">单行文本</option>

                                            <option value="textarea"  title="">多行文本</option>

                                            <option value="umeditor"  title="">富文本编辑器</option>

                                            <option value="select"  title="">下拉选项</option>

                                            <option value="radiobox" selected title="">单选按钮</option>

                                            <option value="checkbox"  title="">复选框</option>

                                            <option value="dateselect"  title="">日期选择</option>

                                            <option value="userselect"  title="">人员选择</option>

                                            <option value="officeselect"  title="">部门选择</option>

                                            <option value="areaselect"  title="">区域选择</option>

                                            <option value="cityselect"  title="">省市区三级联动</option>

                                            <option value="treeselect"  title="">树选择控件</option>

                                            <option value="fileselect"  title="">文件上传选择</option>

                                            <option value="gridselect"  title="">grid选择框</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[6].dictType" value="del_flag" maxlength="200" class="form-control"/>
                                    </td>
                                </tr>
                            </c:if>
                                <c:forEach items="${genTable.columnList}" var="column"  varStatus="idx">
                                    <tr>
                                        <td>
                                            <input type="text" class="form-control" readonly="readonly" name="page-columnList[${idx.index}].name" value="${column.name}"/>

                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="page-columnList[${idx.index}].comments" value="${column.comments}" maxlength="200" readonly="readonly" />
                                        </td>
                                        <td>
                                            <select name="columnList[${idx.index}].javaType" class="form-control required m-b">

                                                <option value="String" ${column.javaType eq 'String' ? "selected":""}  title="">String</option>

                                                <option value="Long"  ${column.javaType eq 'Long' ? "selected":""} title="">Long</option>

                                                <option value="Integer" ${column.javaType eq 'Integer' ? "selected":""}  title="">Integer</option>

                                                <option value="Double" ${column.javaType eq 'Double' ? "selected":""}  title="">Double</option>

                                                <option value="java.util.Date" ${column.javaType eq 'java.util.Date' ? "selected":""}  title="">Date</option>

                                                <option value="com.jeeplus.modules.sys.entity.User" ${column.javaType eq 'com.jeeplus.modules.sys.entity.User' ? "selected":""}  title="">User</option>

                                                <option value="com.jeeplus.modules.sys.entity.Office" ${column.javaType eq 'com.jeeplus.modules.sys.entity.Office' ? "selected":""}  title="">Office</option>

                                                <option value="com.jeeplus.modules.sys.entity.Area" ${column.javaType eq 'com.jeeplus.modules.sys.entity.Area' ? "selected":""}  title="">Area</option>

                                                <option value="This"  title="生成当前对象">ThisObj</option>

                                                <option value="Custom"  class="newadd" >自定义输入</option>
                                            </select>
                                        </td>
                                        <td>
                                            <input type="text" name="columnList[${idx.index}].javaField" value="${column.javaField}" maxlength="200" class="form-control required "/>
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks" name="columnList[${idx.index}].isForm" value="${column.isForm}" />
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks" name="columnList[${idx.index}].isList" value="${column.isList}" />
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks" name="columnList[${idx.index}].isQuery" value="${column.isQuery}"  />
                                        </td>
                                        <td>
                                            <select name="columnList[${idx.index}].queryType" class="form-control required  m-b">

                                                <option value="="  title="">=</option>

                                                <option value="!="  title="">!=</option>

                                                <option value="&gt;"  title="">&gt;</option>

                                                <option value="&gt;="  title="">&gt;=</option>

                                                <option value="&lt;"  title="">&lt;</option>

                                                <option value="&lt;="  title="">&lt;=</option>

                                                <option value="between"  title="">Between</option>

                                                <option value="like"  title="">Like</option>

                                                <option value="left_like"  title="">Left Like</option>

                                                <option value="right_like"  title="">Right Like</option>

                                            </select>
                                        </td>
                                        <td>
                                            <select name="columnList[${idx.index}].showType" class="form-control required  m-b">

                                                <option value="input" title="">单行文本</option>

                                                <option value="textarea" title="">多行文本</option>

                                                <option value="umeditor" title="">富文本编辑器</option>

                                                <option value="select" title="">下拉选项</option>

                                                <option value="radiobox" title="">单选按钮</option>

                                                <option value="checkbox" title="">复选框</option>

                                                <option value="dateselect" title="">日期选择</option>

                                                <option value="userselect" title="">人员选择</option>

                                                <option value="officeselect" title="">部门选择</option>

                                                <option value="areaselect" title="">区域选择</option>

                                                <option value="treeselect" title="">树选择控件</option>

                                                <option value="fileselect" title="">文件上传选择</option>

                                                <option value="gridselect" title="">grid选择框(自定义java对象)</option>

                                            </select>
                                        </td>
                                        <td>
                                            <input type="text" name="columnList[${idx.index}].dictType" value="${column.dictType}" maxlength="200" class="form-control"/>
                                        </td>

                                    </tr>

                                </c:forEach>


                            </tbody>
                        </table>
                    </div>
                </div>

                <div id="tab-3" class="tab-pane">
                    <div class="panel-body">
                        <table id="contentTable3" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
                            <thead>
                            <tr>
                                <th title="数据库字段名"  width="15%">列名</th>
                                <th title="默认读取数据库字段备注">说明</th>
                               <%-- <th title="实体对象的属性字段类型" width="15%">table表名</th>--%>
                                <th title="实体对象的属性字段说明（label1|label2|label3，用户名|登录名|角色）">JAVA属性说明(例如：名字|年龄|备注)<i class="icon-question-sign"></i></th>
                                <th title="选中后该字段被加入到查询列表里">JAVA属性名称(例如：name|age|remarks)</th>
                                <th title="选中后该字段被加入到查询列表里">检索标签(例如：名字|年龄)</th>
                                <th title="选中后该字段被加入到查询条件里">检索key(例如：name|age)</th>

                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${ empty genTable.columnList}">

                                <!-- id -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[0].name" value="id"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[0].comments" value="主键" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[0].fieldLabels" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[0].fieldKeys" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[0].searchLabel" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[0].searchKey" value="" maxlength="200" class="form-control  "/>
                                    </td>


                                </tr>
                                <!-- create_by -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[1].name" value="create_by"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[1].comments" value="创建者" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[1].fieldLabels" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[1].fieldKeys" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[1].searchLabel" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[1].searchKey" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                </tr>

                                <!-- create_date -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[2].name" value="create_date"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[2].comments" value="创建时间" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[2].fieldLabels" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[2].fieldKeys" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[2].searchLabel" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[2].searchKey" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                </tr>

                                <!-- update_by -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[3].name" value="update_by"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[3].comments" value="更新者" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[3].fieldLabels" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[3].fieldKeys" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[3].searchLabel" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[3].searchKey" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                </tr>

                                <!-- update_date -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[4].name" value="update_date"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[4].comments" value="更新时间" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[4].fieldLabels" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[4].fieldKeys" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[4].searchLabel" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[4].searchKey" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                </tr>

                                <!-- remarks -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[5].name" value="remarks"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[5].comments" value="备注信息" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[5].fieldLabels" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[5].fieldKeys" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[5].searchLabel" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[5].searchKey" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                </tr>

                                <!-- del_flag -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[6].name" value="del_flag"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[6].comments" value="逻辑删除标记（0：显示；1：隐藏）" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[6].fieldLabels" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[6].fieldKeys" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[6].searchLabel" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[6].searchKey" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                </tr>

                            </c:if>
                                <c:forEach items="${genTable.columnList}" var="column"  varStatus="idx">
                                    <tr>
                                        <td>
                                            <input type="text" ame="page-columnList[${idx.index}].name" value="${column.name}" class="form-control" readonly="readonly" n/>
                                        </td>
                                        <td>
                                            <input type="text" name="page-columnList[${idx.index}].comments" value="${column.comments}" class="form-control"  maxlength="200" readonly="readonly" />
                                        </td>
                                        <td>
                                            <input type="text" name="columnList[${idx.index}].tableName" value="${column.tableName}" maxlength="200" class="form-control  "/>
                                        </td>
                                        <td>
                                            <input type="text" name="columnList[${idx.index}].fieldLabels" value="${column.fieldLabels}" maxlength="200" class="form-control  "/>
                                        </td>
                                        <td>
                                            <input type="text" name="columnList[${idx.index}].columnList[${idx.index}].fieldKeys" value="${column.fieldKeys}" maxlength="200" class="form-control  "/>
                                        </td>
                                        <td>
                                            <input type="text" name="columnList[${idx.index}].searchLabel" value="${column.searchLabel}" maxlength="200" class="form-control  "/>
                                        </td>
                                        <td>
                                            <input type="text" name="columnList[${idx.index}].searchKey" value="${column.searchKey}" maxlength="200" class="form-control  "/>
                                        </td>
                                    </tr>
                                </c:forEach>


                            </tbody>
                        </table>
                    </div>
                </div>


                <div id="tab-4" class="tab-pane">
                    <div class="panel-body">
                        <table id="contentTable4" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
                            <thead>
                            <tr>
                                <th title="数据库字段名"  width="15%">列名</th>
                                <th title="默认读取数据库字段备注">说明</th>
                                <th title="字段是否可为空值，不可为空字段自动进行空值验证">可空</th>
                                <th title="校验类型">校验类型<i class="icon-question-sign"></i></th>
                                <th title="最小长度">最小长度</th>
                                <th title="最大长度">最大长度</th>
                                <th title="最小值">最小值</th>
                                <th title="最大值">最大值</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${ empty genTable.columnList}">

                                <!-- id -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[0].name" value="id"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[0].comments" value="主键" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[0].isNull" value="1" />
                                    </td>
                                    <td>
                                        <select name="columnList[0].validateType" class="form-control m-b">

                                            <option value=""  title=""></option>

                                            <option value="string"  title="">字符串</option>

                                            <option value="email"  title="">电子邮件</option>

                                            <option value="url"  title="">网址</option>

                                            <option value="date"  title="">日期</option>

                                            <option value="dateISO"  title="">日期(ISO)</option>

                                            <option value="creditcard"  title="">信用卡号</option>

                                            <option value="isMobile"  title="">手机号码</option>

                                            <option value="isPhone"  title="">电话号码</option>

                                            <option value="isTel"  title="">手机/电话</option>

                                            <option value="isQq"  title="">QQ号码</option>

                                            <option value="isIdCardNo"  title="">身份证号码</option>

                                            <option value="number"  title="">数字</option>

                                            <option value="digits"  title="">整数</option>

                                            <option value="isIntGtZero"  title="">整数(大于0)</option>

                                            <option value="isIntGteZero"  title="">整数(大于等于0)</option>

                                            <option value="isIntLtZero"  title="">整数(小于0)</option>

                                            <option value="isIntLteZero"  title="">整数(小于等于0)</option>

                                            <option value="isFloatGtZero"  title="">浮点数(大于0)</option>

                                            <option value="isFloatGteZero"  title="">浮点数(大于等于0)</option>

                                            <option value="isFloatLtZero"  title="">浮点数(小于0)</option>

                                            <option value="isFloatLteZero"  title="">浮点数(小于等于0)</option>

                                            <option value="isZipCode"  title="">邮政编码</option>

                                            <option value="isPwd"  title="以字母开头，长度在6-12之间，只能包含字符、数字和下划线">密码</option>

                                            <option value="stringCheck"  title="只能包含中文、英文、数字、下划线等字符">中文/英文/数字/下划线</option>

                                            <option value="isEnglish"  title="">英语</option>

                                            <option value="isChinese"  title="">汉子</option>

                                            <option value="isChineseChar"  title="匹配中文(包括汉字和字符)">汉英字符</option>

                                            <option value="isRightfulString"  title="判断是否为合法字符(a-zA-Z0-9-_)">合法字符</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[0].minLength" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[0].maxLength" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[0].minValue" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[0].maxValue" value="" maxlength="200" class="form-control  "/>
                                    </td>

                                </tr>
                                <!-- create_by -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[1].name" value="create_by"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[1].comments" value="创建者" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[1].isNull" value="1" />
                                    </td>
                                    <td>
                                        <select name="columnList[1].validateType" class="form-control m-b">

                                            <option value=""  title=""></option>

                                            <option value="string"  title="">字符串</option>

                                            <option value="email"  title="">电子邮件</option>

                                            <option value="url"  title="">网址</option>

                                            <option value="date"  title="">日期</option>

                                            <option value="dateISO"  title="">日期(ISO)</option>

                                            <option value="creditcard"  title="">信用卡号</option>

                                            <option value="isMobile"  title="">手机号码</option>

                                            <option value="isPhone"  title="">电话号码</option>

                                            <option value="isTel"  title="">手机/电话</option>

                                            <option value="isQq"  title="">QQ号码</option>

                                            <option value="isIdCardNo"  title="">身份证号码</option>

                                            <option value="number"  title="">数字</option>

                                            <option value="digits"  title="">整数</option>

                                            <option value="isIntGtZero"  title="">整数(大于0)</option>

                                            <option value="isIntGteZero"  title="">整数(大于等于0)</option>

                                            <option value="isIntLtZero"  title="">整数(小于0)</option>

                                            <option value="isIntLteZero"  title="">整数(小于等于0)</option>

                                            <option value="isFloatGtZero"  title="">浮点数(大于0)</option>

                                            <option value="isFloatGteZero"  title="">浮点数(大于等于0)</option>

                                            <option value="isFloatLtZero"  title="">浮点数(小于0)</option>

                                            <option value="isFloatLteZero"  title="">浮点数(小于等于0)</option>

                                            <option value="isZipCode"  title="">邮政编码</option>

                                            <option value="isPwd"  title="以字母开头，长度在6-12之间，只能包含字符、数字和下划线">密码</option>

                                            <option value="stringCheck"  title="只能包含中文、英文、数字、下划线等字符">中文/英文/数字/下划线</option>

                                            <option value="isEnglish"  title="">英语</option>

                                            <option value="isChinese"  title="">汉子</option>

                                            <option value="isChineseChar"  title="匹配中文(包括汉字和字符)">汉英字符</option>

                                            <option value="isRightfulString"  title="判断是否为合法字符(a-zA-Z0-9-_)">合法字符</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[1].minLength" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[1].maxLength" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[1].minValue" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[1].maxValue" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                </tr>

                                <!-- create_date -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[2].name" value="create_date"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[2].comments" value="创建时间" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[2].isNull" value="1" />
                                    </td>
                                    <td>
                                        <select name="columnList[2].validateType" class="form-control m-b">

                                            <option value=""  title=""></option>

                                            <option value="string"  title="">字符串</option>

                                            <option value="email"  title="">电子邮件</option>

                                            <option value="url"  title="">网址</option>

                                            <option value="date"  title="">日期</option>

                                            <option value="dateISO"  title="">日期(ISO)</option>

                                            <option value="creditcard"  title="">信用卡号</option>

                                            <option value="isMobile"  title="">手机号码</option>

                                            <option value="isPhone"  title="">电话号码</option>

                                            <option value="isTel"  title="">手机/电话</option>

                                            <option value="isQq"  title="">QQ号码</option>

                                            <option value="isIdCardNo"  title="">身份证号码</option>

                                            <option value="number"  title="">数字</option>

                                            <option value="digits"  title="">整数</option>

                                            <option value="isIntGtZero"  title="">整数(大于0)</option>

                                            <option value="isIntGteZero"  title="">整数(大于等于0)</option>

                                            <option value="isIntLtZero"  title="">整数(小于0)</option>

                                            <option value="isIntLteZero"  title="">整数(小于等于0)</option>

                                            <option value="isFloatGtZero"  title="">浮点数(大于0)</option>

                                            <option value="isFloatGteZero"  title="">浮点数(大于等于0)</option>

                                            <option value="isFloatLtZero"  title="">浮点数(小于0)</option>

                                            <option value="isFloatLteZero"  title="">浮点数(小于等于0)</option>

                                            <option value="isZipCode"  title="">邮政编码</option>

                                            <option value="isPwd"  title="以字母开头，长度在6-12之间，只能包含字符、数字和下划线">密码</option>

                                            <option value="stringCheck"  title="只能包含中文、英文、数字、下划线等字符">中文/英文/数字/下划线</option>

                                            <option value="isEnglish"  title="">英语</option>

                                            <option value="isChinese"  title="">汉子</option>

                                            <option value="isChineseChar"  title="匹配中文(包括汉字和字符)">汉英字符</option>

                                            <option value="isRightfulString"  title="判断是否为合法字符(a-zA-Z0-9-_)">合法字符</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[2].minLength" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[2].maxLength" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[2].minValue" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[2].maxValue" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                </tr>

                                <!-- update_by -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[3].name" value="update_by"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[3].comments" value="更新者" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[3].isNull" value="1" />
                                    </td>
                                    <td>
                                        <select name="columnList[3].validateType" class="form-control m-b">

                                            <option value=""  title=""></option>

                                            <option value="string"  title="">字符串</option>

                                            <option value="email"  title="">电子邮件</option>

                                            <option value="url"  title="">网址</option>

                                            <option value="date"  title="">日期</option>

                                            <option value="dateISO"  title="">日期(ISO)</option>

                                            <option value="creditcard"  title="">信用卡号</option>

                                            <option value="isMobile"  title="">手机号码</option>

                                            <option value="isPhone"  title="">电话号码</option>

                                            <option value="isTel"  title="">手机/电话</option>

                                            <option value="isQq"  title="">QQ号码</option>

                                            <option value="isIdCardNo"  title="">身份证号码</option>

                                            <option value="number"  title="">数字</option>

                                            <option value="digits"  title="">整数</option>

                                            <option value="isIntGtZero"  title="">整数(大于0)</option>

                                            <option value="isIntGteZero"  title="">整数(大于等于0)</option>

                                            <option value="isIntLtZero"  title="">整数(小于0)</option>

                                            <option value="isIntLteZero"  title="">整数(小于等于0)</option>

                                            <option value="isFloatGtZero"  title="">浮点数(大于0)</option>

                                            <option value="isFloatGteZero"  title="">浮点数(大于等于0)</option>

                                            <option value="isFloatLtZero"  title="">浮点数(小于0)</option>

                                            <option value="isFloatLteZero"  title="">浮点数(小于等于0)</option>

                                            <option value="isZipCode"  title="">邮政编码</option>

                                            <option value="isPwd"  title="以字母开头，长度在6-12之间，只能包含字符、数字和下划线">密码</option>

                                            <option value="stringCheck"  title="只能包含中文、英文、数字、下划线等字符">中文/英文/数字/下划线</option>

                                            <option value="isEnglish"  title="">英语</option>

                                            <option value="isChinese"  title="">汉子</option>

                                            <option value="isChineseChar"  title="匹配中文(包括汉字和字符)">汉英字符</option>

                                            <option value="isRightfulString"  title="判断是否为合法字符(a-zA-Z0-9-_)">合法字符</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[3].minLength" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[3].maxLength" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[3].minValue" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[3].maxValue" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                </tr>

                                <!-- update_date -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[4].name" value="update_date"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[4].comments" value="更新时间" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[4].isNull" value="1" />
                                    </td>
                                    <td>
                                        <select name="columnList[4].validateType" class="form-control m-b">

                                            <option value=""  title=""></option>

                                            <option value="string"  title="">字符串</option>

                                            <option value="email"  title="">电子邮件</option>

                                            <option value="url"  title="">网址</option>

                                            <option value="date"  title="">日期</option>

                                            <option value="dateISO"  title="">日期(ISO)</option>

                                            <option value="creditcard"  title="">信用卡号</option>

                                            <option value="isMobile"  title="">手机号码</option>

                                            <option value="isPhone"  title="">电话号码</option>

                                            <option value="isTel"  title="">手机/电话</option>

                                            <option value="isQq"  title="">QQ号码</option>

                                            <option value="isIdCardNo"  title="">身份证号码</option>

                                            <option value="number"  title="">数字</option>

                                            <option value="digits"  title="">整数</option>

                                            <option value="isIntGtZero"  title="">整数(大于0)</option>

                                            <option value="isIntGteZero"  title="">整数(大于等于0)</option>

                                            <option value="isIntLtZero"  title="">整数(小于0)</option>

                                            <option value="isIntLteZero"  title="">整数(小于等于0)</option>

                                            <option value="isFloatGtZero"  title="">浮点数(大于0)</option>

                                            <option value="isFloatGteZero"  title="">浮点数(大于等于0)</option>

                                            <option value="isFloatLtZero"  title="">浮点数(小于0)</option>

                                            <option value="isFloatLteZero"  title="">浮点数(小于等于0)</option>

                                            <option value="isZipCode"  title="">邮政编码</option>

                                            <option value="isPwd"  title="以字母开头，长度在6-12之间，只能包含字符、数字和下划线">密码</option>

                                            <option value="stringCheck"  title="只能包含中文、英文、数字、下划线等字符">中文/英文/数字/下划线</option>

                                            <option value="isEnglish"  title="">英语</option>

                                            <option value="isChinese"  title="">汉子</option>

                                            <option value="isChineseChar"  title="匹配中文(包括汉字和字符)">汉英字符</option>

                                            <option value="isRightfulString"  title="判断是否为合法字符(a-zA-Z0-9-_)">合法字符</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[4].minLength" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[4].maxLength" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[4].minValue" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[4].maxValue" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                </tr>

                                <!-- remarks -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[5].name" value="remarks"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[5].comments" value="备注信息" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[5].isNull" value="1" checked />
                                    </td>
                                    <td>
                                        <select name="columnList[5].validateType" class="form-control m-b">

                                            <option value=""  title=""></option>

                                            <option value="string"  title="">字符串</option>

                                            <option value="email"  title="">电子邮件</option>

                                            <option value="url"  title="">网址</option>

                                            <option value="date"  title="">日期</option>

                                            <option value="dateISO"  title="">日期(ISO)</option>

                                            <option value="creditcard"  title="">信用卡号</option>

                                            <option value="isMobile"  title="">手机号码</option>

                                            <option value="isPhone"  title="">电话号码</option>

                                            <option value="isTel"  title="">手机/电话</option>

                                            <option value="isQq"  title="">QQ号码</option>

                                            <option value="isIdCardNo"  title="">身份证号码</option>

                                            <option value="number"  title="">数字</option>

                                            <option value="digits"  title="">整数</option>

                                            <option value="isIntGtZero"  title="">整数(大于0)</option>

                                            <option value="isIntGteZero"  title="">整数(大于等于0)</option>

                                            <option value="isIntLtZero"  title="">整数(小于0)</option>

                                            <option value="isIntLteZero"  title="">整数(小于等于0)</option>

                                            <option value="isFloatGtZero"  title="">浮点数(大于0)</option>

                                            <option value="isFloatGteZero"  title="">浮点数(大于等于0)</option>

                                            <option value="isFloatLtZero"  title="">浮点数(小于0)</option>

                                            <option value="isFloatLteZero"  title="">浮点数(小于等于0)</option>

                                            <option value="isZipCode"  title="">邮政编码</option>

                                            <option value="isPwd"  title="以字母开头，长度在6-12之间，只能包含字符、数字和下划线">密码</option>

                                            <option value="stringCheck"  title="只能包含中文、英文、数字、下划线等字符">中文/英文/数字/下划线</option>

                                            <option value="isEnglish"  title="">英语</option>

                                            <option value="isChinese"  title="">汉子</option>

                                            <option value="isChineseChar"  title="匹配中文(包括汉字和字符)">汉英字符</option>

                                            <option value="isRightfulString"  title="判断是否为合法字符(a-zA-Z0-9-_)">合法字符</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[5].minLength" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[5].maxLength" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[5].minValue" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[5].maxValue" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                </tr>

                                <!-- del_flag -->
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" readonly="readonly" name="page-columnList[6].name" value="del_flag"/>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" name="page-columnList[6].comments" value="逻辑删除标记（0：显示；1：隐藏）" maxlength="200" readonly="readonly" />
                                    </td>
                                    <td>
                                        <input type="checkbox" class="i-checks" name="columnList[6].isNull" value="1" />
                                    </td>
                                    <td>
                                        <select name="columnList[6].validateType" class="form-control m-b">

                                            <option value=""  title=""></option>

                                            <option value="string"  title="">字符串</option>

                                            <option value="email"  title="">电子邮件</option>

                                            <option value="url"  title="">网址</option>

                                            <option value="date"  title="">日期</option>

                                            <option value="dateISO"  title="">日期(ISO)</option>

                                            <option value="creditcard"  title="">信用卡号</option>

                                            <option value="isMobile"  title="">手机号码</option>

                                            <option value="isPhone"  title="">电话号码</option>

                                            <option value="isTel"  title="">手机/电话</option>

                                            <option value="isQq"  title="">QQ号码</option>

                                            <option value="isIdCardNo"  title="">身份证号码</option>

                                            <option value="number"  title="">数字</option>

                                            <option value="digits"  title="">整数</option>

                                            <option value="isIntGtZero"  title="">整数(大于0)</option>

                                            <option value="isIntGteZero"  title="">整数(大于等于0)</option>

                                            <option value="isIntLtZero"  title="">整数(小于0)</option>

                                            <option value="isIntLteZero"  title="">整数(小于等于0)</option>

                                            <option value="isFloatGtZero"  title="">浮点数(大于0)</option>

                                            <option value="isFloatGteZero"  title="">浮点数(大于等于0)</option>

                                            <option value="isFloatLtZero"  title="">浮点数(小于0)</option>

                                            <option value="isFloatLteZero"  title="">浮点数(小于等于0)</option>

                                            <option value="isZipCode"  title="">邮政编码</option>

                                            <option value="isPwd"  title="以字母开头，长度在6-12之间，只能包含字符、数字和下划线">密码</option>

                                            <option value="stringCheck"  title="只能包含中文、英文、数字、下划线等字符">中文/英文/数字/下划线</option>

                                            <option value="isEnglish"  title="">英语</option>

                                            <option value="isChinese"  title="">汉子</option>

                                            <option value="isChineseChar"  title="匹配中文(包括汉字和字符)">汉英字符</option>

                                            <option value="isRightfulString"  title="判断是否为合法字符(a-zA-Z0-9-_)">合法字符</option>

                                        </select>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[6].minLength" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[6].maxLength" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[6].minValue" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                    <td>
                                        <input type="text" name="columnList[6].maxValue" value="" maxlength="200" class="form-control  "/>
                                    </td>
                                </tr>


                            </c:if>
                                <c:forEach items="${genTable.columnList}" var="column"  varStatus="idx">

                                    <tr>
                                        <td>
                                            <input type="text" class="form-control" readonly="readonly" name="page-columnList[${idx.index}].name" value="${column.name}"/>
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" name="page-columnList[${idx.index}].comments" value="${column.comments}" maxlength="200" readonly="readonly" />
                                        </td>
                                        <td>
                                            <input type="checkbox" class="i-checks" name="columnList[${idx.index}].isNull" value="${column.isNull}" />
                                        </td>
                                        <td>
                                            <select name="columnList[${idx.index}].validateType" class="form-control m-b">

                                                <option value="" selected title=""></option>

                                                <option value="string"  title="">字符串</option>

                                                <option value="email"  title="">电子邮件</option>

                                                <option value="url"  title="">网址</option>

                                                <option value="date"  title="">日期</option>

                                                <option value="dateISO"  title="">日期(ISO)</option>

                                                <option value="creditcard"  title="">信用卡号</option>

                                                <option value="isMobile"  title="">手机号码</option>

                                                <option value="isPhone"  title="">电话号码</option>

                                                <option value="isTel"  title="">手机/电话</option>

                                                <option value="isQq"  title="">QQ号码</option>

                                                <option value="isIdCardNo"  title="">身份证号码</option>

                                                <option value="number"  title="">数字</option>

                                                <option value="digits"  title="">整数</option>

                                                <option value="isIntGtZero"  title="">整数(大于0)</option>

                                                <option value="isIntGteZero"  title="">整数(大于等于0)</option>

                                                <option value="isIntLtZero"  title="">整数(小于0)</option>

                                                <option value="isIntLteZero"  title="">整数(小于等于0)</option>

                                                <option value="isFloatGtZero"  title="">浮点数(大于0)</option>

                                                <option value="isFloatGteZero"  title="">浮点数(大于等于0)</option>

                                                <option value="isFloatLtZero"  title="">浮点数(小于0)</option>

                                                <option value="isFloatLteZero"  title="">浮点数(小于等于0)</option>

                                                <option value="isZipCode"  title="">邮政编码</option>

                                                <option value="isPwd"  title="以字母开头，长度在6-12之间，只能包含字符、数字和下划线">密码</option>

                                                <option value="stringCheck"  title="只能包含中文、英文、数字、下划线等字符">中文/英文/数字/下划线</option>

                                                <option value="isEnglish"  title="">英语</option>

                                                <option value="isChinese"  title="">汉子</option>

                                                <option value="isChineseChar"  title="匹配中文(包括汉字和字符)">汉英字符</option>

                                                <option value="isRightfulString"  title="判断是否为合法字符(a-zA-Z0-9-_)">合法字符</option>

                                            </select>
                                        </td>
                                        <td>
                                            <input type="text" name="columnList[${idx.index}].minLength" value="${column.minLength}" maxlength="200" class="form-control  "/>
                                        </td>
                                        <td>
                                            <input type="text" name="columnList[${idx.index}].maxLength" value="${column.maxLength}" maxlength="200" class="form-control  "/>
                                        </td>
                                        <td>
                                            <input type="text" name="columnList[${idx.index}].minValue" value="${column.minValue}" maxlength="200" class="form-control  "/>
                                        </td>
                                        <td>
                                            <input type="text" name="columnList[${idx.index}].maxValue" value="${column.maxValue}" maxlength="200" class="form-control  "/>
                                        </td>
                                    </tr>

                                </c:forEach>


                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>

    </form>
</div>

</body>
</html>