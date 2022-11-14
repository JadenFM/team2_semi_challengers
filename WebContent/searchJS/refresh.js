/**
 * 
 */

/*$(window).bind("pageshow", function(e){
	
	
	if(window.location.href!="http://localhost:8585/Semi_Challengers/main.jsp"){
		if(!e.originalEvent.persisted){
			alert("뒤로가기 실행");
		}else{
			alert("새로고침 실행");
			location.href="/Semi_Challengers/main.jsp"
		}
	}
}, 3000);*/

$(document).ready(function(){
	
	$(window).on("hashchange", function(){
		
		// 메인페이지 이동 함수
		function locationMain(){
		
		location.href="/Semi_Challengers/main.jsp"
		
		}// locationMain() end
		
		let hash = document.location.hash;
		
		if(hash!=""){

		}else{
			locationMain();
		}
			
		
	}); // hashchange end
	
});