function SetClickCB(_cb)
	cb = _cb
end

function SetIndex(_i)
	index = _i
end

function Refresh(_info)
	info = _info
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
	CSAPI.SetText(txtLv, lvStr .. info:GetLevel())
	--排名
	CSAPI.SetText(txtRank1, rank < 4 and rank .. "" or "")
	CSAPI.SetText(txtRank2, rank >= 4 and rank .. "" or "")
	--战斗力
	CSAPI.SetText(txtFighting, info:GetScore() .. "")
	--icon
	-- ResUtil.CRoleItem_BG:Load(iconBg, "btn_02_03")
	-- local _cfg = Cfgs.character:GetByID(info:GetModuleID())
	-- if(_cfg.icon) then
	-- 	ResUtil.RoleCard:Load(icon, _cfg.icon, true)
	-- end
	UIUtil:AddHeadByID(hfParent, 0.9, info:GetFrameId(), info:GetIconID(),info:GetSex())
end