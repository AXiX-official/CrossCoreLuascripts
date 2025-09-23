local data = nil
local skillDatas = nil
local item = nil
local skinInfo = nil
local isLock = false
local isFinish = false

function SetIndex(idx)
    index = idx
end

function Refresh(_data, _elseData)
    data = _data
    skillDatas = _elseData
    if data then
        skinInfo = ShopCommFunc.GetSkinInfo(data);
        SetName()
        SetPrice()
        SetIcon()
        SetSIcon()
        SetLimit()
        SetLock()
        SetFinish()
    end
end

function SetName()
    if skinInfo then
        CSAPI.SetText(txtName, skinInfo:GetRoleName())
        CSAPI.SetText(txtTitle, skinInfo:GetSkinName())
    end
end

function SetPrice()
    local costs = {};
    if data:HasOtherPrice(ShopPriceKey.jCosts1) then
        if data:GetRealPrice()[1].id == -1 then
            costs ={data:GetRealPrice(ShopPriceKey.jCosts1)[1], data:GetRealPrice()[1]}
        else
            costs = {data:GetRealPrice()[1], data:GetRealPrice(ShopPriceKey.jCosts1)[1]};
        end
    else
        costs = data:GetRealPrice();
    end
    CSAPI.SetGOActive(priceObj1, #costs < 2)
    CSAPI.SetGOActive(priceObj2, #costs > 1)
    if #costs == 1 then
        local tips = "";
        if costs[1].id == -1 then
            tips = data:GetCurrencySymbols();
        end
        ShopCommFunc.SetPriceIcon(icon2, costs[1]);
        CSAPI.SetText(txtNum, tips .. tostring(costs[1].num));
    else
        ShopCommFunc.SetPriceIcon(icon4, costs[1]);
        CSAPI.SetText(txtNum1, tostring(costs[1].num));
        CSAPI.SetText(txtPrice, data:GetCurrencySymbols() .. "")
        CSAPI.SetText(txtNum2, tostring(costs[2].num));
    end
end

function SetIcon()
    if skinInfo then
        ResUtil.SkinMall:Load(icon1, data:GetIcon(), true);
    end
end

function SetLimit()
    CSAPI.SetGOActive(limitTag,data:IsLimitTime());
    CSAPI.SetText(txtLimitTag,data:GetEndBuyTips() or "");
end

function SetSIcon()
    if skinInfo then
        local cfg = skinInfo:GetSetCfg();
        CSAPI.SetGOActive(icon3, cfg.icon ~= nil);
        if cfg.icon then
            ResUtil.SkinSetIcon:Load(icon3, cfg.icon .. "_w", true);
        end
    end
end

function SetLock()
    isLock = not data:GetBuyLimit();
    CSAPI.SetGOActive(lockObj, isLock)
end

function SetFinish()
    isFinish = not isLock and data:IsOver()
    CSAPI.SetGOActive(finishObj, isFinish)
end

function OnClick()
    if isLock then
        Tips.ShowTips(data:GetBuyLimitDesc())
        return
    end
    if isFinish then
        return
    end
    -- 显示皮肤预览界面
    local nowIdx = index; -- 当前选中的下标
    local list = {};
    for k, v in ipairs(skillDatas) do
        table.insert(list, ShopCommFunc.GetSkinInfo(v));
    end
    CSAPI.OpenView("SkinFullInfo", {
        list = list,
        idx = nowIdx
    })
end
