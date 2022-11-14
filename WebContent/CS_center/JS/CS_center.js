
$(function(){
	$.ajaxSetup({
		ContentType: "application/x-www-form-urlencoded; charset=UTF-8",
		type : "post"								
	}); // ajaxSetup 끝
});



function getNoticeList(){
	$.ajax({
		url : "/Semi_Challengers/cs_notice_list.do",
		datatype : "html",
		success : function(data){
			$("#CS_content").html(data);
		},
		error : function(){
			toastr.warning('데이터 통신 에러');
		}
		
	});
}




