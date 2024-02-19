local conf = {
	["filename"] = 'j-基地配置表.xlsx',
	["sheetname"] = '建筑属性',
	["types"] = {
'int','string','string','string','string','string'
},
	["names"] = {
'id','key','sName','icon','icon2','viewName'
},
	["data"] = {
{'1',	'1',	'改造槽',	'btn_1_01',	'btn_3_01',	'MatrixRemould'},
{'2',	'2',	'合成菜单',	'btn_1_02',	'btn_3_01',	'MatrixCompound'},
{'3',	'3',	'资源库',	'btn_1_03',	'btn_3_01',	'MatrixResPanel'},
{'4',	'4',	'角色管理',	'btn_1_04',	'btn_3_01',	'MatrixSetRole'},
{'5',	'5',	'订单库',	'btn_1_05',	'btn_3_01',	'MatrixTrading'},
{'6',	'6',	'战斗',	'btn_1_06',	'btn_3_01',	''},
{'7',	'7',	'信息',	'btn_1_07',	'btn_3_01',	'MatrixBuildingInfo'},
{'8',	'8',	'远征列表',	'btn_1_08',	'btn_3_01',	'MatrixExpedition'},
{'9',	'9',	'玩家能力',	'btn_1_08',	'btn_3_01',	'PlayerAbility'},
},
}
--cfgCfgMatrixAttribute = conf
return conf
