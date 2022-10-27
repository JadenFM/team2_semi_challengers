/**
 * 메인페이지 챌린지 리스트를 가져오는 자바스크립트
 */

$(document).ready(function() {
	
	$.ajaxSetup({
		ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
		type : "post"		
	});
	
	function getList(){
		
		$.ajax({
			
			url : "/Semi_Challengers/main_list.do",
			datatype : "xml",
			success : function(data){
				
				$(".list tr:gt(0)").remove();
					
				let table = "";
				
				$(data).find("chall_list").each(function() {
					table += "<tr>";
					table += "<td>" +$(this).find("chall_title").text()+ "</td>";
					table += "<td>" +$(this).find("chall_cont").text()+ "</td>";
					table += "</tr>";
					
				});
				
				$(".list tr:eq(0)").after(table);

				
			},
			error : function(){
				alert('메인페이지 로딩 실패');
			}
			
		});
	} // getList() end
	
	getList();
	
/*	$(window).on("popstate", function(){
		
		window.location = document.location.href;
	});*/
});