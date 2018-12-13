<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html lang="en"
	class="app js no-touch no-android chrome no-firefox no-iemobile no-ie no-ie10 no-ie11 no-ios no-ios7 ipad">
<head>
<meta name="decorator" content="default"/>
<script src="${ctxStatic}/echarts-2.2.7/build/dist/echarts-all.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="${ctxStatic}/common/systemInfo.js"></script>
	<script type="text/javascript">

	</script>
</head>
<body class="" style="">
	<div class="wrapper wrapper-content">
		<div class="row animated fadeInRight">
			<div class="col-sm-12">
				<div class="panel panel-success">
					<div class="panel-heading">
						<i class="fa fa-briefcase"></i> 客户基本信息
					</div>

					<table class="table table-striped table-bordered table-hover"
					       width="100%" style="vertical-align: middle;">

						<tbody id="tbody">
						<tr style=" text-align: left;">
							<td width="100">客户简码：</td>
							<td width="100">客户名称：</td>
							<td width="375">地址：</td>
						</tr>
						<tr><td width="205">福临门油销售占比(百分比)：</td>
							<td width="375">资金周转次数：</td>
							<td width="375">可负债比例(百分比)：</td>
						</tr>

						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="row animated fadeInRight">
				<div class="col-sm-12">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<i class="fa fa-rss-square"></i> 股东信息
						</div>
	
						<div class="panel-body">
							<table id="gdTable"
							       width="100%" style="vertical-align: middle;">
								<thead>
								<tr>
									<th  rowspan="2" >类型</th>
									<th  rowspan="2" >姓名</th>
									<th   rowspan="2" >身份证号</th>
									<th   rowspan="2" >性别</th>
									<th  rowspan="2" >年龄</th>
									<th  rowspan="2" >占股比</th>
									<th colspan="6" >家属信息</th>
								</tr>
								<tr>
									<th >与股东的关系</th>
									<th >姓名</th>
									<th >身份证号</th>
									<th >性别</th>
									<th >年龄</th>
									<th >占股比</th>
								</tr>
								</thead>
								<tbody>

								<c:forEach items="${gdMap}" var="gdMap" >
									<c:if test="${gdMap.key.khlx == '1'}" >
										<c:if test="${not empty gdMap.value}" >
											<c:set var="gdMapValue" value="${gdMap.value}"/>
										</c:if>
										<tr>
											<td rowspan="${gdMapValue.size()}">
												<c:if test="${gdMap.key.khlx == '1'}">
													股东
												</c:if>
											</td>
											<td rowspan="${gdMapValue.size()}">  <c:out value="${gdMap.key.gdxm}" /></td>
											<td rowspan="${gdMapValue.size()}"> <c:out value="${gdMap.key.sfzh}" /> </td>
											<td rowspan="${gdMapValue.size()}">  <c:out value="${gdMap.key.xb}" /> </td>
											<td rowspan="${gdMapValue.size()}">  <c:out value="${gdMap.key.nl}" /> </td>
											<td rowspan="${gdMapValue.size()}"> <c:out value="${gdMap.key.zgb}" /> </td>
										</tr>
										<c:if test="${empty gdMap.value}">

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
										</c:if>
										<c:forEach items="${gdMap.value}" var="gdList">

											<td>
												<c:if test="${gdMap.key.jtcy == '0'}">
													本人
												</c:if>
												<c:if test="${gdMap.key.jtcy == '1'}">
													配偶
												</c:if>
												<c:if test="${gdMap.key.jtcy == '2'}">
													女儿
												</c:if>
												<c:if test="${gdMap.key.jtcy == '3'}">
													儿子
												</c:if>
												<c:if test="${gdMap.key.jtcy == '4'}">
													兄弟
												</c:if>
												<c:if test="${gdMap.key.jtcy == '5'}">
													姐妹
												</c:if>
												<c:if test="${gdMap.key.jtcy == '6'}">
													父母
												</c:if>
												<c:if test="${gdMap.key.jtcy == '7'}">
													朋友
												</c:if>
												<c:if test="${gdMap.key.jtcy == '8'}">
													其它
												</c:if>
											</td>
											<td>
												<c:out value="${gdList.gdxm}" />
											</td>
											<td>
												<c:out value="${gdList.sfzh}" />
											</td>
											<td>
												<c:out value="${gdList.xb}" />
											</td>
											<td>
												<c:out value="${gdList.nl}" />
											</td>
											<td>
												<c:out value="${gdList.zgb}" />
											</td>

										</c:forEach>

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
					<div class="panel-body" style="padding: 0px">
						<div style="height: 370px;" class="embed-responsive embed-responsive-16by9">
							<%--<iframe class="embed-responsive-item" src="${ctx}/monitor/systemInfo"></iframe>--%>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-6">
				<div class="panel panel-danger">
					<div class="panel-heading">
						<i class="fa fa-fire"></i> 生意资金构成（推算后）
					</div>

					<div class="panel-body">
						<div id="main1" style="height: 370px;"></div>

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
						<table id="gdTable"
						       width="100%" style="vertical-align: middle;">
							<thead>
							<tr>
								<th  rowspan="2" >类型</th>
								<th  rowspan="2" >姓名</th>
								<th   rowspan="2" >身份证号</th>
								<th   rowspan="2" >性别</th>
								<th  rowspan="2" >年龄</th>
								<th  rowspan="2" >占股比</th>
								<th colspan="6" >家属信息</th>
							</tr>
							<tr>
								<th >与股东的关系</th>
								<th >姓名</th>
								<th >身份证号</th>
								<th >性别</th>
								<th >年龄</th>
								<th >占股比</th>
							</tr>
							</thead>
							<tbody>

							<c:forEach items="${gdMap}" var="gdMap" >
								<c:if test="${gdMap.key.khlx == '1'}" >
									<c:if test="${not empty gdMap.value}" >
										<c:set var="gdMapValue" value="${gdMap.value}"/>
									</c:if>
									<tr>
										<td rowspan="${gdMapValue.size()}">
											<c:if test="${gdMap.key.khlx == '1'}">
												股东
											</c:if>
										</td>
										<td rowspan="${gdMapValue.size()}">  <c:out value="${gdMap.key.gdxm}" /></td>
										<td rowspan="${gdMapValue.size()}"> <c:out value="${gdMap.key.sfzh}" /> </td>
										<td rowspan="${gdMapValue.size()}">  <c:out value="${gdMap.key.xb}" /> </td>
										<td rowspan="${gdMapValue.size()}">  <c:out value="${gdMap.key.nl}" /> </td>
										<td rowspan="${gdMapValue.size()}"> <c:out value="${gdMap.key.zgb}" /> </td>
									</tr>
									<c:if test="${empty gdMap.value}">

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
									</c:if>
									<c:forEach items="${gdMap.value}" var="gdList">

										<td>
											<c:if test="${gdMap.key.jtcy == '0'}">
												本人
											</c:if>
											<c:if test="${gdMap.key.jtcy == '1'}">
												配偶
											</c:if>
											<c:if test="${gdMap.key.jtcy == '2'}">
												女儿
											</c:if>
											<c:if test="${gdMap.key.jtcy == '3'}">
												儿子
											</c:if>
											<c:if test="${gdMap.key.jtcy == '4'}">
												兄弟
											</c:if>
											<c:if test="${gdMap.key.jtcy == '5'}">
												姐妹
											</c:if>
											<c:if test="${gdMap.key.jtcy == '6'}">
												父母
											</c:if>
											<c:if test="${gdMap.key.jtcy == '7'}">
												朋友
											</c:if>
											<c:if test="${gdMap.key.jtcy == '8'}">
												其它
											</c:if>
										</td>
										<td>
											<c:out value="${gdList.gdxm}" />
										</td>
										<td>
											<c:out value="${gdList.sfzh}" />
										</td>
										<td>
											<c:out value="${gdList.xb}" />
										</td>
										<td>
											<c:out value="${gdList.nl}" />
										</td>
										<td>
											<c:out value="${gdList.zgb}" />
										</td>

									</c:forEach>

								</c:if>
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
						<i class="fa fa-rss-square"></i> 客户销售数据明细汇总(图表)
					</div>

					<div class="panel-body">
						<table id="gdTable"
						       width="100%" style="vertical-align: middle;">
							<thead>
							<tr>
								<th  rowspan="2" >类型</th>
								<th  rowspan="2" >姓名</th>
								<th   rowspan="2" >身份证号</th>
								<th   rowspan="2" >性别</th>
								<th  rowspan="2" >年龄</th>
								<th  rowspan="2" >占股比</th>
								<th colspan="6" >家属信息</th>
							</tr>
							<tr>
								<th >与股东的关系</th>
								<th >姓名</th>
								<th >身份证号</th>
								<th >性别</th>
								<th >年龄</th>
								<th >占股比</th>
							</tr>
							</thead>
							<tbody>

							<c:forEach items="${gdMap}" var="gdMap" >
								<c:if test="${gdMap.key.khlx == '1'}" >
									<c:if test="${not empty gdMap.value}" >
										<c:set var="gdMapValue" value="${gdMap.value}"/>
									</c:if>
									<tr>
										<td rowspan="${gdMapValue.size()}">
											<c:if test="${gdMap.key.khlx == '1'}">
												股东
											</c:if>
										</td>
										<td rowspan="${gdMapValue.size()}">  <c:out value="${gdMap.key.gdxm}" /></td>
										<td rowspan="${gdMapValue.size()}"> <c:out value="${gdMap.key.sfzh}" /> </td>
										<td rowspan="${gdMapValue.size()}">  <c:out value="${gdMap.key.xb}" /> </td>
										<td rowspan="${gdMapValue.size()}">  <c:out value="${gdMap.key.nl}" /> </td>
										<td rowspan="${gdMapValue.size()}"> <c:out value="${gdMap.key.zgb}" /> </td>
									</tr>
									<c:if test="${empty gdMap.value}">

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
									</c:if>
									<c:forEach items="${gdMap.value}" var="gdList">

										<td>
											<c:if test="${gdMap.key.jtcy == '0'}">
												本人
											</c:if>
											<c:if test="${gdMap.key.jtcy == '1'}">
												配偶
											</c:if>
											<c:if test="${gdMap.key.jtcy == '2'}">
												女儿
											</c:if>
											<c:if test="${gdMap.key.jtcy == '3'}">
												儿子
											</c:if>
											<c:if test="${gdMap.key.jtcy == '4'}">
												兄弟
											</c:if>
											<c:if test="${gdMap.key.jtcy == '5'}">
												姐妹
											</c:if>
											<c:if test="${gdMap.key.jtcy == '6'}">
												父母
											</c:if>
											<c:if test="${gdMap.key.jtcy == '7'}">
												朋友
											</c:if>
											<c:if test="${gdMap.key.jtcy == '8'}">
												其它
											</c:if>
										</td>
										<td>
											<c:out value="${gdList.gdxm}" />
										</td>
										<td>
											<c:out value="${gdList.sfzh}" />
										</td>
										<td>
											<c:out value="${gdList.xb}" />
										</td>
										<td>
											<c:out value="${gdList.nl}" />
										</td>
										<td>
											<c:out value="${gdList.zgb}" />
										</td>

									</c:forEach>

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
						<i class="fa fa-th-list"></i> 目标核心企业进货未开票数据情况(数据):中粮福临门
					</div>
					<div class="panel-body" style="padding: 0px">
						<div style="height: 370px;" class="embed-responsive embed-responsive-16by9">
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-6">
				<div class="panel panel-danger">
					<div class="panel-heading">
						<i class="fa fa-fire"></i> 目标核心企业进货未开票数据情况（图表）:中粮福临门
					</div>

					<div class="panel-body">
						<div id="" style="height: 370px;"></div>

					</div>
				</div>
			</div>
		</div>

		<div class="row animated fadeInRight">
			<div class="col-sm-12">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="fa fa-rss-square"></i> 销售客户明细：时间段：2018-1-1至今    销售额降序排列
					</div>

					<div class="panel-body">
						<table id="" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
							<thead>
							<tr>
								<th  rowspan="2" class="sort-column khmc">序号</th>
								<th  rowspan="2" class="sort-column khmc">客户名称</th>
								<th   rowspan="2" class="sort-column guojia">开票金额</th>

							</tr>
							</thead>
							<tbody>


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
						<table id="" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
							<thead>
							<tr>
								<th  rowspan="2" class="sort-column khmc">序号</th>
								<th  rowspan="2" class="sort-column khmc">客户名称</th>
								<th   rowspan="2" class="sort-column guojia">1月</th>
								<th   rowspan="2" class="sort-column guojia">2月</th>
								<th   rowspan="2" class="sort-column guojia">3月</th>
								<th   rowspan="2" class="sort-column guojia">是否赊账</th>
							</tr>
							</thead>
							<tbody>


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
						<table id="" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
							<thead>
							<tr>
								<th  rowspan="2" class="sort-column ">序号</th>
								<th  rowspan="2" class="sort-column ">供应商名称</th>
								<th  rowspan="2" class="sort-column ">开票金额</th>

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
						<i class="fa fa-rss-square"></i> 供应商开票进项数据（数据取自发票数据金税发票接口-进项）
					</div>

					<div class="panel-body">
						<table id="" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
							<thead>
							<tr>
								<th  rowspan="2" class="sort-column ">序号</th>
								<th  rowspan="2" class="sort-column ">开票项目</th>
								<th  rowspan="2" class="sort-column ">开票金额</th>

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
						<i class="fa fa-rss-square"></i> 供应商开票进项数据（数据取自发票数据金税发票接口-进项）
					</div>

					<div class="panel-body">
						<table id="" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
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
						<i class="fa fa-rss-square"></i> 开给各供应商的费用发票情况：（来源：发票接口-销项）
					</div>

					<div class="panel-body">
						<table id="" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
							<thead>
							<tr>
								<th  rowspan="2" class="sort-column ">序号</th>
								<th  rowspan="2" class="sort-column ">供应商名称</th>
								<th  rowspan="2" class="sort-column ">金额</th>
								<th  rowspan="2" class="sort-column ">年月</th>
							</tr>
							</thead>
							<tbody>


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

								<th  rowspan="2" class="sort-column yiyue">融资单位</th>
								<th  rowspan="2" class="sort-column nianfen">是否已经合作</th>
								<th  colspan="5" class="sort-column eryue"  style="text-align:center" >收入情况</th>

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
										<%--<td>
												${item.daqu}
										</td>--%>
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
										<fmt:formatNumber type="percent"  value="${item.flmzb}"  maxIntegerDigits="2"/>
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
</body>
</html>
