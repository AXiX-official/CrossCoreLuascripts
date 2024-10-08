local conf = {
	["filename"] = 'c-词条表.xlsx',
	["sheetname"] = '肉鸽词条表',
	["types"] = {
'int','int','int[]','int[]','int','int','int','int','int','int','int','int','string','string','string','int'
},
	["names"] = {
'id','key','skillId','buffId','target','targetValue','lifeType','lifeValue','preConditions','preConditionsValue','isrepetiton','probability','name','desc','icon','quality'
},
	["data"] = {
{'1000010010',	'1000010010',	'',	'1000010010',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'迅捷：提速Ⅰ',	'我方机动增加<color=#FFC432>15％</color>',	'1001',	'2'},
{'1000010011',	'1000010011',	'',	'1000010011',	'1',	'',	'1',	'',	'1',	'1000010010',	'',	'3000',	'迅捷：提速Ⅱ',	'持有<color=#33CCFF>迅捷：提速Ⅰ</color>时，我方机动增加<color=#FFC432>25％</color>',	'1001',	'3'},
{'1000010020',	'1000010020',	'',	'1000010020',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'迅捷：抗性',	'我方效果抵抗增加<color=#FFC432>20%</color>',	'1001',	'2'},
{'1000010030',	'1000010030',	'',	'1000010030',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'迅捷：提速进攻',	'持有<color=#33CCFF>迅捷：提速Ⅰ</color>时，我方造成伤害增加<color=#FFC432>25%</color>',	'1001',	'3'},
{'1000010040',	'1000010040',	'',	'1000010040',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'迅捷：热身',	'我方单位行动开始时，获得<color=#FFC432>5</color>能量值',	'1001',	'3'},
{'1000010050',	'1000010050',	'',	'1000010050',	'1',	'',	'1',	'',	'',	'',	'',	'2000',	'迅捷：竞速',	'我方单位造成伤害时每比敌方高<color=#FFC432>1</color>机动，则造成伤害增加<color=#FFC432>3%</color>',	'1001',	'6'},
{'1000010060',	'1000010060',	'1000010060',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'迅捷：轻盈',	'我方单位驱散1个负面效果时，根据我方存活角色，每个角色获得<color=#FFC432>10</color>能量值',	'1001',	'3'},
{'1000010070',	'1000010070',	'1000010070',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'迅捷：释放Ⅰ',	'我方行动单位驱散任意我方的负面效果后，我方全体下次攻击时造成伤害增加<color=#FFC432>50%</color>，持续1回合',	'1001',	'4'},
{'1000010080',	'1000010080',	'',	'1000010080',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'迅捷：准备动作',	'战斗开始时，每存在1个我方单位获得<color=#FFC432>10</color>能量值',	'1001',	'4'},
{'1000010090',	'1000010090',	'',	'1000010090',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'迅捷：再动',	'我方单位驱散任意我方的负面效果后，<color=#FFC432>75%</color>概率再次行动',	'1001',	'5'},
{'1000010100',	'1000010100',	'1000010100',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'迅捷：释放Ⅱ',	'我方单位被驱散负面效果后，暴击率增加<color=#FFC432>100%</color>，暴击伤害增加<color=#FFC432>100%</color>，持续<color=#FFC432>2</color>回合',	'1001',	'6'},
{'1000010110',	'1000010110',	'',	'1000010110',	'1',	'',	'2',	'1',	'',	'',	'',	'2000',	'迅捷：先机',	'战斗开始时，我方全体机动增加<color=#FFC432>100%</color>，仅生效<color=#FFC432>1</color>场战斗',	'1001',	'5'},
{'1000010120',	'1000010120',	'',	'1000010120',	'2',	'',	'1',	'',	'',	'',	'',	'3000',	'迅捷：减速',	'战斗开始时，敌方全体机动减少<color=#FFC432>20%</color>，持续5回合',	'1001',	'5'},
{'1000010130',	'1000010130',	'1000010130',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'迅捷：妨碍',	'攻击后敌方目标机动减少<color=#FFC432>5%</color>，上限<color=#FFC432>5</color>层，持续2回合',	'1001',	'5'},
{'1000010140',	'1000010140',	'1000010140',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'迅捷：加机动Ⅰ',	'我方单位使用普攻技能后，自身机动增加<color=#FFC432>16%</color>，上限<color=#FFC432>5</color>层，持续2回合',	'1001',	'5'},
{'1000010150',	'1000010150',	'1000010150',	'',	'1',	'',	'1',	'',	'',	'',	'',	'2000',	'迅捷：加机动Ⅱ',	'我方单位使用大招技能后，自身机动增加<color=#FFC432>16%</color>，持续2回合',	'1001',	'4'},
{'1000010160',	'1000010160',	'1000010160',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'迅捷：脱兔',	'我方单位驱散负面效果时，自身机动增加<color=#FFC432>30</color>，持续2回合',	'1001',	'4'},
{'1000010170',	'1000010170',	'1000010170',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'迅捷：惯性',	'我方单位使用终极技能后，自身攻击力增加<color=#FFC432>8%</color>，可叠加，持续2回合',	'1001',	'4'},
{'1000010180',	'1000010180',	'',	'1000010180',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'迅捷：力量',	'我方攻击力增加<color=#FFC432>10%</color>',	'1001',	'2'},
{'1000010190',	'1000010190',	'',	'1000010190',	'1',	'',	'1',	'',	'1',	'1000010010',	'',	'3000',	'迅捷：猛攻',	'持有<color=#33CCFF>迅捷：提速Ⅰ</color>时，造成伤害时附加<color=#FFC432>30%</color>额外伤害',	'1001',	'6'},
{'1000020010',	'1000020010',	'',	'1000020010',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'神盾：保护Ⅰ',	'战斗开始时，我方全体获得自身耐久<color=#FFC432>8%</color>的护盾',	'1002',	'2'},
{'1000020011',	'1000020011',	'',	'1000020011',	'1',	'',	'1',	'',	'1',	'1000020010',	'',	'3000',	'神盾：保护Ⅱ',	'战斗开始时，若持有<color=#33CCFF>神盾：保护Ⅰ</color>，则我方全体获得自身耐久<color=#FFC432>16%</color>的护盾',	'1002',	'3'},
{'1000020020',	'1000020020',	'',	'1000020020',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'神盾：攻击Ⅰ',	'我方攻击增加<color=#FFC432>8%</color>',	'1002',	'2'},
{'1000020021',	'1000020021',	'',	'1000020021',	'1',	'',	'1',	'',	'1',	'1000020020',	'',	'3000',	'神盾：攻击Ⅱ',	'持有<color=#33CCFF>神盾：攻击Ⅰ</color>时，我方攻击增加<color=#FFC432>16%</color>',	'1002',	'3'},
{'1000020030',	'1000020030',	'',	'1000020030',	'1',	'',	'1',	'',	'',	'',	'',	'4000',	'神盾：盾击Ⅰ',	'我方单位拥有护盾时，造成伤害增加<color=#FFC432>67%</color>',	'1002',	'4'},
{'1000020040',	'1000020040',	'',	'1000020040',	'1',	'',	'2',	'1',	'',	'',	'',	'3000',	'神盾：盾击Ⅱ',	'我方单位拥有护盾时，造成伤害增加<color=#FFC432>100%</color>，仅生效1场战斗',	'1002',	'6'},
{'1000020050',	'1000020050',	'',	'1000020050',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'神盾：额外收益',	'我方单位行动时，若为拥有护盾的目标提供增益，则获得<color=#FFC432>10</color>点能量值',	'1002',	'4'},
{'1000020060',	'1000020060',	'',	'1000020060',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'神盾：防御升级',	'我方单位拥有护盾时，敌方造成伤害减少<color=#FFC432>30%</color>',	'1002',	'5'},
{'1000020070',	'1000020070',	'1000020070',	'',	'1',	'',	'1',	'',	'',	'',	'',	'1500',	'神盾：劣化追加',	'我方单位拥有护盾并对敌方造成伤害时，<color=#FFC432>65%</color>概率对敌方施加劣化效果，持续2回合',	'1002',	'5'},
{'1000020081',	'1000020081',	'',	'1000020081',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'神盾：准备',	'战斗开始时，我方全体获得自身耐久<color=#FFC432>50%</color>的护盾，持续3回合',	'1002',	'4'},
{'1000020090',	'1000020090',	'1000020090',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'神盾：反制',	'我方单位拥有护盾时，若受到攻击则有<color=#FFC432>65%</color>概率进行普攻反击。',	'1002',	'5'},
{'1000020100',	'1000020100',	'1000020100',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'神盾：应激',	'我方单位受到攻击后，获得等同于本次伤害<color=#FFC432>50%</color>的护盾',	'1002',	'4'},
{'1000020110',	'1000020110',	'',	'1000020110',	'1',	'',	'2',	'1',	'',	'',	'',	'3000',	'神盾：保险',	'我方单位拥有的护盾被打破时，立刻获得自身耐久<color=#FFC432>45%</color>的护盾，每场战斗每个角色仅生效1次',	'1002',	'5'},
{'1000020120',	'1000020120',	'',	'1000020120',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'神盾：转化',	'我方单位造成伤害后，获得等同于本次伤害<color=#FFC432>100%</color>的护盾',	'1002',	'6'},
{'1000020130',	'1000020130',	'',	'1000020130',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'神盾：预热',	'我方单位使用终极技能后，若非伤害技能，则自身造成伤害增加<color=#FFC432>50%</color>，上限2层，持续1回合',	'1002',	'5'},
{'1000020140',	'1000020140',	'',	'1000020140',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'神盾：防御Ⅰ',	'我方防御增加<color=#FFC432>10%</color>',	'1002',	'2'},
{'1000020141',	'1000020141',	'',	'1000020141',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'神盾：防御Ⅱ',	'持有<color=#33CCFF>神盾：防御Ⅰ</color>时，我方防御增加<color=#FFC432>10%</color>',	'1002',	'3'},
{'1000020150',	'1000020150',	'1000020150',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'神盾：整备',	'我方单位回合结束时，60%概率获得等同于自身耐久上限<color=#FFC432>12%</color>的护盾，持续2回合',	'1002',	'4'},
{'1000020151',	'1000020151',	'',	'1000020151',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'神盾：整备',	'开场时获得等同于自身耐久上限<color=#FFC432>12%</color>的护盾，持续2回合',	'1002',	'3'},
{'1000020160',	'1000020160',	'',	'1000020160',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'神盾：不屈',	'我方单位受到攻击后，45%概率获得已损失耐久<color=#FFC432>8%</color>的护盾，持续1回合',	'1002',	'4'},
{'1000020170',	'1000020170',	'1000020170',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'神盾：猛击',	'我方单位拥有护盾时，暴击伤害增加<color=#FFC432>80%</color>',	'1002',	'5'},
{'1000020180',	'1000020180',	'1000020180',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'神盾：鹰眼',	'我方单位拥有护盾时，暴击增加<color=#FFC432>100%</color>',	'1002',	'5'},
{'1000030010',	'1000030010',	'',	'1000030010',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'猛袭：单攻',	'我方单体物理伤害增加<color=#FFC432>50%</color>',	'1003',	'2'},
{'1000030020',	'1000030020',	'',	'1000030020',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'猛袭：群攻',	'我方群体物理伤害增加<color=#FFC432>30%</color>',	'1003',	'2'},
{'1000030030',	'1000030030',	'',	'1000030030',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'猛袭：蓄力',	'我方单位对敌方使用普攻技能时，获得<color=#FFC432>5</color>能量值',	'1003',	'2'},
{'1000030040',	'1000030040',	'',	'1000030040',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'猛袭：鹰眼Ⅰ',	'我方单位对敌方造成物理伤害时，50%概率暴击增加<color=#FFC432>20%</color>，持续2回合',	'1003',	'4'},
{'1000030050',	'1000030050',	'',	'1000030050',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'猛袭：鹰眼Ⅱ',	'我方单位对敌方造成物理伤害时，50%概率暴击伤害增加<color=#FFC432>20%</color>，持续2回合',	'1003',	'4'},
{'1000030060',	'1000030060',	'1000030060',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'猛袭：破防',	'我方单位对敌方造成物理伤害时，使敌方防御降低<color=#FFC432>16%</color>，可叠加',	'1003',	'6'},
{'1000030070',	'1000030070',	'',	'1000030070',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'猛袭：瞄准Ⅰ',	'我方单位使用非伤害技能后，暴击增加<color=#FFC432>100%</color>，暴伤增加<color=#FFC432>100%</color>，持续<color=#FFC432>2</color>回合',	'1003',	'6'},
{'1000030080',	'1000030080',	'',	'1000030080',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'猛袭：怒涛',	'我方单位使用终极技能并造成伤害后，40%概率获得<color=#FFC432>100</color>能量值',	'1003',	'4'},
{'1000030090',	'1000030090',	'',	'1000030090',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'猛袭：瞄准Ⅱ',	'我方单位使用技能后，若非伤害技能，则自身造成伤害增加<color=#FFC432>15%</color>，可叠层',	'1003',	'4'},
{'1000030100',	'1000030100',	'',	'1000030100',	'1',	'',	'1',	'',	'',	'',	'',	'4000',	'猛袭：易伤Ⅰ',	'我方单位造成物理伤害时，使敌方目标获得<color=#FF3300>物理易伤</color>：受到物理伤害增加<color=#FFC432>20%</color>，持续2回合',	'1003',	'4'},
{'1000030110',	'1000030110',	'',	'1000030110',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'猛袭：易伤Ⅱ',	'攻击敌方目标时，使耐久小于50%的敌方目标获得<color=#FF3300>物理易伤</color>：受到物理伤害增加<color=#FFC432>20%</color>，持续2回合',	'1003',	'4'},
{'1000030120',	'1000030120',	'',	'1000030120',	'1',	'',	'1',	'',	'',	'',	'',	'4000',	'猛袭：趁势追击',	'对拥有<color=#FF3300>物理易伤</color>的目标造成<color=#FFC432>60%</color>额外伤害',	'1003',	'5'},
{'1000030130',	'1000030130',	'',	'1000030130',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'猛袭：激励',	'持有物理易伤<color=#33CCFF>猛袭：单攻</color>时，我方暴击增加<color=#FFC432>60%</color>',	'1003',	'4'},
{'1000030140',	'1000030140',	'',	'1000030140',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'猛袭：背水',	'我方单位每损失<color=#FFC432>1%</color>耐久，造成伤害增加<color=#FFC432>0.8%</color>',	'1003',	'6'},
{'1000030150',	'1000030150',	'',	'1000030150',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'猛袭：反攻',	'我方单位造成的普攻反击伤害增加<color=#FFC432>26%</color>',	'1003',	'5'},
{'1000030160',	'1000030160',	'',	'1000030160',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'猛袭：群体效应',	'我方单位使用群体攻击前，攻击力增加<color=#FFC432>30%</color>，持续2回合',	'1003',	'5'},
{'1000030170',	'1000030170',	'1000030170',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'猛袭：要害',	'我方造成物理伤害时，65%概率附加相当于<color=#FFC432>120%</color>攻击的真实伤害，不超过目标耐久上限的<color=#FFC432>6%</color>',	'1003',	'4'},
{'1000030180',	'1000030180',	'1000030180',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'猛袭：持续进攻',	'我方单位使用普攻技能后，暴击增加<color=#FFC432>5%</color>，上限<color=#FFC432>5</color>层',	'1003',	'4'},
{'1000030190',	'1000030190',	'',	'1000030190',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'猛袭：先攻',	'战斗开始时，我方全体造成伤害增加<color=#FFC432>100%</color>，持续1回合',	'1003',	'3'},
{'1000030200',	'1000030200',	'1000030200',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'猛袭：伺机而动',	'持有<color=#33CCFF>猛袭：单攻</color>，我方单位50%概率进行普攻反击',	'1004',	'5'},
{'1000040010',	'1000040010',	'',	'1000040010',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'能级：单攻',	'我方单位的单体能量伤害增加<color=#FFC432>50%</color>',	'1004',	'2'},
{'1000040020',	'1000040020',	'',	'1000040020',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'能级：群攻',	'我方单位的群体能量伤害增加<color=#FFC432>30%</color>',	'1004',	'2'},
{'1000040030',	'1000040030',	'',	'1000040030',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'能级：充能',	'我方单位对敌方目标使用普攻技能时，获得<color=#FFC432>5</color>能量值',	'1004',	'2'},
{'1000040040',	'1000040040',	'',	'1000040040',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'能级：鹰眼Ⅰ',	'我方单位造成能量伤害时，50%概率暴击增加<color=#FFC432>20%</color>，持续2回合',	'1004',	'4'},
{'1000040050',	'1000040050',	'',	'1000040050',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'能级：鹰眼Ⅱ',	'我方单位造成能量伤害时，50%概率暴击伤害增加<color=#FFC432>20%</color>，持续2回合',	'1004',	'4'},
{'1000040060',	'1000040060',	'1000040060',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'能级：破防',	'我方单位造成能量伤害时，使敌方目标防御减少<color=#FFC432>16%</color>，可叠加',	'1004',	'6'},
{'1000040070',	'1000040070',	'',	'1000040070',	'1',	'',	'1',	'',	'',	'',	'',	'1500',	'能级：瞄准Ⅰ',	'我方单位使用非伤害技能后，暴击增加<color=#FFC432>100%</color>，暴伤增加<color=#FFC432>100%</color>，持续<color=#FFC432>2</color>回合',	'1004',	'6'},
{'1000040080',	'1000040080',	'',	'1000040080',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'能级：怒涛',	'我方单位使用终极技能并造成伤害后，40%概率获得<color=#FFC432>100</color>能量值',	'1004',	'4'},
{'1000040090',	'1000040090',	'',	'1000040090',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'能级：瞄准Ⅱ',	'我方单位使用技能后，若非伤害技能，则自身造成伤害增加<color=#FFC432>15%</color>，可叠层',	'1004',	'4'},
{'1000040100',	'1000040100',	'',	'1000040100',	'1',	'',	'1',	'',	'',	'',	'',	'4000',	'能级：易伤Ⅰ',	'我方单位造成能量伤害时，能使目标获得<color=#FF3300>能量易伤</color>：受到能量伤害增加20%，持续2回合',	'1004',	'4'},
{'1000040110',	'1000040110',	'',	'1000040110',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'能级：易伤Ⅱ',	'攻击敌方目标时，使生命值小于50%的敌方目标获得<color=#FF3300>能量易伤</color>：受到能量伤害增加20%，持续2回合',	'1004',	'4'},
{'1000040120',	'1000040120',	'',	'1000040120',	'1',	'',	'1',	'',	'',	'',	'',	'4000',	'能级：趁势追击',	'对拥有<color=#FF3300>能量易伤</color>的目标造成<color=#FFC432>60%</color>额外伤害',	'1004',	'5'},
{'1000040130',	'1000040130',	'',	'1000040130',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'能级：激励',	'持有<color=#33CCFF>能级：单攻</color>时，暴击增加<color=#FFC432>60%</color>',	'1004',	'4'},
{'1000040140',	'1000040140',	'',	'1000040140',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'能级：背水',	'我方单位每损失<color=#FFC432>1%</color>耐久，造成伤害增加<color=#FFC432>0.8%</color>',	'1004',	'6'},
{'1000040150',	'1000040150',	'',	'1000040150',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'能级：反攻',	'我方单位造成的普攻反击伤害增加<color=#FFC432>26%</color>',	'1004',	'5'},
{'1000040160',	'1000040160',	'',	'1000040160',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'能级：群体效应',	'我方单位使用群体攻击前，攻击力增加<color=#FFC432>30%</color>，持续2回合',	'1004',	'5'},
{'1000040170',	'1000040170',	'1000040170',	'',	'1',	'',	'1',	'',	'',	'',	'',	'4000',	'能级：要害',	'我方造成能量伤害时，<color=#FFC432>65%</color>概率附加相当于<color=#FFC432>120%</color>攻击的真实伤害，不超过目标耐久上限的<color=#FFC432>6%</color>',	'1004',	'4'},
{'1000040180',	'1000040180',	'1000040180',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'能级：持续进攻',	'我方单位对敌方使用普攻技能后，暴击增加<color=#FFC432>5%</color>，上限5层',	'1004',	'4'},
{'1000040190',	'1000040190',	'',	'1000040190',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'能级：先攻',	'战斗开始时，我方全体造成伤害增加<color=#FFC432>100%</color>，持续1回合',	'1004',	'3'},
{'1000040200',	'1000040200',	'1000040200',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'能级：伺机而动',	'持有<color=#33CCFF>能级：单攻</color>，我方单位<color=#FFC432>50%</color>概率进行普攻反击',	'1004',	'5'},
{'1000050010',	'1000050010',	'',	'1000050010',	'1',	'',	'1',	'',	'',	'',	'',	'4000',	'共鸣：增幅',	'我方终极技能造成伤害增加<color=#FFC432>25%</color>',	'1005',	'2'},
{'1000050020',	'1000050020',	'1000050020',	'',	'1',	'',	'1',	'',	'',	'',	'',	'4000',	'共鸣：强化Ⅰ',	'我方使用终极技能时，自身获得<color=#FF3300>强化</color>:攻击增加<color=#FFC432>8%</color>，上限10层',	'1005',	'5'},
{'1000050030',	'1000050030',	'',	'1000050030',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'共鸣：提速',	'我方机动增加<color=#FFC432>32%</color>',	'1005',	'2'},
{'1000050040',	'1000050040',	'',	'1000050040',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'共鸣：预备',	'战斗开始时，我方每在场1个角色，则获得<color=#FFC432>10</color>能量值',	'1005',	'4'},
{'1000050050',	'1000050050',	'',	'1000050050',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'共鸣：回响',	'我方使用终极技能并造成伤害时，80%概率行动提前<color=#FFC432>20%</color>',	'1005',	'3'},
{'1000050060',	'1000050060',	'1000050060',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'共鸣：强化Ⅱ',	'我方使用终极技能并没有造成伤害时，自身获得1层<color=#FF3300>强化</color>：攻击增加<color=#FFC432>8%</color>，上限10层',	'1005',	'4'},
{'1000050070',	'1000050070',	'',	'1000050070',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'共鸣：节制',	'我方使用终极技能后，获得<color=#FFC432>10</color>能量值',	'1005',	'3'},
{'1000050080',	'1000050080',	'1000050080',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'共鸣：残音',	'我方单位使用终极技能后，自身攻击增加<color=#FFC432>20%</color>，持续<color=#FFC432>2</color>回合',	'1005',	'3'},
{'1000050090',	'1000050090',	'1000050090',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'共鸣：弱化Ⅰ',	'我方单位拥有<color=#FF3300>强化</color>时，对敌方目标造成伤害后，对其施加<color=#FF3300>弱化</color>：受到伤害增加<color=#FFC432>8%</color>，上限<color=#FFC432>5</color>层，持续2回合',	'1005',	'5'},
{'1000050100',	'1000050100',	'1000050100',	'',	'1',	'',	'2',	'1',	'',	'',	'',	'3000',	'共鸣：再动',	'我方使用终极技能行动提前<color=#FFC432>100%</color>，仅生效<color=#FFC432>1</color>场战斗',	'1005',	'6'},
{'1000050110',	'1000050110',	'1000050110',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'共鸣：弱化Ⅱ',	'我方使用终极技能并造成伤害时，对敌方目标施加<color=#FF3300>弱化</color>：受到伤害增加<color=#FFC432>8%</color>，上限<color=#FFC432>5</color>层，持续2回合',	'1005',	'5'},
{'1000050120',	'1000050120',	'',	'1000050120',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'共鸣：反击时刻',	'我方单位耐久低于自身耐久上限<color=#FFC432>50%</color>时，造成伤害增加<color=#FFC432>40%</color>',	'1005',	'4'},
{'1000050130',	'1000050130',	'',	'1000050130',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'共鸣：背水',	'我方单位每损失<color=#FFC432>1%</color>耐久，造成伤害增加<color=#FFC432>0.8%</color>',	'1005',	'4'},
{'1000050140',	'1000050140',	'',	'1000050140',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'共鸣：吸收',	'我方对拥有<color=#FF3300>弱化</color>的敌方单位造成伤害时，获得<color=#FFC432>5</color>能量值',	'1005',	'5'},
{'1000050150',	'1000050150',	'',	'1000050150',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'共鸣：激励',	'我方单位拥有<color=#FF3300>强化</color>时，造成伤害前暴击增加<color=#FFC432>30%</color>',	'1005',	'4'},
{'1000050160',	'1000050160',	'',	'1000050160',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'共鸣：观察',	'我方效果命中增加<color=#FFC432>24%</color>',	'1005',	'2'},
{'1000050170',	'1000050170',	'1000050170',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'共鸣：积蓄',	'我方单位使用终极技能后，若非伤害技能，则自身造成伤害增加<color=#FFC432>66%</color>，上限2层',	'1005',	'4'},
{'1000050180',	'1000050180',	'',	'1000050180',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'共鸣：趁势追击',	'我方对拥有<color=#FF3300>弱化</color>的敌方单位造成额外<color=#FFC432>67%</color>伤害',	'1005',	'6'},
{'1000060010',	'1000060010',	'',	'1000060010',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'免疫：观察Ⅰ',	'我方效果命中增加<color=#FFC432>10%</color>',	'1006',	'2'},
{'1000060011',	'1000060011',	'',	'1000060011',	'1',	'',	'1',	'',	'1',	'1000060010',	'',	'3000',	'免疫：观察Ⅱ',	'持有<color=#33CCFF>免疫：观察Ⅰ</color>时，我方效果命中增加<color=#FFC432>33%</color>',	'1006',	'3'},
{'1000060020',	'1000060020',	'',	'1000060020',	'2',	'',	'1',	'',	'',	'',	'',	'3000',	'免疫：洞悉Ⅰ',	'敌方全体效果抵抗减少<color=#FFC432>10%</color>',	'1006',	'2'},
{'1000060021',	'1000060021',	'',	'1000060021',	'2',	'',	'1',	'',	'1',	'1000060020',	'',	'3000',	'免疫：洞悉Ⅱ',	'持有<color=#33CCFF>免疫：洞悉Ⅰ</color>时，敌方全体效果抵抗减少<color=#FFC432>33%</color>',	'1006',	'3'},
{'1000060030',	'1000060030',	'',	'1000060030',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'免疫：攻击Ⅰ',	'我方攻击增加<color=#FFC432>8%</color>',	'1006',	'2'},
{'1000060031',	'1000060031',	'',	'1000060031',	'1',	'',	'1',	'',	'1',	'1000060030',	'',	'3000',	'免疫：攻击Ⅱ',	'持有<color=#33CCFF>免疫：攻击Ⅰ</color>时，我方攻击增加<color=#FFC432>33%</color>',	'1006',	'3'},
{'1000060040',	'1000060040',	'',	'1000060040',	'1',	'',	'1',	'',	'',	'',	'',	'5000',	'免疫：降速',	'对敌方造成伤害时，概率对目标施加<color=#FF3300>降速</color>:减少效果抵抗和机动<color=#FFC432>8%</color>，可叠层',	'1006',	'5'},
{'1000060050',	'1000060050',	'1000060050',	'',	'1',	'',	'1',	'',	'',	'',	'',	'5000',	'免疫：结霜Ⅰ',	'我方单位使用普攻技能时，概率对敌方目标施加冰冻',	'1006',	'5'},
{'1000060060',	'1000060060',	'',	'1000060060',	'1',	'',	'1',	'',	'',	'',	'',	'5000',	'免疫：破冰',	'我方单位目标发动攻击时，每存在1个负面效果增伤<color=#FFC432>32%</color>',	'1006',	'6'},
{'1000060070',	'1000060070',	'1000060070',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'免疫：持续降温',	'我方单位造成伤害时，概率延长冰冻<color=#FFC432>1</color>回合',	'1006',	'4'},
{'1000060080',	'1000060080',	'1000060080',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'免疫：追加',	'我方单位造成伤害时，根据敌方全体拥有控制效果的个数施加劣化层数',	'1006',	'4'},
{'1000060090',	'1000060090',	'',	'1000060090',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'免疫：限制行动',	'对拥有控制状态的敌方造成伤害时，根据敌方全体拥有控制效果的个数使目标行动推条<color=#FFC432>10%</color>',	'1006',	'4'},
{'1000060100',	'1000060100',	'',	'1000060100',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'免疫：反攻',	'我方单位造成的普攻反击伤害增加<color=#FFC432>26%</color>',	'1006',	'4'},
{'1000060110',	'1000060110',	'1000060110',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'免疫：孱弱',	'我方单位使用终极技能时，100%基础概率使敌方目标的效果抵抗减少<color=#FFC432>100%</color>，持续1回合',	'1006',	'6'},
{'1000060120',	'1000060120',	'1000060120',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'免疫：结霜Ⅲ',	'我方单位使用终极技能并造成伤害后，大概率对敌方目标施加冰冻',	'1006',	'5'},
{'1000060130',	'1000060130',	'',	'1000060130',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'免疫：结霜Ⅱ',	'我方单位进行普攻反击时，对敌方目标施加冰冻效果',	'1006',	'5'},
{'1000060140',	'1000060140',	'',	'1000060140',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'免疫：单攻',	'我方单体伤害增加<color=#FFC432>100%</color>',	'1006',	'5'},
{'1000060150',	'1000060150',	'',	'1000060150',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'免疫：急冻',	'我方单位使用终极技能并造成伤害后，<color=#FFC432>60%</color>概率使敌方目标获得沉默效果',	'1006',	'4'},
{'1000060160',	'1000060160',	'',	'1000060160',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'免疫：背水',	'我方单位每损失<color=#FFC432>1%</color>耐久，造成伤害增加<color=#FFC432>0.8%</color>',	'1006',	'4'},
{'1000070010',	'1000070010',	'',	'1000070010',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'连携：攻击Ⅰ',	'我方攻击增加<color=#FFC432>8%</color>',	'1007',	'2'},
{'1000070020',	'1000070020',	'',	'1000070020',	'1',	'',	'1',	'',	'1',	'1000070010',	'',	'3000',	'连携：攻击Ⅱ',	'持有<color=#33CCFF>连携：攻击Ⅰ</color>时，我方攻击增加<color=#FFC432>32%</color>',	'1007',	'3'},
{'1000070030',	'1000070030',	'',	'1000070030',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'连携：反攻',	'我方单位造成的普攻反击伤害增加<color=#FFC432>32%</color>',	'1007',	'3'},
{'1000070040',	'1000070040',	'',	'1000070040',	'1',	'',	'1',	'',	'',	'',	'',	'1000',	'连携：背水',	'我方单位每损失<color=#FFC432>1%</color>耐久，造成伤害增加<color=#FFC432>0.8%</color>，最高80%',	'1007',	'5'},
{'1000070050',	'1000070050',	'1000070050',	'',	'1',	'',	'1',	'',	'',	'',	'',	'5000',	'连携：癫狂Ⅰ',	'我方单位进行普攻反击后，使自身获得<color=#FF3300>癫狂</color>：暴击增加<color=#FFC432>5%</color>，上限<color=#FFC432>5</color>层',	'1007',	'5'},
{'1000070060',	'1000070060',	'',	'1000070060',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'连携：反击号令',	'战斗开始后，我方全体反击伤害增加<color=#FFC432>67%</color>，持续3回合',	'1007',	'5'},
{'1000070070',	'1000070070',	'',	'1000070070',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'连携：反击强化',	'我方单位进行普攻反击后，自身暴击伤害增加<color=#FFC432>20%</color>',	'1007',	'5'},
{'1000070080',	'1000070080',	'',	'1000070080',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'连携：时机',	'回合结束时，概率使全体行动提前<color=#FFC432>8%</color>',	'1007',	'4'},
{'1000070090',	'1000070090',	'',	'1000070090',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'连携：仇击',	'我方单位造成的普攻追击伤害增加<color=#FFC432>32%</color>',	'1007',	'6'},
{'1000070100',	'1000070100',	'',	'1000070100',	'1',	'',	'1',	'',	'',	'',	'',	'4000',	'连携：癫狂Ⅱ',	'我方单位进行普攻追击后，使自身获得<color=#FF3300>癫狂</color>：暴击增加<color=#FFC432>5%</color>，上限<color=#FFC432>5</color>层',	'1007',	'5'},
{'1000070101',	'1000070101',	'',	'1000070101',	'1',	'',	'1',	'',	'',	'',	'',	'5000',	'连携：狂热',	'我方单位拥有<color=#FF3300>癫狂</color>时，普攻追击后暴击伤害增加<color=#FFC432>8%</color>',	'1007',	'6'},
{'1000070110',	'1000070110',	'',	'1000070110',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'连携：节奏',	'我方单位进行普攻反击后，自身行动提前<color=#FFC432>8%</color>',	'1007',	'4'},
{'1000070120',	'1000070120',	'1000070120',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'连携：反击准备',	'我方全体可以进行普攻反击，<color=#FFC432>65%</color>概率触发',	'1007',	'4'},
{'1000070130',	'1000070130',	'1000070130',	'',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'连携：追击准备',	'我方全体可以进行普攻追击，<color=#FFC432>65%</color>概率触发',	'1007',	'4'},
{'1000070140',	'1000070140',	'',	'1000070140',	'1',	'',	'2',	'1',	'',	'',	'',	'3000',	'连携：追击号令',	'战斗开始后，我方造成的普攻追击伤害增加<color=#FFC432>120%</color>，仅生效<color=#FFC432>1</color>场战斗',	'1007',	'6'},
{'1000070150',	'1000070150',	'',	'1000070150',	'1',	'',	'1',	'',	'',	'',	'',	'3000',	'连携：预热',	'战斗开始时，根据场上角色个数，每位角色获得<color=#FFC432>15</color>能量值',	'1007',	'4'},
{'1000070160',	'1000070160',	'',	'1000070160',	'1',	'',	'1',	'',	'',	'',	'',	'1000',	'连携：单攻',	'我方单体伤害增加<color=#FFC432>80%</color>',	'1007',	'6'},
{'1000080010',	'1000080010',	'1000080010',	'',	'1',	'',	'1',	'',	'',	'',	'',	'10000',	'普攻追击',	'普攻伤害增加<color=#FFC432>50%</color>，对敌人造成伤害后，有<color=#FFC432>60%</color>概率使用普攻进行追击',	'1007',	'6'},
},
}
--cfgCfgRogueBuff = conf
return conf
