local conf = {
	["filename"] = 'j-技能.xlsx',
	["sheetname"] = '技能范围',
	["types"] = {
'int','string','int','int','json','json','string','bool'
},
	["names"] = {
'id','key','group','range_type','range','range_limit','skill_icon','cross'
},
	["data"] = {
{'1',	'one',	'',	'0',	'[[1,1]]',	'',	'effective_range_01',	''},
{'2',	'one_row',	'',	'1',	'',	'',	'effective_range_02',	''},
{'3',	'one_col',	'',	'2',	'',	'',	'effective_range_05',	''},
{'4',	'all',	'',	'3',	'',	'',	'effective_range_04',	''},
{'5',	'tian',	'',	'0',	'[[1,1],[1,2],[2,1],[2,2]]',	'',	'effective_range_06',	''},
{'6',	'shizi',	'',	'0',	'[[1,2],[2,1],[2,2],[2,3],[3,2]]',	'',	'effective_range_03',	''},
{'7',	'summon_area',	'',	'1',	'',	'[[0,1],[0,2],[0,3]]',	'effective_range_07',	''},
{'8',	'one_except_self',	'',	'4',	'[[1,1]]',	'',	'effective_range_01',	''},
{'9',	'myself',	'',	'5',	'[[1,1]]',	'',	'effective_range_01',	''},
{'10',	'shizi1',	'',	'0',	'[[1,1]]',	'',	'effective_range_03',	'1'},
{'11',	'two_row',	'',	'0',	'[[1,1],[1,2],[1,3],[2,1],[2,2],[2,3]]',	'',	'effective_range_10',	''},
{'12',	'two_col',	'',	'0',	'[[1,1],[1,2],[2,1],[2,2],[3,1],[3,2],[4,1],[4,2]]',	'',	'effective_range_11',	''},
{'13',	'all1',	'',	'3',	'[[1,1]]',	'',	'effective_range_04',	''},
},
}
--cfgskill_range = conf
return conf
