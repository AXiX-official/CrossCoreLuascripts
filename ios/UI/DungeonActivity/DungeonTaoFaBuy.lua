local info = nil
local curCount = 1

function OnOpen()
    info = data
    if info then
        RefreshPanel()
    end
end

function RefreshPanel()
    SetCurrCount()
    SetTop()
    SetStage()
end

function SetTop()
    CSAPI.SetText(txt_hasNum,BagMgr:GetCount(ITEM_ID.DIAMOND) .. "")
end

function SetStage()
    CSAPI.SetText(txt_stage1, info.count .. "")
    CSAPI.SetText(txt_stage2, info.count + curCount .. "")
    CSAPI.SetText(txt_tips,LanguageMgr:GetByID(15122) .. (g_DungeonTaoFaDailyBuy - info.buyCount) .. "/" .. g_DungeonTaoFaDailyBuy)
end

function SetCurrCount()
    if curCount < 1 then
        curCount = 1
    end

    if info.buyCount >= g_DungeonTaoFaDailyBuy then
        curCount = 0
    end

    if curCount > (g_DungeonTaoFaDailyBuy - info.buyCount) then
        curCount = g_DungeonTaoFaDailyBuy - info.buyCount
    end

    AddCount(curCount)
    SetNum()
end

function AddCount(num)
    CSAPI.SetText(txt_num,num.."")
end

function SetNum()
    local reward = g_DungeonTaoFaDailyCost[1]
    if reward and reward[2] then
        CSAPI.SetText(txtPrice,curCount * reward[2] .."")
    end
end

function OnClickAdd()
    if g_DungeonTaoFaDailyBuy <= info.buyCount then
        LanguageMgr:ShowTips(33007)
        return
    end

    if curCount + 1 > g_DungeonTaoFaDailyBuy - info.buyCount then
        return
    end

    if info.count + curCount + 1 > g_DungeonTaoFaDailyNum then
        LanguageMgr:ShowTips(33006)
        return
    end
    curCount = curCount + 1

    SetCurrCount()
end

function OnClickRemove()
    curCount = curCount - 1
    SetCurrCount()
end

function OnClickMax()
    if g_DungeonTaoFaDailyBuy <= info.buyCount then
        LanguageMgr:ShowTips(33007)
        return
    end
    curCount = g_DungeonTaoFaDailyBuy - info.buyCount
    SetCurrCount()
end

function OnClickMin()
    curCount = 1
    SetCurrCount()
end

function OnClickPay()
    if g_DungeonTaoFaDailyBuy <= info.buyCount then
        LanguageMgr:ShowTips(33007)
        return
    end
    local _data = {buy_cnt = curCount}
    PlayerProto:BuyTaoFaCount(_data)
    OnClickMask()
end

function OnClickMask()
    view:Close()
end