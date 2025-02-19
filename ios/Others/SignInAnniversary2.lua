local key = nil
local targetTime = 0
local cfg = nil
function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Activity_SignIn, ESignCB)
    fade = ComUtil.GetCom(gameObject, "ActionFade")
end

function OnDestroy()
    eventMgr:ClearListener()
    ReleaseCSComRefs()
end

function Refresh(data,elseData)
    local isSingIn = data.isSingIn ~= nil and data.isSingIn or false
    key = data.key
    cfg = elseData and elseData.cfg or nil

    -- CSAPI.SetGOActive(mask, isSingIn)
    if (isSingIn) then
        EventMgr.Dispatch(EventType.Activity_Click)
    end
    SetDatas()
    SetTime()
end

-- 如果是12或者倒数12位，则额外加多2个空数据填位
function SetDatas()
    curDatas1 = {}
    curDatas2 = {}
    local info = SignInMgr:GetDataByKey(key)
    local curDay = info:GetRealDay()
    datas = SignInMgr:GetDayInfos(key)
    for i, v in ipairs(datas) do
        if i < 4 then
            table.insert(curDatas1, v)
        else
            table.insert(curDatas2, v)
        end
    end
    items1 = items1 or {}
    ItemUtil.AddItems("SignInContinue10/SignInAnniversary2Item",items1,curDatas1,grid)
    items2 = items2 or {}
    ItemUtil.AddItems("SignInContinue10/SignInAnniversary2Item",items2,curDatas2,grid2)

    -- layout:IEShowList(#curDatas, nil, curDay)
end

-- 签到回调
function ESignCB(proto)
    -- if(isClick) then return end
    local _key = SignInMgr:GetDataKey(proto.id, proto.index)
    if (key ~= _key) then
        return
    end
    if proto.isOk == false then
        EventMgr.Dispatch(EventType.Acitivty_List_Pop)
        return
    end
    SignInMgr:AddCacheRecord(key)
    -- CSAPI.SetGOActive(mask, false)
    -- layout:UpdateList()
    SetDatas()
    isClick = false
    ActivityMgr:SetListData(cfg.id, {
        key = _key
    })
end

function SetTime()
    local info = SignInMgr:GetDataByKey(key)
    local cfg = Cfgs.CfgSignReward:GetByID(info.proto.id)

    if cfg then
        local startTimeStr = StringUtil:split(cfg.begTime, " ")[1]
        -- local targetTimeStr = StringUtil:split(cfg.endTime, " ")[1]
        CSAPI.SetText(txtTime,LanguageMgr:GetByID(22046) .. startTimeStr .. "~" .. cfg.endTime)
        -- targetTime = TimeUtil:GetTimeStampBySplit(cfg.endTime)
    end
end

function PlayFade(isFade, cb)
    local star = isFade and 1 or 0
    local target = isFade and 0 or 1
    if not IsNil(fade) then
        fade:Play(star, target, 200, 0, function()
            if cb then
                cb()
            end
        end)
    end
end

-- 自动签到
function OnClickMask()
    if (not isClick) then
        isClick = true
        local data = SignInMgr:GetDataByKey(key)
        ClientProto:AddSign(data:GetID())

        if (data) then
            local rewards = {}
            for i, info in pairs(data:GetRewardCfg().infos) do
                if (i == data:GetIndex()) then
                    for k, m in pairs(info.rewards) do
                        table.insert(rewards, {
                            id = m[1],
                            num = m[2]
                        })
                    end
                end
            end

            local taData = {
                reson = "领取活动奖励",
                activity_name = "周年签到2",
                task_id = data.proto.index,
                task_name = data.proto.index,
                item_gain = rewards
            }
            BuryingPointMgr:TrackEvents("activity_attend", taData)
        end
    end
end

-- 点击背景
function OnClickClose()
    view:Close()
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    hsv = nil;
    mask = nil;
    view = nil;
end
----#End#----
