-- function Awake()
-- 	--综合战力
-- 	CSAPI.SetText(txtFighting1, StringConstant.Exercise21)
-- 	--排名
-- 	CSAPI.SetText(txtRank1, StringConstant.Exercise40)
-- end
function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    data = _data
    if (data) then
        -- role
        if (data.icon_id) then
            local cfg = Cfgs.character:GetByID(data.icon_id)
            SetIcon(cfg.Fight_head)
        end
        -- attack
        CSAPI.SetText(txtFighting2, data.performance .. "")
        -- rank
        CSAPI.SetText(txtRank2, data.rank == 0 and "--" or tostring(data.rank))
        -- name
        CSAPI.SetText(txtName, data.name)
        -- lv
        CSAPI.SetText(txtLv, data.level .. "")
        -- 积分
        local zf1 = ExerciseMgr:GetScore()
        local zf2 = data.score
        local zf = GCalHelp:GetArmyAddScore(zf1, zf2)
        CSAPI.SetText(txtZf2, "+" .. zf)
    end
end

function SetIcon(iconName)
    if iconName then
        CSAPI.SetGOActive(role, true);
        ResUtil.FightCard:Load(role, iconName);
    else
        CSAPI.SetGOActive(role, false);
    end
end

-- 查看
function OnClick()
    if (cb) then
        cb(data)
    end
end
