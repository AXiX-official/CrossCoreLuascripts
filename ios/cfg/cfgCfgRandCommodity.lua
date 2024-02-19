local conf = {
	["filename"] = 's-商店配置.xlsx',
	["sheetname"] = '随机商品配置',
	["types"] = {
'int','string','int','int','int','int[]','json'
},
	["names"] = {
'id','key','group','nRewardId','nFlushType','aFlushTimes','aManFlushCosts'
},
	["data"] = {
{'80001',	'',	'101',	'60001',	'5',	'6,12,18',	'[[10002,100]]'},
{'80002',	'',	'904',	'60002',	'1',	'7',	''},
},
}
--cfgCfgRandCommodity = conf
return conf
