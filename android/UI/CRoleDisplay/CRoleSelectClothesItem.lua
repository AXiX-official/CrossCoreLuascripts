--服装选择
local canUse = false 

function SetIndex(_index)
	index = _index
end

function SetClickCB(_cb)
	cb = _cb
end
-- data :  RoleSkinInfo
function Refresh(_data, _elseData)
	data = _data
	elseData = _elseData
	
	CSAPI.SetGOActive(entity, not data.isEmpty)
	CSAPI.SetGOActive(empty, data.isEmpty)
	if(not data.isEmpty) then
		--icon
		SetIcon(data:GetSkinID())
		--select
		CSAPI.SetGOActive(selectObj, elseData.isSelect)
		--no
		canUse = data:CheckCanUseByMaxLV()
		if(not canvasGroup) then
			canvasGroup = ComUtil.GetCom(clickNode, "CanvasGroup")
		end
		canvasGroup.alpha = canUse and 1 or 0.5
		CSAPI.SetGOActive(txtNo, not canUse)
	end
end

function SetIcon(_modelID)
	if(_modelID) then
		local cfg = Cfgs.character:GetByID(_modelID)
		if(cfg) then
			ResUtil.CardIcon:Load(icon, cfg.Card_head)
		end
	end
end

function OnClick()
	if(not data.isEmpty and canUse and cb) then
		cb(index)
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
entity=nil;
icon=nil;
selectObj=nil;
obj=nil;
txt_select=nil;
txtNo=nil;
empty=nil;
txtEmpty=nil;
view=nil;
end
----#End#----