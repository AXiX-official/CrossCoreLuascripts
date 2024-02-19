local isHold = false
local timer = 0

function SetIndex(_index)
	index = _index
end

function Update()
	if(isPress and Time.time > holdDownTime and Time.time > timer) then
		timer = Time.time + 0.1
		OnClick()
	end
end

function Refresh(_data, _giftData, _isMax)
	data = _data
	giftData = _giftData --选中的后数据
	isMax = _isMax
	isPress = isMax and false or isPress
	
	--bg
	LoadFrame(data:GetQuality())
	--icon
	LoadIcon(data:GetIcon())
	--count
	CSAPI.SetText(txt_count, data:GetCount() .. "")
	--exp
	local color =(giftData.percent > 0) and "00ffbf" or "ffffff"
	StringUtil:SetColorByName(txtExp, giftData.totalVal, color)
	--select,sel
	CSAPI.SetGOActive(selectObj, giftData.num > 0)
	if(giftData.num > 0) then
		CSAPI.SetText(txtSel, giftData.num .. "")
	end
	--percent
	local str = ""
	if(giftData.percent > 0) then
		str = "+" .. giftData.percent
	end
	CSAPI.SetText(txtPercent, str) --todo 11
end

--加载框
function LoadFrame(lvQuality)
	if lvQuality then
		local frame = GridFrame[lvQuality];
		ResUtil.IconGoods:Load(bg, frame);
	else
		ResUtil.IconGoods:Load(bg, GridFrame[1]);
	end
end

--加载图标
function LoadIcon(iconName)
	CSAPI.SetGOActive(icon, iconName ~= nil);
	if(iconName) then
		ResUtil.IconGoods:Load(icon, iconName .. "")
	end
end

function OnClick()
	giftData.slectFunc(this)
	
	if(giftData.had <= 0) then
		LanguageMgr:ShowTips(21022)
	end
end

function OnClickRemove()
	giftData.removeFunc(this)
end

function OnPressDown(isDrag, clickTime)
	holdDownTime = Time.time + 1.5
	timer = Time.time
	isPress = true
end

function OnPressUp(isDrag, clickTime)	
	if not isDrag then
		if Time.time < holdDownTime then
			OnClick()		
		end
	end
	isPress = false
end 