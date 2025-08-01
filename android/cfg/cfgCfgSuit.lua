local conf = {
	["filename"] = 'z-装备配置表.xlsx',
	["sheetname"] = '套装类型',
	["types"] = {
'int','string','string','string','string','string','int','int','string'
},
	["names"] = {
'id','name','name2','icon','skillName','dec','show','SuitType','limitTime'
},
	["data"] = {
{'201',	'穿甲芯片',	'穿甲芯片',	'201',	'穿甲',	'穿甲：\n1.提升角色的暴击\n2.造成暴击伤害时，忽略目标防御',	'1',	'1',	'2024-10-08 16:00:00'},
{'202',	'切割芯片',	'切割芯片',	'202',	'切割',	'切割：\n1.提升角色的攻击\n2.造成伤害时，概率额外附加攻击力一定百分比的真实伤害（伤害不超过目标耐久上限的一定百分比）',	'1',	'1',	''},
{'203',	'征服芯片',	'征服芯片',	'203',	'征服',	'征服：\n1.提升角色的暴伤\n2.对耐久大于60%的单位造成伤害增加',	'1',	'1',	''},
{'204',	'催眠芯片',	'催眠芯片',	'204',	'催眠',	'催眠：\n1.提升角色的机动\n2.使用昏睡效果技能时，效果命中提升',	'',	'2',	''},
{'205',	'重击芯片',	'重击芯片',	'205',	'重击',	'重击：\n1.提升角色的机动\n2.使用眩晕效果技能时，效果命中提升',	'',	'2',	''},
{'206',	'麻醉芯片',	'麻醉芯片',	'206',	'麻醉',	'麻醉：\n1.提升角色的效果命中\n2.受到攻击后，概率对攻击者施加麻痹，持续1回合，享有效果命中加成',	'',	'2',	''},
{'207',	'支援芯片',	'支援芯片',	'207',	'支援',	'支援：\n1.提升角色的耐久\n2.修复效果增加',	'1',	'2',	''},
{'208',	'不屈芯片',	'不屈芯片',	'208',	'不屈',	'不屈：\n1.提升角色的耐久\n2.自身耐久低于40%时，获得耐久上限百分比的吸收护盾，并提升攻击，持续2回合，每场战斗只生效一次',	'',	'2',	''},
{'209',	'汲取芯片',	'汲取芯片',	'209',	'汲取',	'汲取：\n1.提升角色的攻击\n2.攻击后，回复造成伤害百分比的耐久',	'',	'2',	''},
{'210',	'精力芯片',	'精力芯片',	'210',	'精力',	'精力：\n1.提升角色的机动\n2.战斗开始时，获得同步率',	'1',	'2',	''},
{'211',	'慈悲芯片',	'慈悲芯片',	'211',	'慈悲',	'慈悲：\n1.提升角色的耐久\n2.我方单位使用非伤害技能时，概率额外获得5能量值，效果不可叠加',	'',	'2',	''},
{'212',	'收割芯片',	'收割芯片',	'212',	'收割',	'收割：\n1.提升角色的攻击\n2.击败目标时，获得能量值',	'1',	'1',	''},
{'213',	'屏障芯片',	'屏障芯片',	'213',	'屏障',	'屏障：\n1.提升角色的耐久\n2.战斗开始时，我方全体获得耐久百分比的吸收护盾，持续2回合',	'1',	'2',	''},
{'214',	'铁壁芯片',	'铁壁芯片',	'214',	'铁壁',	'铁壁：\n1.提升角色的防御\n2.我方全体受到物理伤害减少，效果不可叠加',	'1',	'2',	''},
{'215',	'灵巧芯片',	'灵巧芯片',	'215',	'灵巧',	'灵巧：\n1.提升角色的攻击\n2.回合结束后，概率使自身行动提前',	'1',	'2',	''},
{'216',	'暴怒芯片',	'暴怒芯片',	'216',	'暴怒',	'暴怒：\n1.提升角色的耐久\n2.受到攻击后，自身行动提前，并提升攻击，持续1回合，最多叠加3层',	'1',	'2',	''},
{'217',	'致命芯片',	'致命芯片',	'217',	'致命',	'致命：\n1.提升角色的攻击\n2.对耐久低于40%的目标，造成伤害增加',	'1',	'1',	''},
{'218',	'腐蚀芯片',	'腐蚀芯片',	'218',	'腐蚀',	'腐蚀：\n1.提升角色效果命中\n2.攻击后，给目标施加1层劣化',	'1',	'2',	''},
{'219',	'集中芯片',	'集中芯片',	'219',	'集中',	'集中：\n1.提升角色的效果命中\n2.战斗开始时，我方全体攻击和效果命中增加，效果不可叠加',	'1',	'2',	''},
{'220',	'金刚芯片',	'金刚芯片',	'220',	'金刚',	'金刚：\n1.提升角色的效果抵抗\n2.战斗开始时，我方全体防御和效果抵抗增加，效果不可叠加',	'1',	'2',	''},
{'221',	'痛击芯片',	'痛击芯片',	'221',	'痛击',	'痛击：\n1.提升角色的暴伤\n2.自身与自身传送的机神攻击时，对护甲的克制效果增加',	'1',	'1',	''},
{'222',	'扩大芯片',	'扩大芯片',	'222',	'扩大',	'扩大：\n1.提升角色的暴伤\n2.佩戴者释放范围技能时，增加造成攻击伤害，释放全体范围技能时，全体范围技能攻击时根据目标数量额外提升攻击',	'1',	'1',	''},
{'223',	'物攻芯片',	'物攻芯片',	'223',	'物攻',	'物攻：\n1.提升角色的暴击\n2.物理伤害增加',	'1',	'1',	''},
{'224',	'能量芯片',	'能量芯片',	'224',	'能量',	'能量：\n1.提升角色的暴击\n2.能量伤害增加',	'1',	'1',	''},
{'225',	'装填芯片',	'装填芯片',	'225',	'装填',	'装填：\n1.提升角色的机动\n2.战斗开始时，获得能量值，效果不可叠加',	'1',	'2',	''},
{'226',	'冰冻芯片',	'冰冻芯片',	'226',	'冰冻',	'冰冻：\n1.提升角色的机动\n2.使用冻结技能时，效果命中增加',	'',	'2',	''},
{'227',	'光幕芯片',	'光幕芯片',	'227',	'光幕',	'光幕：\n1.提升角色的防御\n2.我方全体单位受到能量伤害减少，效果不可叠加',	'1',	'2',	''},
{'228',	'重构芯片',	'重构芯片',	'228',	'重构',	'重构：\n1.提升角色的攻击\n2.战败退场时，复苏自身并回复一定百分比的耐久（每场战斗只生效一次）',	'',	'2',	''},
{'229',	'反射芯片',	'反射芯片',	'229',	'反射',	'反射：\n1.提升角色的耐久\n2.受到暴击伤害时，反弹所受伤害，自身防御转化为反弹伤害,不超过受到伤害的100%',	'',	'2',	''},
{'230',	'钝化芯片',	'钝化芯片',	'230',	'钝化',	'钝化：\n1.提升角色的防御\n2.受到攻击后，降低攻击者的攻击和机动，持续1回合',	'1',	'2',	''},
{'231',	'满溢芯片',	'满溢芯片',	'231',	'满溢',	'满溢：\n1.提升角色的暴伤\n2.使用单体技能击败目标时，将部分溢出伤害分摊给敌方全体',	'',	'2',	''},
{'232',	'复苏芯片',	'复苏芯片',	'232',	'复苏',	'复苏：\n1.提升角色的效果抵抗\n2.耐久下降时，受到修复效果增加',	'',	'2',	''},
{'233',	'威慑芯片',	'威慑芯片',	'233',	'威慑',	'威慑：\n1.提升角色的攻击\n2.击败目标时，使敌方全体行动延后',	'',	'2',	''},
{'234',	'神力芯片',	'神力芯片',	'234',	'神力',	'神力：\n1.提升角色的攻击\n2.自身传送机神造成伤害提升',	'1',	'1',	''},
{'235',	'神速芯片',	'神速芯片',	'235',	'神速',	'神速：\n1.提升角色的效果抵抗\n2.自身传送机神机动、效果命中和同步率提升',	'1',	'2',	''},
{'236',	'救赎芯片',	'救赎芯片',	'236',	'救赎',	'救赎：\n1.提升角色的耐久\n2.队友受到致命攻击时，消耗自身耐久为其抵挡，并立即回复队友一定百分比的耐久，5回合内无法重复触发，自身生命低于40%时无法触发，效果不可叠加',	'',	'2',	''},
{'237',	'振奋芯片',	'振奋芯片',	'237',	'振奋',	'振奋：\n1.提升角色的效果命中\n2.战斗开始时，我方全体机动增加，行动时额外获得同步率，效果不可叠加',	'1',	'2',	''},
{'238',	'战神芯片',	'战神芯片',	'238',	'战神',	'战神：\n1.提升角色的防御\n2.使用普攻技能攻击时，额外追加目标耐久上限百分比的伤害，不超过自身防御的百分比',	'',	'1',	''},
{'239',	'破军芯片',	'破军芯片',	'239',	'破军',	'破军：\n1.提升角色的暴击\n使用普攻技能暴击时，概率额外对敌方全体造成攻击百分比的伤害',	'',	'1',	''},
{'240',	'消除芯片',	'消除芯片',	'240',	'消除',	'消除：\n1.提升角色的攻击\n2.攻击时，概率解除目标1-2个增益效果',	'1',	'2',	''},
{'241',	'震慑芯片',	'震慑芯片',	'241',	'震慑',	'震慑：\n1.提升角色的暴击\n2.造成暴击伤害时，概率使目标行动延后',	'',	'2',	''},
{'242',	'重伤芯片',	'重伤芯片',	'242',	'重伤',	'重伤：\n1.提升角色的效果命中\n2.攻击后，使目标受到修复效果减少，持续1回合',	'1',	'2',	''},
{'243',	'精准芯片',	'精准芯片',	'243',	'精准',	'精准：\n1.提升角色的精准\n2.每次暴击后，概率使暴击伤害增加',	'',	'1',	''},
{'244',	'连击芯片',	'连击芯片',	'244',	'连击',	'连击：\n1.提升角色的暴伤\n2.使用非普攻技能后，普攻必定暴击，并使该技能伤害增加，持续1回合',	'1',	'1',	''},
{'245',	'乘风芯片',	'乘风芯片',	'245',	'乘风',	'乘风：\n1.提升角色的暴击\n2.单体普攻技能触发暴击时，概率使我方全体行动提前',	'1',	'2',	''},
{'246',	'限制芯片',	'限制芯片',	'246',	'限制',	'限制：\n1.提升角色的暴击\n2.使用普攻技能时，概率减少目标防御，持续1回合；目标存在减防状态时，概率施加过载，使目标无法获得同步率，持续2回合',	'',	'2',	''},
{'247',	'愤怒芯片',	'愤怒芯片',	'247',	'愤怒',	'愤怒：\n1.提升角色的效果命中\n2.耐久下降时，攻击提升',	'',	'1',	''},
{'248',	'自在芯片',	'自在芯片',	'248',	'自在',	'自在：\n1.提升角色的暴击\n2.耐久大于80%时，攻击提升',	'',	'1',	''},
{'249',	'反击芯片',	'反击芯片',	'249',	'反击',	'反击：\n1.提升角色的攻击\n2.队友受到攻击时，自身概率使用普攻反击，效果不可叠加',	'1',	'1',	''},
{'250',	'协击芯片',	'协击芯片',	'250',	'协击',	'协击：\n1.提升角色的攻击\n2.队友使用单体普攻技能时，自身概率使用普攻技能协击，效果不可叠加',	'1',	'1',	''},
{'251',	'引爆芯片',	'引爆芯片',	'251',	'引爆',	'引爆：\n1.提升角色的机动\n2.攻击后，概率提前引爆1个持续伤害（劣化、割裂、灼烧）',	'1',	'2',	''},
{'252',	'过载芯片',	'过载芯片',	'252',	'过载',	'过载：\n1.提升角色的效果命中\n2.攻击后，概率对目标施加过载，使其无法获得能量值，持续2回合',	'',	'2',	''},
},
}
--cfgCfgSuit = conf
return conf
