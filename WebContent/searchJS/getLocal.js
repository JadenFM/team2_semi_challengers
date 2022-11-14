/**
 * 
 */

let VIEW_ITEM_DATA = 1;
let VIEW_ITEM_MAXCOUNT = 50;
let VIEW_ITEM_PAGESIZE = 5;

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


/*챌린지를 볼 경우 호출*/
function moveItemViewPage(itemNum, itemTitle, itemImagePath){
	
	console.log('로컬등록 함수 실행');
	
	let latelyItemListJson = getLocalStorage('latelyItemList');
	let viewTime = new Date();
	
	/*최근 본 챌린지가 없을경우 무조건 저장*/
	if(latelyItemListJson=="null"||checkNull(latelyItemListJson)){
		
		let latelyItemListNew = new Array();
		
		let latelyItem = {
			"itemNum" : itemNum,
			"itemImagePath" : itemImagePath,
			"itemTitle" : itemTitle,
			"viewTime" : viewTime.setDate(viewTime.getDate() + Number(VIEW_ITEM_DATA))	
		}
		
		latelyItemListNew.unshift(latelyItem);
		setLocalStorage('latelyItemList', JSON.stringify(latelyItemListNew));
		
	}else{ /*최근 본 챌린지가 있을 경우*/
		let latelyItemList = JSON.parse(latelyItemListJson);
		let isExistsItem = false;
		
		breakPoint : for(var i in latelyItemList){
			if(Number(latelyItemList[i].itemNum) == Number(itemNum)){
				isExistsItem = true;
				break breakPoint;
			}
		}
		
		
		/*새로 본 상품일 경우만 저장*/
		if(!isExistsItem){
			
			/*최대 50개일 경우 마지막 삭제 후 제일 앞에 저장*/
			if(latelyItemList.length == Number(VIEW_ITEM_MAXCOUNT)) latelyItemList.pop();
			
			let latelyItem = {
				"itemNum" : itemNum,
				"itemImagePath" : itemImagePath,
				"itemTitle" : itemTitle,
				"viewTime" : viewTime.setDate(viewTime.getDate() + Number(VIEW_ITEM_DATA))	
			}
				
			latelyItemList.unshift(latelyItem);
			setLocalStorage('latelyItemList', JSON.stringify(latelyItemList));
		}
		
	} /*else 문 end*/
	
} /*moveItemViewPage() end*/


$(document).ready(function(){
	
	console.log('getLocal JS 실행');
	
	let num = $("#local_num").val();
	let title = $("#local_title").val();
	let image = $("#local_image").val();	
	
	console.log('num >>> ' +num);
	console.log('title >>> ' +title);
	console.log('image >>> ' +image);
	
	moveItemViewPage(num, title, image);
});