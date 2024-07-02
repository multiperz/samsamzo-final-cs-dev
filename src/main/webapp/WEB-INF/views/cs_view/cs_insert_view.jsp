<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>고객 문의 등록</title>
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css">
<script src="./js/jquery.validate.min.js" type="text/javascript"></script>
<script src="./js/jquery-3.5.1.min.js" type="text/javascript"></script>
<script src="./js/bootstrap.min_4.5.0.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var today = new Date().toISOString().substr(0, 10);
		$('#csDate').val(today).attr('readonly', true);
	});

	function cancelForm() {
		var currentDate = $('#csDate').val();
		$('#customer_inquiry_form').get(0).reset();
		$('#csDate').val(currentDate);
	}

	function validateForm() {
		var title = $('#csTitle').val().trim();
		var content = $('#csContent').val().trim();

		if (title === '') {
			alert('문의 제목을 입력하세요.');
			$('#csTitle').focus();
			return false;
		}

		if (content === '') {
			alert('문의 내용을 입력하세요.');
			$('#csContent').focus();
			return false;
		}

		return true;
	}
</script>
<style>
.hidden-field {
	display: none;
}
</style>
</head>
<body>
	<header id="main-header" class="py-2 text-white">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<h1>samsamzo 고객 문의 등록</h1>
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
							<h2>문의 등록</h2>
						</div>
						<div class="card-body">
							<form action="./CSInsert" method="post" id="customer_inquiry_form" onsubmit="return validateForm()">
								<fieldset>
									<div class="form-group row">
										<label for="csTitle" class="ml-sm-3 col-form-label">문의 제목</label>
										<div class="col-sm-12">
											<input type="text" name="csTitle" id="csTitle" class="form-control">
										</div>
									</div>
									<div class="form-group row hidden-field">
										<label for="csDate" class="ml-sm-3 col-form-label">문의 일자</label>
										<div class="col-sm-12">
											<input type="date" name="csDate" id="csDate" class="form-control" readonly>
										</div>
									</div>
									<div class="form-group row">
										<label for="csContent" class="ml-sm-3 col-form-label">문의 내용</label>
										<div class="col-sm-12">
											<textarea name="csContent" id="csContent" rows="5" class="form-control"></textarea>
										</div>
									</div>
									<div class="form-group row">
										<div class="col-sm-12">
											<button type="submit" class="btn btn-success">문의 등록</button>
											<button type="button" class="btn btn-secondary" onclick="cancelForm()">취소</button>
										</div>
									</div>
								</fieldset>
							</form>
							<div class="card-footer">
								<a href="./CSSelect" class="btn btn-success btn-block">문의 목록</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>