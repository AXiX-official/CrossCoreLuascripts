local conf = {
	["filename"] = 'z-装备配置表.xlsx',
	["sheetname"] = '材料装备',
	["types"] = {
'int','string','int','int','int','json'
},
	["names"] = {
'id','key','nMaterialCost','nMaterialExp','nSellPrice','jSellRewards'
},
	["data"] = {
{'1',	'1',	'750',	'150',	'75',	''},
{'2',	'2',	'1500',	'300',	'150',	''},
{'3',	'3',	'3000',	'600',	'300',	''},
{'4',	'4',	'6000',	'1200',	'600',	''},
{'5',	'5',	'12000',	'2400',	'1200',	''},
},
}
--cfgCfgMaterialEquip = conf
return conf
