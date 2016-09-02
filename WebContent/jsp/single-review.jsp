<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="language" value="${not empty sessionScope.language ? sessionScope.language : 'en' }" scope="session"/>
<fmt:setLocale value="${language}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>NOT DONE</title>
  <c:set var="url">${pageContext.request.requestURL}</c:set>
    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />
  <link rel="icon"  type="image/x-icon" href="img/tab-logo.png">
  <link rel="stylesheet" href="css/bootstrap.min.css" >
  <link rel="stylesheet" href="css/styles.css">
  <script type="text/javascript">
	  window.setTimeout(function() {
		    $(".alert").fadeTo(500, 0).slideUp(500, function(){
		        $(this).remove(); 
		    });
		}, 1000);
   </script>
   <script>
	 $( function() {
		    $( ".datepicker" ).datepicker();
	} );
   </script>
  <script type="text/javascript">
    $('.nav li').click(function(e) {
  e.preventDefault();
  $('.nav li').removeClass('active');
  $(this).addClass('active');
});
  </script>


  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="http://mybootstrap.ru/wp-content/themes/clear-theme/js/bootstrap-affix.js"></script>
</head>

<body data-spy="scroll" data-target="#myScrollspy" data-offset-top="15">

  <jsp:include page="/WEB-INF/static/header.jsp"></jsp:include>
    <div class="container-fluid"> 
    	<div class="row content ">
      		<jsp:include page="/WEB-INF/static/left-menu.jsp"></jsp:include>
			<c:if test="${errorMessage != null && !errorMessage.isEmpty()}">
				<div class="alert alert-danger fade in">
				  <a href="#" class="close" data-dismiss="alert" aria-label="close"> &times;</a>
				 ${errorMessage} 
				</div>
			</c:if>
			<c:set var="review" value="${requestScope.review}" />
			<c:set var="authorLogin" value="${requestScope.login}" />
	  		<c:set var="filmName" value="${requestScope.filmName}" />
  
	          <c:choose>
	        		<c:when test="${review.type eq  'ps'}"> 
	         			<c:set var="rColor" value="#ccffcc"/>
	         		</c:when>
	         		<c:when test="${review.type eq 'ng'}"> 
	         			<c:set var="rColor" value="#ffcccc"/>
	         		</c:when>
	         		<c:otherwise>
	         			<c:set var="rColor" value="#e6e6ff"/>
	         		</c:otherwise>
	          </c:choose>
              
         <div class="col-md-8 main content ">     
          <div class="panel panel-default container-fluid">
              <div class="row panel-heading" style="background-color:${rColor}">
	              <div class="col-md-6">
	              	<h4 class=" text-left"> 
	             		<a href="<c:url value="/Controller?command=open_film_page&filmID=${review.filmId}" />" >${filmName} </a>
	             	</h4>
	              </div>
	              <div class="col-md-6">
	              	<c:if test="${sessionScope.isAdmin}">
	               		<h4 class=" text-right">
	               			${author}:  
	              			<a href="<c:url value="/Controller?command=open_user_profile&userID=${review.author}" />" >${authorLogin} </a>
	              		</h4>
	             	</c:if>
	              </div>
              </div> 
          	<div class="row panel-body">
               <div class="col-md-12">
                 <p> <br>
                     ${review.text}
                 </p>
               </div>
            </div>
              <div class="row panel-footer" style="background-color:${rColor}">
              	<div class="col-md-6">
              		<h5 class="text-left">${mark}: ${review.mark}/5</h5>
              	</div>
              	<div class="col-md-6">
              		<h5 class="text-right"> ${date}: ${review.date} ${review.time} </h5>
              	</div>
              </div>
           </div>
          </div>
      <jsp:include page="/WEB-INF/static/right-sidebar.jsp"></jsp:include>
     </div>
  </div>  
  <jsp:include page="/WEB-INF/static/footer.jsp"></jsp:include>
</body>
</html>