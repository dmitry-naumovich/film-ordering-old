<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="language" value="${not empty sessionScope.language ? sessionScope.language : 'en' }" scope="session"/>
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="resources.local" var="loc" />
<fmt:message bundle="${loc}" key="local.common.serviceName" var="serviceName" />
<fmt:message bundle="${loc}" key="local.settings.pageTitle" var="pageTitle" />
<fmt:message bundle="${loc}" key="local.settings.pageHeader" var="pageHeader" />
<fmt:message bundle="${loc}" key="local.settings.changePass" var="changePass" />
<fmt:message bundle="${loc}" key="local.settings.repeatPass" var="repeatPass" />
<fmt:message bundle="${loc}" key="local.settings.enterPass" var="enterPass" />
<fmt:message bundle="${loc}" key="local.settings.avatar" var="avatar" />
<fmt:message bundle="${loc}" key="local.settings.tellAbout" var="tellAbout" />
<fmt:message bundle="${loc}" key="local.settings.changeSettingsBtn" var="changeSettingsBtn" />

<fmt:message bundle="${loc}" key="local.signUp.male" var="male" />
<fmt:message bundle="${loc}" key="local.signUp.female" var="female" />
<fmt:message bundle="${loc}" key="local.signUp.unknown" var="unknown" />

<fmt:message bundle="${loc}" key="local.profile.name" var="name" />
<fmt:message bundle="${loc}" key="local.profile.surname" var="surname" />
<fmt:message bundle="${loc}" key="local.profile.sex" var="sex" />
<fmt:message bundle="${loc}" key="local.profile.phoneNum" var="phoneNum" />
<fmt:message bundle="${loc}" key="local.profile.birthDate" var="birthDate" />
<fmt:message bundle="${loc}" key="local.profile.email" var="email" />
<fmt:message bundle="${loc}" key="local.profile.aboutMe" var="aboutMe" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="${language}">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>${serviceName} - ${pageTitle}</title>
  <c:set var="url">${pageContext.request.requestURL}</c:set>
    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />
  <link rel="icon"  type="image/x-icon" href="img/tab-logo.png">
  <link rel="stylesheet" href="css/bootstrap.min.css" >
  <link rel="stylesheet" href="css/styles.css">
   <script src="js/bootstrap-datepicker.js"></script>
  <script type="text/javascript">
  
  $(document).ready(function () {
      
      $('.datepicker').datepicker({
          format: "dd/mm/yyyy"
      })
}
  
  });
  
  function validateForm(event)
  {
      event.preventDefault(); // this will prevent the submit event
      if(document.updSettingsForm.name.value=="") {
        alert("User name can not be left blank");
        document.updSettingsForm.name.focus();
        return false;
      }
      else if(document.updSettingsForm.surname.value=="") {
        alert("Surname can not be left blank");
        document.updSettingsForm.surname.focus();
        return false;
      }
      else if(document.updSettingsForm.password.value=="") {
        alert("Password can not be left blank");
        document.updSettingsForm.password.focus();
        return false;
      }
      else if (document.updSettingsForm.passwordRepeated.value=="") {
    	alert("Password repeated can not be left blank");
    	document.updSettingsForm.passwordRepeated.focus();
    	return false;
      }
      else if (document.updSettingsForm.password.value != document.updSettingsForm.passwordRepeated.value) {
    	  alert("Passwords do not match! Try again.");
    	  document.getElementById("pwd").value="";
    	  document.getElementById("pwdRep").value="";
    	  document.updSettingsForm.password.focus();
    	  return false;
      }
      else if (document.updSettingsForm.email.value=="") {
      	alert("Email can not be left blank");
      	document.updSettingsForm.email.focus();
      	return false;
        }
      else {
          document.updSettingsForm.submit(); // fire submit event
      }
  }
  
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
          <h2 class=" text-left"> ${pageHeader}</h2>
          </div> 
          <div class="row panel-body">
            <div class="col-md-12">

<h4><c:out value="${errorMessage}" /></h4>
<c:set var="user" value="${requestScope.user}"/>

<form name="updSettingsForm" class="form-horizontal" action="Controller" method="post" onSubmit="return validateForm(event);">
	<h4><c:out value="${errorMessage}" /></h4>
  	<div class="form-group">
    	<input type="hidden" name="command" value="change_user_settings" />
  	</div>
    <div class="form-group">
      <label class="col-sm-3 control-label">${name}:</label>
      <div class="col-sm-9">
        <input class="form-control" name="name" type="text" value="${user.name}" > 
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-3 control-label">${surname}:</label>
      <div class="col-sm-9">
        <input class="form-control" name="surname" type="text" value="${user.surname}">
      </div>
    </div>
    <div class="form-group">
      <label for="pwd" class="col-sm-3 control-label">${changePass}:</label>
      <div class="col-sm-9">
        <input class="form-control" name="password" type="password" id="pwd" value="${user.password}">
      </div>
    </div>
    <div class="form-group">
      <label for="pwd-again" class="col-sm-3 control-label">${repeatPass}:</label>
      <div class="col-sm-9">
        <input class="form-control" name="passwordRepeated" type="password" id="pwdRep" value="${user.password}">
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-3 control-label">${sex}: </label>
      <div class="col-sm-9">
      	  <c:choose> 
      	  	<c:when test="${user.sex eq 'm'.charAt(0)}"> 
      	  		<label class="radio-inline"><input type="radio" name="sex" value="m" checked="">${male}</label>
	      		<label class="radio-inline"><input type="radio" name="sex" value="f">${female}</label>
	      		<label class="radio-inline"><input type="radio" name="sex" value="u">${unknown}</label>
      	  	</c:when>
      	  	<c:when test="${user.sex eq 'f'.charAt(0)}"> 
      	  		<label class="radio-inline"><input type="radio" name="sex" value="m">${male}</label>
	      		<label class="radio-inline"><input type="radio" name="sex" value="f" checked="">${female}</label>
	      		<label class="radio-inline"><input type="radio" name="sex" value="u" >${unknown}</label>
      	  	</c:when>
      	  	<c:when test="${user.sex eq 'u'.charAt(0)}"> 
      	  		<label class="radio-inline"><input type="radio" name="sex" value="m">${male}</label>
	      		<label class="radio-inline"><input type="radio" name="sex" value="f">${female}</label>
	      		<label class="radio-inline"><input type="radio" name="sex" value="u" checked="">${unknown}</label>
      	  	</c:when>
      	  </c:choose>
	      
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-3 control-label">${birthDate}:</label>
      <div class="col-sm-9">
        <input class="form-control datepicker" name="birthDate" type="date" value="${user.birthDate}">
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-3 control-label">${email}: </label>
      <div class="col-sm-9">
        <input class="form-control" name="email" type="email" value="${user.email}">
      </div> 
    </div>
     <div class="form-group">
      <label class="col-sm-3 control-label">${phoneNum}: (+375)</label>
      <div class="col-sm-9">
        <input class="form-control" name="phone" type="text" value="${user.phone}">
      </div>
    </div>

     <div class="form-group">
      <label class="col-sm-3 control-label">${avatar}: </label>
      <div class="col-sm-9">
            <input type="file" name="avatar">
      </div>
    </div>    

    <div class="form-group">
      <label class="col-sm-3 control-label" for="comment">${tellAbout}:</label>
      <div class="col-sm-9">
        <textarea class="form-control" rows="5" name="about">${user.about}</textarea>
      </div>
    </div>
    <div class="form-group">
      <div class="col-sm-3 col-md-offset-2">
      <button type="submit" class="btn btn-primary" name="Change settings">${changeSettingsBtn}</button>
      </div>

    </div>    
    
    
</form>
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