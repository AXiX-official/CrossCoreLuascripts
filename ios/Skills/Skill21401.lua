-- 援护I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill21401 = oo.class(SkillBase)
function Skill21401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill21401:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8222
	if SkillJudger:IsDamageType(self, caster, target, true,1) then
	else
		return
	end
	-- 21401
	self:AddTempAttr(SkillEffect[21401], caster, caster, data, "damage",-0.1)
end
-- 行动开始
function Skill21401:OnActionBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 214010
	self:ShowTips(SkillEffect[214010], caster, self.card, data, 2,"铁壁",true,214010)
end
