-- 战斗结束
FightActionFightEnd = oo.class(FightActionBase);
local this = FightActionFightEnd;

function this:OnPlay()
    -- 恢复播放速度
    CSAPI.SetTimeScale(1);

    EventMgr.Dispatch(EventType.Character_FightInfo_Show, false);
    CharacterMgr:SetAllShowState(true);

    local fightOverData = self:GetData();

    -- fightOverData.forceDeadTeam = TeamUtil.enemyTeamId;
    if (fightOverData and fightOverData.forceDeadTeam) then -- 播放结果前，强制某个队伍死亡
        FightActionMgr:ForceDead(fightOverData.forceDeadTeam, self.ForceDeadComplete, self);
    else
        self:PlayResult();
    end

    --    if(not FightClient.isStarted) then
    --        FightClient:ApplyLoadingComplete();
    --    end
end

function this:ForceDeadComplete()
    self:PlayResult();
end

-- 播放结果
function this:PlayResult()

    local fightOverData = self:GetData(); -- DungeonMgr:GetFightOverData();
    if (fightOverData) then
        if (fightOverData.fight_error_msg) then
            local clickFunc = function()
                SceneLoader:Load("MajorCity");
                self:Complete();
                FightClient:Clean();
            end;
            CSAPI.OpenView("DialogNoTop", {
                content = fightOverData.fight_error_msg,
                okCallBack = clickFunc,
                cancelCallBack = clickFunc
            });
        elseif (fightOverData.new_player_fight) then
            self:Complete();

            if (PlayerClient:HasNextNewPlayerFight()) then
                ---继续下一场新手战斗                  
                FightClient:Reset();
                PlayerClient:ApplyNextNewPlayerFight();
            else
                -- 巅峰战斗结束               
                FuncUtil:Call(FightClient.Reset, FightClient, 1000);
                FuncUtil:Call(PlayerClient.PlayFightOP, PlayerClient, 1000);
                -- PlayerClient:PlayFightOP();
            end
        else
            self:PlayCameraAction(fightOverData);
            self:PlayBGM(fightOverData);
            FuncUtil:Call(self.OpenView, self, 2000, fightOverData)
        end
    else
        LogError("没有战斗结束数据");
    end
end

function this:OpenView(fightOverData)

    local dirllId = FightClient:GetDirll();
    if (fightOverData.custom_result and dirllId) then
        -- 退出试玩
        FightClient:QuitDirll();
    else
        local viewKey = self:GetViewKey(fightOverData);
        CSAPI.OpenView(viewKey, fightOverData);
    end

    FightActionMgr:Reset();
    self:Complete();
end

function this:PlayBGM(fightOverData)
    if (fightOverData.bIsWin) then
        -- local mvpInfo = g_FightMgr:GetMvp(TeamUtil.myNetTeamId);
        -- -- Log("MVP：" .. table.tostring(mvpInfo));
        -- if (mvpInfo) then
        --     local cfgModel = Cfgs.character:GetByID(mvpInfo.model);
        --     if (cfgModel.s_mvp) then
        --         if (cfgModel.id == 8011001) then
        --             local soundId = cfgModel.s_mvp[PlayerClient:GetSex()]
        --             if(soundId) then 
        --                 CSAPI.PlayRandSound({soundId}, true);
        --             end
        --         else
        --             CSAPI.PlayRandSound(cfgModel.s_mvp, true);
        --         end
        --     end
        -- end
    else
        -- 播放队长失败声音
        if (fightOverData.team and fightOverData.team.leader) then
            local card = FormationUtil.FindTeamCard(fightOverData.team.leader);
            if (card) then
                local cfgModel = card:GetModelCfg();
                if (cfgModel and cfgModel.s_fail) then
                    CSAPI.PlayRandSound(cfgModel.s_fail, true);
                end
            end
        end
    end

    local bgm = fightOverData.bIsWin and g_bgm_win or g_bgm_fail;
    if (bgm) then
        -- FuncUtil:Call(CSAPI.PlayBGM,nil,50,bgm);
        CSAPI.PlayBGM(bgm);
    end
end

function this:GetActorID()
    return self.data and self.data.actorId;
end

function this:PlayCameraAction(fightOverData)

    local existCharacter;

    if (not fightOverData.actorId) then
        local winTeamId = fightOverData.bIsWin and TeamUtil.ourTeamId or TeamUtil.enemyTeamId;

        -- LogError("胜利队伍：" .. winTeamId);
        local characters = CharacterMgr:GetAll();
        if (characters) then
            for id, character in pairs(characters) do
                local teamId = character.GetTeam();
                if (teamId == winTeamId) then
                    fightOverData.actorId = id;
                    character.ApplyWin();

                    existCharacter = true;
                end
            end
        end

    end
    -- LogError(fightOverData);
    if (existCharacter) then
        CameraMgr:ApplyCommonAction(self, CameraActionMgr.winner);
    end
end

function this:GetViewKey(fightOverData)
    if (fightOverData and fightOverData.custom_result) then
        return "Fight/FightResult";
    else
        fightOverData.sceneType = g_FightMgr and g_FightMgr.type
        return "FightOverResult"
    end
end

return this;
