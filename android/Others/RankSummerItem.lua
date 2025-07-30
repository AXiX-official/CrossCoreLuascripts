function SetClickCB(_cb)
	cb = _cb
end

function SetIndex(_i)
	index = _i
end

function Refresh(_info,elseData)
	info = _info
	isOpenReplace = elseData and elseData.isOpenReplace or false
	type = elseData and elseData.rankType or nil
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
	-- 显示2
	CSAPI.SetText(txtFighting, info:GetScore() .. "")
	-- 显示1
	if IsShowTurn() then
		if type==eRankId.MultTeamRank then
            CSAPI.SetText(txtTurnNum,LanguageMgr:GetByID(77036,info:GetTurnNum() ))
        else
            CSAPI.SetText(txtTurnNum, info:GetTurnNum() .. "")
        end
    end
	--icon
	-- ResUtil.CRoleItem_BG:Load(iconBg, "btn_02_03")
	-- local _cfg = Cfgs.character:GetByID(info:GetModuleID())
	-- if(_cfg.icon) then
	-- 	ResUtil.RoleCard:Load(icon, _cfg.icon, true)
	-- end
	UIUtil:AddHeadByID(hfParent, 0.9, info:GetFrameId(), info:GetIconID(),info:GetSex())
	--title
	UIUtil:AddTitleByID(titleParent,0.6,info:GetTitle())

	CSAPI.SetGOActive(btnOpen,isOpenReplace)
	--
	CSAPI.SetText(txtHard,info:GetHard())

	if type == eRankId.BuffBattleRank then
        CSAPI.SetAnchor(txtTurnNum,581,0)
        CSAPI.SetAnchor(txtFighting,285,0)
    end
end

function GetName()
	return info and info:GetName() or ""
end

function IsShowTurn()
    local cfg = Cfgs.CfgRankTeam:GetByID(rankType)
    if cfg and cfg.isHideTurn then
        return false
    end
    return true
end

function OnClick()
	if cb then
		cb(this)
	end
end