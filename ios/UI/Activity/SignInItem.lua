
--SignInfDayInfo
function Refresh(_data,isClear)
	data = _data

	if isClear == true then
		ClearItem()
	end
	
	CSAPI.SetGOActive(clickNode, data ~= nil)
	CSAPI.SetGOActive(emptyObj, data == nil)
	if data then
		index = data:GetIndex() or 1 --天
		isDone = data:CheckIsDone() --已签
		isEnd = data:CheckIsEnd()   --过期
		isCurDay = data:GetIsCurDay() --是否是当天
		
		local rewards = data:GetRewards()
		reward = rewards[1]  --只取一个数据
		goodsData = data:GetGoodsData()
		
		SetIcon()
		SetDay()
		SetImages()		
	end
end

--reward 1,id 2,num 3,type
function SetIcon()	
	local _data = {type = reward[3], num = reward[2], id = reward[1]}	
	if _data and not isFirst then
		isFirst = true
		if goodsData then
			CSAPI.LoadImg(frame, "UIs/SignIn/iconImg" .. goodsData:GetQuality() .. ".png", false, nil, true)
			LoadIcon(goodsData:GetIcon())
		end
		--state
		local maskStr = ""
		if isDone then
			maskStr = LanguageMgr:GetByID(13002)
		elseif isEnd then
			maskStr = LanguageMgr:GetByID(13003)
		else
			maskStr = "X" .. _data.num
		end
		CSAPI.SetText(txtMask, maskStr)
		
	end
end

--加载图标
function LoadIcon(iconName)
	CSAPI.SetGOActive(icon, iconName ~= nil);
	if(iconName) then
		ResUtil.IconGoods:Load(icon, iconName .. "")
		--CSAPI.SetScale(icon, 0.9, 0.9, 1)
	end
end

function SetDay()
	local _index = index < 10 and "0" .. index or index
	CSAPI.SetText(txtDay, _index .. "")
end

function SetImages()	
	--sel
	if isDone or isEnd then
		CSAPI.SetGOActive(selimg, isCurDay)
	end
	--done
	CSAPI.SetGOActive(doneImg, isDone)	
	
	if not canvasGroup then
		canvasGroup = ComUtil.GetCom(itemObj, "CanvasGroup")
	end
	local isAlpha = isEnd or isDone
	canvasGroup.alpha = isAlpha and 0.3 or 1
end

function SetSelect()
	CSAPI.SetGOActive(selimg, true)
	if not selFade then
		selFade = ComUtil.GetCom(selimg, "ActionFade")
	end
	selFade:Play(0, 1, 1000)
end

function ClearItem()
	CSAPI.SetGOActive(selimg, false)
	isFirst = false
end

function IsCurDay()
	return isCurDay
end

function OnClick()
	local isCard = false
	if(reward[3] == RandRewardType.ITEM) then
		local cfg = Cfgs.ItemInfo:GetByID(reward[1])
		if(cfg.type == ITEM_TYPE.CARD) then
			isCard = true
		end
	end
	if(isCard) then
		CSAPI.OpenView("RolesFullInfo", {id = reward[1], num = reward[2], type = reward[3]})
	else
		UIUtil:OpenGoodsInfo(goodsData, 2)
	end
end

function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
clickNode=nil;
itemObj=nil;
frame=nil;
icon=nil;
txtDay=nil;
txtMask=nil;
doneImg=nil;
selimg=nil;
emptyObj=nil;
view=nil;
end
----#End#----