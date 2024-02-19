local this = {};

--切换周目
function this:Handle(data)
    local fightAction = FightActionMgr:Apply(FightActionType.ChangeStage,data);
    local createFightAction = FightActionMgr:Apply(FightActionType.AddCard,data.datas)
    fightAction:PushSub(createFightAction);

    FightActionUtil:SetServerDatasHangUpState(true);

    return fightAction;
end

return this;