-- 余晖
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4703103 = oo.class(BuffBase)
function Buffer4703103:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer4703103:OnBefourHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8225
	if SkillJudger:IsTypeOf(self, self.caster, target, true,4) then
	else
		return
	end
	-- 4703113
	self:AddTempAttr(BufferEffect[4703113], self.caster, self.card, nil, "damage",0.1*self.nCount)
end
-- 创建时
function Buffer4703103:OnCreate(caster, target)
	-- 8499
	local c99 = SkillApi:SkillLevel(self, self.caster, target or self.owner,3,47031)
	-- 4703103
	self:AddAttr(BufferEffect[4703103], self.caster, self.card, nil, "damage",(0.02*c99)*self.nCount)
end
