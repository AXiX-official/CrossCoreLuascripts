local conf = {
	["filename"] = 'd-多队boss战斗.xlsx',
	["sheetname"] = '结算奖励',
	["types"] = {
'int','table#4','int','int','int','json'
},
	["names"] = {
'id','infos','idx','timesMin','timesMax','reward'
},
	["data"] = {
{'1',	'',	'',	'',	'',	''},
{'1',	'',	'1',	'1',	'1',	'[[10040,280],[10001,60000],[10003,40000]]'},
{'1',	'',	'2',	'2',	'2',	'[[10040,300],[10001,80000],[10003,60000]]'},
{'1',	'',	'3',	'3',	'3',	'[[10040,320],[10001,100000],[10003,80000]]'},
{'1',	'',	'4',	'4',	'4',	'[[10040,340],[10001,120000],[10003,100000]]'},
{'1',	'',	'5',	'5',	'5',	'[[10040,360],[10001,140000],[10003,120000]]'},
},
}
--cfgCfgSettlementRewards = conf
return conf
