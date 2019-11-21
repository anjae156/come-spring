<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>

</style>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async
	src="https://www.googletagmanager.com/gtag/js?id=UA-151430813-1"></script>
<script>
	window.dataLayer = window.dataLayer || [];
	function gtag() {
		dataLayer.push(arguments);
	}
	gtag('js', new Date());

	gtag('config', 'UA-151430813-1');
</script>
<%--CSS링크 --%>
<jsp:include page="../include/common_head.jsp"></jsp:include>
<link href="../resources/css/subpage.css" rel="stylesheet" type="text/css"  media="all">
<title>DARK SOUL3</title>
<style>
#map_ma {
	width: 100%;
	height: 500px;
	clear: both;
	border: solid 2px black;
}
</style>
</head>

<body>
	<%--헤더링크 --%>
	<jsp:include page="../include/header.jsp"></jsp:include>

	<div class="full-width back-image1 full-page page" id="first">
		<div class="wrap">
			<div class="first-part">
				<h1>닥소 커뮤니티</h1>
			</div>
		</div>
	</div>

	<div class="full-width back-image2 full-page page" id="second">
		<div class="wrap">
			<h1>게임소개</h1>
			<div class="inner"style="font-size: 1.8vh" >
				<p >Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut
					eleifend vitae est non faucibus. Sed accumsan arcu a magna feugiat,
					sed interdum dolor mollis. Sed bibendum porttitor molestie. Morbi
					aliquet est et nulla congue, et maximus lorem dignissim. Vestibulum
					elit eros, varius quis metus sed, bibendum lacinia tortor. Aliquam
					erat volutpat. Praesent aliquet arcu at feugiat convallis.</p>
				<img src="../resources/imgs/112.jpg" class="img-50 img-left">
				<p >Aenean condimentum diam et mauris cursus, eget maximus elit
					posuere. Fusce vel neque in odio tincidunt finibus. Vestibulum
					lorem sapien, vulputate non vehicula a, vehicula et urna. Ut
					scelerisque augue vitae mi gravida, in convallis nisl consequat.
					Vestibulum molestie vel nisi sed tincidunt. Vestibulum hendrerit a
					metus at aliquet. Nullam tempus laoreet mi, ac pretium massa
					venenatis eu.</p>
				<p >Mauris suscipit ipsum a mauris lobortis aliquet. Sed rutrum
					rutrum tempor. Quisque vulputate, ante sit amet tempor consectetur,
					ex nisl dignissim massa, eget consectetur diam sem at neque.
					Vivamus tincidunt tincidunt suscipit. Praesent sit amet neque in
					enim porttitor euismod nec a sapien. Proin eu magna mollis, laoreet
					ante at, scelerisque nunc. Proin nec est et elit rutrum consequat
					sed eget eros. Aenean mollis elementum pellentesque. Proin
					pellentesque dolor eu felis dapibus, ac aliquet eros tincidunt.
					Phasellus eu urna arcu. Cras viverra, nisl id dignissim
					scelerisque, est quam vulputate elit, eget maximus tellus magna non
					nisi.
					Mauris suscipit ipsum a mauris lobortis aliquet. Sed rutrum
					rutrum tempor. Quisque vulputate, ante sit amet tempor consectetur,
					ex nisl dignissim massa, eget consectetur diam sem at neque.
					Vivamus tincidunt tincidunt suscipit. Praesent sit amet neque in
					enim porttitor euismod nec a sapien. Proin eu magna mollis, laoreet
					ante at,
					scelerisque nunc. Proin nec est et elit rutrum consequat
					sed eget eros. Aenean mollis elementum pellentesque. Proin
					pellentesque dolor eu felis dapibus, ac aliquet eros tincidunt.
					Phasellus eu urna arcu. Cras viverra, nisl id dignissim
					scelerisque, est quam vulputate elit, eget maximus tellus magna non
					nisi.
					</p>

			</div>
		</div>
	</div>
	<div class="full-width back-image3 full-page page" id="third">
		<div class="wrap">
			<h1>자유게시판 맛보기</h1>
			<div class="inner">
				<article id="A">
    
<table id="notice">
  <tr>
    <th scope="col" class="tno">글번호</th>
    <th scope="col" class="ttitle">제목</th>
    <th scope="col" class="twrite">글쓴이</th>
    <th scope="col" class="tdate">작성일</th>
    <th scope="col" class="tread">조회수</th>
  </tr>
  <c:choose>
  	<c:when test="${pageInfoMap.count gt 0}">
  		
  		<c:forEach var="board" items="${boardList}">
  			<tr onclick="location.href='/board/content?num=${board.num}&pageNum=${pageNum}';">
		  	<td>${board.num}</td>
		  	<td class="left">
		  	<c:if test="${board.reLev gt 0 }">
		  		<c:set var="level" value="${board.reLev * 10}"/>
				<img src="../resources/imgs/re/level.gif" width="${level}" height="13">
		  		<img src="../resources/imgs/re/icon_re.gif" width="13" height="13">
		  	</c:if>
		  	${board.subject}
		  	</td>
		  	<td>${board.username}</td>
		  	<td><fmt:formatDate value="${board.regDate}" pattern="yyyy.MM.dd" /></td>
		  	<td>${board.readcount}</td>
		  </tr>
  		</c:forEach>
  	</c:when>
  	<c:otherwise>
  		<tr>
	  		<td colspan="5">게시판 글이 없습니다.</td>
	  	</tr>
  	</c:otherwise>
  </c:choose>
     
  
</table>
<button  class="BB" type="button" onclick="location.href='../board/list'">공략게시판</button>
<button  class="BB" type="button" onclick="location.href='../boardno/list'">자유 게시판</button>
<button class="BB" type="button" onclick="location.href='../boardimg/list'"> 게시판</button>

</article>


			</div>
		</div>
	</div>
	<div class="full-width back-image4 full-page page" id="fourth">
		<div class="wrap">
			<h1>찾아오는길</h1>
			<div class="inner customer">
				<h2>개발실</h2>
				<div id="map_ma"></div>
				<script type="text/javascript">
					$(document).ready(
							function() {
								var myLatlng = new google.maps.LatLng(
										35.413381, 129.176139); // 위치값 위도 경도
								var Y_point = 35.413381; // Y 좌표
								var X_point = 129.176139; // X 좌표
								var zoomLevel = 15; // 지도의 확대 레벨 : 숫자가 클수록 확대정도가 큼
								var markerTitle = "우리집"; // 현재 위치 마커에 마우스를 오버을때 나타나는 정보
								var markerMaxWidth = 300; // 마커를 클릭했을때 나타나는 말풍선의 최대 크기

								// 말풍선 내용
								var contentString = '<div>' + '<h2>우리집</h2>'
										+ '<p>양산시의 자랑.</p>' +
										'</div>';
								var myLatlng = new google.maps.LatLng(Y_point,
										X_point);
								var mapOptions = {
									zoom : zoomLevel,
									center : myLatlng,
									mapTypeId : google.maps.MapTypeId.ROADMAP
								}
								var map = new google.maps.Map(document
										.getElementById('map_ma'), mapOptions);
								var marker = new google.maps.Marker({
									position : myLatlng,
									map : map,
									title : markerTitle
								});
								var infowindow = new google.maps.InfoWindow({
									content : contentString,
									maxWizzzdth : markerMaxWidth
								});
								google.maps.event.addListener(marker, 'click',
										function() {
											infowindow.open(map, marker);
										});
							});
				</script>
			</div>
		</div>
	</div>
	<%--푸터  --%>
	<jsp:include page="../include/footer.jsp"></jsp:include>

	<%--스크립트 링크 --%>
	<jsp:include page="../include/script.jsp"></jsp:include>
</body>

</html>