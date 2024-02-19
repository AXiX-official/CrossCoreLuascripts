local conf = {
	["filename"] = 'e-枚举定义表.xlsx',
	["sheetname"] = '主界面按钮',
	["types"] = {
'int','string','string','string','string','string'
},
	["names"] = {
'id','key','sName1','sName2','icon','sViewName'
},
	["data"] = {
{'1',	'1',	'基建中心',	'INF.CENTER',	'v1',	'Matrix'},
{'2',	'2',	'商店',	'SHOP',	'v2',	'ShopView'},
{'3',	'3',	'后勤仓',	'STOREHOUSE',	'v3',	'Bag'},
{'4',	'4',	'角色',	'CHAAACTER',	'v4',	'RoleListNormal'},
{'5',	'5',	'编队',	'UNIT EDIT',	'v5',	'TeamView'},
{'6',	'6',	'冷却',	'COOLING SYS',	'v6',	'CoolView'},
{'7',	'7',	'核心构建',	'CORE MAKING',	'v7',	'CreateView'},
},
}
--cfgCfgMenuEnum = conf
return conf
