<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>고객 문의</title>
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css">
<script src="./js/jquery-3.5.1.min.js" type="text/javascript"></script>
<script src="./js/bootstrap.min_4.5.0.js" type="text/javascript"></script>
<style>
.pagination-center {
	display: flex;
	justify-content: center;
}
</style>
</head>
<body>
	<header id="main-header" class="py-2 text-white">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<h1>samsamzo 고객 문의</h1>
				</div>
			</div>
		</div>
	</header>
	<section class="py-4 mb-4 bg-light"></section>
	<section id="department">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="card">
						<div class="card-header">
							<h2>문의 목록</h2>
						</div>
						<div class="card-body">
							<!-- 검색 폼 추가 -->
							<form action="./CSSelect" method="get" class="form-inline justify-content-center mb-4">
								<div class="form-group">
									<label for="searchContent" class="sr-only">검색 기준</label> <select class="form-control mr-2" id="searchContent" name="searchContent">
										<option value="title" ${param.searchContent == 'title' ? 'selected' : ''}>제목</option>
										<option value="content" ${param.searchContent == 'content' ? 'selected' : ''}>내용</option>
									</select> <input type="text" class="form-control mr-2" id="searchKeyword" name="searchKeyword" placeholder="검색어를 입력하세요" value="${param.searchKeyword}">
								</div>
								<button type="submit" class="btn btn-primary">검색</button>
							</form>

							<table class="table table-hover">
								<thead class="thead-light">
									<tr class="text-center">
										<th>문의 번호</th>
										<th>문의 제목</th>
										<th>문의 일자</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="item" items="${list.content}">
										<tr class="text-center">
											<td>${item.csNumber}</td>
											<td>${item.csTitle}</td>
											<td>${item.csDate.substring(0, 10)}</td>
											<td><a href="./CSSelectDetail?cs_number=${item.csNumber}" class="btn btn-outline-info">문의 상세 보기</a></td>
										</tr>
									</c:forEach>
									<c:if test="${empty list.content}">
										<tr>
											<td colspan="4">검색 결과가 없습니다.</td>
										</tr>
									</c:if>
								</tbody>
							</table>
							<div class="container">
								<div class="row justify-content-center">
									<div class="col-md-12 text-center">
										<ul class="pagination pagination-center">
											<li class="page-item ${hasPrevious ? '' : 'disabled'}"><c:choose>
													<c:when test="${hasPrevious}">
														<a class="page-link" href="./CSSelect?page=${previousPage}&amp;searchContent=${param.searchContent}&amp;searchKeyword=${param.searchKeyword}" aria-label="Previous"><span>이전</span></a>
													</c:when>
													<c:otherwise>
														<span class="page-link">이전</span>
													</c:otherwise>
												</c:choose></li>
											<c:forEach begin="${startPage}" end="${endPage}" var="i">
												<c:choose>
													<c:when test="${nowPage eq i}">
														<li class="page-item active"><span class="page-link">${i}</span></li>
													</c:when>
													<c:otherwise>
														<li class="page-item"><a class="page-link" href="./CSSelect?page=${i}&amp;searchContent=${param.searchContent}&amp;searchKeyword=${param.searchKeyword}">${i}</a></li>
													</c:otherwise>
												</c:choose>
											</c:forEach>
											<li class="page-item ${hasNext ? '' : 'disabled'}"><c:choose>
													<c:when test="${hasNext}">
														<a class="page-link" href="./CSSelect?page=${nextPage}&amp;searchContent=${param.searchContent}&amp;searchKeyword=${param.searchKeyword}" aria-label="Next"><span>다음</span></a>
													</c:when>
													<c:otherwise>
														<span class="page-link">다음</span>
													</c:otherwise>
												</c:choose></li>
										</ul>
									</div>
								</div>
							</div>
							<div class="container mt-4">
								<div class="row">
									<div class="col-md-12 text-center">
										<a href="./CSInsert" class="btn btn-success btn-block">문의 입력</a>
										<c:if test="${not empty param.searchKeyword}">
											<a href="./CSSelect" class="btn btn-info btn-block">문의 목록</a>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>