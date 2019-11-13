<%@page import="com.exam.domain.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-151430813-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-151430813-1');
</script>
	<%--CSS링크 --%>
    <jsp:include page="../include/common_head.jsp"></jsp:include>
    <title>DARK SOUL3</title>
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
            <div class="inner">
                <h2>게임소개 </h2>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut eleifend vitae est non faucibus. Sed accumsan
                    arcu a magna feugiat, sed interdum dolor mollis. Sed bibendum porttitor molestie. Morbi aliquet est et
                    nulla congue, et maximus lorem dignissim. Vestibulum elit eros, varius quis metus sed, bibendum lacinia
                    tortor. Aliquam erat volutpat. Praesent aliquet arcu at feugiat convallis.</p>
                <img src="../imgs/112.jpg" class="img-50 img-left">
                <p>Aenean condimentum diam et mauris cursus, eget maximus elit posuere. Fusce vel neque in odio tincidunt finibus.
                    Vestibulum lorem sapien, vulputate non vehicula a, vehicula et urna. Ut scelerisque augue vitae mi gravida,
                    in convallis nisl consequat. Vestibulum molestie vel nisi sed tincidunt. Vestibulum hendrerit a metus
                    at aliquet. Nullam tempus laoreet mi, ac pretium massa venenatis eu.</p>
                <p>Mauris suscipit ipsum a mauris lobortis aliquet. Sed rutrum rutrum tempor. Quisque vulputate, ante sit amet
                    tempor consectetur, ex nisl dignissim massa, eget consectetur diam sem at neque. Vivamus tincidunt tincidunt
                    suscipit. Praesent sit amet neque in enim porttitor euismod nec a sapien. Proin eu magna mollis, laoreet
                    ante at, scelerisque nunc. Proin nec est et elit rutrum consequat sed eget eros. Aenean mollis elementum
                    pellentesque. Proin pellentesque dolor eu felis dapibus, ac aliquet eros tincidunt. Phasellus eu urna
                    arcu. Cras viverra, nisl id dignissim scelerisque, est quam vulputate elit, eget maximus tellus magna
                    non nisi.</p>

            </div>
        </div>
    </div>
    <div class="full-width back-image3 full-page page" id="third">
        <div class="wrap">
            <h1>자유게시판 맛보기 </h1>
            <div class="inner">
	<jsp:include page="../include/noticepage1.jsp"></jsp:include>
                

            </div>
        </div>
    </div>
    <div class="full-width back-image4 full-page page" id="fourth">
        <div class="wrap">
            <h1>고객센터</h1>
            <div class="inner customer">
                <h2>Contact Us</h2>
                <p>Mauris suscipit ipsum a mauris lobortis aliquet. Sed rutrum rutrum tempor. Quisque vulputate, ante sit amet
                    tempor consectetur, ex nisl dignissim massa, eget consectetur diam sem at neque. Vivamus tincidunt tincidunt
                    suscipit. Praesent sit amet neque in enim porttitor euismod nec a sapien. Proin eu magna mollis, laoreet
                    ante at, scelerisque nunc. Proin nec est et elit rutrum consequat sed eget eros. Aenean mollis elementum
                    pellentesque. Proin pellentesque dolor eu felis dapibus, ac aliquet eros tincidunt. Phasellus eu urna
                    arcu. Cras viverra, nisl id dignissim scelerisque, est quam vulputate elit, eget maximus tellus magna
                    non nisi.</p>
                <form action="postAdminEmail.jsp" class="basic-form" onsubmit="return Check():">
                    <label>이름</label>
                    <input type="text">
                    <br>
                    <label>이메일주소</label>
                    <input type="email" name="postemail">
                    <br>
                    <label>메일제목</label>
                    <input type="text" name="subject">
                    <br>
                    <label>내용</label>
                    <textarea></textarea name="content">
                    <br>
                    <input type="submit"/>
                </form>

            </div>
        </div>
    </div>
    <%--푸터  --%>
    <jsp:include page="../include/footer.jsp"></jsp:include>
    
    <%--스크립트 링크 --%>
    <jsp:include page="../include/script.jsp"></jsp:include>
</body>

</html>