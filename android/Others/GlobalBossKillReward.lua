local cfgGlobalBoss =nil
local cfg = nil
local layout = nil
local curDatas = nil
function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/GlobalBoss/GlobalBossRewardItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if lua then
        local _data = curDatas[index]
        lua.Refresh(_data,"cfgGlobalBossKill")
    end
end

function Refresh(_data)
    cfgGlobalBoss = _data
    if cfgGlobalBoss and cfgGlobalBoss.killRwdGroupId then
        cfg = Cfgs.cfgGlobalBossKill:GetByID(cfgGlobalBoss.killRwdGroupId)
        if cfg then
            if curDatas == nil then
                curDatas = {}
                if cfg.infos and #cfg.infos > 0 then
                    for i, info in ipairs(cfg.infos) do
                        table.insert(curDatas,info)
                    end
                    if #curDatas> 0 then
                        table.sort(curDatas,function (a,b)
                            return a.index < b.index
                        end)
                    end
                end
            end
            SetItems()
        end
    end
end

function SetItems()
    layout:IEShowList(#curDatas,nil,1)
end