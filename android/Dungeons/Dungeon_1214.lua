local this=
{
mapid=1214,born_group=100,
groups=
{
[100]={10106,10104},
[101]={10407,10506,11106},
[104]={10604,10807},
[102]={11205},
[103]={10907},
[106]={10505},
[107]={10301,10501,10801,10401,10901,11001,11009,10909,10809},
[108]={10303,10403,10503},
[109]={10803,10903,11003},
[110]={10305,10705}
},
monsters=
{
{id=102141,born_pos=10506,wave=1},
{id=102142,born_pos=10407,wave=1},
{id=102143,born_pos=11106,nRelationID=2,wave=1},
{id=102142,born_pos=10604,wave=2},
{id=102142,born_pos=10807,wave=2},
{id=102144,born_group=102,wave=1},
{id=102145,born_pos=10302,nRelationID=3,wave=1},
{id=102145,born_pos=10402,nRelationID=4,wave=1},
{id=102145,born_pos=10502,nRelationID=5,wave=1},
{id=102145,born_pos=10902,nRelationID=6,wave=1},
{id=102145,born_pos=11002,nRelationID=7,wave=1},
{id=102145,born_pos=11008,nRelationID=8,wave=1}
},
props=
{
{born_group=103,wave=1,rate=100,nPropID=1,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=26,param={10001}},
{born_group=103,wave=1,rate=75,nPropID=2,name="货箱",icon="MapProps_001",desc="装着各种随机素材的箱子。",res="GridProps/baoxiang/baoxiang",get_eff="baoxiang_hit",eBlockState=1,nStep=0,state=1,type=28,param={10006}},
{born_group=106,wave=2,rate=100,nPropID=3,float_content="HP+50%",name="生命补给",icon="MapProps_002",desc="基地投送的作战补给，获得后队伍全体生命+50%。",res="GridProps/buff/Buff_Heal",get_eff="get_eff_green",eBlockState=1,nStep=0,state=1,type=2,param={0.5}},
{born_pos=11106,wave=1,rate=100,nPropID=4,nRelationID=2,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=3,nChangeStep=0,dir={3}},
{born_pos=10302,wave=1,rate=100,nPropID=5,nRelationID=3,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={2}},
{born_pos=10402,wave=1,rate=100,nPropID=6,nRelationID=4,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={2}},
{born_pos=10502,wave=1,rate=100,nPropID=7,nRelationID=5,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={2}},
{born_pos=10902,wave=1,rate=100,nPropID=8,nRelationID=6,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={2}},
{born_pos=11002,wave=1,rate=100,nPropID=9,nRelationID=7,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={2}},
{born_pos=11008,wave=1,rate=100,nPropID=10,nRelationID=8,AICtl=1007,icon="图标名称",desc="未设置",bIsCanPass=1,perpetual=1,nStep=2,state=4,type=29,len=2,nChangeStep=0,dir={4}},
{born_group=107,wave=1,rate=100,nPropID=11,desc="未设置",res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=107,wave=1,rate=100,nPropID=12,desc="未设置",res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=107,wave=1,rate=100,nPropID=13,desc="未设置",res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=107,wave=1,rate=100,nPropID=14,desc="未设置",res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=107,wave=1,rate=100,nPropID=15,desc="未设置",res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=107,wave=1,rate=100,nPropID=16,desc="未设置",res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=107,wave=1,rate=100,nPropID=17,desc="未设置",res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=107,wave=1,rate=100,nPropID=18,desc="未设置",res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=107,wave=1,rate=100,nPropID=19,desc="未设置",res="GridProps/section2/6",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=0},
{born_group=110,wave=1,rate=100,nPropID=20,icon="图标名称",desc="未设置",res="GridProps/section2/1",get_eff="get_eff_blue",bIsCanPass=1,perpetual=1,nStep=0,state=1,type=15,TriggerType=2,TriggerEvent =2,TriggerData ={26,25,22,27,23,24}},
{born_group=110,wave=1,rate=100,nPropID=21,icon="图标名称",desc="未设置",res="GridProps/section2/1",get_eff="get_eff_blue",bIsCanPass=1,perpetual=1,nStep=0,state=1,type=15,TriggerType=2,TriggerEvent =2,TriggerData ={26,25,22,27,23,24}},
{born_group=109,wave=1,rate=100,nPropID=22,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=109,wave=1,rate=100,nPropID=23,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=109,wave=1,rate=100,nPropID=24,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=1,type=16,TriggerType=2,damage=1},
{born_group=108,wave=1,rate=100,nPropID=25,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=4,type=16,TriggerType=2,damage=1},
{born_group=108,wave=1,rate=100,nPropID=26,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=4,type=16,TriggerType=2,damage=1},
{born_group=108,wave=1,rate=100,nPropID=27,desc="未设置",res="GridProps/section2/3",get_eff="baoxiang_hit",eBlockState=3,perpetual=1,nStep=0,state=4,type=16,TriggerType=2,damage=1}
},
}
return this;