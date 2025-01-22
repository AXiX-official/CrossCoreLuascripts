-- 岁稔被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4704303 = oo.class(SkillBase)
function Skill4704303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill4704303:OnRoundOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8705
	local count705 = SkillApi:SkillLevel(self, caster, target,3,7043001)
	-- 8704
	local count704 = SkillApi:BuffCount(self, caster, target,3,4,704300301)
	-- 8921
	if SkillJudger:Greater(self, caster, target, true,count704,0) then
	else
		return
	end
	-- 4704303
	if self:Rand(6000) then
		self:CallOwnerSkill(SkillEffect[4704303], caster, caster, data, 704300100+count705)
	end
end
-- 入场时
function Skill4704303:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4704323
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddSkillAttr(SkillEffect[4704323], caster, target, data, "np",-3)
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8706
	local count706 = SkillApi:SkillLevel(self, caster, target,3,7043003)
	-- 4704311
	self:CallSkillEx(SkillEffect[4704311], caster, self.card, data, 704300300+count706)
end
