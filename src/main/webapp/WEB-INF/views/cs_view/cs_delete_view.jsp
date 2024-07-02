<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>고객 문의 삭제</title>
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css">
<script src="./js/jquery.validate.min.js" type="text/javascript"></script>
<script src="./js/jquery-3.5.1.min.js" type="text/javascript"></script>
<script src="./js/bootstrap.min_4.5.0.js" type="text/javascript"></script>
<script type="text/javascript">
	function backpageAction() {
		var csNumber = document.getElementById('cs_number').value;
		window.location.href = './CSSelectDetail?cs_number=' + csNumber;
	}
</script>
</head>
<body>
	<header id="main-header" class="py-2 text-white">
		<div>
			<div class="container">
				<div class="row">
					<h1>samsamzo 고객 문의 삭제</h1>
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
							<h2>문의 삭제</h2>
						</div>
						<div class="card-body">
							<form action="./CSDelete" method="post" id="customer_inquiry_form">
								<fieldset>
									<div class="form-group row d-none">
										<label for="cs_number" class="ml-sm-3 col-form-label">문의 번호</label>
										<div class="col-sm-12">
											<input type="text" name="cs_number" id="cs_number" class="form-control" value="${csDTO.csNumber}" readonly>
										</div>
									</div>
									<div class="form-group row">
										<label for="csTitle" class="ml-sm-3 col-form-label">문의 제목</label>
										<div class="col-sm-12">
											<input type="text" name="csTitle" id="csTitle" class="form-control" value="${csDTO.csTitle}" readonly>
										</div>
									</div>
									<div class="form-group row d-none">
										<label for="csDate" class="ml-sm-3 col-form-label">문의 일자</label>
										<div class="col-sm-12">
											<input type="date" name="csDate" id="csDate" class="form-control" value="${csDTO.csDate.substring(0,10)}" readonly>
										</div>
									</div>
									<div class="form-group row">
										<label for="csContent" class="ml-sm-3 col-form-label">문의 내용</label>
										<div class="col-sm-12">
											<textarea name="csContent" id="csContent" rows="5" class="form-control" readonly>${csDTO.csContent}</textarea>
										</div>
									</div>
									<div class="form-group row">
										<div class="col-sm-12">
											<button type="submit" class="btn btn-success">문의 삭제</button>
											<button type="button" class="btn btn-secondary" onclick="backpageAction()">취소</button>
										</div>
									</div>
								</fieldset>
							</form>
						</div>
						<div class="card-footer">
							<a href="./CSSelect" class="btn btn-success btn-block">문의 목록</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>