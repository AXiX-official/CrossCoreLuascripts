local this=
{
mapid=2118,born_group=100,
groups=
{
[100]={10201,10102},
[101]={10604,10406},
[104]={10501,10205},
[102]={10404},
[103]={10505},
[105]={10202},
[106]={10603,10503,10403,10402,10401,10501,10502,10602,10601},
[107]={10406,10405,10404,10504,10505,10506,10606,10605,10604},
[108]={10304,10305,10306,10206,10106,10105,10104,10204,10205},
[109]={10101,10102,10103,10201,10202,10203,10301,10302,10303}
},
monsters=
{
{id=201181,born_group=101,wave=1},
{id=201181,born_group=101,wave=1},
{id=201182,born_pos=10205,wave=2},
{id=201183,born_pos=10501,wave=2},
{id=201184,born_group=102,wave=3}
},
props=
{
{born_group=103,wave=2,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=2,rate=75,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_group=105,wave=3,rate=100,nPropID=3,float_content="HP+30%",use_sound="ui_buff_attack",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_pos=10101,wave=1,rate=100,nPropID=4,offset_x=-100,offset_z=300,float_content="HP-20%",shake_delay=0,shake_time=705,shake_range=100,icon="图标名称",desc="红蓝炮塔-2区域",res="GridProps/paotai/paotai",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=30,param={0.1},attackType=1,damage=0.2,ranges={106,107,108,109}}
},
}
return this;