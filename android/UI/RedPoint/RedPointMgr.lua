-- 红点管理
RedPointType = {};
RedPointType.Dungeon = "Dungeon"; -- 副本
RedPointType.Mail = "Mail"; -- 邮件
RedPointType.Shop = "Shop"; -- 商店
RedPointType.Friend = "Friend";
RedPointType.Mission = "Mission";
RedPointType.MissionTower = "MissionTower"; -- 爬塔任务
RedPointType.MissionTaoFa = "MissionTaoFa"; -- 讨伐任务
RedPointType.RoleList = "RoleList";
RedPointType.PlayerAbility = "PlayerAbility";
RedPointType.Activity = "Activity" -- 活动
RedPointType.ActivityList1 = "ActivityList1" -- 活动列表1
RedPointType.ActivityList2 = "ActivityList2" -- 活动列表2
RedPointType.ActivityList3 = "ActivityList3" -- 特别活动
RedPointType.Exploration = "Exploration" -- 勘探
RedPointType.Attack = "Attack" -- 出击
RedPointType.Bag = "Bag" -- 背包
RedPointType.Matrix = "Matrix" -- 基地
RedPointType.Create = "Create" -- 构建
RedPointType.ExerciseL = "ExerciseL"  --演习 
RedPointType.CRoleSkin = "CRoleSkin"  --角色皮肤（看板） 
RedPointType.Archive = "Archive" --档案

RedPointType.ActiveEntry1 = "ActiveEntry1"  --活动入口  拂晓之战
RedPointType.ActiveEntry2 = "ActiveEntry2"  --电影惊魂
RedPointType.ActiveEntry3 = "ActiveEntry3"  --拟真演训
RedPointType.ActiveEntry4 = "ActiveEntry4"  --迷城蛛影
RedPointType.ActiveEntry16 = "ActiveEntry16"  --宠物活动

RedPointType.MaterialBag = "MaterialBag" -- 背包
RedPointType.HeadFrame = "HeadFrame" -- 头像框
RedPointType.Head = "Head" -- 头像

RedPointType.Achievement = "Achievement" --成就
RedPointType.Regression = "Regression" --回归
RedPointType.Badge = "Badge" --徽章
RedPointType.Rogue = "Rogue" --乱序演习
RedPointType.AccuCharge = "AccuCharge" --累计充值

RedPointType.SpecialExploration="SpecialExploration"--特殊勘探

local this = MgrRegister("RedPointMgr")

function this:Clear()
    self.rps = nil;
end

function this:UpdateData(rpType, data)
    self.rps = self.rps or {};
    if (self.rps[rpType] and self.rps[rpType] == data) then
        return
    end
    self.rps[rpType] = data;
    self:ApplyRefresh()
end

function this:GetData(rpType)
    return self.rps and self.rps[rpType];
end

function this:ApplyRefresh()
    if (self.applyRefresh) then
        return;
    end
    self.applyRefresh = 1;

    FuncUtil:Call(self.Refresh, self, 10);
end

function this:Refresh()
    self.applyRefresh = nil;
    EventMgr.Dispatch(EventType.RedPoint_Refresh);
end

return this;
