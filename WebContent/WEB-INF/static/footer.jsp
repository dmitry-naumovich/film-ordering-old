<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var = "language" value = "${not empty sessionScope.language ? sessionScope.language : 'en' }" scope = "session"/>
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="resources.local" var="loc" />
<fmt:message bundle="${loc}" key="local.footer.siteMap.header" var="siteMapHeader" />
<fmt:message bundle="${loc}" key="local.footer.siteMap.main" var="main" />
<fmt:message bundle="${loc}" key="local.footer.siteMap.films" var="films" />
<fmt:message bundle="${loc}" key="local.footer.siteMap.reviews" var="reviews" />
<fmt:message bundle="${loc}" key="local.footer.siteMap.widenedSearch" var="widenedSearch" />
<fmt:message bundle="${loc}" key="local.footer.siteMap.signIn" var="signIn" />
<fmt:message bundle="${loc}" key="local.footer.siteMap.signUp" var="signUp" />
<fmt:message bundle="${loc}" key="local.footer.siteMap.profile" var="profile" />
<fmt:message bundle="${loc}" key="local.footer.siteMap.orders" var="orders" />
<fmt:message bundle="${loc}" key="local.footer.siteMap.news" var="news" />
<fmt:message bundle="${loc}" key="local.footer.siteMap.feedback" var="feedback" />
<fmt:message bundle="${loc}" key="local.footer.siteMap.aboutUs" var="aboutUs" />
<fmt:message bundle="${loc}" key="local.footer.siteMap.help" var="help" />   	
<fmt:message bundle="${loc}" key="local.footer.info" var="footerInfo" />   	
<fmt:message bundle="${loc}" key="local.header.settings" var="settings" />
<fmt:message bundle="${loc}" key="local.header.myReviews" var="myReviews" />
<fmt:message bundle="${loc}" key="local.header.myOrders" var="myOrders" />
<fmt:message bundle="${loc}" key="local.footer.userList" var="userList" />
   	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<footer class="container-fluid text-center"> 
    
    <section id="sec1">

    <h2 id="sitemap-header">${siteMapHeader}</h2>
    <div class="row">
      <div class="col-md-2 col-md-offset-3">
        <ul>
          <li><a href="index.jsp">${main}</a></li>
          <li><a href="<c:url value="/Controller?command=open_all_news"/>" > ${news} </a></li>
          <li><a href="<c:url value="/Controller?command=open_all_films"/>" >${films}</a></li>
          <li><a href="<c:url value="/Controller?command=open_widened_search_page"/>"> ${widenedSearch} </a></li>
        </ul>
      </div>
      <div class="col-md-2">
        <ul>
      		<c:choose> 
      			<c:when test="${sessionScope.isAdmin}">
      				 <li><a href="<c:url value="/Controller?command=open_user_profile&userID=${sessionScope.userID}"/>" >${profile}</a></li>
      				 <li><a href="<c:url value="/Controller?command=open_all_reviews"/>">${reviews}</a></li>
      				 <li><a href="<c:url value="/Controller?command=open_all_orders"/>">${orders}</a></li>
      				 <li><a href="<c:url value="/Controller?command=open_user_list"/>">${userList}</a></li>
      			</c:when>
      			<c:otherwise> 
      				 <li><a href="<c:url value="/Controller?command=open_user_profile&userID=${sessionScope.userID}"/>" >${profile}</a></li>
      				 <li><a href="<c:url value="/Controller?command=open_user_reviews&userID=${sessionScope.userID}"/>">${myReviews}</a></li>
      				 <li><a href="<c:url value="/Controller?command=open_user_orders&userID=${sessionScope.userID}"/>">${myOrders}</a></li>
      				 <li><a href="<c:url value="/Controller?command=open_user_settings&userID=${sessionScope.userID}"/>">${settings}</a></li>
      			</c:otherwise>
      		</c:choose> 
        </ul>
      </div>
      <div class="col-md-2">
        <ul>
          <li><a href="<c:url value="/Controller?command=open_sign_up_page"/>">${signUp}</a></li> 
          <li><a href="<c:url value="/Controller?command=open_feedback_page"/>">${feedback}</a></li>
          <li><a href="<c:url value="/Controller?command=open_about_us_page"/>">${aboutUs}</a></li>
          <li><a href="<c:url value="/Controller?command=open_help_page" />">${help}</a></li>
        </ul>
      </div>
    </div>
    <div class="row" style="text-align:right; margin-right:10px;"> ${footerInfo} </div>
  </section>
  </footer>