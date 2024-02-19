local conf = {
	["filename"] = 's-商店配置.xlsx',
	["sheetname"] = '商城推荐配置',
	["types"] = {
'int','string','int','int','string','string','int','int','int','string','int','string','string'
},
	["names"] = {
'id','key','group','type','resName','img','sJumpID','hasAssistant','modelID','cRoleID','voiceType','startTime','endTime'
},
	["data"] = {
{'1001',	'',	'2001',	'1',	'',	'Store01',	'140003',	'1',	'9908002',	'9908_Kadya',	'21',	'',	''},
{'1002',	'',	'2002',	'2',	'ShopPromote/PromoteSurveryItem',	'',	'',	'1',	'9908002',	'9908_Kadya',	'22',	'',	''},
{'1003',	'',	'2003',	'2',	'ShopPromote/PromoteMonthItem',	'',	'140009',	'1',	'9908002',	'9908_Kadya',	'23',	'',	''},
},
}
--cfgCfgShopReCommend = conf
return conf
