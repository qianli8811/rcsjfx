<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>

<html >
<head>
    <title>生成代码</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        var validateForm;
        function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
            if(validateForm.form()){
                loading('正在提交，请稍等...');
                $("#inputForm").submit();
                return true;
            }

            return false;
        }
        $(document).ready(function() {
            $("#name").focus();
            validateForm = $("#inputForm").validate({
                submitHandler: function(form){
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });

    </script>


</head>
<body id="" class="bg-white"  style="">

<form id="inputForm" class="form-horizontal" action="${ctx}/gen/genTable/genCode" method="post">
    <input id="id" name="id" value="${genScheme.id}" type="hidden" />
    <input type="hidden" name="genTable.id" value="${genScheme.genTable.id}"/>

    <!-- 0:隐藏tip, 1隐藏box,不设置显示全部 -->



    提示：代码生成会覆盖路径中已经存在的同名文件，请做好备份或选择空白目录生成代码。

    <br/>
    <br/>
    <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
        <tbody>
        <tr>
            <td  class="width-15 active"><label class="pull-right"><font color="red">*</font>生成路径:</label></td>
            <td colspan="3">
                <div class="row">
                    <div class="col-sm-10"><input type="text" id="projectPath" value="C:\j" name="projectPath" class="form-control required"></div>
                    <div class="col-sm-2"><a class="btn btn-default" href="#" onclick="selectFolder()">选择生成目录</a></div>
                </div>
            </td>
        </tr>
        <tr>
            <td  class="width-15 active"><label class="pull-right"><font color="red">*</font>代码风格:</label></td>
            <td>
                <select id="category" name="category" class="required form-control">


                    <c:if test="${genScheme.category == 'curd'}">
                        <option value="curd" selected="selected" >单表</option>
                        <option value="curd_many"  >主表</option>
                        <option value="treeTable">树结构表</option>
                        <option value="leftTreeRightTable" >左树(主表)右表</option>
                        <option value="leftTreeRightTable" >右表(附表)右表</option>
                    </c:if>
                    <c:if test="${genScheme.category == 'curd_many'}">
                        <option value="curd" >单表</option>
                        <option value="curd_many" selected="selected"   >主表</option>
                        <option value="curd_many"  >附表</option>
                        <option value="treeTable">树结构表</option>
                        <option value="leftTreeRightTable" >左树(主表)右表</option>
                        <option value="leftTreeRightTable" >右表(附表)右表</option>
                    </c:if>
                    <c:if test="${genScheme.category == 'curd_many'}">
                        <option value="curd"  >单表</option>
                        <option value="curd_many" selected="selected" >附表</option>
                        <option value="curd_many"  >主表</option>
                        <option value="treeTable">树结构表</option>
                        <option value="leftTreeRightTable" >左树(主表)右表</option>
                        <option value="leftTreeRightTable" >右表(附表)右表</option>
                    </c:if>
                    <c:if test="${genScheme.category == 'treeTable'}">
                        <option value="curd"  >单表</option>
                        <option value="curd_many"  >主表</option>
                        <option value="treeTable" selected="selected" >树结构表</option>
                        <option value="leftTreeRightTable" >左树(主表)右表</option>
                        <option value="leftTreeRightTable" >右表(附表)右表</option>
                    </c:if>
                    <c:if test="${genScheme.category == 'leftTreeRightTable'}">
                        <option value="curd" >单表</option>
                        <option value="curd_many"  >主表</option>
                        <option value="treeTable">树结构表</option>
                        <option value="leftTreeRightTable" selected="selected"  >左树(主表)右表</option>
                        <option value="leftTreeRightTable" >右表(附表)右表</option>
                    </c:if>
                    <c:if test="${genScheme.category == 'leftTreeRightTable'}">
                        <option value="curd" >单表</option>
                        <option value="curd_many"  >主表</option>
                        <option value="treeTable">树结构表</option>
                        <option value="leftTreeRightTable" >左树(主表)右表</option>
                        <option value="leftTreeRightTable" selected="selected"  >右表(附表)右表</option>
                    </c:if>

                </select>
            </td>
            <td  class="width-15 active"><label class="pull-right"><font color="red">*</font>表单风格:</label></td>
            <td>
                <span><input id="formStyle1" name="formStyle" class="required i-checks " type="radio" value="2"/>
                    <label for="formStyle1">dialog风格</label>
                </span>
                <span><input id="formStyle2" name="formStyle" class="required i-checks " type="radio" value="1" checked="checked"/><label for="formStyle2">form风格</label></span>
                <br/>
                <span class="help-inline">form风格在移动端体验更佳</span>
            </td>
        </tr>
        <tr>
            <td  class="width-15 active"><label class="pull-right"><font color="red">*</font>生成包路径:</label></td>
            <td>
                <input id="packageName" name="packageName" class="required form-control" type="text" value="${genScheme.packageName}" maxlength="500"/>
                <span class="help-inline">建议模块包：com.jeeplus.modules</span>
            </td>
            <td  class="width-15 active"><label class="pull-right"><font color="red">*</font>生成模块名:</label></td>
            <td>
                <input id="moduleName" name="moduleName" class="required form-control" type="text" value="${genScheme.moduleName}" maxlength="500"/>
                <span class="help-inline">可理解为子系统名，例如 sys</span>
            </td>
        </tr>
        <tr>
            <td  class="width-15 active"><label class="pull-right">生成子模块名:</label></td>
            <td>
                <input id="subModuleName" name="subModuleName" class="form-control" type="text" value="${genScheme.subModuleName}" maxlength="500"/>
                <span class="help-inline">可选，分层下的文件夹，例如 </span>
            </td>
            <td  class="width-15 active"><label class="pull-right"><font color="red">*</font>生成功能描述:</label></td>
            <td>
                <input id="functionName" name="functionName" class="required form-control" type="text" value="${genScheme.functionName}" maxlength="500"/>
                <span class="help-inline">将设置到类描述</span>
            </td>
        </tr>
        <tr>
            <td  class="width-15 active"><label class="pull-right"><font color="red">*</font>生成功能名:</label></td>
            <td>
                <input id="functionNameSimple" name="functionNameSimple" class="required form-control" type="text" value="${genScheme.functionNameSimple}" maxlength="500"/>
                <span class="help-inline">用作功能提示，如：保存“某某”成功</span>
            </td>
            <td  class="width-15 active"><label class="pull-right"><font color="red">*</font>生成功能作者:</label></td>
            <td>
                <input id="functionAuthor" name="functionAuthor" class="required form-control" type="text" value="${genScheme.functionAuthor}" maxlength="500"/>
                <span class="help-inline">功能开发者</span>
            </td>
        </tr>
        </tbody>
    </table>
</form>

</body>
</html>