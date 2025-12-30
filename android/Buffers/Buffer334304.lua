-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer334304 = oo.class(BuffBase)
function Buffer334304:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer334304:OnRoundBegin(caster, target)
	-- 8420
	local c20 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"speed")
	-- 334311
	if SkillJudger:Greater(self, self.caster, target, true,c20,180) then
	else
		return
	end
	-- 334304
	self:MissSurface2(BufferEffect[334304], self.caster, self.card, nil, 2000)
	-- 334313
	self:AddBuff(BufferEffect[334313], self.caster, self.card, nil, 334306)
end
-- 回合结束时
function Buffer334304:OnRoundOver(caster, target)
	-- 334312
	if SkillJudger:HasBuff(self, self.caster, target, true,3,334306) then
	else
		return
	end
	-- 334309
	self:MissSurface2(BufferEffect[334309], self.caster, self.card, nil, -2000)
	-- 334314
	self:DelBufferForce(BufferEffect[334314], self.caster, self.card, nil, 334306)
end
