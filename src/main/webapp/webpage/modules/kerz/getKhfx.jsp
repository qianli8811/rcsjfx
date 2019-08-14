<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html lang="en"
	class="app js no-touch no-android chrome no-firefox no-iemobile no-ie no-ie10 no-ie11 no-ios no-ios7 ipad">
<head>
	<title>客户分析</title>
	<meta name="decorator" content="default"/>
	<script  src="${ctxStatic}/echarts-master/echarts.min.js" ></script>
	<script type="text/javascript">
		$(document).ready(function() {
			var myDate = new Date();
			var year = myDate.getFullYear();    //获取完整的年份(4位,1970-????)


			var beginNianfen = $("#beginNianfen").val();
			for(var i=0;i<5;i++){
				var optionYear = year-i;
				$("#beginNianfen").append("<option value='"+optionYear+"'>"+optionYear+'年'+"</option>");
				$("#endNianfen").append("<option value='"+optionYear+"'>"+optionYear+'年'+"</option>");
			}
			var quYear = year-1;
			$("#beginNianfen").find("option[value = '"+quYear+"']").attr("selected","selected");
			$("#endNianfen").find("option[value = '"+year+"']").attr("selected","selected");



			var myChart1 = echarts.init(document.getElementById('syzjgcJson'));
			//生意资金构成
			/*var syzjgcJson = ${syzjgcJson};*/
			option1 = {
				title : {
					text: '生意资金构成',
					x:'center'
				},
				tooltip : {
					trigger: 'item',
					formatter: "{a} <br/>{b} : {c} ({d}%)"
				},
				legend: {
					orient: 'vertical',
					left: 'left',
					data: ['银行融资','民间借贷','保理融资','自有资金','其它']
				},
				series : [
					{
						name: '生意资金构成',
						type: 'pie',
						radius : '55%',
						center: ['50%', '60%'],
						data:${syzjgcJson},
						itemStyle: {
							emphasis: {
								shadowBlur: 10,
								shadowOffsetX: 0,
								shadowColor: 'rgba(0, 0, 0, 0.5)'
							}
						}
					}
				]
			};
			var myChart2 = echarts.init(document.getElementById('tshzjjgJson'));
			//重构后的生意资金构成
			/*var tshzjjgJson = ${tshzjjgJson};*/
			option2 = {
				title : {
					text: '生意资金构成',
					x:'center'
				},
				tooltip : {
					trigger: 'item',
					formatter: "{a} <br/>{b} : {c} ({d}%)"
				},
				legend: {
					orient: 'vertical',
					left: 'left',
					data:['银行融资','民间借贷','保理融资','自有资金','其它']
				},
				series : [
					{
						name: '生意资金构成',
						type: 'pie',
						radius : '55%',
						center: ['50%', '60%'],
						data:${tshzjjgJson},
						itemStyle: {
							emphasis: {
								shadowBlur: 10,
								shadowOffsetX: 0,
								shadowColor: 'rgba(0, 0, 0, 0.5)'
							}
						}
					}
				]
			};
			var myChart3 = echarts.init(document.getElementById('khxssjmxtb'));
			//重构后的生意资金构成


			option3 = {
				tooltip: {
					trigger: 'axis',
					axisPointer: {
						type: 'cross',
						crossStyle: {
							color: '#999'
						}
					}
				},
				toolbox: {
					feature: {
						dataView: {show: true, readOnly: false},
						magicType: {show: true, type: ['line', 'bar']},
						restore: {show: true},
						saveAsImage: {show: true}
					}
				},
				legend: {
					data:${strxssjhzNian}
				},
				xAxis: [
					{
						type: 'category',
						data: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
						axisPointer: {
							type: 'shadow'
						}
					}
				],
				yAxis: [
					{
						type: 'value',
						name: '',
						min: 0,
						max: 5000000,
						interval: 500000,
						axisLabel: {
							formatter: '{value} '
						}
					}
				],
				series:${khxssjmxtbJson}
			};

			myChart1.setOption(option1);
			myChart2.setOption(option2);
			myChart3.setOption(option3);


		});
	</script>
</head>
<body class="" style="">
<form:form id="searchForm" modelAttribute="rcKhzl" action="${ctx}/kerz/rcKhzl/getKhfx" method="post" class="form-inline">
	<div class="wrapper wrapper-content">

		<div class="row animated fadeInRight">
			<div class="col-sm-12">
				<div class="panel panel-success">
					<div class="panel-heading">
						<i class="fa fa-briefcase"></i> 查询
					</div>
					<div class="panel-body">
					<table class="table table-striped table-bordered table-hover"
					       width="100%" style="vertical-align: middle;">

						<tbody id="cxtbody">
						<tr style=" text-align: left;">
							<td width="100"><span>客户简码：</span>
								<form:input path="khjm" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/></td>
							<td width="100"><span>客户名称：</span>
								<form:input path="khmc" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/></td>
							<td width="375">	<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
								<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
							</td>
						</tr>
						</tbody>
					</table>
					</div>
					<div class="panel-heading">
						<i class="fa fa-briefcase"></i> 股东信息
					</div>
					<div class="panel-body">
						<table class="table table-striped table-bordered table-hover"
						       width="100%" style="vertical-align: middle;">

							<tbody id="zltbody">
							<tr style=" text-align: left;">
								<td width="100">客户简码：${rcKhzl1.khjm}</td>
								<td width="100">客户名称：${rcKhzl1.khmc}</td>
								<td width="375">地址：${rcKhzl1.guojia} ${rcKhzl1.sf}${rcKhzl1.city} ${rcKhzl1.khdz}</td>
							</tr>
							<tr><td width="205">福临门油销售占比(百分比)：${rcKhzl1.flmzb}</td>
								<td width="375">资金周转次数：${rcKhzl1.zjzzcs}</td>
								<td width="375">可负债比例(百分比)： ${rcKhzl1.kfzbl}</td>
							</tr>
							</tbody>
						</table>
					</div>
					<div class="panel-body" style=" white-space: nowrap; overflow: hidden; overflow-x: scroll; -webkit-backface-visibility: hidden; -webkit-overflow-scrolling: touch;">
							<table id="gdTable"
							       width="100%" rules="all"  class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable" style="vertical-align: middle;">
								<thead>
								<tr>
									<th  rowspan="2" >类型</th>
									<th  rowspan="2" >姓名</th>
									<th   rowspan="2" >身份证号</th>
									<th   rowspan="2" >性别</th>
									<th  rowspan="2" >年龄</th>
									<th  rowspan="2" >占股比</th>
									<th colspan="17" >家属信息</th>
								</tr>
								<tr>
									<th >关系</th>
									<th >姓名</th>
									<th >身份证号</th>
									<th >性别</th>
									<th >年龄</th>
									<th >职业</th>
									<th >电话</th>
									<th >是否已婚</th>
									<th >是否担保</th>

									<th >配偶姓名</th>
									<th >配偶身份证号</th>
									<th >配偶性别</th>
									<th >配偶年龄</th>
									<th >是否是股东</th>
									<th >配偶学历</th>
									<th >配偶职业</th>
									<th >配偶电话</th>
								</tr>
								</thead>
								<tbody>

								<c:forEach items="${gdMap}" var="gdMap" >
									<c:if test="${gdMap.key.khlx == '1'}" >
										<c:if test="${not empty gdMap.value}" >
											<c:set var="gdQsMapValue" value="${gdMap.value}"/>
										</c:if>

										<c:if test="${not empty gdQsMapValue.size()}">
											<tr>
											<td rowspan="${gdQsMapValue.size()+1}">
												<c:if test="${gdMap.key.khlx == '1'}">
													股东
												</c:if>
											</td>
											<td rowspan="${gdQsMapValue.size()+1}">  <c:out value="${gdMap.key.gdxm}" /></td>
											<td rowspan="${gdQsMapValue.size()+1}"> <c:out value="${gdMap.key.sfzh}" /> </td>
											<td rowspan="${gdQsMapValue.size()+1}">  <c:if test="${gdMap.key.xb == '1'}">
												男
											</c:if>
												<c:if test="${gdMap.key.xb == '2'}">
													女
												</c:if> </td>
											<td rowspan="${gdQsMapValue.size()+1}">  <c:out value="${gdMap.key.nl}" /> </td>
											<td rowspan="${gdQsMapValue.size()+1}"> <c:out value="${gdMap.key.zgb}" /> </td>
											</tr>
										</c:if>
										<c:if test="${empty gdQsMapValue.size() }">
											<tr>
												<td rowspan="1">
													<c:if test="${gdMap.key.khlx == '1'}">
														股东
													</c:if>
												</td>
												<td rowspan="1">  <c:out value="${gdMap.key.gdxm}" /></td>
												<td rowspan="1"> <c:out value="${gdMap.key.sfzh}" /> </td>
												<td rowspan="1">  <c:if test="${gdMap.key.xb == '1'}">
													男
												</c:if>
													<c:if test="${gdMap.key.xb == '2'}">
														女
													</c:if> </td>
												<td rowspan="1">  <c:out value="${gdMap.key.nl}" /> </td>
												<td rowspan="1"> <c:out value="${gdMap.key.zgb}" /> </td>

												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>

											</tr>
										</c:if>

											<c:if test="${ not empty gdMap.value}">

												<c:forEach items="${gdMap.value}" var="gdList">
												<tr>
													<td>
														<c:if test="${gdMap.key.jsgx == '0'}">
															本人
														</c:if>
														<c:if test="${gdMap.key.jsgx == '1'}">
															配偶
														</c:if>
														<c:if test="${gdMap.key.jsgx == '2'}">
															女儿
														</c:if>
														<c:if test="${gdMap.key.jsgx == '3'}">
															儿子
														</c:if>
														<c:if test="${gdMap.key.jsgx == '4'}">
															兄弟
														</c:if>
														<c:if test="${gdMap.key.jsgx == '5'}">
															姐妹
														</c:if>
														<c:if test="${gdMap.key.jsgx == '6'}">
															父母
														</c:if>
														<c:if test="${gdMap.key.jsgx == '7'}">
															朋友
														</c:if>
														<c:if test="${gdMap.key.jsgx == '8'}">
															其它
														</c:if>
													</td>
													<td>
														<c:out value="${gdList.jsxm}" />
													</td>
													<td>
														<c:out value="${gdList.sfzh}" />
													</td>
													<td>

														<c:if test="${gdList.xb == '1'}">
															男
														</c:if>
														<c:if test="${gdList.xb == '2'}">
															女
														</c:if>
													</td>
													<td>
														<c:out value="${gdList.nl}" />
													</td>
													<td>
														<c:out value="${gdList.job}" />
													</td>
													<td>
														<c:out value="${gdList.telephone}" />
													</td>
													<td>

														<c:if test="${gdList.isMarry == '1'}">
															是
														</c:if>
														<c:if test="${gdList.isMarry == '0'}">
															否
														</c:if>
													</td>
													<td>

														<c:if test="${gdList.isDbr == '1'}">
															是
														</c:if>
														<c:if test="${gdList.isDbr == '0'}">
															否
														</c:if>
													</td>
													<td>
														<c:out value="${gdList.peiouxm}" />
													</td>

													<td>
														<c:out value="${gdList.peiousfzh}" />
													</td>
													<td>


														<c:if test="${gdList.peiouxb == '1'}">
															男
														</c:if>
														<c:if test="${gdList.peiouxb == '2'}">
															女
														</c:if>
													</td>
													<td>
														<c:out value="${gdList.peiounl}" />
													</td>
													<td>


														<c:if test="${gdList.peiouisdbr == '1'}">
															是
														</c:if>
														<c:if test="${gdList.peiouisdbr == '0'}">
															否
														</c:if>
													</td>
													<td>
														<c:out value="${gdList.peiouxl}" />
													</td>
													<td>
														<c:out value="${gdList.peioujob}" />
													</td>
													<td>
														<c:out value="${gdList.peioudh}" />
													</td>

												</tr>
												</c:forEach>
											</c:if>

									</c:if>
								</c:forEach>
								<c:forEach items="${gdMap}" var="gdMap" >
									<c:if test="${gdMap.key.khlx == '2'}" >
										<c:if test="${not empty gdMap.value}" >
											<c:set var="gdQsMapValue" value="${gdMap.value}"/>
										</c:if>

										<c:if test="${not empty gdMap.value}" >
											<tr>
												<td rowspan="${gdQsMapValue.size()+1}">
													<c:if test="${gdMap.key.khlx == '2'}">
														实际控股人
													</c:if>
												</td>
												<td rowspan="${gdQsMapValue.size()+1}">  <c:out value="${gdMap.key.gdxm}" /></td>
												<td rowspan="${gdQsMapValue.size()+1}"> <c:out value="${gdMap.key.sfzh}" /> </td>
												<td rowspan="${gdQsMapValue.size()+1}">  <c:if test="${gdMap.key.xb == '1'}">
													男
												</c:if>
													<c:if test="${gdMap.key.xb == '2'}">
														女
													</c:if> </td>
												<td rowspan="${gdQsMapValue.size()+1}">  <c:out value="${gdMap.key.nl}" /> </td>
												<td rowspan="${gdQsMapValue.size()+1}"> <c:out value="${gdMap.key.zgb}" /> </td>
											</tr>
										</c:if>
										<c:if test="${ empty gdMap.value}" >
											<tr>
												<td rowspan="1">
													<c:if test="${gdMap.key.khlx == '2'}">
														实际控股人
													</c:if>
												</td>
												<td rowspan="1">  <c:out value="${gdMap.key.gdxm}" /></td>
												<td rowspan="1"> <c:out value="${gdMap.key.sfzh}" /> </td>
												<td rowspan="1">  <c:if test="${gdMap.key.xb == '1'}">
													男
												</c:if>
													<c:if test="${gdMap.key.xb == '2'}">
														女
													</c:if> </td>
												<td rowspan="1">  <c:out value="${gdMap.key.nl}" /> </td>
												<td rowspan="1"> <c:out value="${gdMap.key.zgb}" /> </td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>

											</tr>
										</c:if>

											<c:if test="${ not empty gdMap.value}">

												<c:forEach items="${gdMap.value}" var="gdList">
													<tr>
													<td>
														<c:if test="${gdMap.key.jsgx == '0'}">
															本人
														</c:if>
														<c:if test="${gdMap.key.jsgx == '1'}">
															配偶
														</c:if>
														<c:if test="${gdMap.key.jsgx == '2'}">
															女儿
														</c:if>
														<c:if test="${gdMap.key.jsgx == '3'}">
															儿子
														</c:if>
														<c:if test="${gdMap.key.jsgx == '4'}">
															兄弟
														</c:if>
														<c:if test="${gdMap.key.jsgx == '5'}">
															姐妹
														</c:if>
														<c:if test="${gdMap.key.jsgx == '6'}">
															父母
														</c:if>
														<c:if test="${gdMap.key.jsgx == '7'}">
															朋友
														</c:if>
														<c:if test="${gdMap.key.jsgx == '8'}">
															其它
														</c:if>
													</td>
														<td>
															<c:out value="${gdList.jsxm}" />
														</td>
														<td>
															<c:out value="${gdList.sfzh}" />
														</td>
														<td>

															<c:if test="${gdList.xb == '1'}">
																男
															</c:if>
															<c:if test="${gdList.xb == '2'}">
																女
															</c:if>
														</td>
														<td>
															<c:out value="${gdList.nl}" />
														</td>
														<td>
															<c:out value="${gdList.job}" />
														</td>
														<td>
															<c:out value="${gdList.telephone}" />
														</td>
														<td>

															<c:if test="${gdList.isMarry == '1'}">
																是
															</c:if>
															<c:if test="${gdList.isMarry == '0'}">
																否
															</c:if>
														</td>
														<td>

															<c:if test="${gdList.isDbr == '1'}">
																是
															</c:if>
															<c:if test="${gdList.isDbr == '0'}">
																否
															</c:if>
														</td>
														<td>
															<c:out value="${gdList.peiouxm}" />
														</td>

														<td>
															<c:out value="${gdList.peiousfzh}" />
														</td>
														<td>


															<c:if test="${gdList.peiouxb == '1'}">
																男
															</c:if>
															<c:if test="${gdList.peiouxb == '2'}">
																女
															</c:if>
														</td>
														<td>
															<c:out value="${gdList.peiounl}" />
														</td>
														<td>


															<c:if test="${gdList.peiouisdbr == '1'}">
																是
															</c:if>
															<c:if test="${gdList.peiouisdbr == '0'}">
																否
															</c:if>
														</td>
														<td>
															<c:out value="${gdList.peiouxl}" />
														</td>
														<td>
															<c:out value="${gdList.peioujob}" />
														</td>
														<td>
															<c:out value="${gdList.peioudh}" />
														</td>
													</tr>
												</c:forEach>
											</c:if>
										</tr>
									</c:if>
								</c:forEach>

								<c:forEach items="${gdMap}" var="gdMap" >
									<c:if test="${gdMap.key.khlx == '3'}" >
										<c:if test="${not empty gdMap.value}" >
											<c:set var="gdQsMapValue" value="${gdMap.value}"/>
										</c:if>

										<c:if test="${not empty gdMap.value}" >
											<tr>
											<td rowspan="${gdQsMapValue.size()+1}">
												<c:if test="${gdMap.key.khlx == '3'}">
													担保人
												</c:if>
											</td>
											<td rowspan="${gdQsMapValue.size()+1}">  <c:out value="${gdMap.key.gdxm}" /></td>
											<td rowspan="${gdQsMapValue.size()+1}"> <c:out value="${gdMap.key.sfzh}" /> </td>
											<td rowspan="${gdQsMapValue.size()+1}">  <c:if test="${gdMap.key.xb == '1'}">
												男
											</c:if>
												<c:if test="${gdMap.key.xb == '2'}">
													女
												</c:if> </td>
											<td rowspan="${gdQsMapValue.size()+1}">  <c:out value="${gdMap.key.nl}" /> </td>
											<td rowspan="${gdQsMapValue.size()+1}"> <c:out value="${gdMap.key.zgb}" /> </td>
											</tr>
										</c:if>

											<c:if test="${empty gdMap.value}">
												<tr>
													<td rowspan="1">
														<c:if test="${gdMap.key.khlx == '3'}">
															担保人
														</c:if>
													</td>
													<td rowspan="1">  <c:out value="${gdMap.key.gdxm}" /></td>
													<td rowspan="1"> <c:out value="${gdMap.key.sfzh}" /> </td>
													<td rowspan="1">
														<c:if test="${gdMap.key.xb == '1'}">
															男
														</c:if>
														<c:if test="${gdMap.key.xb == '2'}">
															女
														</c:if>
													</td>
													<td rowspan="1">  <c:out value="${gdMap.key.nl}" /> </td>
													<td rowspan="1"> <c:out value="${gdMap.key.zgb}" /> </td>

												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
												<td>

												</td>
													<td>

													</td>
													<td>

													</td>
													<td>

													</td>
													<td>

													</td>
													<td>

													</td>
													<td>

													</td>
													<td>

													</td>
													<td>

													</td>
													<td>

													</td>
													<td>

													</td>
													<td>

													</td>
												</tr>
											</c:if>
											<c:if test="${ not empty gdMap.value}">

												<c:forEach items="${gdMap.value}" var="gdList">
													<tr>
													<td>
														<c:if test="${gdList.jsgx == '0'}">
															本人
														</c:if>
														<c:if test="${gdList.jsgx == '1'}">
															配偶
														</c:if>
														<c:if test="${gdList.jsgx == '2'}">
															女儿
														</c:if>
														<c:if test="${gdList.jsgx == '3'}">
															儿子
														</c:if>
														<c:if test="${gdList.jsgx == '4'}">
															兄弟
														</c:if>
														<c:if test="${gdList.jsgx == '5'}">
															姐妹
														</c:if>
														<c:if test="${gdList.jsgx == '6'}">
															父母
														</c:if>
														<c:if test="${gdList.jsgx == '7'}">
															朋友
														</c:if>
														<c:if test="${gdList.jsgx == '8'}">
															其它
														</c:if>
													</td>
													<td>
														<c:out value="${gdList.jsxm}" />
													</td>
													<td>
														<c:out value="${gdList.sfzh}" />
													</td>
													<td>

														<c:if test="${gdList.xb == '1'}">
															男
														</c:if>
														<c:if test="${gdList.xb == '2'}">
															女
														</c:if>
													</td>
													<td>
														<c:out value="${gdList.nl}" />
													</td>
													<td>
														<c:out value="${gdList.job}" />
													</td>
														<td>
															<c:out value="${gdList.telephone}" />
														</td>
														<td>

															<c:if test="${gdList.isMarry == '1'}">
																是
															</c:if>
															<c:if test="${gdList.isMarry == '0'}">
																否
															</c:if>
													</td>
														<td>

															<c:if test="${gdList.isDbr == '1'}">
																是
															</c:if>
															<c:if test="${gdList.isDbr == '0'}">
																否
															</c:if>
														</td>
														<td>
															<c:out value="${gdList.peiouxm}" />
														</td>

														<td>
															<c:out value="${gdList.peiousfzh}" />
														</td>
														<td>


															<c:if test="${gdList.peiouxb == '1'}">
																男
															</c:if>
															<c:if test="${gdList.peiouxb == '2'}">
																女
															</c:if>
														</td>
														<td>
															<c:out value="${gdList.peiounl}" />
														</td>
														<td>


															<c:if test="${gdList.peiouisdbr == '1'}">
																是
															</c:if>
															<c:if test="${gdList.peiouisdbr == '0'}">
																否
															</c:if>
														</td>
														<td>
															<c:out value="${gdList.peiouxl}" />
														</td>
														<td>
															<c:out value="${gdList.peioujob}" />
														</td>
														<td>
															<c:out value="${gdList.peioudh}" />
														</td>

													</tr>
												</c:forEach>

											</c:if>

										</tr>
									</c:if>
								</c:forEach>
								</tbody>
							</table>


						</div>
				</div>
			</div>
		</div>


		<div class="row animated fadeInRight">
			<div class="col-sm-6">
				<div class="panel panel-info">
					<div class="panel-heading">
						<i class="fa fa-th-list"></i> 生意资金构成（推算前）
					</div>
					<div id="syzjgcJson" class="panel-body"  style="padding: 0px;width:100%;height: 350px">

					</div>
				</div>
			</div>
			<div class="col-sm-6">
				<div class="panel panel-danger">
					<div class="panel-heading">
						<i class="fa fa-fire"></i> 生意资金构成（推算后）
					</div>

					<div id="tshzjjgJson" class="panel-body"  style="padding: 0px;width:100%;height: 350px">

					</div>
				</div>
			</div>
		</div>
		<div class="row animated fadeInRight">
			<div class="col-sm-12">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="fa fa-rss-square"></i> 未结清款项明细
					</div>

					<div class="panel-body">
						<table id="wjqkxmxTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
							<thead>
							<tr>
								<th  rowspan="2" class="sort-column khmc">融资机构</th>
								<th  rowspan="2" class="sort-column khmc">融资金额</th>
								<th   rowspan="2" class="sort-column guojia">融资时间段</th>

							</tr>
							</thead>
							<tbody>
							<c:forEach items="${keRzlist}" var="keRz">
								<tr>
									<td>${keRz.rzjg}</td>
									<td>${keRz.rzje}</td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${keRz.rzkssj}" /> ~ <fmt:formatDate pattern="yyyy-MM-dd"
									                                                                                     value="${keRz.rzjssj}" /></td>
								</tr>
							</c:forEach>

							</tbody>
						</table>


					</div>
				</div>
			</div>
		</div>
		<div class="row animated fadeInRight">
			<div class="col-sm-12">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="fa fa-rss-square"></i> 客户销售数据明细汇总(数据)
					</div>
					<div class="panel-body">
					<table class="table table-striped table-bordered table-hover"
					       width="100%" style="vertical-align: middle;">

						<tbody id="cxjhxssjhz">
						<tr style=" text-align: left;">
							<td width="100"><span>开始时间：</span>
								<select name="beginNianfen" id="beginNianfen"  class="form-control input-sm"  style="width: 120px;display: inline" >
								</select>
							</td>
							<td width="100"><span>结束时间：</span>

								<select name="endNianfen" id="endNianfen"  class="form-control input-sm"  style="width: 120px;display: inline" >
								</select>
							</td>
							<td width="100"><span>统计字段</span>
								<select name="tjName"  class="form-control m-b" style="width: 120px;display: inline">
									<option value="1" label="销售收入"></option>
									<option value="2" label="净值"></option>
									<option value="3" label="税额"></option>
									<option value="4" label="战略价金额"></option>
								</select>
							</td>
							<td width="375"><button  style="width: 150px;display: inline;" class="form-control btn btn-white btn-sm" onclick="search()" > 查询</button>
							</td>
						</tr>
						</tbody>
					</table>
					</div>
					<div class="panel-body">
						<table id="khxssjhzTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
							<thead>
							<tr>
								<th  class="sort-column nianfen">年份</th>
								<th  class="sort-column num">总计</th>
								<th  class="sort-column yiyue">1月</th>
								<th  class="sort-column eryue">2月</th>
								<th  class="sort-column sanyue">3月</th>
								<th  class="sort-column siyue">4月</th>
								<th  class="sort-column wuyue">5月</th>
								<th  class="sort-column liuyue">6月</th>
								<th  class="sort-column qiyue">7月</th>
								<th  class="sort-column bayue">8月</th>
								<th  class="sort-column jiuyue">9月</th>
								<th  class="sort-column shiyue">10月</th>
								<th  class="sort-column syyyue">11月</th>
								<th  class="sort-column seyyue">12月</th>
									<%--<th>操作</th>--%>
							</tr>
							</thead>
							<tbody>
							<c:forEach items="${xssjhzlist}" var="item">
								<tr>
									<td>
											${item.nianfen}
									</td>
									<td>
										<fmt:formatNumber  value="${item.num/10000}"  pattern="#,###,###,###"/>
									</td>
									<td>
										<fmt:formatNumber  value="${item.yiyue/10000}"  pattern="#,###,###,###"/>
									</td>
									<td>
										<fmt:formatNumber  value="${item.eryue/10000}"  pattern="#,###,###,###"/>
									</td>
									<td>
										<fmt:formatNumber  value="${item.sanyue/10000}"  pattern="#,###,###,###"/>
									</td>
									<td>
										<fmt:formatNumber  value="${item.siyue/10000}"  pattern="#,###,###,###"/>
									</td>
									<td>
										<fmt:formatNumber  value="${item.wuyue/10000}"  pattern="#,###,###,###"/>
									</td>
									<td>
										<fmt:formatNumber  value="${item.liuyue/10000}"  pattern="#,###,###,###"/>
									</td>
									<td>
										<fmt:formatNumber  value="${item.qiyue/10000}"  pattern="#,###,###,###"/>
									</td>
									<td>
										<fmt:formatNumber  value="${item.bayue/10000}"  pattern="#,###,###,###"/>
									</td>
									<td>
										<fmt:formatNumber  value="${item.jiuyue/10000}"  pattern="#,###,###,###"/>
									</td>
									<td>
										<fmt:formatNumber  value="${item.shiyue/10000}"  pattern="#,###,###,###"/>
									</td>
									<td>
										<fmt:formatNumber  value="${item.syyyue/10000}"  pattern="#,###,###,###"/>
									</td>
									<td>
										<fmt:formatNumber  value="${item.seyyue/10000}"  pattern="#,###,###,###"/>
									</td>

								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>

					<div class="panel-body">
						<div id="khxssjmxtb" class="panel-body"  style="padding: 0px;width:100%;height: 400px"></div>

					</div>
				</div>
			</div>
		</div>

		<div class="row animated fadeInRight">
			<div class="col-sm-12">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="fa fa-rss-square"></i> 目标核心企业进货未开票数据情况(单位：万):中粮福临门
					</div>

					<div class="panel-body">
						<div class="panel-body" >
								<table id="hexiqiyejinhwkp" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
									<thead>
									<tr>
										<th   class="sort-column khmc">项目</th>
										<th   class="sort-column yiyue">1月</th>
										<th    class="sort-column eryue">2月</th>
										<th    class="sort-column sanyue">3月</th>
										<th    class="sort-column siyue">4月</th>
										<th    class="sort-column wuyue">5月</th>
										<th    class="sort-column liuyue">6月</th>
										<th    class="sort-column qiyue">7月</th>
										<th    class="sort-column bayue">8月</th>
										<th    class="sort-column jiuyue">9月</th>
										<th    class="sort-column shiyue">10月</th>
										<th    class="sort-column syyyue">11月</th>
										<th    class="sort-column seyyue">12月</th>
										<th    class="sort-column num">合计</th>
									</tr>
									</thead>
									<tbody>
									<c:if test="${empty jhshuju }">
										<tr>
											<td>
												实际进货
											</td>
											<td>

											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
										</tr>
									</c:if>
									<c:if test="${ not empty jhshuju }">
										<c:forEach items="${jhshuju}" var="item">
											<tr>
												<td>
													实际进货
												</td>
												<td>
													<fmt:formatNumber  value="${item.yiyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.eryue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.sanyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.siyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.wuyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.liuyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.qiyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.bayue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.jiuyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.shiyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.syyyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.seyyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.num/10000}"  pattern="#,###,###,###"/>
												</td>
											</tr>
										</c:forEach>
									</c:if>
									<c:if test="${empty kpshuju }">
										<tr>
											<td>
												实际开票
											</td>
											<td>

											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
											<td>
											</td>
										</tr>
									</c:if>
									<c:if test="${ not empty kpshuju }">
										<c:forEach items="${kpshuju}" var="item">
											<tr>
												<td>
													实际开票
												</td>
												<td>
													<fmt:formatNumber  value="${item.yiyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.eryue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.sanyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.siyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.wuyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.liuyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.qiyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.bayue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.jiuyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.shiyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.syyyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.seyyue/10000}"  pattern="#,###,###,###"/>
												</td>
												<td>
													<fmt:formatNumber  value="${item.num/10000}"  pattern="#,###,###,###"/>
												</td>
											</tr>
										</c:forEach>
									</c:if>

									<tr>
										<td>
											未开票
										</td>
										<td>

										</td>
										<td>
										</td>
										<td>
										</td>
										<td>
										</td>
										<td>
										</td>
										<td>
										</td>
										<td>
										</td>
										<td>
										</td>
										<td>
										</td>
										<td>
										</td>
										<td>
										</td>
										<td>
										</td>
										<td>
										</td>
									</tr>
									</tbody>

								</table>
						</div>

					</div>
				</div>
			</div>
		</div>


		<div class="row animated fadeInRight">
			<div class="col-sm-12">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="fa fa-rss-square"></i> 销售客户明细，时间：今年1月1日至今    销售额降序排列
					</div>

					<div class="panel-body">
						<table id="xskhmx" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
							<thead>
							<tr>
								<th  rowspan="2" class="sort-column xuhao">序号</th>
								<th  rowspan="2" class="sort-column khmc">客户名称</th>
								<th   rowspan="2" class="sort-column kpje">开票金额</th>
							</tr>
							</thead>
							<tbody>

							<c:forEach items="${xskhmxjxfpHeadlist}" var="item" varStatus="idx">
								<tr>
									<td>
											${idx.count}
									</td>
									<td>
										${item.gmfmc}
									</td>
									<td>${item.hjhsje}
									</td>

								</tr>
							</c:forEach>
							</tbody>
						</table>


					</div>
				</div>
			</div>
		</div>
		<div class="row animated fadeInRight">
			<div class="col-sm-12">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="fa fa-rss-square"></i> 近3个月前5大客户开票数据（数据取自发票数据金税发票接口-销项）
					</div>

					<div class="panel-body">
						<table id="sgqwkhkpsjTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
							<thead>
							<tr>
								<th  rowspan="2" class="sort-column khmc">序号</th>
								<th  rowspan="2" class="sort-column khmc">客户名称</th>

										<th   rowspan="2" class="sort-column guojia">${currentMonth-2}月</th>

										<th   rowspan="2" class="sort-column guojia">${currentMonth-1}月</th>

										<th   rowspan="2" class="sort-column guojia">${currentMonth}月</th>

								<th   rowspan="2" class="sort-column guojia">是否赊账</th>
							</tr>
							</thead>
							<tbody>
							<c:forEach items="${jsyqwMap}" var="item" varStatus="idx">
								<tr>
									<td>
											${idx.count}
									</td>
									<td>
											${item.khmc}
									</td>
									<td>
											${item.dyyue}
									</td>
									<td>
											${item.deryue}
									</td>
									<td>
											${item.dsanyue}
									</td>
									<td>
									</td>
								</tr>
							</c:forEach>

							</tbody>
						</table>


					</div>
				</div>
			</div>
		</div>
		<div class="row animated fadeInRight">
			<div class="col-sm-12">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="fa fa-rss-square"></i> 供应商明细
					</div>

					<div class="panel-body">
						<table id="gysmx" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
							<thead>
							<tr>
								<th  rowspan="2" class="sort-column ">序号</th>
								<th  rowspan="2" class="sort-column ">供应商名称</th>
								<th  rowspan="2" class="sort-column ">开票金额</th>

							</tr>
							</thead>
							<tbody>
							<c:forEach items="${gysjxfpHeadlist}" var="item" varStatus="idx">
								<tr>
									<td>${idx.count}</td>
									<td>${item.xsfmc}</td>
									<td>${item.hjhsje}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>


					</div>
				</div>
			</div>
		</div>
		<div class="row animated fadeInRight">
			<div class="col-sm-12">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="fa fa-rss-square"></i> 供应商开票进项数据（数据取自发票数据金税发票接口-进项）
					</div>

					<div class="panel-body">
						<table id="gyskpjxsj" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
							<thead>
							<tr>
								<th  rowspan="2" class="sort-column ">序号</th>
								<th  rowspan="2" class="sort-column ">开票项目</th>
								<th  rowspan="2" class="sort-column ">开票金额</th>

							</tr>
							</thead>
							<tbody>
							<c:forEach items="${gyskpshujxfpItemlist}" var="item" varStatus="idx">
								<tr>
									<td>${idx.count}</td>
									<td>${item.hwmc}</td>
									<td>${item.hsje}</td>
								</tr>
							</c:forEach>

							</tbody>
						</table>

					</div>
				</div>
			</div>
		</div>
		<div class="row animated fadeInRight">
			<div class="col-sm-12">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="fa fa-rss-square"></i> 供应商开票进项数据（数据取自发票数据金税发票接口-进项）
					</div>

					<div class="panel-body">
						<table id="gyskpjxsjnd" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
							<thead>
							<tr>
								<th  rowspan="2" class="sort-column ">序号</th>
								<th  rowspan="2" class="sort-column ">供应商名称</th>
								<th  rowspan="2" class="sort-column ">去年</th>
								<th  rowspan="2" class="sort-column ">本年</th>
								<th  rowspan="2" class="sort-column ">本月</th>
							</tr>
							</thead>
							<tbody>
							<c:forEach items="${gyskpqnjnbnList}" var="item" varStatus="idx">
								<tr>
									<td>${idx.count}</td>
									<td>${item.ckName}</td>
									<td>${keRz.qunian}</td>
									<td>${keRz.bennian}</td>
									<td>${keRz.benyue}</td>
								</tr>
							</c:forEach>

							</tbody>
						</table>


					</div>
				</div>
			</div>
		</div>
		<div class="row animated fadeInRight">
			<div class="col-sm-12">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="fa fa-rss-square"></i> 开给各供应商的费用发票情况：（来源：发票接口-销项）
					</div>

					<div class="panel-body">
						<table id="gysfyfp" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
							<thead>
							<tr>
								<th  rowspan="2" class="sort-column ">序号</th>
								<th  rowspan="2" class="sort-column ">供应商名称</th>
								<th  rowspan="2" class="sort-column ">金额</th>
								<th  rowspan="2" class="sort-column ">年月</th>
							</tr>
							</thead>
							<tbody>

							<c:forEach items="${gyskpqnjnbnXX}" var="item" varStatus="idx">
								<tr>
									<td>${idx.count}</td>
									<td>${item.ckName}</td>
									<td>${keRz.jshj}</td>
									<td>${keRz.nianyue}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>


					</div>
				</div>
			</div>
		</div>

		<div class="row animated fadeInRight">
			<div class="col-sm-12">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="fa fa-rss-square"></i> 授信额度建议
					</div>

					<div class="panel-body">
						<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
							<thead>
							<tr style="text-align: center">

									<%--<th  rowspan="2" class="sort-column nianfen">客户简码</th>--%>
								<th  rowspan="2" class="sort-column num">大区</th>
								<th  rowspan="2" class="sort-column yiyue">融资单位</th>
								<th  rowspan="2" class="sort-column nianfen">合作状态</th>
								<th  colspan="5" class="sort-column eryue"  style="text-align:center" >收入情况</th>
									<%--<th  class="sort-column sanyue">2015年</th>
									<th  class="sort-column siyue">2016年</th>
									<th  class="sort-column wuyue">2017年</th>
									<th  class="sort-column liuyue">年平均销售额度</th>
									<th  class="sort-column qiyue">2018年</th>--%>
								<th rowspan="2" class="sort-column bayue">累计预算</th>
								<th rowspan="2" class="sort-column jiuyue">预算达成率</th>
								<th rowspan="2" class="sort-column shiyue">全年预算</th>
								<th rowspan="2" class="sort-column syyyue">全年进度</th>
								<th rowspan="2" class="sort-column bayue">福临门占比销售</th>
								<th rowspan="2" class="sort-column jiuyue">其它外部融资</th>
								<th rowspan="2" class="sort-column shiyue">6次周转融创授信额度</th>
								<th rowspan="2" class="sort-column syyyue">不还原整体</th>


							</tr>
							<tr>

								<th  class="sort-column sanyue">${csxeduTj.nianfen-3}年</th>
								<th  class="sort-column siyue">${csxeduTj.nianfen-2}年</th>
								<th  class="sort-column wuyue">${csxeduTj.nianfen-1}年</th>
								<th  class="sort-column liuyue">年平均</th>
								<th  class="sort-column qiyue">${csxeduTj.nianfen}年</th>
							</tr>

							</thead>
							<tbody>
							<c:forEach items="${page.list}" var="item">

								<tr>
										<%--<td>
												${item.khjm}
										</td>--%>
									<td>
											${item.daqu}
									</td>
									<td>
											${item.khmc}
									</td>
									<td >
										<c:if test="${item.sfhz=='1'}">
											是
										</c:if>
										<c:if test="${item.sfhz=='0'}">
											否
										</c:if>
									</td>
									<td style="text-align: right">
										<fmt:formatNumber  value="${item.dsyear/10000}"  pattern="#,###,###,###"/>
									</td>
									<td style="text-align: right">
										<fmt:formatNumber  value="${item.deyear/10000}"  pattern="#,###,###,###"/>
									</td>
									<td style="text-align: right">
										<fmt:formatNumber  value="${item.dyyear/10000}"  pattern="#,###,###,###"/>
									</td>
									<td style="text-align: right">
										<fmt:formatNumber  value="${item.sanyear/10000}"  pattern="#,###,###,###"/>
									</td>
									<td style="text-align: right">
										<fmt:formatNumber  value="${item.dyear/10000}"   pattern="#,###,###,###" />
									</td>
									<td style="text-align: right">
											${ljys}
									</td>
									<td style="text-align: right">
											${dcl}
									</td>
									<td style="text-align: right">
											${qnys}
									</td>
									<td style="text-align: right">
											${qnjd}
									</td>

									<td style="text-align: right">
										<fmt:formatNumber type="percent"  value="${item.flmzb}"  maxIntegerDigits="2"/>
									</td>
									<td>
											<%--<fmt:formatNumber type="percent"  value="${item.flmzb}"  maxIntegerDigits="2"/>--%>
									</td>
									<td style="text-align: right">
										<fmt:formatNumber  value="${item.sxsxed/10000}"  pattern="#,###,###,###"   />
									</td>

									<td style="text-align: right">
										<fmt:formatNumber  value="${item.sxxxed/10000}"  pattern="#,###,###,###"  />
									</td>

								</tr>
							</c:forEach>
							</tbody>
						</table>


					</div>
				</div>
			</div>
		</div>




	</div>
	</form:form>
</body>
</html>
