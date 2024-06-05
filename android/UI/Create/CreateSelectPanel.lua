-- 建造数量选择
local isSet = false

function OnOpen()
    day = TimeUtil:GetTime3("day")
    local dayRecord = PlayerPrefs.GetString(PlayerClient:GetUid() .. "CreateTips_Day", "0")
    if (dayRecord ~= "0" and dayRecord == tostring(day)) then
        isSet = true
    end
    SetDesc()
    SetSelect()
end

function SetDesc()
    CSAPI.SetText(content, data.content)
end

function SetSelect()
    CSAPI.SetGOActive(select2, isSet)
end

function OnClickSelect()
    if (not isSet) then
        PlayerPrefs.SetString(PlayerClient:GetUid() .. "CreateTips_Day", tostring(day))
    else
        PlayerPrefs.SetString(PlayerClient:GetUid() .. "CreateTips_Day", "0")
    end
    isSet = not isSet
    SetSelect()
end

-- 取消
function OnClickCancel()
    view:Close()
end

-- 建造
function OnClickOK()
    if (CreateMgr:CheckPoolActive(data.id)) then
        CreateMgr:CardCreate(data.id, data.cnt)
    else
        LanguageMgr:ShowTips(10015)
    end
    view:Close()
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if  OnClickCancel then
        OnClickCancel();
    end
end