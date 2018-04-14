<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

		 <select name="FileType" id="FileType" >
						<c:forEach items="${ChildListOption }" var="va">
							<option value="${va.FileTypeID }">${va.FileTypeName }</option>
						</c:forEach>
		 </select>	
