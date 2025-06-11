-- 薄暮西沉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4703102 = oo.class(SkillBase)
function Skill4703102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4703102:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703102
	self:OwnerAddBuffCount(SkillEffect[4703102], caster, self.card, data, 4703101,1,4)
end
-- 伤害后
function Skill4703102:OnAfterHurt(caster, target, data)
	-- 4703113
	self:tFunc_4703113_4703107(caster, target, data)
	self:tFunc_4703113_4703111(caster, target, data)
end
-- 攻击结束
function Skill4703102:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8723
	local count723 = SkillApi:GetCount(self, caster, target,3,4703101)
	-- 8937
	if SkillJudger:GreaterEqual(self, caster, self.card, true,count723,7) then
	else
		return
	end
	-- 4703109
	self:ClosingBuffByID(SkillEffect[4703109], caster, target, data, 1,1003)
	-- 4703110
	self:ClosingBuffByID(SkillEffect[4703110], caster, target, data, 1,1051)
end
function Skill4703102:tFunc_4703113_4703107(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8723
	local count723 = SkillApi:GetCount(self, caster, target,3,4703101)
	-- 8936
	if SkillJudger:GreaterEqual(self, caster, self.card, true,count723,5) then
	else
		return
	end
	-- 4703107
	if self:Rand(5000) then
		self:AlterBufferByID(SkillEffect[4703107], caster, target, data, 1003,1)
		-- 4703108
		if self:Rand(5000) then
			self:AlterBufferByID(SkillEffect[4703108], caster, target, data, 1051,1)
		end
	end
end
function Skill4703102:tFunc_4703113_4703111(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 8723
	local count723 = SkillApi:GetCount(self, caster, target,3,4703101)
	-- 8936
	if SkillJudger:GreaterEqual(self, caster, self.card, true,count723,5) then
	else
		return
	end
	-- 4703111
	if self:Rand(5000) then
		self:AlterBufferByID(SkillEffect[4703111], caster, target, data, 1003,1)
		-- 4703112
		if self:Rand(5000) then
			self:AlterBufferByID(SkillEffect[4703112], caster, target, data, 1051,1)
		end
	end
end
