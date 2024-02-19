local colors = {"ffffff", "12f6b2", "30baf7", "956dfd", "ffc146", "ffffff"}
local isShowHot = true
local labelGos = {}

function Awake()
	--立绘
	--cardImgLua = RoleTool.AddRole(iconParent)
end

function OnInit()
	UIUtil:AddTop2("RoleInfoFussion", gameObject, function() view:Close() end, nil, {})
	
	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.Card_Update, OnOpen) --非基础卡更换皮肤
end

function OnDestroy()
	--停止上一段语音
	RoleAudioPlayMgr:StopSound()
	eventMgr:ClearListener()
end

function OnOpen()
	oldCardData = data[1]
	skillData = data[2]
	cfg = Cfgs.skill:GetByID(skillData.id)
	
	InitData()
	RefreshPanel()
end


--封装数据
function InitData()
	local career = 1
	--形态切换、同调 --等级继承，技能、被动技能继承等级，副天赋继承主体，变更皮肤
	if(cfg.type == SkillType.Transform or cfg.type == SkillType.Unite) then	
		local cardId = cfg.type == SkillType.Transform and oldCardData:GetCfg().tTransfo[1] or oldCardData:GetCfg().fit_result
		local cardCfg = Cfgs.CardData:GetByID(cardId)
		--普通技能需要重新封装
		local newSkillDatas = {}
		local curSkillsID = cardCfg.jcSkills
		local skills = oldCardData:GetSkills()
		for i, v in ipairs(skills) do
			local cfg = Cfgs.skill:GetByID(v.id)
			table.insert(newSkillDatas, {id = curSkillsID[i] +(cfg.lv - 1), exp = 0, type = SkillMainType.CardNormal})
		end
		--被动技能
		local sSkillID = cardCfg.tfSkills and cardCfg.tfSkills[1] or nil
		if(sSkillID) then
			local skillsDatas = oldCardData:GetSkills(SkillMainType.CardTalent)
			if(#skillsDatas > 0) then
				local id = skillsDatas and skillsDatas[1].id or nil
				if(id) then
					local cfg = Cfgs.skill:GetByID(id)
					sSkillID = sSkillID +(cfg.lv - 1)
					table.insert(newSkillDatas, {id = sSkillID, exp = 0, type = SkillMainType.CardTalent})
				end
			end
		end
		--副天赋
		--重新封装
		local newInfo = {}
		newInfo = table.copy(oldCardData:GetData())
		newInfo.cfgid = cardId
		newInfo.skills = newSkillDatas
		cardData = CharacterCardsData(newInfo)	
		career = cardCfg.career	
	else
		--召唤 --等级继承，技能、被动技能不继承(到怪物表拿数据)、无副天赋
		local cardId = oldCardData:GetCfg().summon
		local cardCfg = Cfgs.MonsterData:GetByID(cardId)
		--普通技能需要重新封装
		local newSkillDatas = {}
		local curSkillsID = cardCfg.jcSkills
		for i, v in ipairs(curSkillsID) do
			local cfg = Cfgs.skill:GetByID(v)
			table.insert(newSkillDatas, {id = curSkillsID[i], exp = 0, type = SkillMainType.CardNormal})
		end
		--被动技能
		local sSkillID = cardCfg.tfSkills and cardCfg.tfSkills[1] or nil
		table.insert(newSkillDatas, {id = sSkillID, exp = 0, type = SkillMainType.CardTalent})
		
		--重新封装
		local newInfo = {}
		local key = string.format("%s_%s", cardCfg.numerical, oldCardData:GetLv())
		local cfg = Cfgs.MonsterNumerical:GetByKey(key)
		newInfo = table.copy(cfg)
		newInfo.cfgid = cardId
		newInfo.skills = newSkillDatas
		newInfo.break_level = 1
		newInfo.intensify_level = 1
		
		local monsterCardsData = require "MonsterCardsData"
		cardData = MonsterCardsData(newInfo)	
	end
end

function RefreshPanel()
	if(cardData) then
		baseData = cardData:GetBaseProperty()
		curStatusData = cardData:GetTotalProperty()	
		
		SetRole()
		SetName()
		SetTeam()
		SetStar()
		SetLv()
		SetPosEnum()
		SetStatus()
		SetProperty()
		SetSkills()
		SetTalent()
		SetTips()
		SetBreak()
	end
end

function SetBreak()
    local breakLv = cardData:GetBreakLevel()
    CSAPI.SetGOActive(imgBreak, breakLv > 1)
    if (breakLv > 1) then
        ResUtil.RoleCard_BG:Load(imgBreak, "img_37_0" .. (breakLv - 1))
    end
end

function SetRole()
	CSAPI.SetScale(iconParent, 0, 0, 0)
    RoleTool.LoadImg(img, cardData:GetSkinID(), LoadImgType.RoleInfo, function()
        CSAPI.SetScale(iconParent, 1, 1, 1)
    end)

	-- CSAPI.SetScale(iconParent, 0, 0, 0)
	-- cardImgLua.Refresh(cardData:GetSkinID(), LoadImgType.RoleInfo, function()
	-- 	CSAPI.SetScale(iconParent, 1, 1, 1)
	-- end,false)
end


--设置名称
function SetName()
	CSAPI.SetText(txtName1, cardData:GetName())
	CSAPI.SetText(txtName2, cardData:GetEnName())
	--bg
	local quality = cardData:GetQuality()
	local iconName = quality == 6 and "img_4_02.png" or "img_4_01.png"
	CSAPI.LoadImg(imgName, "UIs/Role/" .. iconName, true, nil, true)
	CSAPI.SetImgColorByCode(imgName, colors[quality])
end

--小队
function SetTeam()
	local teamCfg = Cfgs.CfgTeamEnum:GetByID(cardData:GetCamp())
	local iconName = teamCfg.details
	ResUtil:LoadBigImgByExtend(imgTeam1, "Team/" .. iconName .. "/bg.png")
	ResUtil:LoadBigImgByExtend(imgTeam2, "Team/" .. iconName .. "/bg1.png")
end

function SetStar()
    local quality = cardData:GetQuality()
    --bg 
    local iconName = quality == 6 and "img_5_02.png" or "img_5_01.png"
    CSAPI.LoadImg(imgStarBg, "UIs/Role/" .. iconName, true, nil, true)
    CSAPI.SetImgColorByCode(imgStarBg, colors[quality])
    local width = 302 - (6 - quality) * 31
    width = width < 156 and 156 or width
    CSAPI.SetRTSize(imgStarBg, width, 126)
    --star
    ResUtil.RoleCard_BG:Load(imgStar, "img_01_0" .. quality)
    --anim
    if (oldID == nil or oldID ~= cardData:GetID()) then
        UIUtil:SetPObjMove(imgStar, 150, 0, 0, 0, 0, 0, nil, 300, 1)
        UIUtil:SetObjFade(imgStar, 0, 1, nil, 300, 1)
        oldID = cardData:GetID()
    end
end

-- function SetStar()
-- 	local quality = cardData:GetQuality()
-- 	for i = 1, 6 do
-- 		CSAPI.SetGOActive(this["imgStar" .. i], quality >= i)
-- 	end
-- 	local starName = quality >= 6 and "c_img_1_2" or "c_img_1_1"
-- 	ResUtil.RoleStar:Load(imgStar1, starName, true)
-- 	CSAPI.SetImgColorByCode(imgStar1, colors[quality])
-- 	--bg
-- 	local iconName = quality == 6 and "img_5_02.png" or "img_5_01.png"
-- 	CSAPI.LoadImg(imgStarBg, "UIs/Role/" .. iconName, true, nil, true)
-- 	CSAPI.SetImgColorByCode(imgStarBg, colors[quality])

-- 	local width = 302 -(6 - quality) * 31
-- 	width = width < 156 and 156 or width
-- 	CSAPI.SetRTSize(imgStarBg, width, 126)
-- end

function SetLv()
	CSAPI.SetText(txtLv1, cardData:GetLv() .. "")
	CSAPI.SetText(txtLv2, "/" .. cardData:GetMaxLv())
	--exp
	local cur = cardData:GetEXP()
	local max = RoleTool.GetExpByLv(cardData:GetLv())
	if(not expBar) then
		expBar = ComUtil.GetCom(exp, "OutlineBar")
	end
	expBar:SetProgress(max == nil and 1 or cur / max)
end


--角色定位
function SetPosEnum()
	local enums = {}
	local _nums = cardData:GetCfg().pos_enum
	if(_nums) then
		for i, v in ipairs(_nums) do
			local cfg = Cfgs.CfgRolePosEnum:GetByID(v)
			table.insert(enums, cfg)
		end
		local len = #enums
		if(len > 0) then
			local childCount = posEnumGrids.transform.childCount
			local origin = posEnumGrids.transform:GetChild(0).gameObject
			for i, v in ipairs(enums) do
				if(i <= childCount) then
					local _tran = posEnumGrids.transform:GetChild(i - 1)
					CSAPI.SetGOActive(_tran.gameObject, true)
					ResUtil.RolePos:Load(_tran:GetChild(0).gameObject, v.icon)
					CSAPI.SetText(_tran:GetChild(1).gameObject, v.sName)
				else
					local go = CSAPI.CloneGO(origin, posEnumGrids.transform)
					ResUtil.RolePos:Load(go.transform:GetChild(0).gameObject, v.icon)
					CSAPI.SetText(go.transform:GetChild(1).gameObject, v.sName)
				end
			end		
			for i = len + 1, childCount do
				CSAPI.SetGOActive(posEnumGrids.transform:GetChild(i - 1).gameObject, false)
			end
		end	
	end
	CSAPI.SetGOActive(posEnumGrids, #enums > 0)
end

--属性  
function SetStatus()
	--属性条
	statusItems = statusItems or {}	
	statusDatas = {}
	for i, v in ipairs(g_RoleAttributeList) do
		if(i > 4) then
			break
		end
		local cfg = Cfgs.CfgCardPropertyEnum:GetByID(v)
		local key = cfg.sFieldName
		local _data = {}
		_data.id = v
		local val1 = baseData[key]
		local val2 = curStatusData[key]
		--1
		_data.val1 = GetBaseValue(key)
		--2
		if(val2 > val1) then
			_data.val2 = "+" .. RoleTool.GetStatusValueStr(key, val2 - val1)
		else
			_data.val2 = nil
		end
		_data.nobg = true
		table.insert(statusDatas, _data)
	end
	ItemUtil.AddItems("AttributeNew2/AttributeItem6", statusItems, statusDatas, statusGrids)
end
--当前未加成属性值
function GetBaseValue(_key)
	local num = baseData[_key]
	if(num) then
		return RoleTool.GetStatusValueStr(_key, num)
	end
	return ""
end

--性能
function SetProperty()
	CSAPI.SetText(txtProperty2, cardData:GetProperty() .. "")
end

--技能
function SetSkills()
    newSkillDatas = cardData:GetSkillsForShow()
    local ids = {}
    for k, v in pairs(newSkillDatas) do
        table.insert(ids, v.id)
    end
    skillItems = skillItems or {}
    ItemUtil.AddItems("Role/RoleInfoSkillItem1", skillItems, ids, skillGrids, ClickSkillItemCB)
end
function ClickSkillItemCB(index)
    CSAPI.OpenView("RoleSkillInfoView", {newSkillDatas[index], cardData}, 1)
end

function SetTalent()
	talentDatas = GetTalentData()
	talentItems = talentItems or {}
	ItemUtil.AddItems("Role/RoleInfoTalentItem1", talentItems, talentDatas, talentGrids, ClickTalentItemCB, 1, cardData)
end
function ClickTalentItemCB(index)
	local _data = talentDatas[index]
	if(_data.isOpen and _data.id) then
		CSAPI.OpenView("RoleSkillInfoView", {talentDatas[index], cardData}, 2)
	end
end

--封装天赋数据
function GetTalentData()
	local _talentDatas = {}
	local quality = cardData:GetBreakLevel()
	local use = cardData:GetDeputyTalent().use or {}
	for i = 1, 3 do
		local _data = {}
		_data.isOpen = quality > i
		_data.id = nil
		if(_data.isOpen and use[i] ~= 0) then
			_data.id = use[i]
		end
		table.insert(_talentDatas, _data)
	end
	return _talentDatas
end

function SetTips()
	--desc
	local strID = 4101
	if(cfg.type ~= SkillType.Summon) then
		strID = cfg.type == SkillType.Unite and 4102 or 4103
	end
	LanguageMgr:SetText(txtTips2, strID)
	--同调
	CSAPI.SetGOActive(objFit, cfg.type == SkillType.Unite)
	if(cfg.type == SkillType.Unite) then
		if(not layoutAuto) then
			layoutAuto = ComUtil.GetCom(labelObj, "LayoutAuto")
		end
		local strs = RoleUniteUtil:GetStrs(oldCardData:GetCfg())
		if(#strs > 0) then
			labelGos = labelGos or {}
			if(#labelGos < 1) then
				table.insert(labelGos, label.gameObject)
			end
			for i = 1, #strs do
				local go = nil
				if(labelGos[i]) then
					go = labelGos[i]
				else
					go = CSAPI.CloneGO(labelGos[1], labelObj.transform)	
					table.insert(labelGos, go)				
				end
				CSAPI.SetGOActive(go, true)
				local text = ComUtil.GetComInChildren(go, "Text")
				text.text = strs[i]
			end	
			if(#strs < #labelGos) then
				for i = #strs + 1, #labelGos do
					CSAPI.SetGOActive(labelGos[i], false)
				end
			end
			
			layoutAuto:Refresh()
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------
--服装
function OnClickApparel()
	if(not cardData.isMonster) then
		CSAPI.PlayUISound("ui_generic_tab_2") --todo 
		CSAPI.OpenView("RoleApparel", cardData)
	end
end

--放大
function OnClickAmplification()
	CSAPI.OpenView("RoleInfoAmplification", {cardData:GetRoleID(), cardData:GetSkinID(), false}, LoadImgType.RoleInfo)
end


--属性展开
function OnClickAttributeDetail()
	CSAPI.OpenView("AttributeInfoTView", cardData)
end


-- function OnClickUnite()
-- 	--同调对象数据已在后端中计算
-- 	CSAPI.OpenView("RoleUniteView", oldCardData:GetCfg().unite)
-- end

