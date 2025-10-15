local isCheckCard = false
local teamNum = 1
local curDatas1 = nil
local curDatas2 = nil
local items1 = nil
local items2 = nil
local formationView = nil

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetClickCB2(_cb2)
    cb2 = _cb2
end

--teamDatas
function Refresh(_data,_elseData)
    data = _data
    isCheckCard = _elseData
    if data then
        SetDatas()
        SetItems()
        SetSkill()
        SetPos()
    end
end

function SetDatas()
    curDatas1 = data[1] and data[1].data or nil
    curDatas2 = data[2] and data[2].data or nil
end

function SetItems()
    items1 = items1 or {}
    ItemUtil.AddItems("DungeonTeamReplace/DungeonTeamReplaceCard",items1,curDatas1,itemParent1,OnItemClickCB,1,{isCheckCard = isCheckCard})
    if curDatas2 then
        items2 = items2 or {}
        ItemUtil.AddItems("DungeonTeamReplace/DungeonTeamReplaceCard",items2,curDatas2,itemParent2,OnItemClickCB,1,{isCheckCard = isCheckCard})
    end
end

function OnItemClickCB(item)
    CSAPI.OpenView("RoleInfo", item.data)
end

function SetSkill()
    SetSkillIcon(1,data[1].skillGroupID)
    if data[2] then
         SetSkillIcon(2,data[2].skillGroupID)
    end
end

function SetSkillIcon(index,cfgId)
    if not this["txtSkill" .. index] or not this["skillIcon" .. index] then
        return
    end
    if cfgId==nil or cfgId==-1 then
        CSAPI.SetText(this["txtSkill" .. index].gameObject,LanguageMgr:GetByID(15065))
        CSAPI.SetAnchor(this["txtSkill" .. index].gameObject,-74,0)
        CSAPI.SetGOActive(this["skillIcon" .. index].gameObject,false)
        return
    end
    local cfg = Cfgs.CfgPlrSkillGroup:GetByID(cfgId)
    if cfg then
        CSAPI.SetGOActive(this["skillIcon" .. index].gameObject,true)
        CSAPI.SetText(this["txtSkill" .. index].gameObject,cfg.sName);
        ResUtil.Ability:Load(this["skillIcon" .. index].gameObject, cfg.sIcon.."_1");
        CSAPI.SetAnchor(this["txtSkill" .. index].gameObject,-38,0)
    end
end

function SetPos()
    if gameObject.name == "DungeonTeamReplaceItem2" then
        local num = data[2] ~= nil and 2 or 1
        CSAPI.SetAnchor(teamObj1,0,num == 2 and 94 or -30)
        CSAPI.SetGOActive(teamObj2,num > 1)
    end
end

function OnClickShow(go)
    if data == nil then
        return
    end
    local teamData = go.name == "btnShow1" and data[1] or data[2]
    if cb2 then
        cb2(teamData)
    end
end

function OnClickReplace()
    if cb then
        cb(this)
    end
end
