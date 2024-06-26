local this=
{
mapid=1116,born_group=100,
groups=
{
[100]={10201,10102},
[101]={10605,10506},
[104]={10601,10105},
[102]={10703},
[103]={10404},
[105]={10704,10401,10407,10104},
[106]={10501},
[107]={10505,10506,10507,10605,10606,10607,10705,10706,10707},
[108]={10301,10201,10101,10102,10103,10203,10303,10302,10202},
[109]={10601,10501,10502,10503,10603,10703,10702,10602},
[110]={10105,10106,10205,10206,10207,10305,10306,10307}
},
monsters=
{
{id=101161,born_group=101,wave=1},
{id=101161,born_group=101,wave=1},
{id=101162,born_pos=10307,wave=2},
{id=101162,born_pos=10601,wave=2},
{id=101164,born_group=102,wave=3}
},
props=
{
{born_group=103,wave=2,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=2,rate=75,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_group=106,wave=3,rate=100,nPropID=3,float_content="HP+30%",use_sound="ui_buff_attack",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_group=105,wave=1,rate=100,nPropID=4,name="岩石障碍",icon="MapProps_008",desc="碎星建筑残骸，队伍无法移动到上面。",res="GridProps/trap/G_01_Trap_03",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=1,damage=0},
{born_group=105,wave=1,rate=100,nPropID=5,name="岩石障碍",icon="MapProps_008",desc="碎星建筑残骸，队伍无法移动到上面。",res="GridProps/trap/G_01_Trap_03",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=1,damage=0},
{born_group=105,wave=1,rate=100,nPropID=6,name="岩石障碍",icon="MapProps_008",desc="碎星建筑残骸，队伍无法移动到上面。",res="GridProps/trap/G_01_Trap_03",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=1,damage=0},
{born_group=105,wave=1,rate=100,nPropID=7,name="岩石障碍",icon="MapProps_008",desc="碎星建筑残骸，队伍无法移动到上面。",res="GridProps/trap/G_01_Trap_03",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=1,damage=0},
{born_pos=10701,wave=1,rate=100,nPropID=8,float_content="HP-20%",shake_delay=0,shake_time=705,shake_range=100,icon="图标名称",desc="红蓝炮塔-2区域",res="GridProps/paotai/paotai",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=30,param={0.1},attackType=1,damage=0.2,ranges={107,108,109,110}}
},
}
return this;