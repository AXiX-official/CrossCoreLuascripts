-- 王权爆发
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill326301 = oo.class(SkillBase)
function Skill326301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill326301:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 8112
	if SkillJudger:Greater(self, caster, self.card, true,count29,0) then
	else
		return
	end
	-- 326301
	if self:Rand(2000) then
		self:AlterBufferByID(SkillEffect[326301], caster, target, data, 1003,1)
	end
end
