-- 玩家造成伤害时，会依照攻击者伤害量的80%获得护盾值
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020120 = oo.class(BuffBase)
function Buffer1000020120:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer1000020120:OnActionOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 1000020120
	self:AddShield(BufferEffect[1000020120], self.caster, self.card, nil, 4,1)
end
