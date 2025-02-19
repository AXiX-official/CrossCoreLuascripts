local conf = {
	["filename"] = 'j-卡牌角色.xlsx',
	["sheetname"] = '角色动作',
	["types"] = {
'string','string','string','string','int[]','int','int','int','int','json','int','int[]','bool','string[]','string','json','json','json','json'
},
	["names"] = {
'id','key','action','sType','loop','restore','actionTalkID1','actionTalkID2','actionTalkID3','robotActions','shadow','centerOffset','inteDir','childs','faceName','roleActions_g_d','roleActions_g_m','roleActions_m_d','roleActions_m_m'
},
	["data"] = {
{'idle',	'idle',	'悠闲',	'Speed',	'2,8',	'',	'',	'',	'',	'[["walk",100]]',	'',	'',	'',	'',	'',	'[["walk",150],["Furn_ComA_ipad_01",10],["base_dozeOff",10],["base_drinkTea",10],["base_phone",10],["normal_clean",5],["normal_daze_0",10],["normal_daze_06",10]]',	'[["walk",50],["Furn_ComA_ipad_01",50],["base_dozeOff",20],["base_drinkTea",50],["base_phone",50],["base_handlingData",50]]',	'[["walk",50],["Furn_ComA_ipad_01",50],["base_phone",50]]',	'[["walk",50],["Furn_ComA_ipad_01",50],["base_phone",50]]'},
{'walk',	'walk',	'移动',	'Speed',	'',	'',	'',	'',	'',	'[["idle",100]]',	'',	'',	'',	'',	'',	'[["idle",100]]',	'[["idle",50],["Furn_ComA_ipad_01",50],["base_dozeOff",50],["base_drinkTea",10],["base_phone",10]]',	'[["idle",50],["Furn_ComA_ipad_01",50],["base_phone",10]]',	'[["idle",50],["Furn_ComA_ipad_01",50],["base_phone",10]]'},
{'base_operatePC',	'base_operatePC',	'操作电脑（基建）',	'furniture',	'5',	'',	'',	'',	'',	'',	'',	'',	'1',	'',	'',	'',	'[["walk",20],["idle",100]]',	'',	'[["walk",20],["idle",100]]'},
{'base_operatePC1',	'base_operatePC1',	'操作电脑（基建）',	'furniture',	'5',	'',	'',	'',	'',	'',	'',	'',	'1',	'',	'',	'[["walk",20],["idle",100]]',	'',	'[["walk",20],["idle",100]]',	''},
{'role_highfive_01',	'role_highfive_01',	'击掌-右手',	'furniture',	'3',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'[["walk",100]]',	'',	'[["idle",100],["walk",100]]',	''},
{'role_highfive_02',	'role_highfive_02',	'击掌-左手',	'furniture',	'3',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'[["walk",100]]',	'',	'[["idle",100],["walk",100]]',	''},
{'furniture_sleep_01',	'furniture_sleep_01',	'睡觉1（从左边上床）',	'furniture',	'14,24',	'10',	'3',	'4',	'5',	'',	'1',	'1,0,-1',	'',	'',	'furniture_sleep_01',	'[["walk",100]]',	'[["walk",100]]',	'[["walk",100]]',	'[["walk",100]]'},
{'furniture_sleep_02',	'furniture_sleep_02',	'睡觉2（从右边上床）',	'furniture',	'14,24',	'10',	'',	'',	'',	'',	'1',	'',	'',	'',	'furniture_sleep_02',	'[["walk",100]]',	'[["walk",100]]',	'[["walk",100]]',	'[["walk",100]]'},
{'furniture_sit_01',	'furniture_sit_01',	'坐沙发',	'furniture',	'7,12',	'2',	'',	'6',	'',	'',	'',	'',	'',	'',	'',	'[["walk",100]]',	'[["walk",100]]',	'[["walk",100]]',	'[["walk",100]]'},
{'furniture_sit_02',	'furniture_sit_02',	'坐椅子（看书）',	'furniture',	'13',	'',	'7',	'8',	'',	'',	'',	'',	'',	'Prop/Furn_ComA_Book_01',	'',	'[["walk",100]]',	'[["walk",100]]',	'[["walk",100]]',	'[["walk",100]]'},
{'furniture_sit_03',	'furniture_sit_03',	'坐睡（左）',	'furniture',	'16,21',	'5',	'',	'',	'9',	'',	'',	'',	'',	'',	'furniture_sit_03',	'[["walk",100]]',	'[["idle",100],["walk",100]]',	'[["idle",100],["walk",100]]',	'[["idle",100],["walk",100]]'},
{'furniture_sit_04',	'furniture_sit_04',	'坐有靠背的椅子',	'furniture',	'8',	'2',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'[["walk",100]]',	'[["idle",100],["walk",100]]',	'[["idle",100],["walk",100]]',	'[["idle",100],["walk",100]]'},
{'furniture_sit_05',	'furniture_sit_05',	'坐无靠背的椅子',	'furniture',	'12',	'3',	'',	'',	'',	'',	'',	'',	'',	'Prop/Furn_ComA_Switch_01',	'',	'[["walk",100]]',	'[["idle",100],["walk",100]]',	'[["idle",100],["walk",100]]',	'[["idle",100],["walk",100]]'},
{'furniture_watch',	'furniture_watch',	'观看',	'furniture',	'7',	'',	'',	'',	'',	'',	'',	'',	'1',	'',	'',	'[["walk",100]]',	'[["idle",100],["walk",100]]',	'[["idle",100],["walk",100]]',	'[["idle",100],["walk",100]]'},
{'furniture_gundam',	'furniture_gundam',	'玩模型',	'furniture',	'13',	'',	'',	'',	'',	'',	'',	'',	'1',	'Prop/Furn_ComA_Model_01',	'',	'[["walk",100]]',	'[["idle",100],["walk",100]]',	'[["idle",100],["walk",100]]',	'[["idle",100],["walk",100]]'},
{'furniture_Watering',	'furniture_Watering',	'浇水',	'furniture',	'6',	'',	'',	'',	'',	'',	'',	'',	'1',	'Prop/Furn_ComA_WateringPot',	'',	'[["walk",100]]',	'[["idle",100],["walk",100]]',	'[["idle",100],["walk",100]]',	'[["idle",100],["walk",100]]'},
{'furniture_Dance',	'furniture_Dance',	'跳舞',	'furniture',	'11',	'',	'',	'',	'',	'',	'1',	'',	'1',	'',	'',	'[["walk",100]]',	'[["idle",100],["walk",100]]',	'[["idle",100],["walk",100]]',	'[["idle",100],["walk",100]]'},
{'furniture_revive01',	'furniture_revive01',	'棺材',	'furniture',	'9',	'',	'',	'',	'',	'',	'1',	'',	'1',	'',	'',	'[["walk",100]]',	'[["idle",100],["walk",100]]',	'[["idle",100],["walk",100]]',	'[["idle",100],["walk",100]]'},
{'click_grab',	'click_grab',	'抓起',	'grab',	'',	'',	'',	'',	'',	'[["idle",50],["walk",50]]',	'1',	'',	'',	'',	'',	'[["idle",100]]',	'[["idle",100],["walk",50]]',	'[["idle",100],["walk",50]]',	'[["idle",100],["walk",50]]'},
{'furniture_Nod',	'furniture_Nod',	'点头',	'leisure',	'2',	'',	'',	'',	'',	'[["idle",50],["walk",50]]',	'',	'',	'',	'',	'',	'[["idle",100]]',	'[["walk",50],["idle",100],["base_dozeOff",100]]',	'[["walk",50],["idle",100]]',	'[["walk",50],["idle",100]]'},
{'click_lens',	'click_lens',	'望向镜头',	'leisure',	'4',	'',	'',	'',	'',	'[["idle",50],["walk",50]]',	'',	'',	'',	'',	'',	'[["idle",100]]',	'[["walk",50],["idle",100],["base_dozeOff",100]]',	'[["walk",50],["idle",100]]',	'[["walk",50],["idle",100]]'},
{'click_lens_02',	'click_lens_02',	'望向镜头2（内敛）',	'leisure',	'4',	'',	'',	'',	'',	'[["idle",50],["walk",50]]',	'',	'',	'',	'',	'',	'[["idle",100]]',	'[["walk",50],["idle",100],["base_dozeOff",100]]',	'[["walk",50],["idle",100]]',	'[["walk",50],["idle",100]]'},
{'Furn_ComA_ipad_01',	'Furn_ComA_ipad_01',	'看ipad',	'leisure',	'5',	'',	'',	'',	'',	'',	'',	'',	'',	'Prop/Furn_ComA_ipad_01',	'',	'[["walk",50],["idle",50]]',	'[["walk",20],["idle",100]]',	'[["walk",20],["idle",100]]',	'[["walk",20],["idle",100]]'},
{'base_dozeOff',	'base_dozeOff',	'打瞌睡',	'leisure',	'8,13',	'5',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'[["walk",50],["idle",50],["normal_stretch",50]]',	'[["walk",20],["idle",100]]',	'',	''},
{'base_drinkTea',	'base_drinkTea',	'喝茶',	'leisure',	'8',	'',	'',	'',	'',	'',	'',	'',	'',	'Prop/base_drinkTea',	'',	'[["walk",50],["idle",50]]',	'[["walk",20],["idle",100]]',	'',	''},
{'base_phone',	'base_phone',	'打电话',	'leisure',	'8',	'',	'',	'',	'',	'',	'',	'',	'',	'Prop/base_phone',	'',	'[["walk",50],["idle",50]]',	'[["walk",20],["idle",100]]',	'[["walk",20],["idle",100]]',	'[["walk",20],["idle",100]]'},
{'base_handlingData',	'base_handlingData',	'送货（基建）',	'leisure',	'6,11',	'',	'',	'',	'',	'',	'',	'',	'',	'Prop/Furn_ComA_UAV_01,Prop/Furn_ComA_CargoBox_0',	'',	'',	'[["walk",20],["idle",100]]',	'',	'[["walk",20],["idle",100]]'},
{'normal_fatigue',	'normal_fatigue',	'疲劳',	'leisure',	'10',	'',	'1',	'',	'',	'',	'',	'',	'',	'',	'',	'[["idle",50],["base_dozeOff",50]]',	'',	'',	''},
{'normal_clean',	'normal_clean',	'打扫',	'leisure',	'13',	'',	'2',	'',	'',	'',	'',	'',	'',	'Prop/Furn_ComA_Broom_01',	'',	'[["idle",50],["normal_stretch",50],["normal_fatigue",50],["walk",50]]',	'',	'',	''},
{'normal_daze_01',	'normal_daze_01',	'思考',	'leisure',	'5,15',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'[["walk",50],["idle",50]]',	'',	'',	''},
{'normal_daze_03',	'normal_daze_03',	'舞蹈-可爱（女）',	'leisure',	'11',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'[["walk",50],["idle",50]]',	'',	'',	''},
{'normal_daze_04',	'normal_daze_04',	'舞蹈-活泼（女）',	'leisure',	'9',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'[["walk",50],["idle",50]]',	'',	'',	''},
{'normal_daze_05',	'normal_daze_05',	'热身（女）',	'leisure',	'7',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'[["normal_daze_03",50],["normal_daze_04",50],["walk",50]]',	'',	'',	''},
{'normal_daze_06',	'normal_daze_06',	'看书（女）',	'leisure',	'15',	'',	'',	'',	'',	'',	'',	'',	'',	'Prop/Furn_ComA_Book_02',	'',	'[["walk",50],["idle",50],["normal_stretch",50]]',	'',	'',	''},
{'normal_stretch',	'normal_stretch',	'伸懒腰',	'leisure',	'5',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'[["walk",50],["idle",50]]',	'',	'',	''},
},
}
--cfgCfgCardRoleAction = conf
return conf
