local info = nil
local key = nil
local items = {}

function Refresh(_data,_elseData)
    info = _data
    key = _elseData
    if info then
        if key == "cfgGlobalBossKill" then
            SetBossKill()
        elseif key == "CfgRankReward" then
            SetRankReward()
        end
    end
end

function SetBossKill()
    local curMonth = TimeUtil:GetTimeHMS(TimeUtil:GetTime(),"%m")
    local curDay = (g_BosssTart or 1) + (info.day or 0)
    if g_BosscLose and curDay > g_BosscLose then --超过关闭日
        curDay = g_BosscLose
    end
    LanguageMgr:SetText(txtName,70010,curMonth,curDay)
    if info.mailId then
        local cfgMail = Cfgs.CfgMail:GetByID(info.mailId)
        if cfgMail and cfgMail.rewards then
            ShowReward(cfgMail.rewards)
        end
    end
end


function SetRankReward()
    local sub = info.sub
    local up = info.up
    local str1 = sub[1] == 1 and sub[2] or math.floor(sub[2] / 100) .. "%"
    if up == nil then
        CSAPI.SetText(txtName,str1 .. "+")
    elseif sub[2] == up[2] then 
        CSAPI.SetText(txtName,str1 .. "")
    else
        local str2 = up[1] == 1 and up[2] or math.floor(up[2] / 100) .. "%"
        CSAPI.SetText(txtName,str1.."-"..str2)
    end

    if info.mailId then
        local cfgMail = Cfgs.CfgMail:GetByID(info.mailId)
        if cfgMail and cfgMail.rewards then
            ShowReward(cfgMail.rewards)
        end
    end
    CSAPI.SetAnchor(grid,-100,40)
end

function ShowReward(rewards)
    GridAddRewards(items,rewards,grid,1,#rewards)
end