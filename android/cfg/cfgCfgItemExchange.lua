local conf = {
	["filename"] = 'w-物品表.xlsx',
	["sheetname"] = '物品兑换',
	["types"] = {
'int','int','json','json','int'
},
	["names"] = {
'id','key','gets','costs','type'
},
	["data"] = {
{'1001',	'1001',	'[[11002,1]]',	'[[10002,150]]',	'1'},
{'1002',	'1002',	'[[11002,1]]',	'[[10040,150]]',	'1'},
{'1003',	'1003',	'[[10040,1]]',	'[[10002,1]]',	'1'},
{'101001',	'101001',	'[[10033,10]]',	'[[101001,1]]',	'2'},
{'101002',	'101002',	'[[10033,5]]',	'[[101002,1]]',	'2'},
{'101003',	'101003',	'[[10033,5]]',	'[[101003,1]]',	'2'},
{'101004',	'101004',	'[[10034,5]]',	'[[101004,1]]',	'2'},
{'101005',	'101005',	'[[10033,1]]',	'[[101005,1]]',	'2'},
{'101006',	'101006',	'[[10034,5]]',	'[[101006,1]]',	'2'},
{'101007',	'101007',	'[[10034,5]]',	'[[101007,1]]',	'2'},
{'101008',	'101008',	'[[10034,5]]',	'[[101008,1]]',	'2'},
{'101009',	'101009',	'[[10034,5]]',	'[[101009,1]]',	'2'},
{'101010',	'101010',	'[[10034,5]]',	'[[101010,1]]',	'2'},
{'101011',	'101011',	'[[10034,5]]',	'[[101011,1]]',	'2'},
{'101012',	'101012',	'[[10033,1]]',	'[[101012,1]]',	'2'},
{'101013',	'101013',	'[[10034,5]]',	'[[101013,1]]',	'2'},
{'101014',	'101014',	'[[10034,5]]',	'[[101014,1]]',	'2'},
{'101015',	'101015',	'[[10034,5]]',	'[[101015,1]]',	'2'},
{'101016',	'101016',	'[[10034,5]]',	'[[101016,1]]',	'2'},
{'101017',	'101017',	'[[10033,1]]',	'[[101017,1]]',	'2'},
{'101018',	'101018',	'[[10033,1]]',	'[[101018,1]]',	'2'},
{'101019',	'101019',	'[[10033,1]]',	'[[101019,1]]',	'2'},
{'101020',	'101020',	'[[10033,1]]',	'[[101020,1]]',	'2'},
{'101021',	'101021',	'[[10033,1]]',	'[[101021,1]]',	'2'},
{'101022',	'101022',	'[[10033,5]]',	'[[101022,1]]',	'2'},
{'101023',	'101023',	'[[10033,5]]',	'[[101023,1]]',	'2'},
{'101024',	'101024',	'[[10033,5]]',	'[[101024,1]]',	'2'},
{'101025',	'101025',	'[[10033,1]]',	'[[101025,1]]',	'2'},
{'101026',	'101026',	'[[10033,10]]',	'[[101026,1]]',	'2'},
{'101027',	'101027',	'[[10034,5]]',	'[[101027,1]]',	'2'},
{'101028',	'101028',	'[[10034,5]]',	'[[101028,1]]',	'2'},
{'102001',	'102001',	'[[10033,10]]',	'[[102001,1]]',	'2'},
{'102002',	'102002',	'[[10033,5]]',	'[[102002,1]]',	'2'},
{'102003',	'102003',	'[[10033,1]]',	'[[102003,1]]',	'2'},
{'102004',	'102004',	'[[10033,1]]',	'[[102004,1]]',	'2'},
{'102005',	'102005',	'[[10033,1]]',	'[[102005,1]]',	'2'},
{'102006',	'102006',	'[[10033,1]]',	'[[102006,1]]',	'2'},
{'102007',	'102007',	'[[10033,10]]',	'[[102007,1]]',	'2'},
{'102008',	'102008',	'[[10033,10]]',	'[[102008,1]]',	'2'},
{'102009',	'102009',	'[[10034,5]]',	'[[102009,1]]',	'2'},
{'102010',	'102010',	'[[10033,1]]',	'[[102010,1]]',	'2'},
{'102011',	'102011',	'[[10033,10]]',	'[[102011,1]]',	'2'},
{'102012',	'102012',	'[[10033,1]]',	'[[102012,1]]',	'2'},
{'102013',	'102013',	'[[10033,1]]',	'[[102013,1]]',	'2'},
{'102014',	'102014',	'[[10033,5]]',	'[[102014,1]]',	'2'},
{'102015',	'102015',	'[[10034,5]]',	'[[102015,1]]',	'2'},
{'102016',	'102016',	'[[10034,5]]',	'[[102016,1]]',	'2'},
{'102017',	'102017',	'[[10034,5]]',	'[[102017,1]]',	'2'},
{'102018',	'102018',	'[[10033,1]]',	'[[102018,1]]',	'2'},
{'102019',	'102019',	'[[10033,1]]',	'[[102019,1]]',	'2'},
{'102020',	'102020',	'[[10034,5]]',	'[[102020,1]]',	'2'},
{'102021',	'102021',	'[[10034,5]]',	'[[102021,1]]',	'2'},
{'102024',	'102024',	'[[10033,10]]',	'[[102024,1]]',	'2'},
{'103001',	'103001',	'[[10033,5]]',	'[[103001,1]]',	'2'},
{'103002',	'103002',	'[[10034,5]]',	'[[103002,1]]',	'2'},
{'103003',	'103003',	'[[10033,1]]',	'[[103003,1]]',	'2'},
{'103004',	'103004',	'[[10033,1]]',	'[[103004,1]]',	'2'},
{'103005',	'103005',	'[[10033,10]]',	'[[103005,1]]',	'2'},
{'103006',	'103006',	'[[10033,1]]',	'[[103006,1]]',	'2'},
{'103007',	'103007',	'[[10033,1]]',	'[[103007,1]]',	'2'},
{'103008',	'103008',	'[[10033,1]]',	'[[103008,1]]',	'2'},
{'103009',	'103009',	'[[10033,1]]',	'[[103009,1]]',	'2'},
{'103010',	'103010',	'[[10033,1]]',	'[[103010,1]]',	'2'},
{'103011',	'103011',	'[[10033,1]]',	'[[103011,1]]',	'2'},
{'103012',	'103012',	'[[10033,1]]',	'[[103012,1]]',	'2'},
{'103013',	'103013',	'[[10034,5]]',	'[[103013,1]]',	'2'},
{'103014',	'103014',	'[[10034,5]]',	'[[103014,1]]',	'2'},
{'103015',	'103015',	'[[10033,1]]',	'[[103015,1]]',	'2'},
{'103016',	'103016',	'[[10034,5]]',	'[[103016,1]]',	'2'},
{'103017',	'103017',	'[[10033,1]]',	'[[103017,1]]',	'2'},
{'103018',	'103018',	'[[10033,10]]',	'[[103018,1]]',	'2'},
{'103019',	'103019',	'[[10034,5]]',	'[[103019,1]]',	'2'},
{'103020',	'103020',	'[[10033,1]]',	'[[103020,1]]',	'2'},
{'103021',	'103021',	'[[10033,1]]',	'[[103021,1]]',	'2'},
{'103022',	'103022',	'[[10033,10]]',	'[[103022,1]]',	'2'},
{'103023',	'103023',	'[[10033,5]]',	'[[103023,1]]',	'2'},
{'103024',	'103024',	'[[10034,5]]',	'[[103024,1]]',	'2'},
{'103025',	'103025',	'[[10033,5]]',	'[[103025,1]]',	'2'},
{'103026',	'103026',	'[[10033,1]]',	'[[103026,1]]',	'2'},
{'103027',	'103027',	'[[10033,5]]',	'[[103027,1]]',	'2'},
{'103028',	'103028',	'[[10033,1]]',	'[[103028,1]]',	'2'},
{'103029',	'103029',	'[[10034,5]]',	'[[103029,1]]',	'2'},
{'103030',	'103030',	'[[10033,1]]',	'[[103030,1]]',	'2'},
{'103031',	'103031',	'[[10033,5]]',	'[[103031,1]]',	'2'},
{'103032',	'103032',	'[[10033,5]]',	'[[103032,1]]',	'2'},
{'103040',	'103040',	'[[10033,10]]',	'[[103040,1]]',	'2'},
{'103042',	'103042',	'[[10033,10]]',	'[[103042,1]]',	'2'},
{'103043',	'103043',	'[[10033,10]]',	'[[103043,1]]',	'2'},
{'104001',	'104001',	'[[10033,10]]',	'[[104001,1]]',	'2'},
{'104002',	'104002',	'[[10033,5]]',	'[[104002,1]]',	'2'},
{'104003',	'104003',	'[[10033,5]]',	'[[104003,1]]',	'2'},
{'104004',	'104004',	'[[10033,5]]',	'[[104004,1]]',	'2'},
{'104005',	'104005',	'[[10034,5]]',	'[[104005,1]]',	'2'},
{'104006',	'104006',	'[[10034,5]]',	'[[104006,1]]',	'2'},
{'104007',	'104007',	'[[10033,1]]',	'[[104007,1]]',	'2'},
{'104008',	'104008',	'[[10033,1]]',	'[[104008,1]]',	'2'},
{'104009',	'104009',	'[[10034,5]]',	'[[104009,1]]',	'2'},
{'104010',	'104010',	'[[10034,5]]',	'[[104010,1]]',	'2'},
{'104011',	'104011',	'[[10034,5]]',	'[[104011,1]]',	'2'},
{'104012',	'104012',	'[[10034,5]]',	'[[104012,1]]',	'2'},
{'104013',	'104013',	'[[10034,5]]',	'[[104013,1]]',	'2'},
{'104014',	'104014',	'[[10033,1]]',	'[[104014,1]]',	'2'},
{'104015',	'104015',	'[[10033,5]]',	'[[104015,1]]',	'2'},
{'104016',	'104016',	'[[10034,5]]',	'[[104016,1]]',	'2'},
{'104017',	'104017',	'[[10033,1]]',	'[[104017,1]]',	'2'},
{'104018',	'104018',	'[[10034,5]]',	'[[104018,1]]',	'2'},
{'104019',	'104019',	'[[10034,5]]',	'[[104019,1]]',	'2'},
{'104020',	'104020',	'[[10034,5]]',	'[[104020,1]]',	'2'},
{'104021',	'104021',	'[[10034,5]]',	'[[104021,1]]',	'2'},
{'104022',	'104022',	'[[10033,1]]',	'[[104022,1]]',	'2'},
{'104023',	'104023',	'[[10033,10]]',	'[[104023,1]]',	'2'},
{'104029',	'104029',	'[[10034,5]]',	'[[104029,1]]',	'2'},
{'104031',	'104031',	'[[10033,10]]',	'[[104031,1]]',	'2'},
{'104032',	'104032',	'[[10033,1]]',	'[[104032,1]]',	'2'},
{'104035',	'104035',	'[[10033,10]]',	'[[104035,1]]',	'2'},
{'104040',	'104040',	'[[10033,10]]',	'[[104040,1]]',	'2'},
{'105001',	'105001',	'[[10033,10]]',	'[[105001,1]]',	'2'},
{'105002',	'105002',	'[[10033,1]]',	'[[105002,1]]',	'2'},
{'105003',	'105003',	'[[10033,5]]',	'[[105003,1]]',	'2'},
{'105004',	'105004',	'[[10033,10]]',	'[[105004,1]]',	'2'},
{'105005',	'105005',	'[[10033,1]]',	'[[105005,1]]',	'2'},
{'105006',	'105006',	'[[10033,5]]',	'[[105006,1]]',	'2'},
{'105007',	'105007',	'[[10033,1]]',	'[[105007,1]]',	'2'},
{'105008',	'105008',	'[[10033,5]]',	'[[105008,1]]',	'2'},
{'105009',	'105009',	'[[10033,1]]',	'[[105009,1]]',	'2'},
{'105010',	'105010',	'[[10034,5]]',	'[[105010,1]]',	'2'},
{'105011',	'105011',	'[[10034,5]]',	'[[105011,1]]',	'2'},
{'105012',	'105012',	'[[10034,5]]',	'[[105012,1]]',	'2'},
{'105013',	'105013',	'[[10033,1]]',	'[[105013,1]]',	'2'},
{'105014',	'105014',	'[[10033,5]]',	'[[105014,1]]',	'2'},
{'105015',	'105015',	'[[10034,5]]',	'[[105015,1]]',	'2'},
{'105016',	'105016',	'[[10034,5]]',	'[[105016,1]]',	'2'},
{'105017',	'105017',	'[[10034,5]]',	'[[105017,1]]',	'2'},
{'105018',	'105018',	'[[10033,1]]',	'[[105018,1]]',	'2'},
{'105019',	'105019',	'[[10034,5]]',	'[[105019,1]]',	'2'},
{'105022',	'105022',	'[[10033,1]]',	'[[105022,1]]',	'2'},
{'105025',	'105025',	'[[10033,10]]',	'[[105025,1]]',	'2'},
{'105026',	'105026',	'[[10033,1]]',	'[[105026,1]]',	'2'},
{'105028',	'105028',	'[[10034,5]]',	'[[105028,1]]',	'2'},
{'105032',	'105032',	'[[10033,10]]',	'[[105032,1]]',	'2'},
{'106001',	'106001',	'[[10033,10]]',	'[[106001,1]]',	'2'},
{'106002',	'106002',	'[[10033,10]]',	'[[106002,1]]',	'2'},
{'106003',	'106003',	'[[10033,10]]',	'[[106003,1]]',	'2'},
{'106004',	'106004',	'[[10033,1]]',	'[[106004,1]]',	'2'},
{'106005',	'106005',	'[[10033,10]]',	'[[106005,1]]',	'2'},
{'106006',	'106006',	'[[10033,1]]',	'[[106006,1]]',	'2'},
{'106007',	'106007',	'[[10034,5]]',	'[[106007,1]]',	'2'},
{'106008',	'106008',	'[[10034,5]]',	'[[106008,1]]',	'2'},
{'106009',	'106009',	'[[10033,10]]',	'[[106009,1]]',	'2'},
{'106010',	'106010',	'[[10034,5]]',	'[[106010,1]]',	'2'},
{'106011',	'106011',	'[[10033,5]]',	'[[106011,1]]',	'2'},
{'106012',	'106012',	'[[10033,1]]',	'[[106012,1]]',	'2'},
{'106013',	'106013',	'[[10034,5]]',	'[[106013,1]]',	'2'},
{'106014',	'106014',	'[[10033,1]]',	'[[106014,1]]',	'2'},
{'106015',	'106015',	'[[10034,5]]',	'[[106015,1]]',	'2'},
{'106016',	'106016',	'[[10034,5]]',	'[[106016,1]]',	'2'},
{'106017',	'106017',	'[[10034,5]]',	'[[106017,1]]',	'2'},
{'106018',	'106018',	'[[10034,5]]',	'[[106018,1]]',	'2'},
{'106019',	'106019',	'[[10033,1]]',	'[[106019,1]]',	'2'},
{'106020',	'106020',	'[[10033,1]]',	'[[106020,1]]',	'2'},
{'106021',	'106021',	'[[10034,5]]',	'[[106021,1]]',	'2'},
{'106028',	'106028',	'[[10034,5]]',	'[[106028,1]]',	'2'},
{'107001',	'107001',	'[[10033,10]]',	'[[107001,1]]',	'2'},
{'107002',	'107002',	'[[10033,10]]',	'[[107002,1]]',	'2'},
{'107003',	'107003',	'[[10033,10]]',	'[[107003,1]]',	'2'},
{'107004',	'107004',	'[[10033,10]]',	'[[107004,1]]',	'2'},
{'107005',	'107005',	'[[10033,10]]',	'[[107005,1]]',	'2'},
{'107006',	'107006',	'[[10033,5]]',	'[[107006,1]]',	'2'},
{'107007',	'107007',	'[[10033,5]]',	'[[107007,1]]',	'2'},
{'107008',	'107008',	'[[10033,1]]',	'[[107008,1]]',	'2'},
{'107009',	'107009',	'[[10033,10]]',	'[[107009,1]]',	'2'},
{'107010',	'107010',	'[[10033,10]]',	'[[107010,1]]',	'2'},
{'107011',	'107011',	'[[10033,1]]',	'[[107011,1]]',	'2'},
{'107012',	'107012',	'[[10033,1]]',	'[[107012,1]]',	'2'},
{'107013',	'107013',	'[[10033,5]]',	'[[107013,1]]',	'2'},
{'107014',	'107014',	'[[10033,1]]',	'[[107014,1]]',	'2'},
{'107015',	'107015',	'[[10033,5]]',	'[[107015,1]]',	'2'},
{'107016',	'107016',	'[[10033,5]]',	'[[107016,1]]',	'2'},
{'107017',	'107017',	'[[10033,5]]',	'[[107017,1]]',	'2'},
{'107018',	'107018',	'[[10033,5]]',	'[[107018,1]]',	'2'},
{'107019',	'107019',	'[[10033,5]]',	'[[107019,1]]',	'2'},
{'107020',	'107020',	'[[10033,5]]',	'[[107020,1]]',	'2'},
{'107021',	'107021',	'[[10033,5]]',	'[[107021,1]]',	'2'},
{'107022',	'107022',	'[[10033,5]]',	'[[107022,1]]',	'2'},
{'107023',	'107023',	'[[10034,5]]',	'[[107023,1]]',	'2'},
{'107024',	'107024',	'[[10033,10]]',	'[[107024,1]]',	'2'},
{'107025',	'107025',	'[[10033,10]]',	'[[107025,1]]',	'2'},
{'107026',	'107026',	'[[10033,10]]',	'[[107026,1]]',	'2'},
{'107027',	'107027',	'[[10033,10]]',	'[[107027,1]]',	'2'},
{'107028',	'107028',	'[[10033,5]]',	'[[107028,1]]',	'2'},
{'107029',	'107029',	'[[10033,10]]',	'[[107029,1]]',	'2'},
{'107030',	'107030',	'[[10033,10]]',	'[[107030,1]]',	'2'},
{'107031',	'107031',	'[[10033,10]]',	'[[107031,1]]',	'2'},
{'107033',	'107033',	'[[10033,10]]',	'[[107033,1]]',	'2'},
{'107034',	'107034',	'[[10033,5]]',	'[[107034,1]]',	'2'},
{'107035',	'107035',	'[[10033,5]]',	'[[107035,1]]',	'2'},
{'107036',	'107036',	'[[10033,10]]',	'[[107036,1]]',	'2'},
{'107101',	'107101',	'[[10033,5]]',	'[[107101,1]]',	'2'},
},
}
--cfgCfgItemExchange = conf
return conf