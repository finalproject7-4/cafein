<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<!-- SweetAlert 추가 -->
<script src="
https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js
"></script>
<!-- SweetAlert 추가 -->
<div class="toast-container position-fixed bottom-0 end-0 p-3" style="position: relative; z-index: 9999;">
  <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
      <img src="../resources/img/bean.ico" style="width: 15px; height: 15px;">
      <strong class="me-auto">&nbsp;Cafein</strong>
      <small></small>
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body">
    	재고 <b>${productToast.stockid }</b>번의 <b>${productToast.itemname }</b>이(가) <b style="color: red;">${productToast.stockquantity }</b>개 남았습니다.
    </div>
  </div>
</div>

<script>
var toastEl = document.querySelector('#liveToast');

//토스트 인스턴스 생성
var toast = new bootstrap.Toast(toastEl);

// 토스트 표시
toast.show();
</script>