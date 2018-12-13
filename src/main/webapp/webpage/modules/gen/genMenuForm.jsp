<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>

<!DOCTYPE html>
<html >
<head>
    <title>菜单管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        var validateForm;


        function doSubmit(table, index) {
            if (validateForm.form()) {


                $("#inputForm").submit();
                return true
            }
            return false
        }
        $(document).ready(function() {
            $("#name").focus();
            validateForm = $("#inputForm").validate({
                submitHandler: function(form) {
                    $.ajax({
                        url: "${ctx}/gen/genScheme/createMenu",
                        method: "POST",
                        data: $('#inputForm').serialize(),
                        error: function(data) {
                            $("#messageBox").text("操作失败!。");
                        },
                        success: function(data) {
                            if (data.success) {
                                $table.bootstrapTable('refresh');
                                $("#messageBox").text(data.msg);
                            } else {

                                $("#messageBox").text(data.msg);
                            }

                        }
                    })
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent())
                    } else {
                        error.insertAfter(element)
                    }
                }
            })
        });
    </script>

</head>
<body id="" class="bg-white"  style="">
<div class="ibox-content">
    <sys:message content="${message}"/>
<form id="inputForm" class="form-horizontal" action="${ctx}/gen/genScheme/createMenu" method="post">
    <input id="id" name="id" type="hidden" value="${menu.id}"/>

    <!-- 0:隐藏tip, 1隐藏box,不设置显示全部 -->

    <input type="hidden" name="gen_table_id" value="${gen_table_id}"/>
    <input type="hidden" name="genTableType" value="${genTable.tableType}">
    <table class="table table-bordered">
        <tbody>
        <tr>
            <td  class="width-15 active"><label class="pull-right">上级菜单:</label></td>
            <td class="width-35" >
                <input id="menuId" name="parent.id" class="form-control required form-control" type="hidden" value="1"/>
                <div class="input-group" style="width:100%">
                    <input id="menuName" name="parent.name" readonly="readonly"  type="text" value="功能菜单" data-msg-required=""
                           class="form-control required" style=""/>
                    <span class="input-group-btn">
	       		 <button type="button"  id="menuButton" class="btn   btn-primary  "><i class="fa fa-search"></i>
	             </button>

	             	 <button type="button" id="menuDelButton" class="close" data-dismiss="alert" style="position: absolute; top: 5px; right: 53px; z-index: 999; display: block;">×</button>

       		 </span>

                </div>
                <label id="menuName-error" class="error" for="menuName" style="display:none"></label>
                <script type="text/javascript">
                    $(document).ready(function(){
                        $("#menuButton, #menuName").click(function(){
                            // 是否限制选择，如果限制，设置为disabled
                            if ($("#menuButton").hasClass("disabled")){
                                return true;
                            }
                            // 正常打开
                            top.layer.open({
                                type: 2,
                                area: ['300px', '420px'],
                                title:"选择菜单",
                                ajaxData:{selectIds: $("#menuId").val()},
                                content: "${ctx}/tag/treeselect?url="+encodeURIComponent("/sys/menu/treeData")+"&module=&checked=&extId=&isAll=&allowSearch=" ,
                                btn: ['确定', '关闭']
                                ,yes: function(index, layero){ //或者使用btn1
                                    var tree = layero.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
                                    var ids = [], names = [], nodes = [];
                                    if ("" == "true"){
                                        nodes = tree.get_checked(true);
                                    }else{
                                        nodes = tree.get_selected(true);
                                    }
                                    for(var i=0; i<nodes.length; i++) {//
                                        ids.push(nodes[i].id);
                                        names.push(nodes[i].text);//
                                        break; // 如果为非复选框选择，则返回第一个选择
                                    }
                                    $("#menuId").val(ids.join(",").replace(/u_/ig,""));
                                    $("#menuName").val(names.join(","));
                                    $("#menuName").focus();
                                    top.layer.close(index);
                                },
                                cancel: function(index){ //或者使用btn2
                                    //按钮【按钮二】的回调
                                }
                            });

                        });

                        $("#menuDelButton").click(function(){
                            // 是否限制选择，如果限制，设置为disabled
                            if ($("#menuButton").hasClass("disabled")){
                                return true;
                            }
                            // 清除
                            $("#menuId").val("");
                            $("#menuName").val("");
                            $("#menuName").focus();

                        });
                    })
                </script></td>
        </tr>
        <tr>
            <td  class="width-15 active"><label class="pull-right"><font color="red">*</font> 名称:</label></td>
            <td  class="width-35" ><input id="name" name="name" class="required form-control " type="text" value="" maxlength="50"/></td>
        </tr>

        <tr>
            <td  class="width-15 active"><label class="pull-right">图标:</label></td>
            <td class="width-35" >

                <i id="iconIcon" class=" hide"></i>&nbsp;<span id="iconIconLabel">无</span>&nbsp;
                <input id="icon" name="icon" type="hidden" value=""/><a id="iconButton" href="javascript:" class="btn btn-primary">选择</a>&nbsp;&nbsp;
                <input id="iconclear" class="btn btn-default" type="button" value="清除" onclick="clear()"/>
                <script type="text/javascript">
                    $(document).ready(function(){
                        $("#iconButton").click(function(){

                            top.layer.open({
                                type: 2,
                                title:"选择图标",
                                area: ['700px',  $(top.document).height()-180+"px"],
                                content: '${ctx}/tag/iconselect?value="+$("#icon").val()',
                                btn: ['确定', '关闭'],
                                yes: function(index, layero){ //或者使用btn1
                                    var icon = layero.find("iframe")[0].contentWindow.$("#icon").val();
                                    $("#iconIcon").attr("class", icon);
                                    $("#iconIconLabel").text(icon);
                                    $("#icon").val(icon);
                                    top.layer.close(index);
                                },cancel: function(index){ //或者使用btn2

                                }
                            });
                        });
                        $("#iconclear").click(function(){
                            $("#iconIcon").attr("class", "icon- hide");
                            $("#iconIconLabel").text("无");
                            $("#icon").val("");

                        });
                    })
                </script></td>
        </tr>

        </tbody>
    </table>
</form>

</body>
</html>

