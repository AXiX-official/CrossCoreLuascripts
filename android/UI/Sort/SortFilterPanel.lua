local copyFilterDatas = {}

function OnOpen()
    id = data:GetID()
    cfg = Cfgs.CfgSortFilter:GetByID(id)
    sortData = SortMgr:GetData(id)
    copyFilterDatas = table.copy(sortData.Filter)
    SetItems()
end

function SetItems()
    items = items or {}
    ItemUtil.AddItems("Sort/SortFilterItem", items, cfg.filter, Content, nil, 1, copyFilterDatas)
end

-- 重置
function OnClickC()
    copyFilterDatas = {}
    if (cfg.filter) then
        for k, v in pairs(cfg.filter) do
            copyFilterDatas[v[2]] = {0}
        end
    end
    SetItems()
end

-- 确定
function OnClickS()
    sortData.Filter = copyFilterDatas
    data.SelectCB()
    view:Close()
end

function OnClickMask()
    view:Close()
end