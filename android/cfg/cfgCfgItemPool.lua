local conf = {
	["filename"] = 'd-道具池表.xlsx',
	["sheetname"] = '道具池表',
	["types"] = {
'int','string','int','int','int','string','string','int','json','int','int','int[]'
},
	["names"] = {
'id','Propname','extracttype','Proptype','group','starttime','endtime','costtype','cost','costnum','maxcostnum','Languageid'
},
	["data"] = {
{'1001',	'回归道具池1',	'1',	'4',	'1',	'',	'',	'1',	'[[10402,1]]',	'1',	'10',	'60107,60108'},
{'1002',	'回归道具池2',	'2',	'4',	'1',	'',	'',	'1',	'[[10402,1]]',	'1',	'10',	'60107,60108'},
{'1003',	'幸运扭蛋',	'3',	'1',	'2',	'2024-08-25 10:00:00',	'2024-10-16 03:00:00',	'2',	'[[1,10406,1],[2,10406,1],[3,10406,1],[4,10406,1],[5,10406,1],[6,10406,1]]',	'1',	'1',	'67001,67003'},
},
}
--cfgCfgItemPool = conf
return conf
