-- 受到攻击后叠加防御力2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010041 = oo.class(SkillBase)
function Skill1100010041:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100010041:OnActionOver(caster, target, data)
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
	-- 8222
	if SkillJudger:IsDamageType(self, caster, target, true,1) then
	else
		return
	end
	-- 1100010041
	self:AddBuffCount(SkillEffect[1100010041], caster, caster, data, 1100010040,1,2)
end
