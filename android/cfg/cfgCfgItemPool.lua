local conf = {
	["filename"] = 'd-道具池表.xlsx',
	["sheetname"] = '道具池表',
	["types"] = {
'int','string','int','int','int','string','string','int[]','int','int','int[]'
},
	["names"] = {
'id','Propname','extracttype','Proptype','group','starttime','endtime','cost','costnum','maxcostnum','Languageid'
},
	["data"] = {
{'1001',	'回归道具池1',	'1',	'4',	'1',	'',	'',	'10402,1',	'1',	'10',	'60107,60108'},
{'1002',	'回归道具池2',	'2',	'4',	'1',	'',	'',	'10402,1',	'1',	'10',	'60107,60108'},
},
}
--cfgCfgItemPool = conf
return conf
