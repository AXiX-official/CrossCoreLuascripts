--关卡组
local clickCallBack = nil
local curName = nil
local alpha = 0
local data = nil
local btnPos = {}
local isSelect = false

local index = 0

function SetClickCB(callBack)
	clickCallBack = callBack
end

function SetIndex(idx)
	index = idx
end

function Awake()	
	bgFade = ComUtil.GetCom(bg, "ActionFade")
	nodeFadeT = ComUtil.GetCom(node, "ActionFadeT")
	dotCloseFadeT = ComUtil.GetCom(dotClose, "ActionFadeT")
	dotOpenFadeT = ComUtil.GetCom(dotOpen, "ActionFadeT")
	canvasGroup = ComUtil.GetCom(gameObject, "CanvasGroup")
end

function Refresh(_data)
	data = _data
	if data then				
		--icon
		SetColor()
		
		--index
		CSAPI.SetText(txtNum, index .. "")
		
		--name
		CSAPI.SetText(txtName, data:GetName())
		
		--title
		CSAPI.SetText(txtTitle2, index .. "")
		
		--pos
		SetPos(data:GetPos())
		
		--btnPos
		SetBtnPos(data:GetRelativePos())
		
		--new
		SetNew(data:IsCurrNew())

		--star
		local cur,max = data:GetStar()
		if cur ~= max then
			cur = StringUtil:SetByColor(cur.."", "FFFFFF")
		end
		SetStar(cur.."/"..max)
		
		--button
		-- SetBtnActive(data:IsOpen())
		
		--action
		--SetTxtState()
	end
end

function SetPos(pos)
	CSAPI.SetLocalPos(gameObject, pos.x, pos.y)
end

function SetBtnPos(pos)
	pos = pos and pos or {100, 0}
	local x = 180 *(pos[1] / 100)
	local y = 80 *(pos[2] / 100)
	CSAPI.SetAnchor(root, x, y)
	btnPos = {x, y}
end

function SetNew(isNew)
	CSAPI.SetGOActive(newObj, isNew)
end

function SetStar(str)
	CSAPI.SetText(txtStar,str)
	local starColor = {255, 193, 70, 255}
	if not data:IsOpen() then
		starColor = {255, 255, 255, 255}
	end
	CSAPI.SetTextColor(txtStar,starColor[1],starColor[2],starColor[3],starColor[4])
	CSAPI.SetImgColor(starImg,starColor[1],starColor[2],starColor[3],starColor[4])
end

--能否点击
function SetBtnActive(isClick)
	CSAPI.SetGOActive(btnClick, isClick)
end

function Show(isShow)
	canvasGroup.alpha = isShow and 1 or 0
end

function ShowRoot(isShow)
	CSAPI.SetGOActive(root, isShow)
end

function SetSel(isSel)
	isSelect = isSel
	SetColor()
end

--设置颜色
function SetColor()
	type = type or 0
	if not txtCG then
		txtCG = ComUtil.GetCom(txtObj, "CanvasGroup")
	end
	txtCG.alpha = data:IsOpen() and 1 or 0.4
	
	local iconColor = {255, 255, 255, 255}
	local nameColor = {255, 255, 255, 255}
	local titleColor1 = {255, 255, 255, 255}
	local titleColor2 = {255, 255, 255, 255}
	local numColor = {255, 255, 255, 255}
	
	if isSelect or data:IsCurrNew() then
		iconColor = {255, 193, 70, 255}
		nameColor = {255, 193, 70, 255}
		titleColor1 = {255, 193, 70, 255}
		titleColor2 = {255, 193, 70, 255}
		numColor = {15, 15, 25, 255}
	elseif(data:IsHard()) then
		iconColor = {255, 0, 64, 255}
	else
		numColor = {15, 15, 25, 255}
	end
	CSAPI.SetImgColor(icon, iconColor[1], iconColor[2], iconColor[3], iconColor[4])
	CSAPI.SetTextColor(txtName, nameColor[1], nameColor[2], nameColor[3], nameColor[4])
	CSAPI.SetTextColor(txtTitle1, titleColor1[1], titleColor1[2], titleColor1[3], titleColor1[4])
	CSAPI.SetTextColor(txtTitle2, titleColor2[1], titleColor2[2], titleColor2[3], titleColor2[4])	
	CSAPI.SetTextColor(txtNum, numColor[1], numColor[2], numColor[3], numColor[4])	
end

--text组件状态 
function SetAction(cb)
	bgFade:Play(0, 1, 200)
	nodeFadeT:Play(function()
		if cb then
			cb()
		end
	end)
end

function SetDotAction(isOpen)
	if not isOpen then
		dotCloseFadeT:Play()
	else
		dotOpenFadeT:Play()
	end
end

--缩放
function SetScale(scale)
	CSAPI.SetScale(gameObject, 1 / scale, 1 / scale, 1)
end

function SetRootScale(scale)
	CSAPI.SetScale(root.gameObject, 1 / scale * 2, 1 / scale * 2, 1)
end

function GetOffsetPos()
	return btnPos and btnPos or {0, 0}
end

function GetIndex()
	return index
end

function GetID()
	return data:GetID()
end

function GetGroups()
	return data and data:GetDungeonGroups()
end

function GetPassCount()
	if data then
		return data:GetPassCount()
	end
	return 0,0
end

function IsHard()
	return data:IsHard()
end

function IsPass()
	return data:IsPass()
end

function OnClick()
	local isOpen, str = data:IsOpen()
	if not isOpen then
		local cfgID = data:GetDungeonGroups()[1]
		local cfg = Cfgs.MainLine:GetByID(cfgID)
		if not cfg or not cfg.preChapterID then
			return
		end
		local preCfgID = Cfgs.MainLine:GetByID(cfgID).preChapterID[1]
		local preCfg = Cfgs.MainLine:GetByID(preCfgID)
		local name = preCfg and preCfg.chapterID .. " " .. preCfg.name or ""
		LanguageMgr:ShowTips(25002, name)
		return
	end
	if clickCallBack then
		clickCallBack(this)
	end
end

function OnDestroy()	
	ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	centerObj = nil;
	dot = nil;
	root = nil;
	bg = nil;
	node = nil;
	img = nil;
	icon = nil;
	txtObj = nil;
	txtNum = nil;
	txtTitle = nil;
	txtName = nil;
	newObj = nil;
	txtNew = nil;
	btnClick = nil;
	dotClose = nil;
	dotOpen = nil;
	view = nil;
end
----#End#----
