--FireBall数据
local this = 
{
[-1183793042]={
{effect="enter_eff",time=2500,type=0,pos_ref={ref_type=6}}
},
[1310282141]={
{time=10600,type=0,cue_sheet="fight/effect/nineth.acb",cue_name="Silver_Feather_attack_skill_02"},
{effect="cast2_eff",time=10600,type=0,pos_ref={ref_type=6}},
{effect="cast2_hit",delay=4900,time=5000,type=0,pos_ref={ref_type=3}},
{delay=5450,time=3000,type=1,hit_type=1,hits={0}},
{delay=3400,time=10600,type=0,cue_sheet="cv/Silver_Feather.acb",cue_name="Silver_Feather_12",cue_feature=1},
{delay=5150,time=3000,type=1,hit_type=1,hits={0}},
{delay=5750,time=3000,type=1,hit_type=1,hits={0}}
},
[-686817241]={
{effect="cast1_eff",time=4000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Silver_Feather.acb",cue_name="Silver_Feather_10",cue_feature=1},
{time=4000,type=0,cue_sheet="fight/effect/nineth.acb",cue_name="Silver_Feather_attack_skill_01"}
},
[661633433]={
effect="cast0_hit",time=3000,type=0,pos_ref={ref_type=1}
},
[-1609092943]={
{effect="cast0_eff",time=4000,path_index=0,type=0,pos_ref={ref_type=6},cue_sheet="cv/Silver_Feather.acb",cue_name="Silver_Feather_09",cue_feature=1,path_target={ref_type=1}},
{delay=1250,time=3000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=200,range1=50,range2=200,hz=30,decay_value=0.4},hit_creates={661633433},hits={0}},
{delay=1400,time=3000,type=1,hit_type=0,hits={0}},
{time=4000,type=0,cue_sheet="fight/effect/nineth.acb",cue_name="Silver_Feather_attack_general"}
},
[518161756]={
effect="cast3_hit",time=3000,type=0,pos_ref={ref_type=1}
},
[958292235]={
{effect="cast3_eff3",time=200000,type=0,pos_ref={ref_type=16},cue_sheet="cv/Silver_Feather.acb",cue_name="Silver_Feather_07",cue_feature=1},
{delay=1000,time=3000,type=4,hits={0}},
{delay=1000,time=3000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=50,range1=10,hz=30,decay_value=0.3},hit_creates={518161756},hits={0}}
}
};

return this;