<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>企业核心数据管理</title>
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
			
					laydate({
			            elem: '#fapiaoshiqi', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });
		});
	</script>
</head>
<body class="hideScroll">
		<form:form id="inputForm" modelAttribute="cCustSale" action="${ctx}/xssj/cCustSale/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>工厂：</label></td>
					<td class="width-35">
						<form:input path="gongchang" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>大区：</label></td>
					<td class="width-35">
						<form:input path="daqu" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>城市群：</label></td>
					<td class="width-35">
						<form:input path="chengshi" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>业务员：</label></td>
					<td class="width-35">
						<form:input path="yewuyuan" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>客户代码：</label></td>
					<td class="width-35">
						<form:input path="custNo" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>客户名称：</label></td>
					<td class="width-35">
						<form:input path="custName" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>大品类描述：</label></td>
					<td class="width-35">
						<form:input path="dapinleimiaoshu" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>一级品类描述：</label></td>
					<td class="width-35">
						<form:input path="yijipinleimiaoshu" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>二级品类描述：</label></td>
					<td class="width-35">
						<form:input path="erjipinleimiaoshu" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>三级品类描述：</label></td>
					<td class="width-35">
						<form:input path="sanjipinleimiaoshu" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>产品线描述：</label></td>
					<td class="width-35">
						<form:input path="chanpinxianmiaoshu" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>物料编码：</label></td>
					<td class="width-35">
						<form:input path="wuliaobianma" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>物料描述：</label></td>
					<td class="width-35">
						<form:input path="wuliaomiaoshu" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>箱：</label></td>
					<td class="width-35">
						<form:input path="xiang" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>吨：</label></td>
					<td class="width-35">
						<form:input path="dun" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>销售收入：</label></td>
					<td class="width-35">
						<form:input path="xiaoshoushouru" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>净值：</label></td>
					<td class="width-35">
						<form:input path="jingzhi" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>税额：</label></td>
					<td class="width-35">
						<form:input path="shuie" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>战略价金额：</label></td>
					<td class="width-35">
						<form:input path="zhanlvjine" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>折扣金额：</label></td>
					<td class="width-35">
						<form:input path="zhekoujine" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>折扣百分比：</label></td>
					<td class="width-35">
						<form:input path="zhekoubili" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>售达方简称：</label></td>
					<td class="width-35">
						<form:input path="shoudafangjiancheng" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>出具发票日期：</label></td>
					<td class="width-35">
						<input id="fapiaoshiqi" name="fapiaoshiqi" type="text" maxlength="20" class="laydate-icon form-control layer-date required"
							value="<fmt:formatDate value="${cCustSale.fapiaoshiqi}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>订单号码：</label></td>
					<td class="width-35">
						<form:input path="dingdanbianhao" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>单据日期：</label></td>
					<td class="width-35">
						<input id="danjuriqi" name="fapiaoshiqi" type="text" maxlength="20" class="laydate-icon form-control layer-date required"
						       value="<fmt:formatDate value="${cCustSale.danjuriqi}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>库存地点：</label></td>
					<td class="width-35">
						<form:input path="kucundidian" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>采购订单号码：</label></td>
					<td class="width-35">
						<form:input path="caigoubianhao" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"></td>
		   			<td class="width-35" ></td>
		  		</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>