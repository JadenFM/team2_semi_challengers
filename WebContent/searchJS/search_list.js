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
	let page = 1;
	let loading = true;
	let scroll_option = "";
	
	console.log('시작 page>>> ' +page);
	
	
	function getHash(strCy, strDu, strCa, keyword){
		
		document.location.hash = "option/keyword=" +keyword+ "&cycle=" +strCy+ "&duration=" +strDu+ "&category=" +strCa;
		
	}
	
	function getHashKey(keyword){
		
		document.location.hash = "search/keyword=" +keyword;
		
	}
	
	function getHashCategory(category){
		document.location.hash = "category/category=" +category;
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
	
	function ref(){
		
		console.log('ref실행');
		let hash = document.location.hash;
		
		let decodeHashURI = decodeURI(hash);
		
		let regEx = /#([a-zA-z]+)/;	
		
		let match = decodeHashURI.match(regEx);
		
		if(match){
			let category = match[1];
			
			if(category == "search"){
					let regEx = /#search\/keyword=(.*)/i;
					let match = decodeHashURI.match(regEx);
					let code = match[1];
					let define = "";
					getSearchList(code, define, page);
					scroll_option = "search";
			}
		}else{
			if(check(category)){
					console.log('시작카테고리');
					getHashCategory(category);
					getCheckCategory(category);
				}else{
					console.log('시작 키워드');
					getHashKey(keyword);
				}
		}
		
	}
	
	function getCheckCategory(category){
		
			$("input:checkbox[name='category']").each(function(){
			
				if(category == $(this).val()){
					$(this).prop("checked", true);
				}
			
			});
	}
	
	function getSearchList(keyword, category, page){

		console.log(keyword);
		console.log(category);
		console.log(page);
		console.log("===========");
		$.ajax({
			
			url : "/Semi_Challengers/search_list.do",
			data : {"keyword" : keyword,
					"category" : category,
					"page" : page
			},
			datatype : "xml",
			async : false,
			success : function(data){
				
					
				let card = "<div class='card_chall'>";
				let count= 0;
				
				if(data == 1){
					card += "<div class='none2'>챌린지가 없습니다.</div>"; 
					loading = false;
					
				}else{
				
					$(data).find("chall_list").each(function() {
						count += 1
						card += "<div class='chall_items'>";
						card += "<a href='" +getContextPath()+ "/search_content.do?num=" +$(this).find("chall_num").text()+ "'>";
						card += "<div class='img_wrap'>";
						card += "<img class='most_chall_image' src='" +getContextPath()+ "/uploadFile/" +$(this).find("chall_mainimage").text()+ "'>";
						card += "<div class='img_text'><span><img class='icon_people' src='" +getContextPath()+ "/search_image/people.jpg'></span>&nbsp;" +$(this).find("chall_ongoingpeople").text()+ "명</div></div>";
						card += "<span class='span_img'><img class='profil' src='"+getContextPath()+"/memUpload/" +$(this).find("chall_creater_img").text()+ "'></span>&nbsp;";
						card += "<span class='span_creater'>" +$(this).find("chall_creater_name").text()+ "</span><br>";
						card += "<p>" +$(this).find("chall_title").text()+ "</p><a>";
						card += "<span class='span_wrap'>" +$(this).find("chall_cycle").text()+ "</span>&nbsp;";
						card += "<span class='span_wrap'>" +$(this).find("chall_duration").text()+ "</span>&nbsp;";
						card += "</div>";
						
						if(count % 4 == 0){
							card += "</div>";
							card += "<div class='card_chall'>";
							count = 0;
						}
						
					});
				
					if(count %4 != 0){
						for(let i=count; i<4; i++){
							card += "<div class='chall_items'>";
							card += "<div class='chall_none'></div>";
							card += "</div>";
							count++;
						}
					}
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
	
		console.log('중복실행 에이젝스 체크');
		$.ajax({
			url : "/Semi_Challengers/search_list_option.do",
			data : {
				optionCy : cycle,
				optionDu : duration,
				optionCa : category,
				keyword : keyword,
				page : page
				},
			datatype : "xml",
			success : function(data){
				
					
				let card = "<div class='card_chall'>";
				let count= 0;
				
				if(data == 1){
					card += "<div class='none2'>챌린지가 없습니다.</div>"; 
					loading = false;
				}else{
				
					$(data).find("chall_list").each(function() {
						count += 1
						card += "<div class='chall_items'>";
						card += "<a href='" +getContextPath()+ "/search_content.do?num=" +$(this).find("chall_num").text()+ "'>";
						card += "<div class='img_wrap'>";
						card += "<img class='most_chall_image' src='" +getContextPath()+ "/uploadFile/" +$(this).find("chall_mainimage").text()+ "'>";
						card += "<div class='img_text'><span><img class='icon_people' src='" +getContextPath()+ "/search_image/people.jpg'></span>&nbsp;" +$(this).find("chall_ongoingpeople").text()+ "명</div></div>";
						card += "<span class='span_img'><img class='profil' src='"+getContextPath()+"/memUpload/" +$(this).find("chall_creater_img").text()+ "'></span>&nbsp;";
						card += "<span class='span_creater'>" +$(this).find("chall_creater_name").text()+ "</span><br>";
						card += "<p>" +$(this).find("chall_title").text()+ "</p><a>";
						card += "<span class='span_wrap'>" +$(this).find("chall_cycle").text()+ "</span>&nbsp;";
						card += "<span class='span_wrap'>" +$(this).find("chall_duration").text()+ "</span>&nbsp;";
						card += "</div>";
						
						if(count % 4 == 0){
							card += "</div>";
							card += "<div class='card_chall'>";
							count = 0;
						}
						
					});
					
					if(count %4 != 0){
						for(let i=count; i<4; i++){
							card += "<div class='chall_items'>";
							card += "<div class='chall_none'></div>";
							card += "</div>";
							count++;
						}
					}
				}
				
					card += "</div>";
					$("#card_chall").append(card);
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
		
		console.log('해시이벤트 시작');
		$("#card_chall").empty();
		
		let hash = document.location.hash;
		
		let decodeHashURI = decodeURI(hash);
		
		let regEx = /#([a-zA-z]+)/;	
		
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
					scroll_option = "option";
				}else if(category == "search"){
					
					let regEx = /#search\/keyword=(.*)/i;
					let match = decodeHashURI.match(regEx);
					let code = match[1];
					let define = "";
					getSearchList(code, define, page);
					scroll_option = "search";
				}else if(category == "category"){
					let regEx = /#category\/category=(.*)/i;
					let match = decodeHashURI.match(regEx);
					let code = match[1];
					let define = "";
					getSearchList(define, code, page);
					scroll_option = "category";
				}
			}
		}
			
		
	}); // hashchange end
	
	

	$("#search_option").on("click", function(){
		
		$("#card_chall").empty();
		page = 1;
		
		if($(".cycle").is(":checked") || $(".duration").is(":checked")){
			testOption(keyword);	
			
		}else if($(".category").is(":checked")){
			testOption(keyword);
		}else{
			getHashKey(keyword);
		}
		
		
	});	
	
	
	/*페이지 로드*/
	ref();
		
		
		
	$(window).scroll(function(){
	
	
	
	if(loading){
	    if($(window).scrollTop()>=$(document).height() - $(window).height()){
		
			let hash = document.location.hash;
			
			let decodeHashURI = decodeURI(hash);
			
			console.log('스크롤 이벤트 if문 실행');
			console.log('keyword >>> ' +keyword);
			console.log('category >>> ' +category);
			page++;
			console.log('page >>> ' +page);
			console.log('scroll_option >>> ' +scroll_option);
			
			if(scroll_option == "option"){
				
				console.log('중복실행 체크');
				let regEx = /#([a-zA-z]+)\/keyword=(.*)&cycle=(.*)&duration=(.*)&category=(.*)/i;
				let match = decodeHashURI.match(regEx);
				let key = match[2];
				let cycle = match[3];
				let duration = match[4];
				let category = match[5];
				
				getSearchListOption(key, cycle, duration, category);
			}else if(scroll_option == "search"){
				
				let regEx = /#search\/keyword=(.*)/i;
				let match = decodeHashURI.match(regEx);
				let code = match[1];
				let define = "";
				
				getSearchList(code, define, page);
				
			}else if(scroll_option == "category"){
				let regEx = /#category\/category=(.*)/i;
				let match = decodeHashURI.match(regEx);
				let code = match[1];
				let define = "";
				getSearchList(define, code, page);
			}
			
	    }
	}
});
		
		

		
});	




























