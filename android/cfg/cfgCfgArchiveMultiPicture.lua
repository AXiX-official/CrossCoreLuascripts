local conf = {
	["filename"] = 'd-多人插图.xlsx',
	["sheetname"] = '多人插图',
	["types"] = {
'int','string','int','string','int','string','string','int','string','string','string','string','string','float[]','string','float[]','bool','int'
},
	["names"] = {
'id','key','itemId','sName','sort','sStart','sEnd','theme_type','img','img_replace','icon','set_icon','get_txt','imgPos','l2dName','l2dPos','show','shopId'
},
	["data"] = {
{'1',	'1',	'61001',	'皇室聚会',	'1',	'',	'',	'2',	'three_people',	'',	'board_three_people',	'',	'任务获取',	'0,0,1',	'CG02',	'-16,-51,0.85',	'',	'1'},
{'2',	'2',	'61002',	'沙滩集会',	'2',	'',	'',	'1',	'seashore',	'seashore_replace',	'board_seashore',	'',	'商店购买',	'-45,-8,1.05',	'CG_seashore',	'-16,-51,0.85',	'1',	'80401'},
{'3',	'3',	'61003',	'后勤彗心',	'3',	'',	'',	'2',	'kadya_liedown',	'kadya_liedown',	'board_kadya_liedown',	'',	'高级勘测奖励',	'0,-60,0.85',	'kadiya',	'0,0,1',	'',	'1'},
{'4',	'4',	'61007',	'热夏之约',	'4',	'',	'',	'1',	'summer_rendezvous',	'summer_rendezvous_replace',	'board_summer_rendezvous',	'',	'商店购买',	'-235,68,1.5',	'CG04_SummerRendezvous',	'0,0,1',	'1',	'80402'},
{'5',	'5',	'61008',	'曦光盛宴',	'5',	'',	'',	'3',	'shimmering_feast',	'shimmering_feast_replace',	'board_shimmering_feast',	'',	'商店购买',	'-97.8,28.7,1.1',	'CG05_ShimmeringFeast_spine',	'0,0,1',	'1',	'80403'},
{'6',	'6',	'61009',	'顷刻烟火',	'6',	'',	'',	'3',	'fireworks_IoIent',	'fireworks_IoIent_replace',	'board_fireworks_IoIent',	'',	'商店购买',	'29,-22,1.32',	'CG03_FireworksLoIent',	'0,0,1',	'1',	'80404'},
{'7',	'7',	'61010',	'导购进修课',	'7',	'',	'',	'2',	'trytomoveforward',	'trytomoveforward_replace',	'board_trytomoveforward',	'',	'商店购买',	'-163,-386,0.95',	'CG06_TryToMoveForward_spine',	'0,-71,1',	'1',	'80405'},
{'8',	'8',	'61004',	'基地勘测',	'8',	'',	'',	'4',	'base_check',	'',	'board_base_check',	'',	'高级勘测奖励',	'0,0,0.98',	'XingYun',	'-16,-51,0.85',	'',	'1'},
{'9',	'9',	'61011',	'游乐时光',	'9',	'',	'',	'2',	'play_time',	'play_time',	'board_play_time',	'',	'高级勘测奖励',	'-28,-89,1',	'2022_04',	'0,0,1',	'',	'1'},
{'10',	'10',	'61012',	'慵懒午后',	'10',	'',	'',	'2',	'relaxing_afternoon',	'relaxing_afternoon',	'board_relaxing_afternoon',	'',	'高级勘测奖励',	'113,0,0.94',	'Aerbeisi',	'113,0,1',	'',	'1'},
{'11',	'11',	'61013',	'妙探双姝',	'11',	'',	'',	'5',	'bestie_agent',	'bestie_agent_replace',	'board_bestie_agent',	'',	'商店购买',	'-260,-57,0.9',	'CG0008_BestieAgent_spine',	'58,-28,1',	'1',	'80406'},
{'12',	'12',	'61014',	'星河共旅',	'12',	'',	'',	'6',	'trip_in_the_milky_way',	'trip_in_the_milky_way',	'board_trip_in_the_milky_way',	'',	'高级勘测奖励',	'-58,-65,1.2',	'Ying',	'-58,-65,1.3',	'',	'1'},
{'13',	'13',	'61015',	'温室闲暇',	'13',	'',	'',	'2',	'greenhouse',	'',	'board_greenhouse',	'',	'商店购买',	'299,-27,1.4',	'CG00012_Greenhouse_spine',	'0,-37,1',	'1',	'80407'},
{'14',	'14',	'61016',	'熠星之夜',	'14',	'',	'',	'2',	'starry_night',	'starry_night_replace',	'board_starry_night',	'',	'商店购买',	'78,-72,1.2',	'CG00011_StarryNight_spine',	'217,-77,1.23',	'1',	'80408'},
{'15',	'15',	'61018',	'与喵同乐',	'15',	'',	'',	'2',	'fun_with_mew',	'fun_with_mew',	'board_fun_with_mew',	'',	'高级勘测奖励',	'-69.5,-10,0.62',	'feili',	'-48,-10,1.4',	'',	'1'},
{'16',	'16',	'61017',	'软梦盈心',	'16',	'',	'',	'2',	'tender_dream',	'',	'board_tender_dream',	'',	'商店购买',	'-49,14,1.05',	'CG0007_TenderDreamImmersingHeart',	'0,0,1',	'1',	'80409'},
{'17',	'17',	'61019',	'醺光盏影',	'17',	'',	'',	'2',	'intoxicated_shadow',	'intoxicated_shadow_replace',	'board_intoxicated_shadow',	'',	'商店购买',	'-59,-38,1.12',	'CG00010_IntoxicatedShadow_spine',	'0,0,1',	'1',	'80410'},
{'18',	'18',	'61020',	'失重空间',	'18',	'',	'',	'2',	'weightless_space',	'weightless_space_replace',	'board_weightless_space',	'',	'商店购买',	'63,-60,0.55',	'CG0009_WeightlessSpace_spine',	'0,0,1.3',	'1',	'80411'},
{'20',	'20',	'61022',	'铁壁之卫',	'19',	'',	'',	'6',	'guard_of_iron_bastion',	'guard_of_iron_bastion_replace',	'board_guard_of_iron_bastion',	'',	'商店购买',	'-44,15,0.67',	'CG0014_GuardOfIronBastion_spine',	'72,0,1',	'',	'1'},
{'21',	'21',	'61023',	'瞬息留影',	'21',	'2024/7/31 3:00:00',	'',	'6',	'silhouette_in_a_moment',	'',	'board_silhouette_in_a_moment',	'Small_silhouette_in_a_moment',	'高级勘测奖励',	'101,15,1',	'leikesi',	'106,11,1.1',	'',	'1'},
{'22',	'22',	'61024',	'雪域众神',	'22',	'',	'',	'6',	'snowland_gods',	'',	'board_snowland_gods',	'Small_snowland_gods',	'活动商店兑换',	'-37,-132,1.1',	'CG0019_SnowlandGods_spine',	'72,-38,1',	'',	'1'},
{'27',	'27',	'61029',	'欢欣鼓舞',	'27',	'',	'',	'7',	'dance_for_joy',	'',	'board_dance_for_joy',	'Small_dance_for_joy',	'加油喝彩2024',	'-70,-20,0.88',	'CG0024_DanceForJoy_spine',	'55,-51,1.23',	'',	'1'},
},
}
--cfgCfgArchiveMultiPicture = conf
return conf
