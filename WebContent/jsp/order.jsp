<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="language" value="${not empty sessionScope.language ? sessionScope.language : 'en' }" scope="session"/>
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="resources.local" var="loc" />
<fmt:message bundle="${loc}" key="local.order.pageTitle" var="pageTitle" />
<fmt:message bundle="${loc}" key="local.order.pageHeader" var="pageHeader" />
<fmt:message bundle="${loc}" key="local.order.price" var="price" />
<fmt:message bundle="${loc}" key="local.order.discount" var="discount" />
<fmt:message bundle="${loc}" key="local.order.orderSum" var="orderSum" />
<fmt:message bundle="${loc}" key="local.order.rublesShorten" var="rublesShorten" />
<fmt:message bundle="${loc}" key="local.order.cancelBtn" var="cancelBtn" />
<fmt:message bundle="${loc}" key="local.order.buyBtn" var="buyBtn" />

<c:set var="film" value="${requestScope.film}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="${language}">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>${pageTitle}</title>
  <c:set var="url">${pageContext.request.requestURL}</c:set>
    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />
  <link rel="icon"  type="image/x-icon" href="img/tab-logo.png">
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/styles.css">
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

      <div class="col-md-8 main content ">
        <div class="panel panel-primary">
          <div class=" panel-heading" >
          <h2 class=" text-left" style="margin:0px; padding:0px;"> ${pageHeader} ${film.name}</h2>
          </div> 
          <div class="row panel-body">
            <div class="col-md-12">
                
                <table class="table table-striped">
                    <thead>
                      <tr>
                        <th>
                          <figure>
                          	<img src="img/films/${film.id}/folder.jpg" alt="$ {film.name}" class="img-thumbnail img-responsive" width="210" height="140" /> 
                          </figure>
                        </th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td>${user????}</td>
                        <td>${order.user???}</td>
                      </tr>
                      <tr>
                        <td>${price}</td>
                        <td>${film.price} ${rublesShorten}</td>
                      </tr>
                      <tr>
                        <td>${discount}</td>
                        <td>${requestScope.discountAmount}%</td>
                      </tr>
                      <tr>
                        <td>${orderSum}</td>
                        <td>${requestScope.orderSum} ${rublesShorten}</td>
                      </tr>

                      <tr>
                        <th>
                          <a href="#" onclick="history.back();" class="btn btn-danger" role="button">${cancelBtn}</a>
                        </th>
                        <td> <a href="jsp/success-page.jsp" class="btn btn-primary" role="button">${buyBtn}</a></td>
                      </tr>
                    </tbody>
                </table>
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