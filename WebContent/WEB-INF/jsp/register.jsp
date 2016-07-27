<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ru">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Заказ фильмов</title>
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
          <h2 class=" text-left" style="margin:0px; padding:0px;"> Регистрация</h2>
          </div> 
          <div class="row panel-body">
            <div class="col-md-12">


<form class="form-horizontal" method="post" name="register">
    <div class="form-group">
      <label class="col-sm-2 control-label">Имя*:</label>
      <div class="col-sm-10">
        <input class="form-control" id="focusedInput" type="text" placeholder="Введите имя" required>
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-2 control-label">Фамилия*:</label>
      <div class="col-sm-10">
        <input class="form-control" id="disabledInput" type="text" placeholder="Введите фамилию" required>
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-2 control-label">Логин*:</label>
      <div class="col-sm-10">
        <input class="form-control" id="login-input" type="text" placeholder="Введите логин" required>
      </div>
    </div>
    <div class="form-group">
      <label for="pwd" class="col-sm-2 control-label">Пароль*:</label>
      <div class="col-sm-10">
        <input class="form-control" id="pwd" type="password" placeholder="Введите пароль" required>
      </div>
    </div>
    <div class="form-group">
      <label for="pwd-again" class="col-sm-2 control-label">Повторите пароль*:</label>
      <div class="col-sm-10">
        <input class="form-control" id="pwd-again" type="password" placeholder="Введите пароль" required>
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-2 control-label">Выберите дату рождения:</label>
      <div class="col-sm-10">
        <input class="form-control" id="bDateInput" type="date">
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-2 control-label">Введите email*: </label>
      <div class="col-sm-10">
        <input class="form-control" id="emailInput" type="email" name="useremail" placeholder="Введите email" required>
      </div> 
    </div>
     <div class="form-group">
      <label class="col-sm-2 control-label">Введите телефон: </label>
      <div class="col-sm-10">
        <input class="form-control" id="phoneInput" type="text" name="userphone" placeholder="Введите телефон">
      </div>
    </div>
     <div class="form-group">
      <label class="col-sm-2 control-label">Пол*: </label>
      <div class="col-sm-10">
      <label class="radio-inline"><input type="radio" name="optradio">Мужской</label>
      <label class="radio-inline"><input type="radio" name="optradio">Женский</label>
      <label class="radio-inline"><input type="radio" name="optradio">Я пока не определился</label>
      </div>
    </div>

     <div class="form-group">
      <label class="col-sm-2 control-label">Аватар: </label>
      <div class="col-sm-10">
            <input type="file" name="avatar">
      </div>
    </div>    

    <div class="form-group">
      <label class="col-sm-2 control-label" for="comment">Расскажите о себе:</label>
      <div class="col-sm-10">
        <textarea class="form-control" rows="5" id="comment"></textarea>
      </div>
    </div>
    <div class="form-group">
      <div class="col-sm-2 col-md-offset-2">
      <button type="submit" class="btn btn-primary">Зарегистрироваться</button>
      </div>

      <label class="col-sm-4 col-md-offset-3 control-label" for="comment">Уже зарегистрированы? Тогда </label>
      <a href="../pages/logination.html" class="btn btn-primary" role="button">Войти</a>

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