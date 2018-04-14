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
			if($("#POName").val()==""){
				
				$("#POName").tips({
					side:1,
		            msg:'请输入党组织机构名',
		            bg:'#AE81FF',
		            time:2
		        });
				
				$("#POName").focus();
				return false;
			}
			/* if($("#POPhone").val()==""){
				
				$("#POPhone").tips({
					side:1,
		            msg:'请输入机构联系电话',
		            bg:'#AE81FF',
		            time:2
		        });
				
				$("#POPhone").focus();
				return false;
			}
			if($("#POAddress").val()==""){
				
				$("#POAddress").tips({
					side:1,
		            msg:'请输入党组织机构地址',
		            bg:'#AE81FF',
		            time:2
		        });
				
				$("#POAddress").focus();
				return false;
			}
			if($("#POType").val()==""){
				
				$("#POType").tips({
					side:1,
		            msg:'请输入党组织机构类型',
		            bg:'#AE81FF',
		            time:2
		        });
				
				$("#POType").focus();
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
		<input type="hidden" name="parentId" id="parentId" value=""/>
		<input type="hidden" name="parentIds" id="parentIds" value=""/>
		<input type="hidden" name="POID" id="POID" value="${pd.POID }"/>
		<input type="hidden" name="POFatherID" id="POFatherID" value="${pd.POFatherID }"/>
		<div id="zhongxin">
		<table class="table table-striped table-bordered">
			<tr>
				<td>上级党组织机构名：</td>
				<td style="position:relative;">
					<p class="xuanze">
						上级党组织机构名
					</p>
					<ul class="xuanUl"  title="菜单">
							<li class="xxx" value="0">上级级党组织机构名</li>
							<c:forEach items="${menuList}" var="menu">
								<li value="${menu.POID }" onclick="yingcs('${menu.POID }');" class="hhh">${menu.POName }</li>
							</c:forEach>
					</ul>
				</td>	
			</tr>
			<tr id="hides4">
				<td>党组织机构名：</td>
				<td><input type="text" name="POName" id="POName" placeholder="输入党组织机构名" value="${pd.POName }" title="党组织机构名"/></td>
			</tr>
			<tr>
				<td>党组织机构联系电话：</td>
				<td><input type="text" name="POPhone" id="POPhone" placeholder="输入党组织机构联系电话" value="${pd.POPhone }" title="党组织机构联系电话"/></td>
			</tr>
			<tr>
				<td>党组织机构地址：</td>
				<td><input type="text" name="POAddress" id="POAddress" placeholder="输入党组织机构地址" value="${pd.POAddress }" title="党组织机构地址"/></td>
			</tr>
			<tr>
				<td>党组织机构类型：</td>
				<td><input type="text" name="POType" id="POType" placeholder="输入党组织机构类型" value="${pd.POType }" title="党组织机构类型"/></td>
			</tr>
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
function yingcs(id){
		$("#parentIds").val(id);
	}
</script>
</html>