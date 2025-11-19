local conf = {
	["filename"] = 'h-活动列表.xlsx',
	["sheetname"] = '累计充值',
	["types"] = {
'int','string','string','int','json'
},
	["names"] = {
'id','key','sDescription','money','jAwardId'
},
	["data"] = {
{'1',	'',	'累计充值 <color=#ffc146>6</color> 元',	'600',	'[[10002,60,2]]'},
{'2',	'',	'累计充值 <color=#ffc146>30</color> 元',	'3000',	'[[10002,90,2]]'},
{'3',	'',	'累计充值 <color=#ffc146>98</color> 元',	'9800',	'[[10002,340,2]]'},
{'4',	'',	'累计充值 <color=#ffc146>198</color> 元',	'19800',	'[[10002,500,2]]'},
{'5',	'',	'累计充值 <color=#ffc146>500</color> 元',	'50000',	'[[10002,2010,2]]'},
},
}
--cfgCfgRechargeCount = conf
return conf
