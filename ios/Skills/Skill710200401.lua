-- 机神传送
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill710200401 = oo.class(SkillBase)
function Skill710200401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill710200401:CanSummon()
	return self.card:CanSummon(10000001,1,{4,1},{progress=1001})
end
-- 执行技能
function Skill710200401:DoSkill(caster, target, data)
	-- 40001
	self.order = self.order + 1
	self:Summon(SkillEffect[40001], caster, target, data, 10000001,1,{4,1},{progress=1001})
end
