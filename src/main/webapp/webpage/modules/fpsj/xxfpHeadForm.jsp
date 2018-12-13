<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>发票数据管理</title>
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
<body class="hideScroll">
		<form:form id="inputForm" modelAttribute="xxfpHead" action="${ctx}/fpsj/xxfpHead/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>金税发票号码：</label></td>
					<td class="width-35">
						<form:input path="fphm" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>开票日期：</label></td>
					<td class="width-35">


						<input id="kprq" name="kprq" type="text" maxlength="20" class=" form-control layer-date input-sm"
						       value="<fmt:formatDate value="${xxfpHead.kprq}" pattern="yyyy-MM-dd"/>"/>
					</td>
				</tr>

				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>客户税号：</label></td>
					<td class="width-35">
						<form:input path="khsh" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>客户名称：</label></td>
					<td class="width-35">
						<form:input path="khmc" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>客户地址：</label></td>
					<td class="width-35">
						<form:input path="khdz" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>客户银行账号：</label></td>
					<td class="width-35">
						<form:input path="khkhyhzh" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>开票人：</label></td>
					<td class="width-35">
						<form:input path="kpr" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>收款人：</label></td>
					<td class="width-35">
						<form:input path="skr" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>复核人：</label></td>
					<td class="width-35">
						<form:input path="fhr" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>作废标志：</label></td>
					<td class="width-35">
						<form:input path="zfbz" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>开票类型：</label></td>
					<td class="width-35">
						<form:input path="kplx" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>合计不含税金额：</label></td>
					<td class="width-35">
						<form:input path="zbhsje" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>合计税额：</label></td>
					<td class="width-35">
						<form:input path="zse" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>合计价税合计：</label></td>
					<td class="width-35">
						<form:input path="jshj" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>分机号：</label></td>
					<td class="width-35">
						<form:input path="skjbh" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>开票方税号：</label></td>
					<td class="width-35">
						<form:input path="qysh" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>开票方银行账号：</label></td>
					<td class="width-35">
						<form:input path="qykhyhzh" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>发票备注：</label></td>
					<td class="width-35">
						<form:input path="bz" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>

		  		</tr>
		 	</tbody>
		</table>
	</form:form>


		<div class="tabs-container">
			<ul class="nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true"> 销项项物品明细列表</a>
				</li>
			</ul>
			<div class="tab-content">
				<div id="tab-1" class="tab-pane active">
					<div class="panel-body">
						<table id="contentTable1" class="table table-striped table-bordered table-hover  dataTables-example dataTable">
							<thead>
							<tr>
								<th>明细行号</th>
								<th>商品名称</th>
								<th >规格型号</th>
								<th >单位</th>
								<th >数量</th>
								<th >不含税单价</th>
								<th >不含税金额</th>
								<th >含税金额</th>
								<th >税率</th>
								<th >税额</th>

							</tr>
							</thead>
							<tbody>

							<c:forEach items="${xxfpItemList}" var="xxfpItem"  varStatus="idx">
								<tr>
									<td>
											${xxfpItem.mxxh}
									</td>
									<td>
											${xxfpItem.cpmc}
									</td>
									<td>
											${xxfpItem.cpxh}
									</td>
									<td>
											${xxfpItem.cpdw}
									</td>
									<td>
											${xxfpItem.cpsl}
									</td>
									<td>
											${xxfpItem.cpdj}
									</td>
									<td>
											${xxfpItem.bhsje}
									</td>
									<td>
											${xxfpItem.sl}
									</td>
									<td>
											${xxfpItem.se}
									</td>
									<td>
											${xxfpItem.hsje}
									</td>

								</tr>
							</c:forEach>



							</tbody>
						</table>
					</div>
				</div>

			</div>

		</div>
</body>
</html>