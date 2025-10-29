function SetClickCB(_cb)
	cb = _cb
end

function SetIndex(_i)
	index = _i
end

function Refresh(_info,elseData)
	info = _info
	isOpenReplace = elseData and elseData.isOpenReplace or false
	local rank = info:GetRank()

	--bg
	CSAPI.SetGOActive(bg1, true)
	CSAPI.SetGOActive(bg2, false)
	--color
	CSAPI.SetGOActive(imgColor, rank < 4)
	if(rank < 4) then
		CSAPI.LoadImg(imgColor, "UIs/Rank/img_02_0" .. rank .. ".png", true, nil, true);
	end
	--name
	CSAPI.SetText(txtName, info:GetName())
	--等级
	local lvStr = LanguageMgr:GetByID(1033) or "LV."
	CSAPI.SetText(txtLv, info:GetLevel() .. "")
	--排名
	CSAPI.SetText(txtRank1, rank < 4 and rank .. "" or "")
	CSAPI.SetText(txtRank2, rank >= 4 and rank .. "" or "")
	--战斗力
	CSAPI.SetText(txtFighting, info:GetDamage() .. "")
	--icon
	UIUtil:AddHeadByID(hfParent, 0.9, info:GetFrameId(), info:GetIconID(), info:GetSex())
	--title
	UIUtil:AddTitleByID(titleParent,0.6, info:GetTitle())
	--cards
	SetCards()
end

function SetCards()
	if info:GetCardList() and #info:GetCardList()>0 then
		local cards = {}
		for i, v in ipairs(info:GetCardList()) do
			table.insert(cards,CharacterCardsData(v))
		end
		items = items or {}
		ItemUtil.AddItems("RoleLittleCard/RoleSmallCard", items, cards, teamGrid, OnClick)
	end
end

function GetName()
	return info and info:GetName() or ""
end

function OnClick()
	if cb then
		cb(this)
	end
end