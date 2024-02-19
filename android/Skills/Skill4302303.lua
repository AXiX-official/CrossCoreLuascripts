-- 急躁反击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4302303 = oo.class(SkillBase)
function Skill4302303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4302303:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8607
	local count607 = SkillApi:SkillLevel(self, caster, target,3,3023003)
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 4302303
	if self:Rand(2000) then
		self:BeatBack(SkillEffect[4302303], caster, self.card, data, 302300300+count607,2)
	end
end
-- 回合开始处理完成后
function Skill4302303:OnAfterRoundBegin(caster, target, data)
	-- 8251
	if SkillJudger:HasBuff(self, caster, target, true,1,4102301) then
	else
		return
	end
	-- 4302306
	self:AddBuff(SkillEffect[4302306], caster, self.card, data, 4102302)
end
-- 回合开始时
function Skill4302303:OnRoundBegin(caster, target, data)
	-- 4302307
	self:AddBuff(SkillEffect[4302307], caster, self.card, data, 4102302)
end
