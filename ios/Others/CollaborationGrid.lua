--角色支援
local data = nil
local card = nil
local uid = 0

function SetClickCB(_cb)
	cb = _cb
end

function SetIndex(idx)
	index = idx
end

function Refresh(_data, elseData)
	data = _data
	uid = elseData
	CSAPI.SetRTSize(icon, 0, 0)	
	if data then		
		Show(true)
		AddChild()
	else
		card = nil
		Show(false)
		SetQuality()
	end
end

function Show(isShow)	
	CSAPI.SetGOActive(nilObj, not isShow)
	CSAPI.SetGOActive(lvObj, isShow)
	CSAPI.SetGOActive(icon, isShow)
end

function AddChild()
	CSAPI.SetGOActive(rootNode, true)
	card = CharacterCardsData(data.card_info)
	--lv
	CSAPI.SetText(txt_lv, card:GetLv() .. "")
	--icon
	SetIcon(card:GetIcon())
	--quality
	SetQuality(card:GetQuality())
end

--icon
function SetIcon(_iconName)
	if(_iconName) then
		ResUtil.RoleCard:Load(icon, _iconName, true)
		CSAPI.SetScale(icon, 0.5, 0.5, 1)
		-- CSAPI.SetRTSize(icon, 105, 105)
	end
end

function SetScale(scale)
	scale=scale or 1;
	CSAPI.SetScale(gameObject, scale, scale, scale)
end

function SetQuality(quality)
	quality=quality or 3;
	local iconName = "img_02_0" .. quality
	ResUtil.CardBorder:Load(qualityImg, iconName, false)	
end

function GetCid()
	return data and data.cid
end

function GetIndex()
	return index
end

function OnClickSelf()
	if cb then
		cb(this)
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
bgIcon=nil;
nilObj=nil;
icon=nil;
lvObj=nil;
txtLv2=nil;
equipObj=nil;
equipIcon_1=nil;
equipIcon_2=nil;
equipIcon_3=nil;
equipIcon_4=nil;
equipIcon_5=nil;
view=nil;
end
----#End#----