/**
 * 
 */
function prevSlide(){
	$(".slide").hide();
	let slideAll = $(".slide");
	let currentIndex = 0;
	
	$(".slide").each(function(index, item){
		if($(this).hasClass("active")){
			currentIndex = index;
		}
	});
	
	let newIndex = 0;
	
	if(currentIndex <= 0){
		newIndex = slideAll.length-1;
	}else{
		newIndex = currentIndex-1;
	}
	
	$(".slide").removeClass("active");
	$(".slide").eq(newIndex).addClass("active");
	$(".slide").eq(newIndex).show();
}

function nextSlide(){
	
	$(".slide").hide();
	let slideAll = $(".slide");
	let currentIndex = 0;
	
	$(".slide").each(function(index, item){
		if($(this).hasClass("active")){
			currentIndex = index;
		}
	});
	
	let newIndex = 0;
	
	if(currentIndex >= slideAll.length-1){
		newIndex = 0;
	}else{
		newIndex = currentIndex+1;
	}
	$(".slide").removeClass("active");
	$(".slide").eq(newIndex).addClass("active");
	$(".slide").eq(newIndex).show();
}

$(document).ready(function(){
	
	setInterval(nextSlide, 4000);

	
})

