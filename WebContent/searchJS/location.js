/**
 * 
 */
$(document).ready(function(){
	
	
	$.ajaxSetup({
		ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
		type : "post"		
	});
	
	
	function getContextPath(){
		let path = location.href.indexOf(location.host)+location.host.length;
		
		return location.href.substring(path, location.href.indexOf('/', path+1));
	}
	
	function formSubmit_category(name){
		document.getElementById("form_search_category").value = name;
		
		console.log('변환>>>' +document.getElementById("form_search_category").value);
		document.getElementById("form_search2").submit();
	}
	
	function formSubmit_keyword(name){
		document.getElementById("form_search_keyword").value = name;
		document.getElementById("form_search2").submit();
	}
	
	function getSearchKeyup(keyword){
		
		let category = "";
		$.ajax({
			
			url : getContextPath()+"/search_list2.do",
			data : {keyword : keyword,
					category : category
			},
			datatype : "xml",
			success : function(data){
				let card = "";
				
				$("#search_wrap").css("display", "none");
				$("#card_keyword").children().remove();
				
				if(data == 1){
					card += "<div class='none'>찾으시는 챌린지가 없습니다.</div>"; 
				}else{
					$(data).find("chall_list").each(function(){
						card += "<div class='card_items_keyword'>";
						card += "<a href='" +getContextPath()+ "/search_content.do?num=" +$(this).find("chall_num").text()+ "'><div class='card_keyword_icon'><img src='" +getContextPath()+"/uploadFile/" +$(this).find("chall_mainimage").text() +"'></div>";
						card += "<div class='card_keyword_info'><p>" +$(this).find("chall_title").text()+ "</p>";
						card += "<span>" +$(this).find("chall_cycle").text()+ "</sapn>";
						card += "<span>" +$(this).find("chall_duration").text()+ "</sapn></div>";
						card += "</div>";
					});
				}
				$("#card_keyword").append(card);
				$("#search_wrap2").css("display", "block")
			},
			error : function(){
				alert('keyup 이벤트 에러');
			}
			
		});
		
	}
	

	
	/*레이어 이벤트*/
	function getMostCategory(){
		
		$.ajax({
			
			url : getContextPath()+"/main_most_category.do",
			datatype : "xml",
			async : false,
			success : function(data){
				
				$("#card_most_category").empty();
					
				let card = "";
				
				$(data).find("chall_list").each(function() {
				
					card += "<div class='card_items'>";
					card += "<a class='form_category' data-value='" +$(this).find("chall_category_code").text()+ "'><img class='card_image' src='" +getContextPath()+ "/uploadFile/" +$(this).find("chall_category_image").text()+ "'>";
					card += "<p>" +$(this).find("chall_category_name").text()+ "</p></a>";
					card += "</div>";
					
				});
				
				$("#card_most_category").append(card);
				
			},
			error : function(){
				alert('메인페이지 로딩 실패');
			}
			
		});	
		
	}
	
	function getMostKeyword(){
		
		$.ajax({
			
			url : getContextPath()+"/main_most_keyword.do",
			datatype : "xml",
			async : false,
			success : function(data){
				$("#card_most_keyword").empty();
				
				let card = "";
				
				card = "<ol id='card_most_keyword'>";
				
				$(data).find("chall_list").each(function(){
					
					card += "<li><label><a class='keyword_form' data-value='" +$(this).find("chall_keyword_name").text()+ "'>"+$(this).find("chall_keyword_name").text()+ "</a></label></li>";
				});
				
				card += "</ol>";
				
				$("#card_most_keyword").append(card);
				
				
			},
			error : function(){
				alert('키워드 로딩 실패');
			}
		});
		
	} // getMostKeyword() end
	
	
	
	/*검색 레이어*/
	$("#open").on("click", function(){
		
		if($("#search_wrap").css("display") == "none"){
			$("#search_wrap").css("display", "block");
		}
		if($("#search_wrap2").css("display") == "block"){
			$("#search_wrap2").css("display", "none");			
		}
		
		$("#search_layer").css("display", "block");
		
		getMostCategory();
		getMostKeyword();
		

	});	

	
	$("#close").on("click", function(){
		$("#search_layer").css("display", "none");
		$("#search_text2").val("");
	});
	
	/*인기 검색어 클릭*/
	$(document).on("click", ".keyword_form", function(){
		let name= $(this).attr('data-value');
		formSubmit_keyword(name);
	});
	
	/*인기 카테고리 클릭*/
	$(document).on("click", ".form_category", function(){
		let name = $(this).attr('data-value');
		formSubmit_category(name);
	});
	
	$(document).on("click", "#move_search", function(){
		$("#form_search").submit();
	});
	
	
	
	/* 검색 레이어 ajax 딜레이 설정*/
	let timeout = null
	$("#search_text2").on("propertychange change keyup paste input", function() {
	    let keyword = $(this).val();
	    clearTimeout(timeout);
	    timeout = setTimeout(function() {
	        
			if(keyword != ""){
				getSearchKeyup(keyword);          
			}else{
				$("#search_wrap").css("display", "block");
				$("#search_wrap2").css("display", "none");
			}
	    }, 100);
	})
	
	

	
	


/*	$(".search_form").on("click", function(){
		alert('클릭완료');
		let name = $(this).attr('data-value');
		formSubmit_search(name);	
	});*/

}); // 본문 end

