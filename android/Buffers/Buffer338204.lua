-- 吞噬强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer338204 = oo.class(BuffBase)
function Buffer338204:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer338204:OnBefourHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8246
	if SkillJudger:IsTargetMech(self, self.caster, target, true,10) then
	else
		return
	end
	-- 338214
	self:AddTempAttr(BufferEffect[338214], self.caster, target or self.owner, nil,"bedamage",0.08*self.nCount)
end
-- 创建时
function Buffer338204:OnCreate(caster, target)
	-- 338204
	self:AddAttr(BufferEffect[338204], self.caster, self.card, nil, "damage",0.04*self.nCount)
end
