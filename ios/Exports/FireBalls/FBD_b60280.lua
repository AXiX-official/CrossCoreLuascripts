--FireBall数据
local this = 
{
[-686817241]={
{delay=1000,time=1300,type=3,hits={0}},
{time=3500,type=0,cue_sheet="fight/effect/fourteen.acb",cue_name="Clarent_attack_skill_01"},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6}}
},
[1310282141]={
{time=9500,type=1,hit_type=1,hits={3900,4150,4300,7900,8100}},
{delay=9600,time=1000,type=3,hit_creates={2124325257},hits={0}},
{effect="cast2_eff",time=9100,type=0,pos_ref={ref_type=6}},
{time=9100,type=0,cue_sheet="fight/effect/fourteen.acb",cue_name="Clarent_attack_skill_02"}
},
[2124325257]={
effect="qc_zhiliao_hit",effect_pack="common_hit",time=2000,type=0,pos_ref={ref_type=15}
},
[-1609092943]={
{time=3500,type=0,cue_sheet="fight/effect/fourteen.acb",cue_name="Clarent_attack_general"},
{delay=300,time=4000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=150,range1=100,range2=100,hz=30,decay_value=0.3},hit_creates={661633433},hits={0}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6}},
{delay=980,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=300,range1=250,range2=300,hz=30,decay_value=0.3},hit_creates={1349028111},hits={0}}
},
[661633433]={
effect="cast0_hit_1",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[1349028111]={
effect="cast0_hit_2",time=2000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1183793042]={
{effect="enter_eff",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win_eff",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;