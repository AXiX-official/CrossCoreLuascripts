local curIndex = 1
local key = nil
local items = {}
local descFade = nil
local modelId = 0
local soundIndex = 1
local isSignIn = false

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Activity_SignIn, ESignCB)
    descFade = ComUtil.GetCom(desc, "ActionFade")

    CSAPI.SetGOActive(desc, false)

    cardIconItem = RoleTool.AddRole(iconParent, PlayCB, EndCB)

    fade = ComUtil.GetCom(gameObject, "ActionFade")
end

function OnDestroy()
    eventMgr:ClearListener()
    ReleaseCSComRefs()
end

function OnDisable()
    RoleAudioPlayMgr:StopSound()
end

function Refresh(data)
    isSignIn = data.isSingIn ~= nil and data.isSingIn or false
    key = data.key
    -- CSAPI.SetGOActive(mask, isSignIn)
    if (isSignIn) then
        EventMgr.Dispatch(EventType.Activity_Click)
    end
    SetDatas()
    SetTime()
    -- 卡牌角色id
    SetRole(50080)
end

function SetDatas(closeAnim)
    curDatas = {}
    local info = SignInMgr:GetDataByKey(key)
    local curDay = info:GetRealDay()
    datas = SignInMgr:GetDayInfos(key)

    for i, v in ipairs(datas) do
        table.insert(curDatas, v)
    end

    curIndex = curDay
    LanguageMgr:SetText(txtDay, 13013, curIndex .. "")

    SetItems(curDatas,closeAnim)
end

function SetItems(datas,closeAnim)
    items = items or {}
    for i = 1, 7 do
        local pos = {
            x = -527 + (i - 1) % 3 * 261,
            y = 137 - math.floor(i / 4) * 359
        }
        if i > 6 then -- 第七天位置做特殊处理
            pos = {
                x = 258,
                y = -44
            }
        end
        if items[i] == nil then
            if i < 7 then
                ResUtil:CreateUIGOAsync("SignInContinue/SignInContinueItem", grids, function(go)
                    local lua = ComUtil.GetLuaTable(go)
                    lua.Refresh(datas[i], curIndex == i and isSignIn)
                    lua.SetPos(pos)
                    lua.ShowAnim()
                    table.insert(items, lua)
                end)
            else
                ResUtil:CreateUIGOAsync("SignInContinue/SignInContinueItem2", grids, function(go)
                    local lua = ComUtil.GetLuaTable(go)
                    lua.Refresh(datas[i], curIndex == i and isSignIn)
                    lua.SetPos(pos)
                    lua.ShowAnim()
                    table.insert(items, lua)
                end)
            end
        else
            items[i].Refresh(datas[i], curIndex == i and isSignIn)
            items[i].SetPos(pos)
            if not closeAnim then
                items[i].ShowAnim()
            end
        end
    end
end

-- 签到回调
function ESignCB(proto)

    local _key = SignInMgr:GetDataKey(proto.id, proto.index)
    if (key ~= _key) then
        return
    end
    if proto.isOk == false then
        EventMgr.Dispatch(EventType.Acitivty_List_Pop)
        return
    end
    SignInMgr:AddCacheRecord(key)
    isSignIn = false
    -- CSAPI.SetGOActive(mask, false)
    SetDatas(true)
    isClick = false
    ActivityMgr:SetListData(ActivityListType.SignInContinue, {
        key = _key
    })
    ActivityMgr:CheckRedPointData(ActivityListType.SignInContinue)

    local taData = {
        reson = "领取活动奖励",
        activity_name = "七日活动",
        task_id = proto.id,
        task_name = proto.index,
        item_gain = rewards
    }
    BuryingPointMgr:TrackEvents("activity_attend", taData)
end

function SetTime()
    local info = SignInMgr:GetDataByKey(key)
    local cfg = Cfgs.CfgSignReward:GetByID(info.proto.id)

    if cfg and cfg.begTime and cfg.endTime then
        local s1 = StringUtil:split(cfg.begTime, " ")
        local s2 = StringUtil:split(cfg.endTime, " ")
        CSAPI.SetText(txtTime, s1[1] .. "-" .. s2[1])
    end
end

function SetRole(id)
    local cfg = Cfgs.CfgCardRole:GetByID(id)
    if cfg then
        -- CSAPI.SetText(txtName, cfg.sAliasName or "")
        -- CSAPI.SetText(txtName2, cfg.eName or "")
        modelId = cfg.aModels
        -- RoleTool.LoadImg(icon, cfg.aModels + 1, LoadImgType.Main)
        cardIconItem.Refresh(modelId + 1, LoadImgType.Main, nil, false)
    end
end

-- 声音id
function PlayVoiceByID(id)
    local cfgSound = Cfgs.Sound:GetByID(id)
    if cfgSound and (not RoleAudioPlayMgr:GetIsPlaying()) then
        RoleAudioPlayMgr:Play(cfgSound, PlayCB, EndCB)
    end
end


function PlayCB(curCfg)
    if (not IsNil(gameObject)) then
        local cfgSound = Cfgs.Sound:GetByKey(curCfg.key)
        local script = SettingMgr:GetSoundScript(cfgSound) 
        if cfgSound and script then
            CSAPI.SetText(txtDesc, script)
            CSAPI.SetGOActive(desc, true)
            descFade.delayValue = 0
            descFade:Play(0, 1, 200)
        end
    end
end

function EndCB()
    if (not IsNil(gameObject)) then
        descFade.delayValue = 1
        descFade:Play(1, 0, 200, 0)
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
        end
    end
end

-- 点击背景
function OnClickClose()
    view:Close()
end

function OnClickSound()
    local ids = {50080125,50080126,50080127}
	if(cardIconItem) then
		cardIconItem.PlayVoiceByID(ids[soundIndex])
	end
    soundIndex = soundIndex +1
    if soundIndex > #ids then
        soundIndex = 1
    end
end

function PlayFade(isFade,cb)
	local star = isFade and 1 or 0
	local target = isFade and 0 or 1
	fade:Play(star,target,200,0,function ()
		if cb then
			cb()
		end
	end)
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
