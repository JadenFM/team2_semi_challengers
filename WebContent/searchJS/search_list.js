/**
 * 검색 목록을 가져오는 Ajax
 */
$(document).ready(function(){
	
	$.ajaxSetup({
		ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
		type : "post"		
	});
	
	function getSearchList(){

		//var formData = $("#form_searchText, #from_searchOption").serialize();
		
		var keyword = $("#text").val();
		
		var url = "/Semi_Challengers/search/search.jsp";
		
		$.ajax({
			
			url : "/Semi_Challengers/search_list.do",
			data : {"keyword" : keyword},
			datatyle : "xml",
			async : false,
			success : function(data){
				
				history.pushState(keyword, null, url);
				
				$(".li tr:gt(0)").remove();
				
				let table = "";
				
				$(data).find("chall_list").each(function() {
					table += "<tr>";
					table += "<td>" +$(this).find("chall_title").text()+ "</td>";
					table += "<td>" +$(this).find("chall_cont").text()+ "</td>";
					table += "</tr>";
					
				});
			
				$(".li tr:eq(0)").after(table);
			},
			error : function(){
				alert('검색 목록 불러오기 실패');
			}
			
			
		});
	} // getSearchList end
	
	$(window).on("popstate", function(){
		
		window.location = document.location.href;
	});
	
	getSearchList();


	
	
});
