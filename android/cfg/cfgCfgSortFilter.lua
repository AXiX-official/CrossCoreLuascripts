local conf = {
	["filename"] = 'p-排序筛选.xlsx',
	["sheetname"] = '排序筛选总表',
	["types"] = {
'int','string','string','int[]','int','int[]','json','json'
},
	["names"] = {
'id','key','view','sort_view','sort_default','sort','filter','filter_default'
},
	["data"] = {
{'1',	'1',	'RoleListNormal',	'1008,1002,1001,1005,1004,1006,1003',	'1008',	'1008,1002,1001,1005,1004,1006,1003,1000',	'[[3022,"CfgTeamEnum"],[3024,"CfgCardSortQuality"],[3027,"CfgRolePosEnum"]]',	''},
{'2',	'2',	'TeamView',	'1002,1001,1005,1004,1006,1003,1008',	'1002',	'1002,1001,1005,1008,1004,1006,1003,1000',	'[[3022,"CfgTeamEnum"],[3024,"CfgCardSortQuality"],[3027,"CfgRolePosEnum"]]',	''},
{'3',	'3',	'TeamView',	'1002,1001,1005,1004,1006,1003,1008',	'1002',	'1002,1001,1005,1008,1004,1006,1003,1000',	'[[3022,"CfgTeamEnum"],[3024,"CfgCardSortQuality"],[3027,"CfgRolePosEnum"]]',	''},
{'4',	'4',	'TeamView',	'1002,1001,1005,1004,1006,1003,1008',	'1002',	'1002,1001,1005,1008,1004,1006,1003,1000',	'[[3022,"CfgTeamEnum"],[3024,"CfgCardSortQuality"],[3027,"CfgRolePosEnum"]]',	''},
{'5',	'5',	'CRoleSelectView',	'4003,4004',	'4003',	'4003,4004,4000',	'[[3022,"CfgTeamEnum"],[1053,"CfgIsSkin"],[3024,"CfgCardSortQuality"]]',	''},
{'6',	'6',	'CRoleSelectView',	'5002',	'5002',	'5002,5001,5000',	'[[1054,"CfgMultiImageThemeType"]]',	''},
{'7',	'7',	'DormSetRoleList',	'4001',	'4001',	'4001,4005,4008,4006,4002,4000',	'[[3022,"CfgTeamEnum"]]',	''},
{'8',	'8',	'DormSetRoleList',	'4007,4008',	'4007',	'4005,4007,4008,4000',	'[[3022,"CfgTeamEnum"]]',	''},
{'9',	'9',	'Bag',	'2001',	'2001',	'2001,2000',	'[[1055,"CfgGoodsSortEnum"]]',	''},
{'10',	'10',	'Bag',	'3001,3002,3003,3004,3005,3006,3008,3010',	'3001',	'3001,3010,3003,3002,3008,3004,3006,3007,3005,3000',	'[[1056,"CfgEquipQualityEnum"],[1057,"CfgEquipSlotEnum"],[1058,"CfgIsEquipEnum"],[1059,"CfgEquipSkillTypeSortEnum"]]',	''},
{'11',	'11',	'Bag',	'3009,3002,3003,3004,3005,3006,3010',	'3009',	'3009,3002,3003,3010,3004,3005,3006,3000',	'[[1056,"CfgEquipQualityEnum"],[1057,"CfgEquipSlotEnum"],[1059,"CfgEquipSkillTypeSortEnum"]]',	''},
{'12',	'12',	'RoleEquip',	'3001,3002,3010,3006,3004,3005',	'3001',	'3001,3010,3002,3006,3004,3005,3000',	'[[1056,"CfgEquipQualityEnum"],[1059,"CfgEquipSkillTypeSortEnum"]]',	''},
{'13',	'13',	'RoleEquip',	'3001,3002,3010,3006,3004,3005',	'3001',	'3001,3010,3002,3006,3004,3005,3000',	'[[1056,"CfgEquipQualityEnum"],[1059,"CfgEquipSkillTypeSortEnum"]]',	''},
{'14',	'14',	'EquipStreng',	'3001,3002,3010,3006,3004,3005',	'3001',	'3001,3010,3002,3006,3004,3005,3000',	'[[1056,"CfgEquipQualityEnum"],[1059,"CfgEquipSkillTypeSortEnum"]]',	''},
{'15',	'15',	'MatrixCompound',	'6003,6001,6002',	'6003',	'6004,6003,6001,6002,6000',	'',	''},
{'16',	'16',	'Bag',	'3001',	'3009',	'3001,3000',	'',	''},
{'17',	'17',	'RoleListSelectView',	'1008,1002,1001,1005,1004,1006,1003',	'1008',	'1009,1008,1002,1001,1005,1004,1006,1003,1000',	'[[3022,"CfgTeamEnum"],[3024,"CfgCardSortQuality"],[3027,"CfgRolePosEnum"]]',	''},
{'18',	'18',	'DormSetRoleList',	'4001',	'4001',	'4009,4001,4005,4008,4006,4002,4000',	'[[1060,"CfgMatrixOrderType"]]',	'[["CfgMatrixOrderType",[13]]]'},
{'19',	'19',	'RewardPanel',	'7003,7002,7001,7000',	'7003',	'7003,7002,7001,7000',	'',	''},
{'20',	'20',	'SweepView',	'7003',	'7003',	'7003',	'',	''},
{'21',	'21',	'Bag',	'2001',	'2001',	'2001,2000',	'',	''},
{'22',	'22',	'HeadFramePanel',	'8000',	'8000',	'8000',	'[[1061,"CfgIsAvatar"]]',	''},
{'23',	'23',	'AchievementView',	'9003,9001',	'9003',	'9002,9003,9001,9000',	'[[3024,"CfgAchieveQualitySort"]]',	''},
{'24',	'24',	'CRoleDisplayS',	'10001',	'10001',	'10001',	'[[7072,"CfgRandomRoleType"],[3022,"CfgTeamEnum"],[1053,"CfgIsSkin"],[3024,"CfgCardSortQuality"],[1054,"CfgMultiImageThemeType"]]',	''},
{'25',	'25',	'TeamView',	'1002,1001,1005,1004,1006,1003,1008',	'1002',	'1010,1002,1001,1005,1008,1004,1006,1003,1000',	'[[3022,"CfgTeamEnum"],[3024,"CfgCardSortQuality"],[3027,"CfgRolePosEnum"]]',	''},
{'26',	'26',	'TeamView',	'1002,1001,1005,1004,1006,1003,1008',	'1002',	'1011,1010,1002,1001,1005,1008,1004,1006,1003,1000',	'[[3022,"CfgTeamEnum"],[3024,"CfgCardSortQuality"],[3027,"CfgRolePosEnum"]]',	''},
},
}
--cfgCfgSortFilter = conf
return conf
