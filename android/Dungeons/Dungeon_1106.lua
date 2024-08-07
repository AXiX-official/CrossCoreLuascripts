local this=
{
mapid=1106,born_group=101,
groups=
{
[101]={10201,10102},
[100]={10503,10305},
[102]={10405},
[103]={10203},
[104]={10303},
[105]={10504},
[106]={10202},
[107]={10104,10105,10204,10205},
[108]={10401,10501,10502,10402},
[109]={10303,10304,10403,10404}
},
monsters=
{
{id=101061,born_group=100,wave=1},
{id=101061,born_group=100,wave=1},
{id=101063,born_group=104,wave=2},
{id=101064,born_group=102,wave=3}
},
props=
{
{born_group=103,wave=2,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=2,rate=75,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_group=105,wave=3,rate=100,nPropID=3,float_content="HP+30%",use_sound="ui_buff_attack",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+30%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.3}},
{born_pos=10505,wave=1,rate=100,nPropID=4,offset_x=-300,offset_y=-100,offset_z=100,float_content="HP-20%",shake_delay=0,shake_time=705,shake_range=100,icon="图标名称",desc="红蓝炮塔-2区域",res="GridProps/paotai/paotai",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=30,param={0.1},attackType=1,damage=0.2,ranges={107,108,109}}
},
}
return this;