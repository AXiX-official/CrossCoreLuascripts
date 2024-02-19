--召唤角色
FightActionSummon = oo.class(FightActionBase);
local this = FightActionSummon;


--设置父FightAction
function this:SetParent(fightAction)
    self.fightAction = fightAction;
    FightActionBase.SetParent(self,fightAction);
    self.master = fightAction:GetActorCharacter();
end

function this:SetData(fightActionData)
    FightActionBase.SetData(self,fightActionData);
    self:Preload(fightActionData.datas);
end
--预加载角色
function this:Preload(datas)   
    CharacterMgr:PreloadCharacters(datas,self.OnPreloadCallBack,self)
end
--预加载完成回调
function this:OnPreloadCallBack()
    self.isPreloaded = 1;
    self:ApplyCreate();
end

function this:OnPlay()   
    self.isPlayed = 1;

    self:ApplyCreate();

    EventMgr.Dispatch(EventType.Character_FightInfo_Show,false); 

    EventMgr.Dispatch(EventType.Scene_Mask_Changed,true);
end

function this:OnClean()
    self.isSummonShow = nil;
    self.isSummonCreated = nil;
    self.isPreloaded = nil;
    self.isPlayed = nil;

    if(self.summons)then
        for _,character in ipairs(self.summons)do
            character.SetSummonState(false);
            character.SetOverTurn(false);
        end
    end
    if(self.master)then
        self.master.SetOverTurn(false);
    end

    self.summons = nil;
    self.master = nil;

    EventMgr.Dispatch(EventType.Scene_Mask_Changed,false);
end

function this:ApplyCreate()
    if(not self.isPreloaded or not self.isPlayed)then
        return;
    end

   self.summons = CharacterMgr:CreateCharacters(self.data.datas);
   self:SetSummonsShowState(false);
   self.isSummonCreated = 1;

   self:MasterShow();
   --self:ApplySummonShow();    
end

function this:MasterShow()
    if(self.master == nil)then
       LogError("召唤失败！！！召唤师不见了！！！"); 
    end

    self.master.SetOverTurn(true);


    local cfgSkill = Cfgs.skill:GetByID(self.fightAction and self.fightAction:GetSkillID()); 

    local summonCast = cfgSkill and cfgSkill.cast or "summon";
    local masterSummonData = self.master.GetCastStateData(summonCast);  
    if(not masterSummonData)then
        LogError(self.master.GetModelName() .. " has not " .. tostring(summonCast) .. " data");
    end
    --召唤师施法
    self.master.ApplyCast(summonCast);
    --LogError(CSAPI.GetTime() .. ":" .. tostring(summonCast));
    self.master.ApplyCastPreFB(summonCast);  
    
    
    local delay = masterSummonData.summon_delay or 0;
    FuncUtil:Call(self.SummonEnter,self,delay);

    local maskDelayTime = 80;--大招场景遮罩延迟时间
    FuncUtil:Call(self.Complete,self,masterSummonData.play_time + maskDelayTime);
end

function this:SetSummonsShowState(isShow)
    if(not self.summons)then
        return;
    end
    for _,character in ipairs(self.summons)do
        character.SetOverTurn(true);
        character.SetShowState(isShow);
    end
end
--召唤者进场
function this:SummonEnter()    
    self.isSummonShow = 1;
    --self.master.SetShowState(false);
    self:ApplySummonShow();

    EventMgr.Dispatch(EventType.Character_FightInfo_Show,false); 
end

function this:ApplySummonShow()
    if(self.isSummonShow and self.isSummonCreated)then        
        self:SummonShow();
    end
end

function this:SummonShow()
    local x,y,z = self.master.GetPos();

    self:SetSummonsShowState(true);
    for _,character in ipairs(self.summons)do
        character.ApplyCast("summon_enter");
        character.SetSummonState(true);
        character.ApplySummon();

        character.SetPos(x,y,z);
    end
end

return this;