/**
 * 
 */

function getContextPath(){
		
		let path = location.href.indexOf(location.host)+location.host.length;
		
		return location.href.substring(path, location.href.indexOf('/', path+1));
}

let VIEW_ITEM_DATA = 1;
let VIEW_ITEM_MAXCOUNT = 50;

function checkNull(obj){
	
	if(obj==""||obj==null||obj==undefined||obj==NaN){
		return true;
	}else{
		return false;
	}
}


function setLocalStorage(name, obj){
	localStorage.setItem(name, obj);
}

function removeLocalStorage(name){
	localStorage.removeItem(name);
} 

function getLocalStorage(name){
	return localStorage.getItem(name);
}




/*최근 본 상품 공간 확보, 일정 시간 지난 것 빼고 재저장, 페이지별 무조건 호출*/
function initLatelyViewItemList(){
	/*로컬스토리지에서 저장된 정보 있는지 확인*/
	if(checkNull(getLocalStorage('latelyItemList'))){
		/*없을 경우 공간 생성*/
		setLocalStorage('latelyItemList', null);
		
		/*챌린지를 표시할 태그에 없을 경우 표시*/
		let card = "";
		card += "<div class='card_items'>";
		card += "<p>최근 조회한 챌린지가 없습니다.</p>";
		card += "</div>";
		
		$("#card_qurency").append(card);
		
	}else{ /* 기존 정보가 있을 경우*/
		
		let latelyItemListJson = getLocalStorage('latelyItemList');
		
		/*실제 저장된 데이터가 있는 경우*/
		if(latelyItemListJson != "null" || checkNull(latelyItemListJson)){
			
			let nowDate = new Date();
			
			/*문자열을 자바스크립트 객체로 변환*/
			let latelyItemList = JSON.parse(latelyItemListJson);
			
			/*일정시간 경과된 아이템 제외 후 다시 넣기위한 Array*/
			let latelyItemNew = new Array();
			
			/*챌린지별 저장된 시간이 현재 시간보다 클 경우 다시 추가*/
			for(let i in latelyItemList){
				let viewTime = new Date(latelyItemList[i].viewTime);
				
				/*시간이 경과된 경우를 제외하고 재저장*/
				if(nowDate.getTime() < viewTime.getTime()){
					latelyItemNew.push(latelyItemList[i])
				}
			}
			
			/*시간이 모두 경과된 경우 로컬 스토리지를 비워줌*/
			if(latelyItemNew.length == 0){
				setLocalStorage('latelyItemList', null); /*재저장*/
			}else{
				setLocalStorage('latelyItemList', JSON.stringify(latelyItemNew));
			}
			
		}
		
			console.log("겟>> " +getLocalStorage('latelyItemList'));
			let latelyItemList = JSON.parse(getLocalStorage('latelyItemList'));
			console.log(latelyItemList[0].itemNum);
			
		/*화면을 그리는 함수 호출*/
		latelyViewItemRender();
	} /*else문 end*/
} /*initLatelyViewItemList() end*/


/*최근 본 상품 화면 셋팅(페이징)*/
function latelyViewItemRender(){
	
	/*로컬스토리지에서 latelyItemList 값 확인*/
	if(getLocalStorage('latelyItemList') !="null"||checkNull(getLocalStorage('latelyItemList'))){
		
		let latelyItemList = JSON.parse(getLocalStorage('latelyItemList'));
		
		let card = "";
		/*가져온 최근 본 챌린지 올리기*/
		for(let i=0; i<5; i++){
			
			if(!checkNull(latelyItemList[i])){
				
				/*상품 그리는 부분 */
				card += "<div class='card_items'>";
				card += "<a href='" +getContextPath()+ "/search_content.do?num=" +latelyItemList[i].itemNum+ "'><img class='card_image' src='" +getContextPath()+ "/uploadFile/" +latelyItemList[i].itemImagePath+ "'>";
				card += "<p>" +latelyItemList[i].itemTitle+ "</p></a>";
				card += "</div>";
				
			}else{
				card += "<div class='card_items'><div class='blank'></div></div>";
			}
		}
		
		$("#card_qurency").append(card);
		
	}else{ /*챌린지가 없을 경우*/
		$("#card_qurency").empty();

		$("#card_qurency").append("<div class='none'>최근 조회한 챌린지가 없습니다</div>");
	}
} /* latelyViewItemRender() end*/




$(document).ready(function(){
	
	initLatelyViewItemList()
	
});

