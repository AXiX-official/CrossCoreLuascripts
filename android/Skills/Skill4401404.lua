-- 粼光
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4401404 = oo.class(SkillBase)
function Skill4401404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4401404:OnBefourHurt(caster, target, data)
	-- 4401404
	self:tFunc_4401404_4401414(caster, target, data)
	self:tFunc_4401404_4401407(caster, target, data)
end
function Skill4401404:tFunc_4401404_4401407(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8412
	local count12 = SkillApi:BuffCount(self, caster, target,2,1,2)
	-- 8826
	if SkillJudger:Less(self, caster, target, true,count12,1) then
	else
		return
	end
	-- 4401407
	self:AddTempAttr(SkillEffect[4401407], caster, self.card, data, "damage",0.1)
end
function Skill4401404:tFunc_4401404_4401414(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4401414
	if self:Rand(7000) then
		self:DelBufferGroup(SkillEffect[4401414], caster, target, data, 2,1)
		-- 4401406
		self:ShowTips(SkillEffect[4401406], caster, self.card, data, 2,"粼光",true,4401406)
	end
end
