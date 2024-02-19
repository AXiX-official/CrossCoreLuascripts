-- 救赎I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill23601 = oo.class(SkillBase)
function Skill23601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill23601:OnAfterHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8072
	if SkillJudger:TargetIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8134
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.4) then
	else
		return
	end
	-- 8151
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.001) then
	else
		return
	end
	-- 93002
	if SkillJudger:CheckCD(self, caster, target, false) then
	else
		return
	end
	-- 23601
	self:SetHP(SkillEffect[23601], caster, target, data, 1)
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 23611
	self:AddHp(SkillEffect[23611], caster, self.card, data, -count49*0.3)
	-- 23621
	self:Cure(SkillEffect[23621], caster, target, data, 6,0.1)
	-- 93004
	self:ResetCD(SkillEffect[93004], caster, target, data, 5)
	-- 236010
	self:ShowTips(SkillEffect[236010], caster, self.card, data, 2,"救赎",true)
end
