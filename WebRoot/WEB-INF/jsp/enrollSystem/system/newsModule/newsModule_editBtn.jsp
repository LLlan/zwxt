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
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		<link rel="stylesheet" href="static/assets/css/font-awesome.css" />
		<!-- ace styles -->
		<link rel="stylesheet" href="static/assets/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />

		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<!--查看图片插件 -->
		<script type="text/javascript" src="static/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="static/js/ace-elements.min.js"></script>
		<script type="text/javascript" src="static/js/ace.min.js"></script>
		<!-- 确认窗口 -->
		<script type="text/javascript" src="static/js/bootbox.min.js"></script>
		
		<!-- 引入 -->
		<!--[if !IE]> -->
		<script type="text/javascript">
			window.jQuery || document.write("<script src='static/assets/js/jquery.js'>"+"<"+"/script>");
		</script>
		<script src="static/js/bootstrap.min.js"></script>
		<!-- ace scripts -->
		<script src="static/assets/js/ace/elements.fileinput.js"></script>
		<script src="static/assets/js/ace/ace.js"></script>
		<style>
			  .cbox{display:block;width:16px;height:16px;border:1px solid #ccc;background:#fff;}
			  .cbox.checked{background:#f00;}
			  .cbox.checked:after{content:""}
		</style>
	</head>
<body>
	<form action="newsModule/update.do" name="Form" id="Form" method="post">
	
		<input  type="hidden" name="FileTypeID" id="FileTypeID" value="${fileType.FileTypeID }" />
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
		<tr>
				<td>所属版块:</td>
				<td>
					
					<c:if test="${fileType.FileTypePathID==0 }">
						<input  type="hidden" name="FileTypePathID" id="FileTypePathID" value="" />
						<p>顶级板块</p>
					</c:if>
					<c:if test="${fileType.FileTypePathID!=0 }">
						<p>${fileType_parent.FileTypeName }</p>
						<input  type="hidden" name="FileTypePathID" id="FileTypePathID" value="${fileType_parent.FileTypeID }" />
					</c:if>
				</td>
			</tr>
			<tr>
				<td>版块名称:</td>
				<td>
					<input type="text" name="FileTypeName" id="FileTypeName" value="${fileType.FileTypeName }"/>
				</td>
			</tr>
			
			<input type="hidden"  name="FileTypeHot" id="FileTypeHot" value="${fileType.FileTypeHot}"/>
			
			<%-- <c:if test="${fileType.FileTypePathID==0 }"> --%>
					<tr>
						<td>是否热度:</td>
						<td>
							<c:if test="${fileType.FileTypeHot==true}">
								<span id="cbox" class="cbox checked" onclick="this.className=/checked/ig.test(this.className)?this.className.replace('checked',''):(this.className+' checked')"></span>
							</c:if>
							<c:if test="${fileType.FileTypeHot==false }">
								<span id="cbox" class="cbox" onclick="this.className=/checked/ig.test(this.className)?this.className.replace('checked',''):(this.className+' checked')"></span>
							</c:if>
						</td>
					</tr>	
			<%-- </c:if> --%>
				
			<tr>
				<td style="text-align: center;" colspan="2">
					<a class="btn btn-mini btn-primary" onclick="update();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
		</table>
		</div>
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
	</form>
<script type="text/javascript">

	$(top.hangge());
		$(function() {
			
	})
	
</script>
<script type="text/javascript">
	//保存
	function update(){
		
		//设置热度
		var classval=$("#cbox").attr("class")
		
		if(classval!=undefined){
			//选中热度
			if(classval=='cbox checked'){
				$("#FileTypeHot").val(1)
			}
			//取消热度
			if(classval.trim()=='cbox'){
				/* alert(classval) */
				$("#FileTypeHot").val(0)
			}
		}
		
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show(); 
	}
</script>
</body>
</html>