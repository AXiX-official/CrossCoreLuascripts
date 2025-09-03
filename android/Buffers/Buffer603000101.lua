-- 莫拉标记
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer603000101 = oo.class(BuffBase)
function Buffer603000101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer603000101:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 603000102
	self:LimitDamage(BufferEffect[603000102], self.caster, target or self.owner, nil,0.03*self.nCount,1.5)
end
-- 创建时
function Buffer603000101:OnCreate(caster, target)
	-- 4603000
	local c60301 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,46030)
	-- 4603005
	local c60305 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,460301)
	-- 4603001
	self:AddAttr(BufferEffect[4603001], self.caster, self.card, nil, "defense",-20*self.nCount*c60301+(-30*self.nCount*c60305))
	-- 4603000
	local c60301 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,46030)
	-- 4603005
	local c60305 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,460301)
	-- 4603002
	self:AddAttr(BufferEffect[4603002], self.caster, self.card, nil, "bedamage",-0.01*self.nCount*c60301+(-0.02*self.nCount*c60305))
end
