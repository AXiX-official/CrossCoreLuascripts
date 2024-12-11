local isPlay = true
local timer = nil
local words = {}
local oldStr = ""
local cur = 0
local graphic = nil
local l2d = nil
local topLua

function Awake()
    topLua = UIUtil:AddTop2("ASMRShow", gameObject, function()
        timer = nil
        ASMRMgr:StopBGM()
        view:Close()
    end, nil, {})
    CSAPI.SetGOActive(topLua.gameObject, false)

    -- 立绘
    cardIconItem = RoleTool.AddRole(iconParent, nil, nil, false)
    -- 多人插图 
    mulIconItem = RoleTool.AddMulRole(iconParent, nil, nil, false)
end

function OnDestroy()
    ASMRMgr:RemoveCueSheet(curData:GetCfg().id, 2)
    SetMusic(false)
end

function OnOpen()
    SetMusic(true)
    curData = ASMRMgr:GetData(data)
    Play()
    local l2dName = curData:GetCfg().l2d
    if (l2dName) then
        SetL2d(l2dName)
    else
        SetModel()
    end
end

function SetModel()
    local model = curData:GetCfg().model
    CSAPI.SetGOActive(cardIconItem.gameObject, model >= 10000)
    CSAPI.SetGOActive(mulIconItem.gameObject, model < 10000)
    local item = model >= 10000 and cardIconItem or mulIconItem
    item.Refresh(model, LoadImgType.Main, nil, false)
end

function Play()
    words = {}
    local voiceCfg = Cfgs.CfgAsmrVoice:GetByID(curData:GetCfg().voice)
    for k, v in pairs(voiceCfg.arr) do
        words[v.time] = v.word
    end
    ASMRMgr:StopBGM()
    source = ASMRMgr:PlayBGM(curData:GetCfg().id, 2)
    timer = Time.time
end

function Update()
    if (timer ~= nil and Time.time >= timer) then
        timer = Time.time + 1
        local time = source:GetCurTime()
        if (time >= cur) then
            cur = time
            oldStr = words[math.floor(time)] or oldStr
            CSAPI.SetText(txtVoice, oldStr)
        else
            view:Close()
        end
    end
end

function OnClickBG()
    isPlay = not isPlay
    CSAPI.SetGOActive(topLua.gameObject, not isPlay)
    CSAPI.SetGOActive(stop, not isPlay)
    source:Pause(not isPlay)
    timer = isPlay and Time.time or nil
    if (l2d) then
        local te = l2d.animationState:GetCurrent(0)
        if (te) then
            te.TimeScale = isPlay and 1 or 0
        end
    end
end

function SetL2d(l2dName)
    ResUtil:CreateSpine(l2dName .. "/" .. l2dName, 0, 0, 0, bg, function(go)
        l2d = ComUtil.GetCom(go, "CSpine")
    end)
end

function SetMusic(isOpen)
    if(not CSAPI.IsViewOpen("ASMRView"))then 
        local musicScale = SettingMgr:GetValue(s_audio_scale.music)
        local curMusicScale = ASMRMgr:GetASMRMusicScale()
        local scale = isOpen and curMusicScale or musicScale
        SettingMgr:SetAudioScale(s_audio_scale.music, scale)
    end 
end