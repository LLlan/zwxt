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
		
		<meta charset="utf-8" />
		<title>菜单</title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<!--提示框-->
		<style>
			*{
				margin:0;
				padding:0;
			}
			.xuanze{
				width: 206px;
			    height: 28px;
			    line-height: 28px;
			    border: 1px solid #d5d5d5;
			    padding: 0 5px;
			}
			.xuanUl{
				list-style: none;
				width: 206px;
				height: 130px;
    			overflow: auto;
				border: 1px solid #d5d5d5;
			    padding: 0 5px;
				position:absolute;
				top:38px;
				left:8px;
				border-top:none;
				display: none;
				background-color: #fff;
			    z-index: 898;
			}
			.xuanUl>li{
				height:26px;
				line-height: 26px;
			}
			ul, ol {
			    padding: 0;
			    margin:0;
			}
		</style>
		<script>
		$(function(){
			$(".xuanze").click(function(){
				if($(this).hasClass("kai")){
					$(this).removeClass("kai");
					$(".xuanUl").css("display","none");
				}else{
					$(this).addClass("kai");
					$(".xuanUl").css("display","block");
					$(".xxx").click(function(){
						$(".xuanze").text($(this).text());
						$("#hides").show();
						$(".xuanUl").css("display","none");
						$(".xuanze").removeClass("kai");
						$("#parentIds").val("");
					});
					$(".hhh").click(function(){
						$(".xuanze").text($(this).text());
						$("#hides").hide();
						$(".xuanUl").css("display","none");
						$(".xuanze").removeClass("kai");
						console.log($(".hhh").val());
						$("#parentIds").val($(".hhh").val());
					})
				}
			})
		})
	</script>
</head>

<script type="text/javascript">
	$(top.hangge());
	$(document).ready(function(){		
		if($("#menuId").val()!=""){
			var parentId = "${menu.parentId}";
			if(parentId==""){
				$("#parentId").attr("disabled",true);
			}else{
				$("#parentId").val(parentId);
			}
		}
		setMUR();
	}); 

	function setMUR(){
		if($("#parentId").val()=="0"){
			$("#menuUrl").attr("readonly",true);
			$("#menuUrl").val("");
			$("#form-field-radio1").attr("disabled",false);
			$("#form-field-radio2").attr("disabled",false);
		}else{
			$("#menuUrl").attr("readonly",false);
			$("#form-field-radio1").attr("disabled",true);
			$("#form-field-radio2").attr("disabled",true);
			$("#form-field-radio1").attr("checked",false);
			$("#form-field-radio2").attr("checked",false);
		}
	}

	//保存
	function save(){
		/* if($("#parentId").val()==""){
				
				$("#parentId").tips({
					side:3,
		            msg:'请输入菜单名称',
		            bg:'#AE81FF',
		            time:2
		        });
				
				$("#parentId").focus();
				return false;
			} */
			/* if($("#menuUrl").val()==""){
				$("#menuUrl").val('#');
			} */
		/* 	if($("#PBLProvinceName").val()==""){
				
				$("#PBLProvinceName").tips({
					side:1,
		            msg:'请输入所在省份名',
		            bg:'#AE81FF',
		            time:2
		        });
				
				$("#PBLProvinceName").focus();
				return false;
			} */
			/*
			if(isNaN(Number($("#menuOrder").val()))){
				
				$("#menuOrder").tips({
					side:1,
		            msg:'请输入菜单序号',
		            bg:'#AE81FF',
		            time:2
		        });
				
				$("#menuOrder").focus();
				$("#menuOrder").val(1);
				return false;
			} */
			 
			$("#menuForm").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
	function setType(value){
		$("#MENU_TYPE").val(value);
	}
	
</script>
<body>
	<form  action="PartyOrgan/${msg }.do" name="menuForm" id="menuForm" method="post" >
		<input type="hidden" name="POID" id="POID" value="${pd.POID }"/>
		<input type="hidden" name="POFatherID" id="POFatherID" value="${pd.POFatherID }"/>
		<div id="zhongxin">
		<table class="table table-striped table-bordered">
			<%-- <tr>
				<td>顶级省份：</td>
				<td style="position:relative;">
					<p class="xuanze">
						顶级省份
					</p>
					<ul class="xuanUl"  title="菜单">
							<li class="xxx" value="0">顶级省份</li>
							<c:forEach items="${menuList}" var="menu">
								<li value="${menu.PBLProvinceID }" class="hhh">${menu.PBLProvinceName }</li>
							</c:forEach>
					</ul>
				</td>	
			</tr> --%>
			<c:if test="${msg =='updatePBLProvince'}">
				<tr>
					<td>党建网所在省份名：</td>
					<td><input type="text" name="PBLProvinceName" id="PBLProvinceName" placeholder="输入党建网所在省份名" value="${pd.PBLProvinceName }" title="党建网所在省份名"/></td>
				</tr>
			</c:if>
			<c:if test="${msg =='updatePBLCity'}">
				<tr>
					<td>党建网所在城市名：</td>
					<td><input type="text" name="PBLCityName" id="PBLCityName" placeholder="输入党建网所在城市名" value="${pd.PBLCityName }" title="党建网所在城市名"/></td>
				</tr>
				<tr>
					<td>党建网名称：</td>
					<td><input type="text" name="PBANetName" id="PBANetName" placeholder="输入党建网名称" value="${pd.PBANetName }" title="党建网名称"/></td>
				</tr>
				<tr>
					<td>党建联盟党建网链接URL：</td>
					<td><input type="text" name="PBANetURL" id="PBANetURL" placeholder="输入党建联盟党建网链接URL" value="${pd.PBANetURL }" title="党建联盟党建网链接URL"/></td>
				</tr>
			</c:if>
			<!-- <tr>
				<td><input type="text" name="MENU_URL" id="menuUrl" placeholder="这里输入链接地址" value="" title="地址"/></td>
			</tr> -->
			<!-- <tr>
				<td><input type="number" name="MENU_ORDER" id="menuOrder" placeholder="这里输入序号" value="" title="序号"/></td>
			</tr> -->
			<!-- <tr>
				<td style="text-align: center;" colspan="2">
					<label style="float:left;padding-left: 32px;"><input name="form-field-radio" id="form-field-radio1" onclick="setType('1');" type="radio" value="icon-edit"><span class="lbl">系统菜单</span></label>
					<label style="float:left;padding-left: 5px;"><input name="form-field-radio" id="form-field-radio2" onclick="setType('2');" type="radio" value="icon-edit"><span class="lbl">业务菜单</span></label>
				</td>
			</tr> -->
			<tr>
				<td style="text-align: center; padding-top: 10px;" colspan="2">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
		</table>
		</div>
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"></h4></div>
	</form>
</body>
<script type="text/javascript">
function yingcs(){
		alert("asd");
		//$(".hides").hide();
	}
</script>
</html>