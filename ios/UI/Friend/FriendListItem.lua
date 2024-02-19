local data = nil
local typeIndex = nil
local index = 0


local iconName = {"Friend", "Find", "Sreach", "Black"}
local typeStr = {"Friend", "Find", "Sreach", "Black"}


function SetIndex(idx)
	index = idx
end

function SetClickCB(_cb)
	cb = _cb
end

function Refresh(_data, _elseData)
	data = _data
	typeIndex = _elseData
	SetSelect(typeIndex == data.index)
	SetPanel()
	StartTween()
end

function SetPanel()
	--title
	CSAPI.SetText(txtTitle1, data.name)
	CSAPI.SetText(txtTitle2, typeStr[index])
	
	--new
	SetNew()
	
	--icon
	SetIcon()
end

--红点
function SetNew()
	local isNew = false
	if data and data.datas and #data.datas > 0 then
		if data.index == 3 then
			isNew = true
		else
			for i, v in ipairs(data.datas) do	
				local friendData = FriendMgr:GetData(v.uid)				
				if friendData:IsNew() and friendData:IsOnLine() then
					isNew = true
					break
				end
			end	
		end
	end
	CSAPI.SetGOActive(newObj, isNew)
end

--图标
function SetIcon()
	CSAPI.LoadImg(icon, "UIs/Friend/" .. iconName[data.index] .. ".png", true, nil, true)
end

--选择状态
function SetSelect(isSelect)
	CSAPI.SetGOActive(light, isSelect)
	
	local color = isSelect and {255, 255, 255, 255} or {255, 255, 255, 125}
	CSAPI.SetTextColor(txtTitle1, color[1], color[2], color[3], color[4])
	CSAPI.SetTextColor(txtTitle2, color[1], color[2], color[3], color[4])
	CSAPI.SetImgColor(icon, color[1], color[2], color[3], color[4])
	CSAPI.SetImgColor(img1, color[1], color[2], color[3], color[4])
	
	if not isFirst then
		isFirst = true
		local scale = isSelect and 1 or 0.85
		CSAPI.SetScale(top, scale, scale, 1)
		return
	end
	
	LineAnim(isSelect)
	TopAnim(isSelect)
end

function GetType()
	return data and data.index
end

function OnClick()
	if(cb) then
		cb(this)
	end
end


--进入动画
function StartTween()
	CSAPI.SetGOActive(start, true)
	LineAnim(typeIndex == data.index)
end

--线段动画
function LineAnim(_isSelect)
	local xScale = _isSelect and 3 or 1
	CSAPI.SetUIScaleTo(img1, nil, xScale, 1, 1, nil, 0.1)
end

--图标和字体动画
function TopAnim(_isSelect)
	local scale = _isSelect and 1 or 0.85
	CSAPI.SetUIScaleTo(top, nil, scale, scale, 1, nil, 0.1)
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
img1=nil;
top=nil;
icon=nil;
txtTitle1=nil;
light=nil;
txtTitle2=nil;
newObj=nil;
start=nil;
view=nil;
end
----#End#----