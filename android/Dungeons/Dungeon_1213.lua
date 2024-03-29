local this=
{
mapid=1213,born_group=100,
groups=
{
[100]={10601,10501},
[101]={10705,10503,10206},
[104]={10506,10305},
[102]={10105},
[103]={10708},
[106]={10204},
[111]={10405,10406,10404},
[112]={10707,10607},
[107]={10605},
[105]={10702,10609}
},
monsters=
{
{id=102131,born_pos=10503,wave=1},
{id=102132,born_pos=10705,wave=1},
{id=102133,born_pos=10206,wave=1},
{id=102132,born_pos=10506,wave=2},
{id=102131,born_pos=10305,wave=2},
{id=102134,born_group=102,wave=3},
{id=102135,born_pos=10703,nRelationID=1,wave=1},
{id=102135,born_pos=10608,nRelationID=2,wave=1}
},
props=
{
{born_group=103,wave=1,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=1,rate=75,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_group=106,wave=1,rate=100,nPropID=3,float_content="+50%HP",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+50%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.5}},
{born_pos=10605,wave=1,rate=100,nPropID=4,nRelationID=1,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={2}},
{born_pos=10608,wave=1,rate=100,nPropID=5,nRelationID=2,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={4}},
{born_group=107,wave=1,rate=100,nPropID=6,icon="图标名称",desc="未设置",res="GridProps/section2/1",get_eff="get_eff_blue",bIsCanPass=1,perpetual=1,nStep=0,state=1,type=15,TriggerType=2,TriggerEvent =2,TriggerData ={10,9,7,8,11}},
{born_group=112,wave=1,rate=100,nPropID=7,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=112,wave=1,rate=100,nPropID=8,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=111,wave=1,rate=100,nPropID=9,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=4,type=16,TriggerType=2,damage=1},
{born_group=111,wave=1,rate=100,nPropID=10,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=4,type=16,TriggerType=2,damage=1},
{born_group=111,wave=1,rate=100,nPropID=11,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=4,type=16,TriggerType=2,damage=1},
{born_group=105,wave=1,rate=100,nPropID=12,desc="未设置",res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=105,wave=1,rate=100,nPropID=13,desc="未设置",res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0}
},
}
return this;