local conf = {
	["filename"] = 's-商店配置1.xlsx',
	["sheetname"] = '兑换配置表',
	["types"] = {
'int','string','int','int','int[]','json'
},
	["names"] = {
'id','key','group','nRewardId','aFlushTimes','aManFlushCosts'
},
	["data"] = {
{'80001',	'',	'101',	'60001',	'6,12,18',	'[[10002,10]]'},
},
}
cfgCfgExchange = conf
return conf
