$(function(){
		$("#1").css('color','black');
		$("#2,#3").css('color','lightgray');
		
		$("#3").click(function(){						// 결제
			$("#3").css('color','black');
			$("#1,#2").css('color','lightgray');
			$.ajax({
				type : "post",
				url : "/Semi_Challengers/answer_check_X.do",
				datatype : "html",
				success : function(data){
					$(".body").hide();
					$(".asd").html(data);
				},
				error : function(){
					alert("에러가 발생하였습니다.")
				}
			})
		})
		$("#1").click(function(){
			$("#1").css('color','black');
			$("#2,#3").css('color','lightgray');
			$(".ekqquso,.ekqqusx").show();
		})
	});