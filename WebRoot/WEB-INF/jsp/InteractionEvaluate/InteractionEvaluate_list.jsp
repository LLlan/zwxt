<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 引入标签库 -->
<%@include file="/common/include/taglibs.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%@ include file="../system/admin/top.jsp"%> 
	</head> 
<body>
		
<div class="container-fluid" id="main-container">

<div id="page-content" class="clearfix">
						
  <div class="row-fluid">


	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="InteractionManage/InteractionEvaluateListPage.do" method="post" name="residenceForm" id="residenceForm">
			<table>
				<tr>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="searchName" value="${pd.searchName}" placeholder="这里输入关键词" />
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td>
					<c:if test="${QX.cha == 1 }">
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();" title="检索"><i id="nav-search-icon" class="icon-search"></i></button></td>
					<%-- <td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="window.location.href='<%=basePath%>/user/listtabUsers.do';" title="切换模式"><i id="nav-search-icon" class="icon-exchange"></i></a></td> --%>
					<!-- <td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="icon-download-alt"></i></a></td> -->
					<%-- <c:if test="${QX.edit == 1 }"><td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="fromExcel();" title="从EXCEL导入"><i id="nav-search-icon" class="icon-cloud-upload"></i></a></td></c:if> --%>
					</c:if> 
				</tr>
			</table>
			<!-- 检索  -->
			
			<a title="返回上一页" href="InteractionManage/InteractionListPage.do" class="btn btn-mini btn-info" onclick="" >返回上一页</a>
			
			<c:if test="${pd.InteractionContent != null}">
				<%-- <div id="jzgd"  style="height:100%; margin-top: 8px;">
					<div style="height:63px;">
						<span style="margin-top: 8px;" class=""><b>互动条目内容：</b></span> 
						${fn:substring(pd.InteractionContent eq null?'无':pd.InteractionContent,0,250)}
						<a onclick="jiazai();">加载更多...</a>
					</div>
				</div> --%>
				 <div style="margin-top:8px;  border: 1px solid ;">
					<span style="margin-top: 8px;" class=""><b>互动条目内容：</b></span> 
                     <%-- ${fn:substring(pd.InteractionContent, 0, 250)} --%>
                       ${fn:substring(pd.InteractionContent, 0, 250)}
		           <div id = "showdiv" style="display:none;">
                        <%-- ${fn:length(pd.InteractionContent)-250 :  } --%>
                        <c:if test="${fn:length(pd.InteractionContent)-250<=1000000000}">
                        		${fn:substring(pd.InteractionContent, 250, 1000000000)}
                        		<%-- ${fn:substring(fn:length(pd.InteractionContent)-250 le 250?'':pd.InteractionContent,200,10000)} --%>
                        </c:if>
		           </div>
		        </div>
		        <c:if test="${fn:length(pd.InteractionContent)>250 }">  
	           		<a style="" onclick="showHideCode()">加载更多...</a>
                </c:if>
				<%-- <div id="jzgds"  style="height:100%; overflow:auto; margin-top: 8px;">
					<div style="height:63px;">
						<span style="margin-top: 8px;" class=""><b>互动条目内容：</b></span> 
						${pd.InteractionContent }
						${fn:substring(pd.InteractionContent eq null?'无':pd.InteractionContent,0,250)}
						<a onclick="jiazai();">加载更多...</a>
					</div>
				</div> --%>
			</c:if>
			<table style="margin-top: 8px;" id="table_report" class="table table-striped table-bordered table-hover">
				
				<thead>
					<tr>
						<th class="center">
								<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
						</th>
						<th class="center">序号</th>
						<th class="center">评价党员</th>
						<th class="center">评价内容</th>
						<th class="center">评价时间</th>
						<th class="center">操作</th>
					</tr>
				</thead>
										
		<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty InteractionEvaluateList}">
						<c:if test="${QX.cha == 1 }">
						<c:forEach items="${InteractionEvaluateList}" var="rlist" varStatus="vs">
									
							<tr>
								<td class='center' style="width: 30px;">
									<label>
										<input type='checkbox' name='ids' value="${rlist.IFID }"/>
										<span class="lbl"></span>
									</label>
								</td>
								<td class='center' style="width: 30px;">${vs.index+1}</td>
								<td class='center' style="width: 10%;">${rlist.PMName}</td>
            					<td class='center'>
            						${rlist.IFContent }
									<%-- <a id="span_content" onclick="jianjies('${rlist.IFID }')" style="" onmousemove="showdiv('span_div','',event)" onmouseover="showdiv('span_div','',event)" onmouseout="showdiv('span_div','none',event)">
										<c:if test="${rlist.IFContent != null}">
											${fn:substring(rlist.IFContent eq null?'无':'查看内容',0,5)}...
										</c:if>
									</a> --%>
								</td>
								<td class='center' style="width: 12%;">
										<%-- <fmt:formatDate type="date" value="${rlist.InteractionTime}" /> --%>
										<%-- <fmt:formatDate type="both" dateStyle="long" timeStyle="long" value="${rlist.IFTime}" /> --%>
										<fmt:formatDate value="${rlist.IFTime}" type="both" pattern="yyyy-MM-dd HH:mm"/>
            					</td>
								<td class='center' style="width: 10%;">
									<%-- <a class='btn btn-mini btn-info' title="编辑" onclick="edits('${rlist.InteractionID }')" ><i class='icon-edit'></i></a> --%>
									<a class='btn btn-mini btn-danger' title="删除"  onclick="del('${rlist.IFID }','${rlist.InteractionID }',true)"><i class='icon-trash'></i></a>
								</td>
							</tr>
						
						</c:forEach>
						</c:if>
						
						<c:if test="${QX.cha == 0 }">
							<tr>
								<td colspan="14" class="center">您无权查看</td>
							</tr>
						</c:if>
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="14" class="center">没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>
				
				</tbody>
</table>
			
		<div class="page-header position-relative">
			<table style="width:100%;">
				<tr>
					<td style="vertical-align:top;">
						<c:if test="${QX.add != 1 }">
							<a class="btn btn-small btn-success" onclick="add();">新增</a>
							<a title="批量删除" class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" ><i class='icon-trash'></i>批量删除</a>
						</c:if>
					</td>
					<c:if test="${QX.cha == 1 }">
						<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
					</c:if>
				</tr>
			</table>
		</div>
		</form>
	</div>
 
 
 
 
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
	
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
		
		<!-- 返回顶部  -->
		<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
			<i class="icon-double-angle-up icon-only"></i>
		</a>
		
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		
		
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		<script type="text/javascript">
		
		$(top.hangge());
		
		//检索
		function search(){
			top.jzts();
			$("#residenceForm").submit();
		}
		
		
		//去发送电子邮件页面
		function sendEmail(EMAIL){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="发送电子邮件";
			 diag.URL = '<%=basePath%>head/goSendEmail.do?EMAIL='+EMAIL;
			 diag.Width = 660;
			 diag.Height = 470;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//去发送短信页面
		function sendSms(phone){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="发送短信";
			 diag.URL = '<%=basePath%>head/goSendSms.do?PHONE='+phone+'&msg=appuser';
			 diag.Width = 600;
			 diag.Height = 265;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>StudyManage/toAdd.do';
			 diag.Width = 600;
			 diag.Height = 300;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location.reload()",100);
					 }else{
						 nextPage('${page.currentPage}');
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		
			
		//修改
		function edit(tagID){
			 top.jzts();
		   	 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>InteractionManage/toEdit.do?InteractionID='+tagID;
			 diag.Width = 900;
			 diag.Height = 500;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					nextPage("${page.currentPage}");
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//查看评价内容
		function jianjies(id){
			 top.jzts();
		   	 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="查看内容";
			 diag.URL = '<%=basePath%>InteractionManage/kanjianjies.do?IFID='+id;
			 diag.Width =900;
			 diag.Height = 600;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					nextPage("${page.currentPage}");
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function del(tagID,InteractionID,msg){
			bootbox.confirm("确定要删除该条数据吗?", function(result) {
				if(result) {
					top.jzts();
					var url = '<%=basePath%>InteractionManage/deleteInteractionEvaluate.do?ids='+tagID;
					$.get(url,function(data){
						//nextPage("${page.currentPage}");
						window.location.href='InteractionManage/InteractionEvaluateListPage.do?InteractionID='+InteractionID;
					});
				}
			});
		}
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					var emstr = '';
					var phones = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
						  	if(str=='') str += document.getElementsByName('ids')[i].value;
						  	else str += ',' + document.getElementsByName('ids')[i].value;
						  	
						  	if(emstr=='') emstr += document.getElementsByName('ids')[i].id;
						  	else emstr += ';' + document.getElementsByName('ids')[i].id;
						  	
						  	if(phones=='') phones += document.getElementsByName('ids')[i].alt;
						  	else phones += ';' + document.getElementsByName('ids')[i].alt;
						  }
					}
					if(str==''){
						bootbox.dialog("您没有选择任何内容!", 
							[
							  {
								"label" : "关闭",
								"class" : "btn-small btn-success",
								"callback": function() {
									//Example.show("great success");
									}
								}
							 ]
						);
						
						$("#zcheckbox").tips({
							side:3,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:1
				        });
						
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							var url = "<%=basePath%>InteractionManage/deleteInteractionEvaluate.do?ids="+str;
							$.get(url,function(data){
								nextPage("${page.currentPage}");
							});
							$.ajax({
								type: "POST",
								url: '<%=basePath%>InteractionManage/deleteInteractionEvaluate.do',
						    	data: {ids:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											nextPage("${page.currentPage}");
									 });
								}
							});
						}else if(msg == '确定要给选中的用户发送邮件吗?'){
							sendEmail(emstr);
						}else if(msg == '确定要给选中的用户发送短信吗?'){
							sendSms(phones);
						}
						
						
					}
				}
			});
		}
		
		
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			//日期框
			$('.date-picker').datepicker();
			
			//下拉框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//复选框
			$('table th input:checkbox').on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});
					
			});
			
		});
		
		//导出excel
		function toExcel(){
			var USERNAME = $("#nav-search-input").val();
			var lastLoginStart = $("#lastLoginStart").val();
			var lastLoginEnd = $("#lastLoginEnd").val();
			var ROLE_ID = $("#role_id").val();
			window.location.href='<%=basePath%>user/excel.do?USERNAME='+USERNAME+'&lastLoginStart='+lastLoginStart+'&lastLoginEnd='+lastLoginEnd+'&ROLE_ID='+ROLE_ID;
		}
		
		//打开上传excel页面
		function fromExcel(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="EXCEL 导入到数据库";
			 diag.URL = '<%=basePath%>user/goUploadExcel.do';
			 diag.Width = 300;
			 diag.Height = 150;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location.reload()",100);
					 }else{
						 nextPage("${page.currentPage}");
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		$("#jzgds").hide();
		function jiazai(){
			
			//$("#jzgd").hide();
			$("#jzgds").show();
			
			
		}
		</script>
		<script type="text/javascript">
 
          function showHideCode(){
             $("#showdiv").toggle();
          }
</script>
	</body>
</html>

