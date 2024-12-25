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
    local sub = info.sub or 1
    local up = info.up or -1
    if up == -1 then
        CSAPI.SetText(txtName,sub .. "+")
    else
        CSAPI.SetText(txtName,sub.."-"..up)
    end
    

    if info.mailId then
        local cfgMail = Cfgs.CfgMail:GetByID(info.mailId)
        if cfgMail and cfgMail.rewards then
            ShowReward(cfgMail.rewards)
        end
    end
end

function ShowReward(rewards)
    GridAddRewards(items,rewards,grid,1,#rewards)
end