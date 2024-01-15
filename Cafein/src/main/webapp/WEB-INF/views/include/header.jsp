<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="UTF-8">

<head>
    <meta charset="utf-8">
    <title>Cafe In</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
    
    
    
    <!-- 적용된 배경색: #FBF8EF, a태그 활성화 색상: #610B0B -->
    
    <!-- 별도로 추가한 부분: 부트스트랩, 달력 작동위한 추가. 제이쿼리, 스타일시트 -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- 	<script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
	
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
	
	
   
  	<!-- 아이콘 -->
<!-- 	<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script> -->

	
    <!-- Favicon -->
    <link href="../resources/img/bean.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;700&display=swap">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="../resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="../resources/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="../resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="../resources/css/style.css" rel="stylesheet">
    <link href="../resources/css/Modal.css" rel="stylesheet">
</head>

<body>
    <div class="container-fluid position-relative bg-white d-flex p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->


        <!-- Sidebar Start -->
        <div class="sidebar pe-4 pb-3" style="background-color: #FBF8EF;">
            <nav class="navbar bg-light navbar-light">
                <a href="/main/main" style="margin-top: -45px;">
                    <img width="194px" height="160px" src="../resources/img/cafein.png" alt="cafein_logo"
                    style="margin-top: 30px;margin-left:15px;scale: 1.3;">
                </a>
                <div class="navbar-nav w-100">
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class='fas fa-info-circle' style='font-size:24px; '></i><b> 기준정보관리</b></a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="/information/items" class="dropdown-item">품목관리</a>
                            <a href="/information/clients" class="dropdown-item">거래처관리</a>
                            <a href="/information/members" class="dropdown-item">사원관리</a>
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class='fas fa-leaf' style='font-size:24px'></i><b> 생산관리</b></a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="/production/produceList" class="dropdown-item">생산목록</a>
                            <a href="/production/roastedList" class="dropdown-item">완제품</a>
                            <a href="/production/WKList" class="dropdown-item">작업지시관리</a>
                        </div>
                    </div>
                 
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class='fas fa-sitemap' style='font-size:24px'></i><b> 자재관리</b></a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="/material/stock" class="dropdown-item">재고현황</a>
                            <a href="/material/orders" class="dropdown-item">발주관리</a>
                            <a href="/material/receive" class="dropdown-item">입고관리</a>
                            <a href="/material/releases" class="dropdown-item">출고관리</a>
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class='fas fa-tools' style='font-size:24px'></i><b> 품질관리</b></a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="/quality/qualities" class="dropdown-item">품질관리</a>
                            <a href="/quality/returns" class="dropdown-item">반품관리</a>
               
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class='fas fa-poll' style='font-size:24px'></i><b> 영업관리</b></a>
                        <div class="dropdown-menu bg-transparent border-0"> 
                            <a href="/sales/POList" class="dropdown-item">수주관리</a>
                            <a href="/sales/SHList" class="dropdown-item">출하관리</a>
                            <a href="/sales/PFList" class="dropdown-item">실적관리</a>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
        <!-- Sidebar End -->
   
        <!-- Content Start -->
        <div class="content">
        
         <!-- Navbar Start -->
         <nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
               <a href="#" class="sidebar-toggler flex-shrink-0">
                    <i class="fa fa-bars" style="color:#610B0B;"></i>
                </a>
                <div class="navbar-nav align-items-center ms-auto">
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                            <img class="rounded-circle me-lg-2" src="../resources/img/user.png" alt="" style="width: 40px; height: 40px;">
                            <span class="d-none d-lg-inline-flex">${membername}(${membercode })</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                            <a href="/main/logout" class="dropdown-item">로그아웃</a>
                        </div>
                    </div>
                </div>
         </nav>
         <!-- Navbar End -->