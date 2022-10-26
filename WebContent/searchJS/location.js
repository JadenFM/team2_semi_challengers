/**
 * 페이지 이동 Ajax
 */


$(function(){
	
	$.ajaxSetup({
		ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
		type : "post"		
	});
	
	
	// 검색 리스트 호출 함수
	function locationSearch(){
		
		var formData = $("#form_searchText").serialize();
		
		var url = "/Semi_Challengers/search/search.jsp";
		
		$.ajax({
			
			url : url, 
			data : formData,
			datatyle : "html",
			//async : false,
			success : function(data){
				alert("데이터 전송 성공");
				
				history.pushState(formData, null, url);
				$("#load").children().remove();
				$("#load").html(data);
				
			},error: function(){
				alert("데이터 전송 실패");
			}
		});
	}// searchList() end
	
	$(window).on("popstate", function(){
		
		window.location = document.location.href;
	});
	
	
	// Enter 클릭
	$("#search_text").on("keydown", function(key){
		if(key.keyCode == 13){
			$("#search_btn").click();	
		}
	});
	
	
	// 검색 버튼 클릭 이벤트
	$("#search_btn").on("click", function(){
			locationSearch();		
	}); // 검색클릭 이벤트 end
	
	
	

	
	
});