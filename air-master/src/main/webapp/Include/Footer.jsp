<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   </div>  <!--//inner_wrap-->

        <footer id="footer">
            <div class="foot_cont">
                <p>&copy; Fine Dust Corporation All Rights Reserved.</p>
            </div>
        </footer>
    </div><!--//container-->

    <script>
        var pointSize = $(".pointer").width()/2;
        $("#header").mousemove(function(e){    
            $('.pointer').css("top:50%", e.pageY-pointSize);
            $('.pointer').css("left", e.pageX-pointSize);
            $('.pointer').fadeIn();
        });
        $("#header").on("mouseleave", function(){
        $('.pointer').fadeOut();
        });

    </script>
</body>
</html>