<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
    <title>表单管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#contentTable thead tr th input.i-checks').on('ifChecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定
                $('#contentTable tbody tr td input.i-checks').iCheck('check');
            });

            $('#contentTable thead tr th input.i-checks').on('ifUnchecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定
                $('#contentTable tbody tr td input.i-checks').iCheck('uncheck');
            });

        });

        function genCode(){

            // var url = $(this).attr('data-url');
            var size = $("#contentTable tbody tr td input.i-checks:checked").size();
            if(size == 0 ){
                top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
                return;
            }

            if(size > 1 ){
                top.layer.alert('只能选择一条数据!', {icon: 0, title:'警告'});
                return;
            }
            var id =  $("#contentTable tbody tr td input.i-checks:checkbox:checked").attr("id");
            var tableType =  $("#contentTable tbody tr td input.i-checks:checkbox:checked").closest("td").next().text();
            if(tableType.indexOf("附表")>=0){

                top.layer.alert('不能选择附表生成代码，请选择主表!', {icon: 0, title:'警告'});
                return;

            }
            var isSync = $("#contentTable tbody tr td input.i-checks:checkbox:checked").closest("td").next().next().next().next().next().next().text();
            if(isSync.indexOf("未同步")>=0){

                top.layer.alert('请先同步数据库!', {icon: 0, title:'警告'});
                return;

            }
            openDialog('生成代码','${ctx}/gen/genTable/genCodeForm?genTable.id='+id,'800px', '500px');
        }
        function createMenu(){

            // var url = $(this).attr('data-url');
            var size = $("#contentTable tbody tr td input.i-checks:checked").size();
            if(size == 0 ){
                top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
                return;
            }

            if(size > 1 ){
                top.layer.alert('只能选择一条数据!', {icon: 0, title:'警告'});
                return;
            }
            var id =  $("#contentTable tbody tr td input.i-checks:checkbox:checked").attr("id");
            var tableType =  $("#contentTable tbody tr td input.i-checks:checkbox:checked").closest("td").next().text();
            if(tableType.indexOf("附表")>=0){

                top.layer.alert('不能选择附表创建菜单，请选择主表!', {icon: 0, title:'警告'});
                return;

            }
            var isSync = $("#contentTable tbody tr td input.i-checks:checkbox:checked").closest("td").next().next().next().next().next().next().text();
            if(isSync.indexOf("未同步")>=0){

                top.layer.alert('请先同步数据库!', {icon: 0, title:'警告'});
                return;

            }
            openDialog('创建菜单','${ctx}/gen/genScheme/menuForm?gen_table_id='+id,'800px', '500px');
        }
        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
    </script>

</head>
<body id="" class="gray-bg"  style="">

<div class="wrapper wrapper-content">
    <div class="ibox">
        <div class="ibox-title">
            <h5>表单列表  </h5>
            <div class="ibox-tools">
                <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                </a>
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-wrench"></i>
                </a>
                <ul class="dropdown-menu dropdown-user">
                    <li><a href="#">选项1</a>
                    </li>
                    <li><a href="#">选项2</a>
                    </li>
                </ul>
                <a class="close-link">
                    <i class="fa fa-times"></i>
                </a>
            </div>
        </div>

        <div class="ibox-content">
            <!-- 0:隐藏tip, 1隐藏box,不设置显示全部 -->
            <script type="text/javascript">top.$.jBox.closeTip();</script>
            <!--查询条件-->
            <div class="row">
                <div class="col-sm-12">
                    <form id="searchForm" class="form-inline" action="${ctx}/gen/genTable/" method="post">
                        <input id="pageNo" name="pageNo" type="hidden" value="1"/>
                        <input id="pageSize" name="pageSize" type="hidden" value="10"/>
                        <input id="orderBy" name="orderBy" type="hidden" value=""/>
                        <script type="text/javascript">
                            $(document).ready(function() {
                                var orderBy = $("#orderBy").val().split(" ");
                                $(".sort-column").each(function(){
                                    $(this).html($(this).html()+" <i class=\"fa fa-sort\"></i>");
                                });
                                $(".sort-column").each(function(){
                                    if ($(this).hasClass(orderBy[0])){
                                        orderBy[1] = orderBy[1]&&orderBy[1].toUpperCase()=="DESC"?"down":"up";
                                        $(this).find("i").remove();
                                        $(this).html($(this).html()+" <i class=\"fa fa-sort-"+orderBy[1]+"\"></i>");
                                    }
                                });
                                $(".sort-column").click(function(){
                                    var order = $(this).attr("class").split(" ");
                                    var sort = $("#orderBy").val().split(" ");
                                    for(var i=0; i<order.length; i++){
                                        if (order[i] == "sort-column"){order = order[i+1]; break;}
                                    }
                                    if (order == sort[0]){
                                        sort = (sort[1]&&sort[1].toUpperCase()=="DESC"?"ASC":"DESC");
                                        $("#orderBy").val(order+" DESC"!=order+" "+sort?"":order+" "+sort);
                                    }else{
                                        $("#orderBy").val(order+" ASC");
                                    }
                                    page();
                                });
                            });
                        </script>
                        <div class="form-group">
                            <span>表名：</span><input id="nameLike" name="nameLike" class=" form-control input-sm" type="text" value="" maxlength="50"/>
                            <span>说明：</span><input id="comments" name="comments" class=" form-control input-sm" type="text" value="" maxlength="50"/>
                            <span>父表表名：</span><input id="parentTable" name="parentTable" class=" form-control input-sm" type="text" value="" maxlength="50"/>
                        </div>
                    </form>
                    <br/>
                </div>
            </div>
            <div class="ibox-content">
                <sys:message content="${message}"/>
            <!-- 工具栏 -->
            <div class="row">
                <div class="col-sm-12">
                    <div class="pull-left">
                        <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="add()" title="添加"><i class="fa fa-plus"></i> 添加</button>
                        <script type="text/javascript">
                            function add(){
                                openDialog("新增"+'表单',"${ctx}/gen/genTable/form","85%", "85%","");
                            }
                        </script><!-- 增加按钮 -->

                        <button  class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" title="导入" onclick="openDialog('导入表单','${ctx}/gen/genTable/importTableFromDB','700px', '300px')"><i class="fa fa-folder-open-o"></i> 数据库导入表单</button>

                        <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="edit()" title="修改"><i class="fa fa-file-text-o"></i> 修改</button>
                        </button>

                        <script type="text/javascript">
                            $(document).ready(function() {
                                $('#contentTable thead tr th input.i-checks').on('ifChecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定
                                    $('#contentTable tbody tr td input.i-checks').iCheck('check');
                                });

                                $('#contentTable thead tr th input.i-checks').on('ifUnchecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定
                                    $('#contentTable tbody tr td input.i-checks').iCheck('uncheck');
                                });

                            });

                            function edit(){

                                var size = $("#contentTable tbody tr td input.i-checks:checked").size();
                                if(size == 0 ){
                                    top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
                                    return;
                                }

                                if(size > 1 ){
                                    top.layer.alert('只能选择一条数据!', {icon: 0, title:'警告'});
                                    return;
                                }
                                var id =  $("#contentTable tbody tr td input.i-checks:checkbox:checked").attr("id");
                                openDialog("修改"+'表单',"${ctx}/gen/genTable/form?id="+id,"85%", "85%","");
                            }
                        </script><!-- 编辑按钮 -->


                        <button  class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" title="生成代码" onclick="genCode()"><i class="fa fa-folder-open-o"></i> 生成代码</button>



                        <button  class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" title="创建菜单" onclick="createMenu()"><i class="fa fa-folder-open-o"></i> 创建菜单</button>


                        <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>

                    </div>
                    <div class="pull-right">
                        <button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
                        <button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
                    </div>
                </div>
            </div>

            <table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
                <thead>
                <tr>
                    <th> <input type="checkbox" class="i-checks"></th>
                    <th class="sort-column table_type">表类型</th>
                    <th class="sort-column name">表名</th>
                    <th>说明</th>
                    <th class="sort-column class_name">类名</th>
                    <th class="sort-column parent_table">主表</th>
                    <th class="sort-column isSync">同步数据库</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${page.list}" var="genTable">
                    <tr>
                        <td> <input type="checkbox" id="${genTable.id}" class="i-checks"></td>
                        <td>

                                <c:if test="${genTable.tableType == 0}">
                                    单表
                                </c:if>
                                <c:if test="${genTable.tableType == 1}">
                                    主表
                                </c:if>
                                <c:if test="${genTable.tableType == 2}">
                                    附表
                                </c:if>

                                <c:if test="${genTable.tableType == 3}">
                                    树结构表
                                </c:if>
                        </td>
                        <td>
                                ${genTable.name}
                        </td>
                        <td>
                                ${genTable.comments}
                        </td>
                        <td>
                                ${genTable.className}
                        </td>
                        <td>
                                ${genTable.parentTable}
                        </td>

                        <td>
                                ${genTable.isSync}
                        </td>
                        <td>
                            <shiro:hasPermission name="gen:genTable:view">
                                <a href="#" onclick="openDialogView('查看商品', '${ctx}/gen/genTable/form?id=${genTable.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
                            </shiro:hasPermission>
                            <shiro:hasPermission name="gen:genTable:edit">
                                <a href="#" onclick="openDialog('修改商品', '${ctx}/gen/genTable/form?id=${genTable.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
                            </shiro:hasPermission>
                            <shiro:hasPermission name="gen:genTable:del">
                                <a href="${ctx}/gen/genTable/delete?id=${genTable.id}" onclick="return confirmx('确认要删除该商品吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
                            </shiro:hasPermission>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <!-- 分页代码 -->
            <table:page page="${page}"></table:page>


            <br/>
            <br/>
        </div>
    </div>

</div>


<script type="text/javascript">//<!-- 无框架时，左上角显示菜单图标按钮。
if(!(self.frameElement && self.frameElement.tagName=="IFRAME")){
    $("body").prepend("<i id=\"btnMenu\" class=\"icon-th-list\" style=\"cursor:pointer;float:right;margin:10px;\"></i><div id=\"menuContent\"></div>");
    $("#btnMenu").click(function(){

        top.layer.open({
            type: 2,
            area:['300px','350px'],
            content: 'get:${ctx}/sys/menu/treeselect;JSESSIONID=221afeec7dbd400bb0e02c1e2a5c5d1d' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
        });
        //top.$.jBox('get:${ctx}/sys/menu/treeselect;JSESSIONID=221afeec7dbd400bb0e02c1e2a5c5d1d', {title:'选择菜单', buttons:{'关闭':true}, width:300, height: 350, top:10});
        //if ($("#menuContent").html()==""){$.get("${ctx}/sys/menu/treeselect", function(data){$("#menuContent").html(data);});}else{$("#menuContent").toggle(100);}
    });
}//-->
</script>
</body>
</html>
