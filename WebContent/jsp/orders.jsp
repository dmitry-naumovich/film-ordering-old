<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="language" value="${not empty sessionScope.language ? sessionScope.language : 'en' }" scope="session"/>
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="resources.local" var="loc" />
<fmt:message bundle="${loc}" key="local.common.serviceName" var="serviceName" />
<fmt:message bundle="${loc}" key="local.common.rublesShorten" var="rublesShorten" />
<fmt:message bundle="${loc}" key="local.films.openFilmPage" var="openFilmPage" />
<fmt:message bundle="${loc}" key="local.orders.openSingleOrderBtn" var="openSingleOrderBtn" />
<fmt:message bundle="${loc}" key="local.profile.myOrders" var="myOrders" />
<fmt:message bundle="${loc}" key="local.orders.pageTitle" var="pageTitle" />
<fmt:message bundle="${loc}" key="local.orders.userOrder" var="userOrder" />
<fmt:message bundle="${loc}" key="local.orders.userProfile" var="userProfile" />
<fmt:message bundle="${loc}" key="local.orders.orderNum" var="orderNum" />
<fmt:message bundle="${loc}" key="local.orders.orderDate" var="orderDate" />
<fmt:message bundle="${loc}" key="local.orders.orderTime" var="orderTime" />
<fmt:message bundle="${loc}" key="local.orders.filmName" var="filmName" />
<fmt:message bundle="${loc}" key="local.orders.userLogin" var="userLogin" />
<fmt:message bundle="${loc}" key="local.orders.filmPrice" var="filmPrice" />
<fmt:message bundle="${loc}" key="local.orders.discount" var="discount" />
<fmt:message bundle="${loc}" key="local.orders.orderSum" var="orderSum" />
<fmt:message bundle="${loc}" key="local.orders.filmOrders" var="filmOrders" />
<fmt:message bundle="${loc}" key="local.footer.siteMap.orders" var="orders" />


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="${language}">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title> ${serviceName} - ${pageTitle}</title>
  <c:set var="url">${pageContext.request.requestURL}</c:set>
    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />
  <link rel="icon"  type="image/x-icon" href="img/tab-logo.png">
  <link rel="stylesheet" href="css/bootstrap.min.css" >
  <link rel="stylesheet" href="css/styles.css">
  <script type="text/javascript">
    $('.nav li').click(function(e) {
  e.preventDefault();
  $('.nav li').removeClass('active');
  $(this).addClass('active');
});
  </script>
	<script type="text/javascript">
  	window.setTimeout(function() {
	    $(".alert").fadeTo(500, 0).slideUp(500, function(){
	        $(this).remove(); 
	    });
	}, 1000)
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
	  
	  
      <div class="col-md-8 main content ">
        <div class="panel panel-primary">
          <div class="panel-heading" >
          	<c:choose> 
          		<c:when test="${sessionScope.isAdmin}">
          			<c:choose>
	          			<c:when test="${requestScope.orderViewType eq 'all'}"> 
	          				<h4 class="text-left">${orders}</h4>
	          			</c:when>
	          			<c:when test="${requestScope.orderViewType eq 'user'}"> 
	          				<h4 class="text-left"> ${userOrder}
	          				 	<a href="<c:url value="/Controller?command=open_user_profile&userID=${requestScope.userID}"/>">${requestScope.userLogin} </a>
	          				</h4>
	          				<h4 class="text-right">
	          					<a class="btn btn-info" href="<c:url value="/Controller?command=open_user_profile&userID=${order.userId}"/>" role="button" >${userProfile}</a>
	          				</h4>
	          			</c:when>
	          			<c:when test="${requestScope.orderViewType eq 'film'}">
	          				<h4 class="text-left"> ${filmOrders}
	          					<a class="btn btn-success" href="<c:url value="/Controller?command=open_film_page&filmID=${order.filmId}"/>" role="button" >${requestScope.filmName}</a>
	          				</h4>
	          			</c:when>
          			</c:choose> 
          			
          		</c:when>
          		<c:otherwise>
          			<h4 class="text-left"> ${myOrders} </h4>
          		</c:otherwise>
          	</c:choose>
          	
          </div> 
          <div class="row panel-body">
            <div class="col-md-12">
            <c:if test="${errorMessage != null && !errorMessage.isEmpty()}">
					<div class="alert alert-danger fade in">
					  <a href="#" class="close" data-dismiss="alert" aria-label="close"> &times;</a>
					 ${errorMessage} 
					</div>
				</c:if>
				<c:if test="${successMessage != null && !successMessage.isEmpty()}">
					<div class="alert alert-success fade in">
					  <a href="#" class="close" data-dismiss="alert" aria-label="close"> &times;</a>
					 ${successMessage} 
					</div>
				</c:if>
                
                <c:forEach items="${requestScope.orders}" var="order" varStatus="status">
                
                    <div class="panel panel-default container-fluid">
                        <div class="row panel-heading" >
                        	<div class="col-md-12">                         	
                        		<h5 class="text-left"> </h5>
                        		<c:if test="${requestScope.orderViewType eq 'all'}" >
	                        		<h5 class="text-right">
	                        			<a class="btn btn-info" href="<c:url value="/Controller?command=open_single_order&orderNum=${order.ordNum}"/>" role="button" >${openSingleOrderBtn}</a>
	                        		</h5>
                        		</c:if>
                        	</div>
                        	
                        </div> 
                    <div class="row panel-body">
                        <div class="col-md-12">
                          <div class="col-md-4">
                            
                              <figure>
                                <img src="img/films/${order.filmId}/folder.jpg" alt="Img not loaded" class="img-thumbnail img-responsive" width="210" height="140" style="margin-top: 30px;"/> 
                              </figure>
                          </div>
                          <div class="col-md-8">
                              <table class="table table-striped">
                    <thead>
                        
                      <tr>
                      <td> 
                      	<a class="btn btn-success" href="<c:url value="/Controller?command=open_film_page&filmID=${order.filmId}"/>" role="button" >${openFilmPage}</a>
                      </td>
                       <td> 
                      	<a class="btn btn-success" href="<c:url value="/Controller?command=open_user_profile&userID=${order.userId}"/>" role="button" >${userProfile}</a>
                      </td>
                      
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td>${orderNum}</td>
                        <td>#${order.ordNum}</td>
                      </tr>
                      <tr>
                        <td>${orderDate}</td>
                        <td>${order.date}</td>
                      </tr>
                      <tr>
                        <td>${orderTime}</td>
                        <td>${order.time}</td>
                      </tr>
                      <c:if test="${!(requestScope.orderViewType eq 'film')}">
	                      <tr>
	                        <td>${filmName}</td>
	                        <td>${requestScope.filmNames[status.index]}</td>
	                      </tr>
                      </c:if>
                      <c:if test="${!(requestScope.orderViewType eq 'user')}"> 
	          			<tr>
	          				<td>${userLogin}</td>
                        	<td>${requestScope.userLogins[status.index]}</td>
                        </tr>
	          		  </c:if>
                      <tr>
                        <td>${filmPrice}</td>
                        <td>${order.price} ${rublesShorten}</td>
                      </tr>
                      <tr>
                        <td>${discount}</td>
                        <td>${order.discount}%</td>
                      </tr>
                      <tr>
                        <td>${orderSum}</td>
                        <td>${order.payment} ${rublesShorten}</td>
                      </tr>
                    </tbody>
                </table>

                          </div>
                          
                        </div>
                        </div>
                        </div>
                    </c:forEach>

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