<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>客户管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  if(validateForm.form()){
			  $("#inputForm").submit();
			  return true;
		  }
	
		  return false;
		}
		$(document).ready(function() {
			validateForm = $("#inputForm").validate({
                rules:{
                    flmzb:{
                        required:true,//不能为空
                        number: true,
                    }
                },
                messages: {
                    flmzb: {
                        required: "请输入整数",
                        number: "请正确输入数字"
                    }
                },

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


		// function resetColumnNo() {
		// 	$("#tab-4 #contentTable4 tbody tr").each(function (b, c) {
		// 		$(this).find("span[name*=rcGdList],select[name*=rcGdList],input[name*=rcGdList]").each(function () {
		// 			var a = $(this).attr("name"), c = a.split(".")[1], c = "rcGdList[" + b + "]." + c;
		// 			console.info("1a:---"+a);
		// 			console.info("1b:---"+b);
		// 			console.info("1c:---"+c);
		// 			console.info("");
		// 			console.info($(this).attr("name", c));
		//
		// 			//0 <= a.indexOf(".sort") && ($(this).val(b), $(this).next().text(b))
		// 		});
		//
		// 	});
		//
		// };
		/*function addColumn() {

			var d = $("#template4").clone();
			d.removeAttr("style");
			d.removeAttr("id");

			$("#tab-4 #contentTable4 tbody").append(d);

			d.find("input:checkbox").iCheck({
				checkboxClass: "icheckbox_square-green",
				radioClass: "iradio_square-blue",
				increaseArea: "20%"
			});
			resetColumnNo();
			$("#contentTable1").tableDnD({
				onDragClass: "myDragClass", onDrop: function (a, b) {
					toIndex = $(b).index();
					var d = $("#tab-4 #contentTable4 tbody tr:eq(" + fromIndex + ")");
					fromIndex < toIndex ? d.insertAfter(c) : d.insertBefore(c);
					resetColumnNo()
				}, onDragStart: function (a, b) {
					fromIndex = $(b).index()
				}
			});
			return !1
		};
		function delColumn() {
			$("input[name='ck']:checked").closest("tr").each(function () {
				var b = $(this).find("input[name*=name]").attr("name");
				$(this).remove();

				$("#tab-4 #contentTable4 tbody tr input[name='rcGdList" + b + "']").closest("tr").remove()
			});
			resetColumnNo();
			return !1
		};*/
	</script>
</head>
<body class="hideScroll">
<%--

<table style="display:none">

	<tr id="template4" style="display:none">
		&lt;%&ndash;<td>
			<input type="hidden" class="form-control" name="rcGdList[0].id" value="" />
			<input type="checkbox" class="form-control" name="rcGdList[0].id" value="" />
		</td>&ndash;%&gt;
		<td>
			<input type="checkbox" class="form-control  " name="ck" value="1"/>
		</td>
		<td>
			<input type="text" class="form-control" name="rcGdList[0].gdxm" value=""/>
		</td>
		<td>
			<input type="text" class="form-control" name="rcGdList[0].sfzh" value=""/>
		</td>
		<td>
			<input type="text" class="form-control" name="rcGdList[0].xb" value=""/>
		</td>
		<td>
			<input type="text" class="form-control" name="rcGdList[0].nl" value=""/>
		</td>
		<td>
			<input type="text" class="form-control" name="rcGdList[0].zgb" value=""/>
		</td>


		<td>
			<select name="rcGdList[0].khlx" class="form-control m-b">
				<option value="" title=""></option>
				<option value="1" title=""> 股东</option>
				<option value="2" title="">实际控股人</option>
				<option value="3" title="">担保人</option>
			</select>

		</td>
		<td>
			<select name="rcGdList[0].isDbr" class="form-control m-b">
				<option value="" title=""></option>
				<option value="1" title=""> 是</option>
				<option value="0" title="">否</option>
			</select>
		</td>
		<td>
			<select name="rcGdList[0].jtcy" class="form-control m-b">
				<option value="" title=""></option>
				<option value="0" title="">配偶</option>
				<option value="1" title="">女儿</option>
				<option value="2" title="">儿子</option>
			</select>
		</td>
	</tr>
</table>
--%>


		<form:form id="inputForm" modelAttribute="rcKhzl" action="${ctx}/kerz/rcKhzl/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>


		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>客户简码：</label></td>
					<td class="width-35">
						<form:input path="khjm" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>客户名称：</label></td>
					<td class="width-35">
						<form:input path="khmc" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>福临门油销售占比(百分比)：</label></td>
					<td class="width-35">
						<form:input path="flmzb" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>资金周转次数：</label></td>
					<td class="width-35" >
						<form:input path="zjzzcs" htmlEscape="false"    class="form-control required"/>
					</td>


				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>可负债比例(百分比)：</label></td>
					<td class="width-35">
						<form:input path="kfzbl" htmlEscape="false"    class="form-control required"/>
					</td>
					<%--<td class="width-15 active"><label class="pull-right"><font color="red">*</font>资金周转次数：</label></td>
					<td class="width-35" >
						<form:input path="zjzzcs" htmlEscape="false"    class="form-control required"/>
					</td>--%>


				</tr>




				<tr><td class="width-15 active"><label class="pull-right"><font color="red">*</font>国家：</label></td>
					<td class="width-35">
							<%--<form:input path="guojia" htmlEscape="false"    class="form-control required"/>--%>
						<input name="guojia" value="中国" class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>省份/州/自治区/直辖市：</label></td>
					<td class="width-35">
						<form:input path="sf" htmlEscape="false"    class="form-control required"/>
					</td>

				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>城市：</label></td>
					<td class="width-35">
						<form:input path="city" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>详细地址，xxx县(区)xxx镇(乡)xxx村xxx号：</label></td>
					<td class="width-35">
						<form:input path="khdz" htmlEscape="false"    class="form-control required"/>
					</td>

		  		</tr>
		 	</tbody>
		</table>
			<br/><br/>
			<%--<button class="btn btn-white btn-sm" onclick="return addColumn()"><i class="fa fa-plus"> 增加</i></button>
			<button class="btn btn-white btn-sm" onclick="return delColumn()"><i class="fa fa-minus"> 删除</i> </button>
			<br/><br/>

			<div class="tabs-container">
				<ul class="nav nav-tabs">

					<li class="active"><a data-toggle="tab" href="#tab-4" aria-expanded="false">股东信息</a>
					</li>


				</ul>
				<div class="tab-content">

					<div id="tab-4" class="tab-pane active" class="tab-pane">
						<div class="panel-body">
							<table id="contentTable4" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
								<thead>
								<tr>
									<th title="字段是否可为空值，不可为空字段自动进行空值验证">序号</th>
									<th title="字段是否可为空值，不可为空字段自动进行空值验证">姓名</th>
									<th title="校验类型">身份证号</th>
									<th title="最小长度">性别</th>
									<th title="最大长度">年龄</th>
									<th title="默认读取数据库字段备注">占股比</th>
									<th title="数据库字段名"  width="15%">股东类型</th>
									<th title="最小值">是否是担保人</th>
									<th title="最大值">股东家属信息</th>

								</tr>
								</thead>
								<tbody>
								<c:if test="${ not empty rcKhzl.rcGdList}">
									<c:forEach items="${rcKhzl.rcGdList}" var="column"  varStatus="idx">
										<tr>
												&lt;%&ndash;<td>
													<input type="hidden" class="form-control" name="rcGdList[${idx.index}].id" value="${idx.index}" />
													<input type="checkbox" class="form-control" name="rcGdList[${idx.index}].id" value="" />
												</td>&ndash;%&gt;
											<td>
												<input type="checkbox" class="i-checks " name="rcGdList[${idx.index}].ck" value="1" />
											</td>
											<td>
												<input type="hidden" class="form-control" name="rcGdList[${idx.index}].id" value="${column.id}" />
												<input type="text" class="form-control" name="rcGdList[${idx.index}].gdxm" value="${column.gdxm}" />
											</td>
											<td>
												<input type="text" class="form-control" name="rcGdList[${idx.index}].sfzh" value="${column.sfzh}" />
											</td>
											<td>
												<input type="text" class="form-control" name="rcGdList[${idx.index}].xb" value="${column.xb}" />
											</td>
											<td>
												<input type="text" class="form-control" name="rcGdList[${idx.index}].nl" value="${column.nl}" />
											</td>
											<td>
												<input type="text" class="form-control" name="rcGdList[${idx.index}].zgb" value="${column.zgb}"   />
											</td>
											<td>
												<select name="rcGdList[${idx.index}].khlx" class="form-control m-b">
													<option value=""   title=""> </option>
													<option value="1" ${column.khlx == '1' ?"selected":""}  title=""> 股东</option>

													<option value="2" ${column.khlx == '2' ?"selected":""} title="">实际控股人</option>

													<option value="3" ${column.khlx == '3' ?"selected":""} title="">担保人</option>
												</select>

											</td>
											<td>
												<select name="rcGdList[${idx.index}].isDbr" class="form-control m-b">
													<option value=""  title=""> </option>
													<option value="1" ${column.isDbr =='1' ?"selected":""}  title=""> 是</option>
													<option value="0" ${column.isDbr =='2' ?"selected":""} title="">否</option>
												</select>
											</td>
											<td>
												<select name="rcGdList[${idx.index}].jtcy" class="form-control m-b">
													<option value=""  title=""> </option>
													<option value="0" ${column.isDbr =='0' ?"selected":""}  title="">配偶</option>
													<option value="1" ${column.isDbr =='1' ?"selected":""} title="">女儿</option>
													<option value="2" ${column.isDbr =='2' ?"selected":""} title="">儿子</option>
												</select>
											</td>



										</tr>

									</c:forEach>
								</c:if>


								</tbody>
							</table>
						</div>
					</div>
				</div>

			</div>--%>
	</form:form>
</body>
</html>