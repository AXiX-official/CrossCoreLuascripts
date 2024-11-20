local conf = {
	["filename"] = 'j-角斗场表.xlsx',
	["sheetname"] = '入口表',
	["types"] = {
'int','int','string','string','string','int','json','int[]','int','json','int','int[]','int','int','int','int','int'
},
	["names"] = {
'id','key','seasonName','begTime','endTime','optionalSwitch','optionalCost','optionalRefresh','randomSwitch','randomCost','randomSet','randomRefresh','savePoint','freeType','freeNum','freeMax','messageid'
},
	["data"] = {
{'1',	'1',	'测试赛季',	'2024/12/01 10:00:00',	'2025/02/01 02:59:59',	'1',	'',	'30',	'1',	'[[10035,90],[10040,90]]',	'1',	'30',	'',	'2',	'1',	'3',	'9006'},
{'2',	'2',	'第2赛季',	'2025/02/01 03:00:00',	'2025/04/01 03:00:00',	'1',	'',	'30',	'1',	'[[10035,90],[10040,90]]',	'1',	'30',	'',	'2',	'1',	'3',	'9006'},
},
}
--cfgcfgColosseum = conf
return conf
