local conf = {
	["filename"] = 's-商店配置.xlsx',
	["sheetname"] = '商店表',
	["types"] = {
'int','string','string','string','string','int','int'
},
	["names"] = {
'id','key','sName','openTime','closeTime','nOpenLimitType','nOpenLimitVal'
},
	["data"] = {
{'1',	'',	'资源中心',	'',	'',	'',	''},
{'2',	'',	'碎星商贸',	'',	'',	'',	''},
{'3',	'',	'外装研发',	'',	'',	'',	''},
},
}
--cfgCfgShopInfo = conf
return conf
