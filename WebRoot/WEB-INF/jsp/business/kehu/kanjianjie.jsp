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
			if($("#POID").val()==""){
				$("#POID").tips({
					side:3,
		            msg:'请选择所属党组织机构',
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
	<form action="kehu/${msg }.do" id="residenceForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="PMID" id="PMID" value="${pd.PMID}"/>
		<div id="zhongxin">
		<table class="table table-striped table-bordered">
			<tr>
				<b style="text-align: center;"><h3>党员简介内容</h3></b>
				<%-- <td style="text-align: center;"><img style="width: 50px;height: 50px;" alt="" src="${pd.PMPhoto }"></td> --%>
			</tr>
			
			<tr>
				<td>
				<span>${pd.PMIntroduction }</span>
					<!-- <a class="btn btn-mini btn-primary" onclick="save();">保存</a> -->
					<a style="text-align: center; margin-left: 87%; margin-top: 50%;" class="btn btn-mini btn-danger" onclick="top.Dialog.close();">返回</a>
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
</body>
</html>