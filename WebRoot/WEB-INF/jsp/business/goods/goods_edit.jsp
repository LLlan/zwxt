<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
		<!-- jsp文件头和头部 -->
		<%@ include file="../../system/admin/top.jsp"%>
		<meta charset="utf-8" />
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<!-- 下拉框 -->
		<link rel="stylesheet" href="static/css/chosen.css" />
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript" src="static/js/common/jsAddress.js"></script>  
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		
		<!-- 百度在线编辑器 -->
		<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
	    <script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.min.js"></script>
	    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
	    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
	    <script type="text/javascript" charset="utf-8" src="plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
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
</script>
<script type="text/javascript">
		$(top.hangge());
		$(document).ready(function(){
		});
	
		//保存
		function save(){
			
			if($("#AVTID").val()==""){
				$("#AVTID").tips({
					side:3,
		            msg:'请选择评优投票类型',
		            bg:'#AE81FF',
		            time:2
		        });
				return;
			}
			if($("#ATName").val()==""){
				$("#ATName").tips({
					side:3,
		            msg:'请输入投票题目标题名',
		            bg:'#AE81FF',
		            time:2
		        });
				return;
			}
			
			if($("#ATBegTime").val()==""){
				$("#ATBegTime").tips({
					side:3,
		            msg:'请选择投票开始时间',
		            bg:'#AE81FF',
		            time:2
		        });
				return;
			}
			
			if($("#ATEndTime").val()==""){
				$("#ATEndTime").tips({
					side:3,
		            msg:'请选择投票结束时间',
		            bg:'#AE81FF',
		            time:2
		        });
				return;
			}
			
			$("#residenceForm").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
	
	
	
	//验证邮箱格式
	function ismail(mail){
		return(new RegExp(/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/).test(mail));
		}
	
	//验证身份证号码格式
	function isIDCard(IDCard){
		return(new RegExp(/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/).test(IDCard));
	}; 	
	
	 //判断用户名是否存在
	 function hasU(){
		var USERNAME = $("#loginname").val();
		var url = "<%=basePath%>user/hasU.do?USERNAME="+USERNAME+"&tm="+new Date().getTime();
		$.get(url,function(data){
			if(data=="error"){
				$("#loginname").css("background-color","#D16E6C");
				setTimeout("$('#loginname').val('此用户名已存在!')",500);
			}else{
				$("#userForm").submit();
				$("#zhongxin").hide();
				$("#zhongxin2").show();
			}
		});
	} 
	
	//判断邮箱是否存在
	function hasE(USERNAME){
		var EMAIL = $("#EMAIL").val();
		var url = "<%=basePath%>user/hasE.do?EMAIL="+EMAIL+"&USERNAME="+USERNAME+"&tm="+new Date().getTime();
		$.get(url,function(data){
			if(data=="error"){
				
				$("#EMAIL").tips({
					side:3,
		            msg:'邮箱已存在',
		            bg:'#AE81FF',
		            time:3
		        });
				
				setTimeout("$('#EMAIL').val('')",2000);
				
			}
		});
	}
	
	//判断编码是否存在
	function hasN(USERNAME){
		var NUMBER = $("#NUMBER").val();
		var url = "<%=basePath%>user/hasN.do?NUMBER="+NUMBER+"&USERNAME="+USERNAME+"&tm="+new Date().getTime();
		$.get(url,function(data){
			if(data=="error"){
				
				$("#NUMBER").tips({
					side:3,
		            msg:'编号已存在',
		            bg:'#AE81FF',
		            time:3
		        });
				
				setTimeout("$('#NUMBER').val('')",2000);
				
			}
		});
	}
	
</script>
<style type="text/css">
	.P-C-AClass{
		width: 100px;
	}
	.P-C-AClass2{
		width: 150px;
	}
	.P-C-AClass3{
		width: 170px;
	}
	.inputClass{
		width: 290px;
	}
	.table tr td input{
		width: 420px;
	}
</style>
	</head>
<body>
	<form action="report/${msg }.do" id="residenceForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="ATID" id="ATID" value="${pd.ATID}"/>
		<input type="hidden" name="AVTIDs" id="AVTIDs" value="${pd.AVTID}"/>
		<div id="zhongxin">
		<table class="  center table table-striped table-bordered">
			<c:if test="${msg =='saveGoods' }">
				<tr>
					<td>评优投票类型:</td>
					<td>
						<select name="AVTID" id="AVTID">
							<option value="">请选择评优投票类型</option>
							<c:forEach items="${AppraisingVotingTypeList }" var="va">
								<option value="${va.AVTID }" <c:if test="${pd.AVTID == va.AVTID }">selected</c:if> >${va.AVTName }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
			</c:if>
			<c:if test="${msg !='saveGoods' }">
				<tr>
					<td>评优投票类型:</td>
					<td>
						<select name="AVTIDs" id="AVTIDs" disabled="disabled">
							<option value="">请选择评优投票类型</option>
							<c:forEach items="${AppraisingVotingTypeList }" var="va">
								<option value="${va.AVTID }" <c:if test="${pd.AVTID == va.AVTID }">selected</c:if> >${va.AVTName }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
			</c:if>
			<tr>
				<td width="110px;">投票题目标题名：</td>
				<td>
					<input type="text" name="ATName" id="ATName" value="${pd.ATName }"  class="inputClass" placeholder="请输入投票题目标题名" title=""/>
				</td>
			</tr>
			<tr>
				<td>是否热度：</td>
				<td>
				     <select name="Hot" id="Hot" title="热度">
				     	<option value="">是否热度</option>
						<option value="1" <c:if test="${pd.Hot == 'true' }">selected</c:if> >是</option>
						<option value="0" <c:if test="${pd.Hot == 'false' }">selected</c:if> >否</option>
					</select>          
				</td>
			</tr>
		 	<tr>
				<td>投票开始时间：</td>
				<td>
					<input class="span10 date-picker"  data-date-format="yyyy-mm-dd" readonly="readonly" style="width:100px;" type="text" name="ATBegTime" id="ATBegTime" value="${ATBegTime }"  class="inputClass" placeholder="投票开始时间" title="投票开始时间"/>
				</td>
			</tr> 
			<tr>
				<td>投票开始时间：</td>
				<td>
				     <input class="span10 date-picker"  data-date-format="yyyy-mm-dd" readonly="readonly" style="width:100px;" type="text" name="ATEndTime" id="ATEndTime" value="${ATEndTime }"  class="inputClass" placeholder="投票结束时间" title="投票结束时间"/>             
				</td>
			</tr>
			<tr>
				<td>可以供投票的投票选项个数：</td>
				<td>
				     <input type="text" name="ATOptionNum" id="ATOptionNum" value="${pd.ATOptionNum }"  class="inputClass" placeholder="请输入投票选项个数" title=""/>             
				</td>
			</tr>
			<tr>
				<td>评优题目图像存储路径:</td>
				<td>
					<c:if test="${pd == null || pd.ATPhoto == '' || pd.ATPhoto == null }">
						<input type="file" id="tp" name="file" onchange="fileType(this)"/>
					</c:if>
					<c:if test="${pd != null && pd.ATPhoto != '' && pd.ATPhoto != null }">
						<a href="${pd.ATPhoto}" target="_blank">
							<img style="width:50px;" src="${pd.ATPhoto}"/>
						</a>
						<%-- <input type="button" class="btn btn-mini btn-danger" value="删除" onclick="delP('${pd.PhotoPath}','${pd.PhotoID }');" /> --%>
						<input type="file" id="tp" name="file" value="${pd.ATPhoto }" onchange="fileType(this)"/>
						<input type="hidden" name="ATPhoto" id="tpz" value="${pd.ATPhoto }"/>
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="2">评优题目简介:</td>
			</tr>
			<tr>
				<td colspan="2" style="height: 100px;">
					<textarea id="editor" name="ATIntroduction" style="height:400px;width: 865px;">${pd.ATIntroduction==null?"":pd.ATIntroduction }</textarea>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;" colspan="2">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
		</table>
		</div>
		
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"></h4></div>
		
	</form>
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<script src="static/js/chosen.jquery.min.js" type="text/javascript"></script><!-- 下拉框 -->
		
		<script type="text/javascript">
			//实例化编辑器
			//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
			var ue = UE.getEditor('editor');
		</script>
</body>
</html>