/**
 * 메인페이지 챌린지 리스트를 가져오는 자바스크립트
 */

$(document).ready(function() {
	
	$.ajaxSetup({
		ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
		type : "post"		
	});
	
	function getContextPath(){
		
		let path = location.href.indexOf(location.host)+location.host.length;
		
		return location.href.substring(path, location.href.indexOf('/', path+1));
	}
	
	function formSubmit(name){
	document.getElementById("form_category").value = name;
	
	console.log('변환>>>' +document.getElementById("form_category").value);
	document.getElementById("form").submit();
}




	
	
	function getCategory(){
		
		$.ajax({
			
			url : getContextPath()+"/main_category.do",
			datatype : "xml",
			async : false,
			success : function(data){
				
				$("#input_items").empty();
					
				let card = "<div class='card_category'>";
				let count= 0;
				
				$(data).find("chall_list").each(function() {
					count += 1
					card += "<div class='category_items'>";
					card += "<a class='formSubmit' data-value='" +$(this).find("chall_category_code").text()+ "'><img class='category_image' src='" +getContextPath()+ "/uploadFile/" +$(this).find("chall_category_image").text()+ "'>";
					card += "<p>" +$(this).find("chall_category_name").text()+ "</p></a>";
					card += "</div>";
					
					if(count % 5 == 0){
						card += "</div>";
						card += "<div class='card_category'>";
					}
					
				});
				card +="<a class='category_items' href='#'><img class='category_image' src='" +getContextPath+ "/uploadFile/CategoryAll.jpg'>";
				card += "<p>전체보기</p></a>";
				card += "</div>";
				$("#input_items").append(card);
				
			},
			error : function(){
				alert('메인페이지 로딩 실패');
			}
			
		});	
	} // getCategory() end
	
	function getMostchall(option){
		
		$.ajax({
			
			url : getContextPath() +"/main_most_chall.do",
			data : {option : option},
			datatype : "xml",
			async : false,
			success : function(data){
				
				$("#input_items2").empty();
					
				let card = "<div class='card_most_chall'>";
				
				$(data).find("chall_list").each(function() {
					card += "<div class='most_chall_items'>";
					card += "<a href='" +getContextPath()+ "/search_content.do?num=" +$(this).find("chall_num").text()+ "'><img class='most_chall_image' src='" +getContextPath()+ "/uploadFile/" +$(this).find("chall_mainimage").text()+ "'>";
					card += "<p>" +$(this).find("chall_title").text()+ "</p></a>";
					card += "<span class='most_chall_time'>" +$(this).find("chall_cycle").text()+ "</span>&nbsp;";
					card += "<span class='most_chall_time'>" +$(this).find("chall_duration").text()+ "</span>";
					card += "</div>";
					
				});
				$("#input_items2").append(card);				
				
			},
			error : function(){
				alert('인기챌린지 불러오기 실패');
			}
		});
	}
	
	function getAdminchall(){
		
		$.ajax({
			
			url : getContextPath() +"/main_admin_chall.do",
			datatype : "xml",
			async : false,
			success : function(data){
				
				$("#input_items3").empty();
					
				let card = "<div class='card_admin_chall'>";
				
				$(data).find("chall_list").each(function() {
					card += "<div class='admin_chall_items'>";
					card += "<a  class='local' href='" +getContextPath()+ "/search_content.do?num=" +$(this).find("chall_num").text()+ "'><img class='admin_chall_image' src='" +getContextPath()+ "/uploadFile/" +$(this).find("chall_mainimage").text()+ "'>";
					card += "<p>" +$(this).find("chall_title").text()+ "</p></a>";
					card += "<span class='admin_chall_time'>" +$(this).find("chall_cycle").text()+ "</span>&nbsp;";
					card += "<span class='admin_chall_time'>" +$(this).find("chall_duration").text()+ "</span>";
					card += "</div>";
					
				});
				$("#input_items3").append(card);				
				
			},
			error : function(){
				alert('인기챌린지 불러오기 실패');
			}
		});
	}
	
	getCategory();
	getMostchall();
	getAdminchall();
	
	$(".formSubmit").on("click", function(){
		let name = $(this).attr('data-value');
		formSubmit(name);	
	});
	
	
	
});

