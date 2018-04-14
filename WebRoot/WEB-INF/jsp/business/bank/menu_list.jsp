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
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>

<script type="text/javascript">
	$(top.hangge());	
	
	//新增
	function addmenu(){
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="新增菜单";
		 diag.URL = '<%=basePath%>bank/toAdd.do';
		 diag.Width = 500;
		 diag.Height = 400;
		 diag.CancelEvent = function(){ //关闭事件
			if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				top.jzts(); 
				setTimeout("location.reload()",100);
			}
			diag.close();
		 };
		 diag.show();
	}
	
	//修改
	function editmenu(menuId){
		 top.jzts();
	   	 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="编辑";
		 diag.URL = '<%=basePath%>bank/toEdit.do?PBLCityID='+menuId;
		 diag.Width = 450;
		 diag.Height = 300;
		 diag.CancelEvent = function(){ //关闭事件
			if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				top.jzts(); 
				setTimeout("location.reload()",100);
			}
			diag.close();
		 };
		 diag.show();
	}
	
	//编辑顶部菜单图标
	function editTb(menuId){
		 top.jzts();
	   	 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="编辑顶级省份名";
		 diag.URL = '<%=basePath%>bank/toEditicon.do?MENU_ID='+menuId;
		 diag.Width = 400;
		 diag.Height = 180;
		 diag.CancelEvent = function(){ //关闭事件
			if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				top.jzts(); 
				setTimeout("location.reload()",100);
			}
			diag.close();
		 };
		 diag.show();
	}
	
	function delmenu(menuId,isParent){
		var flag = false;
		if(isParent){
			if(confirm("确定要删除该菜单吗？其下子菜单将一并删除！")){
				flag = true;
			}
		}else{
			if(confirm("确定要删除该菜单吗？")){
				flag = true;
			}
		}
		if(flag){
			top.jzts();
			var url = "<%=basePath%>bank/delPBLProvince.do?MENU_ID="+menuId+"&guid="+new Date().getTime();
			$.get(url,function(data){
				top.jzts();
				document.location.reload();
			});
		}
	}
	
	function delmenus(menuId,isParent){
		var flag = false;
		if(isParent){
			if(confirm("确定要删除该菜单吗？其下子菜单将一并删除！")){
				flag = true;
			}
		}else{
			if(confirm("确定要删除该菜单吗？")){
				flag = true;
			}
		}
		if(flag){
			top.jzts();
			var url = "<%=basePath%>bank/delPBLCity.do?PBLCityID="+menuId+"&guid="+new Date().getTime();
			$.get(url,function(data){
				top.jzts();
				document.location.reload();
			});
		}
	}
	
	function openClose(menuId,curObj,trIndex){
		var txt = $(curObj).text();
		if(txt=="展开"){
			$(curObj).text("折叠");
			$("#tr"+menuId).after("<tr id='tempTr"+menuId+"'><td colspan='5'>数据载入中</td></tr>");
			if(trIndex%2==0){
				$("#tempTr"+menuId).addClass("main_table_even");
			}
			var url = "<%=basePath%>bank/subs.do?MENU_ID="+menuId+"&guid="+new Date().getTime();
			$.get(url,function(data){
				if(data.length>0){
					var html = "";
					$.each(data,function(i){
						html = "<tr style='height:24px;line-height:24px;' name='subTr"+menuId+"'>";
						html += "<td></td>";
						html += "<td><span style='width:80px;display:inline-block;'></span>";
						if(i==data.length-1)
							html += "<img src='static/images/joinbottom.gif' style='vertical-align: middle;'/>";
						else
							html += "<img src='static/images/join.gif' style='vertical-align: middle;'/>";
						html += "<span style='width:100px;text-align:left;display:inline-block;'>"+this.PBLCityName+"</span>";
						html += "</td>";
						html += "<td>"+this.PBANetName+"</td>";
						html += "<td class='center'>"+this.PBANetURL+"</td>";
						html += "<td><a class='btn btn-mini btn-info' title='编辑' onclick='editmenu(\""+this.PBLCityID+"\")'><i class='icon-edit'></i></a> <a class='btn btn-mini btn-danger' title='删除' onclick='delmenus(\""+this.PBLCityID+"\",false)'><i class='icon-trash'></i></a></td>";
						html += "</tr>";
						$("#tempTr"+menuId).before(html);
					});
					$("#tempTr"+menuId).remove();
					if(trIndex%2==0){
						$("tr[name='subTr"+menuId+"']").addClass("main_table_even");
					}
				}else{
					$("#tempTr"+menuId+" > td").html("没有相关数据");
				}
			},"json");
		}else{
			$("#tempTr"+menuId).remove();
			$("tr[name='subTr"+menuId+"']").remove();
			$(curObj).text("展开");
		}
	}
</script>
</head>

<body>
	<table id="table_report" class="table table-striped table-bordered table-hover">
		<thead>
		<tr>
			<th class="center"  style="width: 50px;">序号</th>
			<th class='center'>党建网所在省份名</th>
			<th class='center'>党建网名称</th>
			<th class='center'>党建联盟党建网链接URL</th>
			<th class='center'>操作</th>
		</tr>
		</thead>
		<c:choose>
			<c:when test="${not empty menuList}">
			<c:if test="${QX.cha == 1 }">
				<c:forEach items="${menuList}" var="menu" varStatus="vs">
				<tr id="tr${menu.PBLProvinceID }">
				<td class="center">${vs.index+1}</td>
				<td class='center'>
					<%-- <i class="${menu.MENU_ICON }">&nbsp;</i>${menu.MENU_NAME }&nbsp; --%>
					${menu.PBLProvinceName }
					<%-- <c:if test="${menu.MENU_TYPE == '1' }">
					<span class="label label-success arrowed">系统</span>
					</c:if>
					<c:if test="${menu.MENU_TYPE != '1' }">
					<span class="label label-important arrowed-in">业务</span>
					</c:if> --%>
				</td>
				<td>${menu.PBANetURL == '#'? '': menu.PBANetURL}</td>
				<td class='center'></td>
				<td class='center' style="width: 25%;">
					<a class='btn btn-mini btn-warning' onclick="openClose('${menu.PBLProvinceID }',this,${vs.index })" >展开</a>
					<%-- <a class='btn btn-mini btn-purple' title="图标" onclick="editTb('${menu.PBLProvinceID }')" ><i class='icon-picture'></i></a> --%>
					<a class='btn btn-mini btn-info' title="编辑" onclick="editTb('${menu.PBLProvinceID }')" ><i class='icon-edit'></i></a>
					<a class='btn btn-mini btn-danger' title="删除"  onclick="delmenu('${menu.PBLProvinceID }',true)"><i class='icon-trash'></i></a>
				</td>
				</tr>
				</c:forEach>
				</c:if>
				<c:if test="${QX.cha == 0 }">
					<tr>
						<td colspan="100" class="center">您无权查看</td>
					</tr>
				</c:if>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="100" class="center">没有相关数据</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
	
	<div class="page_and_btn">
		<div>
			<c:if test="${QX.add == 1 }">
				&nbsp;&nbsp;<a class="btn btn-small btn-success" onclick="addmenu();">新增</a>
			</c:if>
			<c:if test="${QX.cha == 1 }">
				<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
			</c:if>	
		</div>
	</div>
	
</body>
</html>