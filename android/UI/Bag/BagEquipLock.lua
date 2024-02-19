--装备背包加锁
local this={};
local root=nil;
local data=nil;
local selectList={}; --选中状态的列表
local originList={}; --源列表的列表
function this.SetData(_root,_data)
    root=_root;
    data=_data;
end

function this.Refresh()
    local list = EquipMgr:GetAllEquipArr(nil, true);
    if list then
        this.CleanCache();
        for k,v in ipairs(list) do
            if v:IsLock()==true then
                table.insert(selectList,v);
                table.insert(originList,v);
            end
        end
    end
    root.Refresh(list);
end

-- function this.GetScreenDataType()
--     return EquipViewKey.Bag;
-- end

function this.GetElseData(data)
    local isSelect=false;
    if selectList then
        for k, v in ipairs(selectList) do
            if v:GetID() == data:GetID() then
                isSelect = true;
                break;
            end
        end
    end
    return {isClick=true,isSelectLock = isSelect,selectType=1,hideLock=true,showNew=true, removeFunc = nil};
end

function this.OnClickGrid(tab)
    if tab.data:IsNew() then
		EquipProto:SetIsNew({tab.data:GetID()}, function()
			tab.SetNewState(tab.data:IsNew());
		end);
    end
    local key=-1;
    for k,v in ipairs(selectList) do
        if v:GetID()==tab.data:GetID() then
            key=k;
            break;
        end
    end
    if key==-1 then
        table.insert(selectList,tab.data);
    else
        table.remove(selectList,key);
    end
    root.UpdateCell(tab.index);
end

function this.OnClickReturn()
    this.CleanCache()
    root.ChangeLayout(BagMgr:GetSelChildTabIndex(),EquipBagType.Normal,BagType.Equipped);
end

function this.OnClickLock()
    local infos={};
    local max=#originList>=#selectList and #originList or #selectList
    for k,v in ipairs(originList) do
        local has=false;
        for _,val in ipairs(selectList) do
            if v:GetID()==val:GetID() then
                has=true;
                break;
            end
        end
        table.insert(infos,{sid=v:GetID(),lock=has==true and 1 or 0});
    end
    for k, v in ipairs(selectList) do
        local has=false;
        for _,val in ipairs(infos) do
            if v:GetID()==val.sid then
                has=true;
                break;
            end
        end
        if has==false then
            table.insert(infos,{sid=v:GetID(),lock=1});
        end
    end
    EquipProto:SetLock(infos)
end

function this.CleanCache()
    selectList={};
    originList={};
end

return this;