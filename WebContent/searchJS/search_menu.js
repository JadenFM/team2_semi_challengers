/**
 * search.jsp 페이지 애니메이션 기능
 */

$(document).ready(function(){
	
	$(".toggle_menu").on("click", function(){
		
		let subMenu = $(this).nextAll("ul");
		let icon = $(this).next("span").children("a");
		
		if(subMenu.is(":visible")){
			subMenu.slideUp();
			icon.text("+");
		}else{
			subMenu.slideDown();
			icon.text("-");
		}
	});
	
	// 체크박스 선택 이벤트
	$("#category_all").on("click", function(){
		if($("#category_all").is(":checked")){
			$(".category").prop("checked", true);
		}else{
			$(".category").prop("checked", false);
		}
	});
	$(".category").on("click", function(){
		
		if($("input:checkbox[class='category']:checked").length==$(".category").length){
			
			$("#category_all").prop("checked", true);
		}else{
			$("#category_all").prop("checked", false);
		}
	});
	
	$("#cycle_all").on("click", function(){
		if($("#cycle_all").is(":checked")){
			$(".cycle").prop("checked", true);
		}else{
			$(".cycle").prop("checked", false);
		}
	});
	$(".cycle").on("click", function(){
		
		if($("input:checkbox[class='cycle']:checked").length==$(".cycle").length){
			
			$("#cycle_all").prop("checked", true);
		}else{
			$("#cycle_all").prop("checked", false);
		}
	});
	
	$("#duration_all").on("click", function(){
		if($("#duration_all").is(":checked")){
			$(".duration").prop("checked", true);
		}else{
			$(".duration").prop("checked", false);
		}
	});
	
	$(".duration").on("click", function(){
		
		if($("input:checkbox[class='duration']:checked").length==$(".duration").length){
			
			$("#duration_all").prop("checked", true);
		}else{
			$("#duration_all").prop("checked", false);
		}
	}); // 체크박스 선택 이벤트 end
	
	
	$(".top_btn").on("click", function(){
	
		window.scrollTo(0,0);
	
	})
	
	
});