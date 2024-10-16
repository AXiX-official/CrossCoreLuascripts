local tab1 = nil
local tab2 = nil
local curIndex1 = nil
local curIndex2 = nil

function Awake()
    CSAPI.SetGOActive(mask ,false)
    
    curIndex1 = SettingMgr:GetValue(s_other_live_key) or s_other_live_default
    curIndex2 = SettingMgr:GetValue(s_other_equipLock_key) or s_other_equipLock_default
    if not curIndex1 or curIndex1 == 0 then
        curIndex1 = s_other_live_default
    end
    if not curIndex2 or curIndex2 == 0 then
        curIndex2 = s_other_equipLock_default
    end

    SetLive()
    SetAuto()
end

--直播模式
function SetLive()
    CSAPI.SetGOActive(zbms_open,curIndex1 == 1)
    CSAPI.SetGOActive(zbms_close,curIndex1 == 2)
end

--自动上锁
function SetAuto()
    CSAPI.SetGOActive(zdss_open,curIndex2 == 1)
    CSAPI.SetGOActive(zdss_close,curIndex2 == 2)
end

function OnClickLive()
    local index = curIndex1 == 1 and 2 or 1
    if index == 1 then
        local dialogData = {}
        dialogData.content = LanguageMgr:GetTips(7008)
        dialogData.okCallBack=function ()
            curIndex1 = 1
            SetLive()
            SettingMgr:SaveValue(s_other_live_key, curIndex1)
            EventMgr.Dispatch(EventType.Setting_Live_Change, curIndex1)
            LanguageMgr:ShowTips(7011)
        end
        CSAPI.OpenView("Dialog",dialogData)
    else
        curIndex1 = 2
        SetLive()
        SettingMgr:SaveValue(s_other_live_key, curIndex1)
        EventMgr.Dispatch(EventType.Setting_Live_Change, curIndex1)
        LanguageMgr:ShowTips(7010)
    end
end

function OnClickTips()
    CSAPI.OpenView("Prompt",{
        content = LanguageMgr:GetTips(7009)
    })
end

function OnClickAuto()
    local index = curIndex2 == 1 and 2 or 1
    CSAPI.SetGOActive(mask ,true)
    EventMgr.Dispatch(EventType.Net_Msg_Wait,{msg="zdss",time=1000,
    timeOutCallBack=function()
        LanguageMgr:ShowTips(7012)
        CSAPI.SetGOActive(mask ,false)
    end})

    PlayerProto:Setting(index == 1,function (b)
        CSAPI.SetGOActive(mask ,false)
        if b then
            EventMgr.Dispatch(EventType.Net_Msg_Getted,"zdss")
            curIndex2 = index
            SetAuto()    
            SettingMgr:SaveValue(s_other_equipLock_key, curIndex2)
            LanguageMgr:ShowTips(index == 1 and 7011 or 7010)
        else
            LanguageMgr:ShowTips(7012)
        end
    end)
end

function SetFade(isOpen,callback)
    if isOpen then
        CSAPI.SetGOActive(gameObject, true)
        UIUtil:SetObjFade(gameObject,0, 1,callback,200)
    else
        UIUtil:SetObjFade(gameObject,1, 0,function ()
            CSAPI.SetGOActive(gameObject, false)
            if callback then
                callback()
            end
        end,200)
    end
end

