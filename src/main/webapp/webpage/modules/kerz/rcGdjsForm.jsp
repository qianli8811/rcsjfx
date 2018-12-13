<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>股东家属管理</title>
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
			var isDbr =   $("input[name='isDbr']:checked").val();
			if(!isDbr){
				$("input[name='isDbr']").each(function () {
					if($(this).val()==0){
						$("input[name='isDbr'][value='0']").attr("checked",false);
						$("input[name='isDbr'][value='0']").parent().removeClass("checked");

						$("input[name='isDbr'][value='1']").attr("checked",true);
						$("input[name='isDbr'][value='1']").parent().addClass("checked");
					}else {
						$("input[name='isDbr'][value='0']").attr("checked",true);
						$("input[name='isDbr'][value='0']").parent().addClass("checked");
						$("input[name='isDbr'][value='1']").attr("checked",false);
						$("input[name='isDbr'][value='1']").parent().removeClass("checked");
					};
				});
			}
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

			$("#sfzh").blur(function(){
				var sfzh = $("#sfzh").val();
				var res = CertificateNoParse(sfzh);
				//年龄
				var nl = res.age;
				$("#nl").val(nl);
				//获取性别
				var xb = res.sex;
				if(xb == '男'){
					//$("input:radio[name=xb][value='1']").attr("checked",true);

					$("input[name='xb'][value='2']").attr("checked",false);
					$("input[name='xb'][value='2']").parent().removeClass("checked");

					$("input[name='xb'][value='1']").attr("checked",true);
					$("input[name='xb'][value='1']").parent().addClass("checked");
				}
				if(xb == '女'){
					//$("input:radio[name=xb][value='2']").attr("checked",true);
					$("input[name='xb'][value='1']").attr("checked",false);
					$("input[name='xb'][value='1']").parent().removeClass("checked");

					$("input[name='xb'][value='2']").attr("checked",true);
					$("input[name='xb'][value='2']").parent().addClass("checked");
				}


			});

			$("#peiousfzh").blur(function(){
				var peiousfzh = $("#peiousfzh").val();
				var res1 = CertificateNoParse(peiousfzh);
				//年龄
				var peiounl = res1.age;
				$("#peiounl").val(peiounl);
				//获取性别
				var xb = res1.sex;
				if(xb == '男'){
					//$("input:radio[name=xb][value='1']").attr("checked",true);

					$("input[name='peiouxb'][value='2']").attr("checked",false);
					$("input[name='peiouxb'][value='2']").parent().removeClass("checked");

					$("input[name='peiouxb'][value='1']").attr("checked",true);
					$("input[name='peiouxb'][value='1']").parent().addClass("checked");
				}
				if(xb == '女'){
					//$("input:radio[name=xb][value='2']").attr("checked",true);
					$("input[name='peiouxb'][value='1']").attr("checked",false);
					$("input[name='peiouxb'][value='1']").parent().removeClass("checked");

					$("input[name='peiouxb'][value='2']").attr("checked",true);
					$("input[name='peiouxb'][value='2']").parent().addClass("checked");
				}


			});
		});
		function CertificateNoParse(certificateNo){
			var pat = /^\d{6}(((19|20)\d{2}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])\d{3}([0-9]|x|X))|(\d{2}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])\d{3}))$/;
			if(!pat.test(certificateNo))
				return null;

			var parseInner = function(certificateNo, idxSexStart, birthYearSpan){
				var res = {};
				var idxSex = 1 - certificateNo.substr(idxSexStart, 1) % 2;
				res.sex = idxSex == '1' ? '女' : '男';

				var year = (birthYearSpan == 2 ? '19' : '') +
					certificateNo.substr(6, birthYearSpan);
				var month = certificateNo.substr(6 + birthYearSpan, 2);
				var day = certificateNo.substr(8 + birthYearSpan, 2);
				res.birthday = year + '-' + month + '-' + day;

				var d = new Date(); //当然，在正式项目中，这里应该获取服务器的当前时间
				var monthFloor = ((d.getMonth()+1) < parseInt(month,10) || (d.getMonth()+1) == parseInt(month,10) && d.getDate() < parseInt(day,10)) ? 1 : 0;
				res.age = d.getFullYear() - parseInt(year,10) - monthFloor;
				return res;
			};

			return parseInner(certificateNo, certificateNo.length == 15 ? 14 : 16, certificateNo.length == 15 ? 2 : 4);
		};
	</script>
</head>
<body class="hideScroll">
		<form:form id="inputForm" modelAttribute="rcGdjs" action="${ctx}/kerz/rcGdxx/saveRcGdjs" method="post" class="form-horizontal">
		<form:hidden path="id"/>
			<form:hidden path="rcGdxx.id"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>关系：</label></td>
					<td class="width-35">
						<form:select path="jsgx" class="form-control required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('jtcy_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>姓名：</label></td>
					<td class="width-35">
						<form:input path="jsxm" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>身份证号：</label></td>
					<td class="width-35">
						<form:input path="sfzh" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right">性别：</label></td>
					<td class="width-35">
						<form:radiobuttons path="xb" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks required"/>

					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">年龄：</label></td>
					<td class="width-35">
						<form:input path="nl" htmlEscape="false"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>职业：</label></td>
					<td class="width-35">
						<form:input path="job" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>电话：</label></td>
					<td class="width-35">
						<form:input path="telephone" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right">是否已婚：</label></td>
					<td class="width-35">
						<form:radiobuttons path="isMarry" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>配偶姓名：</label></td>
					<td class="width-35">
						<form:input path="peiouxm" htmlEscape="false"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">是否担保：</label></td>
					<td class="width-35">
						<form:radiobuttons path="isDbr" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks "/>

					</td>

				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">配偶身份证号：</label></td>
					<td class="width-35">
						<form:input path="peiousfzh" htmlEscape="false"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">配偶是否担保：</label></td>
					<td class="width-35">
						<form:radiobuttons path="peiouisdbr" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">性别：</label></td>
					<td class="width-35">
						<form:radiobuttons path="peiouxb" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks "/>

					</td>
					<td class="width-15 active"><label class="pull-right">年龄：</label></td>
					<td class="width-35">
						<form:input path="peiounl" htmlEscape="false"    class="form-control "/>
					</td>
		  		</tr>

				<tr>
					<td class="width-15 active"><label class="pull-right">配偶学历：</label></td>
					<td class="width-35">
						<form:input path="peiouxl" htmlEscape="false"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">配偶职业：</label></td>
					<td class="width-35">
						<form:input path="peioujob" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">配偶电话：</label></td>
					<td class="width-35">
						<form:input path="peioudh" htmlEscape="false"    class="form-control "/>

					</td>
					<td class="width-15 active"><label class="pull-right">备注：</label></td>
					<td class="width-35">

						<form:input path="remarks" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>


		 	</tbody>
		</table>
	</form:form>
</body>
</html>