/**
 * 검색 목록을 가져오는 Ajax
 */
$(document).ready(function(){
	
	$.ajaxSetup({
		ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
		type : "post"		
	});
	
	let keyword = $("#keyword").val();
	let category = $("#category").val();
	
	console.log('JS 키워드 >>> ' +keyword);
	console.log('JS 카테고리 >>>' +category);
	
	function getHash(strCy, strDu, strCa, keyword){
		
		document.location.hash = "option/keyword=" +keyword+ "&cycle=" +strCy+ "&duration=" +strDu+ "&category=" +strCa;
		
	}
	
	function getHashKey(keyword){
		
		document.location.hash = "search/keyword=" +keyword;
		
	}
	
	function getContextPath(){
		let path = location.href.indexOf(location.host)+location.host.length;
		
		return location.href.substring(path, location.href.indexOf('/', path+1));
	}
	
	function check(str){
		
		if(typeof str == "undefined" || str == null || str == "")
			return false;
		else
			return true ;
	}
	
	function getCheckCategory(category){
		
			$("input:checkbox[name='category']").each(function(){
			
				if(category == $(this).val()){
					$(this).prop("checked", true);
				}
			
			});
	}
	
	function getSearchList(keyword, category){

		
		$.ajax({
			
			url : "/Semi_Challengers/search_list.do",
			data : {"keyword" : keyword,
					"category" : category
			},
			datatype : "xml",
			async : false,
			success : function(data){
/*				let table = "";
				$("#search_item").empty();
			
				if(data == 1){
					table += "<tr><td class='none'>찾으시는 챌린지가 없습니다.</td></tr>"; 
				}else{

					let count = 0;
					table += "<tr>";
					$(data).find("chall_list").each(function() {
						count += 1;
						
						table += "<td><a href='" +getContextPath()+ "/search_content.do?num=" +$(this).find("chall_num").text()+ "'>";	
						table += "<img src='" +getContextPath()+ "/uploadFile/" +$(this).find("chall_mainimage").text()+ "'><br><br>";
						table += $(this).find("chall_creater_name").text()+ "<br>";
						table += $(this).find("chall_title").text()+ "<br>";
						table += $(this).find("chall_cycle").text()+ "&nbsp;";
						table += $(this).find("chall_duration").text()+ "&nbsp;";
						
						if(count%4==0){
							table += "</tr>";
							table += "<tr>";
						}
					});
				}
				table += "</tr>";
				$(".search_item").append(table);*/
				
				$("#card_chall").empty();
					
				let card = "<div class='card_chall'>";
				let count= 0;
				
				$(data).find("chall_list").each(function() {
					count += 1
					card += "<div class='chall_items'>";
					card += "<a href='" +getContextPath()+ "/search_content.do?num=" +$(this).find("chall_num").text()+ "'><img class='category_image' src='" +getContextPath()+ "/uploadFile/" +$(this).find("chall_category_image").text()+ "'>";
					card += "<p>" +$(this).find("chall_title").text()+ "</p></a>";
					card += "<span>" +$(this).find("chall_cycle").text()+ "</span><br>";
					card += "<span>" +$(this).find("chall_duration").text()+ "</span><br>";
					card += "</div>";
					
					if(count % 4 == 0){
						card += "</div>";
						card += "<div class='card_chall'>";
						count = 0;
					}
					
				});
				
				if(count %4 != 0){
					card += "<div class='chall_items'>";
					card += "<div class='chall_none'></div>";
					card += "</div>";
				}
				card += "</div>";
				$("#card_chall").append(card);
				
				
			},
			error : function(){
				alert('검색 목록 불러오기 실패');
			}
			
			
		});
	} // getSearchList end
	
		// 검색 옵션 설정 시 리스트 출력 함수
	function getSearchListOption(keyword, cycle, duration, category){
	
	
		$.ajax({
			url : "/Semi_Challengers/search_list_option.do",
			data : {
				optionCy : cycle,
				optionDu : duration,
				optionCa : category,
				keyword : keyword
				},
			datatype : "xml",
			success : function(data){
				
				$("#search_item").empty();
			
				let table = "";
				let count = 0;
				table += "<tr>";
				$(data).find("chall_list").each(function() {
					count += 1;
					table += "<td><a href='" +getContextPath()+ "/search_content.do?num=" +$(this).find("chall_num").text()+ "'>";	
					table += "<img src='" +getContextPath()+ "/uploadFile/" +$(this).find("chall_mainimage").text()+ "'><br><br>";
					table += $(this).find("chall_creater_name").text()+ "<br>";
					table += $(this).find("chall_title").text()+ "<br>";
					table += $(this).find("chall_cycle").text()+ "&nbsp;";
					table += $(this).find("chall_duration").text()+ "&nbsp;";
					
					if(count%4==0){
						table += "</tr>";
						table += "<tr>";
					}
				});
				
				table += "</tr>";
				$(".search_item").append(table);
				
			},
			error : function(){
				alert('옵션 선택 불러오기 실패');
			}		
		});
		
		
	} //getSearchListOption() end
	
	
	function testOption(keyword){
	
		let arrCy = [];
		let arrDu = [];
		let arrCa = [];
		
		let sizeCy = $("input:checkbox[name='cycle']:checked").length;
		let sizeDu = $("input:checkbox[name='duration']:checked").length;
		let sizeCa = $("input:checkbox[name='category']:checked").length;
		if(sizeCy>=1){
			
			$("input:checkbox[name='cycle']:checked").each(function(){
			
			arrCy.push($(this).val());
			
			});
		}
		
		
		if(sizeDu>=1){
			
			$("input:checkbox[name='duration']:checked").each(function(){
			
			arrDu.push($(this).val());
			
			});
		}
		
		
		if(sizeCa>=1){
			$("input:checkbox[name='category']:checked").each(function(){
			
			arrCa.push($(this).val());
			
			});
		}
		
		let strCy = arrCy.join(',');
		let strDu = arrDu.join(',');
		let strCa = arrCa.join(',');
		
		getHash(strCy, strDu, strCa, keyword);
			
		
	} // testOption() end
	
	
	// Ajax 페이지 이동 구현
	$(window).on("hashchange", function(){
		
		let hash = document.location.hash;
		
		let decodeHashURI = decodeURI(hash);
		
		let regEx = /#([a-zA-z]+)/;	
		
		// /#([a-zA-z]+)\/([ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|]+)_([ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|]+)=([ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|]+)/i;
		
		let match = decodeHashURI.match(regEx);
		
		if(hash!=""){
			if(match){
				let category = match[1];
				
				if(category == "option"){
					let regEx = /#([a-zA-z]+)\/keyword=(.*)&cycle=(.*)&duration=(.*)&category=(.*)/i;
					let match = decodeHashURI.match(regEx);
					let key = match[2];
					let cycle = match[3];
					let duration = match[4];
					let category = match[5];
					
					getSearchListOption(key, cycle, duration, category);
					
				}
			}
		}
			
		
	}); // hashchange end
	
	

	$("#test").on("click", function(){
		
		if($(".cycle").is(":checked") || $(".duration").is(":checked")){
			testOption(keyword);	
			
		}else if($(".category").is(":checked")){
			testOption(keyword);
		}else{
			getHashKey(keyword);
		}
		
		
	});	
	

		if(check(category)){
			getCheckCategory(category);
		}
	
		getSearchList(keyword, category);

		
});	

$('#search_list').on('ajaxComplete', function() {
	
	
	console.log('성공?');
	
	
});