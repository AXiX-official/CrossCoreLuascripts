local this=
{
mapid=1208,born_group=100,
groups=
{
[100]={10102,10104},
[101]={10403,10407,10603},
[104]={10607,10206},
[102]={10308},
[108]={10606},
[103]={10601},
[106]={10708},
[109]={10503,10504},
[107]={10303},
[110]={10506,10507,10508},
[111]={10307},
[112]={10301},
[113]={10609},
[114]={10302,10303,10304,10305},
[115]={10608,10607,10606}
},
monsters=
{
{id=102081,born_pos=10403,wave=1},
{id=102082,born_pos=10407,wave=1},
{id=102082,born_pos=10603,wave=1},
{id=102081,born_pos=10206,wave=2},
{id=102083,born_pos=10707,wave=2},
{id=102084,born_group=102,wave=3}
},
props=
{
{born_group=112,wave=1,rate=100,nPropID=1,angle=270,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =114,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_group=113,wave=1,rate=100,nPropID=2,angle=90,desc="未设置",res="GridProps/section2/5",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=37,attack_range =115,start_round=1,interval_round  =3,damage=0.09999999,collide_damage=0.09999999},
{born_group=103,wave=1,rate=100,nPropID=3,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=1,rate=75,nPropID=4,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_group=106,wave=1,rate=100,nPropID=5,float_content="HP+50%",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+50%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.5}},
{born_group=107,wave=1,rate=100,nPropID=6,icon="图标名称",desc="未设置",res="GridProps/section2/1",get_eff="get_eff_blue",bIsCanPass=1,perpetual=1,nStep=0,state=1,type=15,TriggerType=2,TriggerEvent =2,TriggerData ={7,8}},
{born_group=109,wave=1,rate=100,nPropID=7,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=109,wave=1,rate=100,nPropID=8,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=111,wave=1,rate=100,nPropID=9,icon="图标名称",desc="未设置",res="GridProps/section2/2",get_eff="get_eff_blue",bIsCanPass=1,perpetual=1,nStep=0,state=1,type=15,TriggerType=2,TriggerEvent =2,TriggerData ={10,11,12}},
{born_group=110,wave=1,rate=100,nPropID=10,desc="未设置",res="GridProps/section2/4",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=110,wave=1,rate=100,nPropID=11,desc="未设置",res="GridProps/section2/4",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=110,wave=1,rate=100,nPropID=12,desc="未设置",res="GridProps/section2/4",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1}
},
}
return this;