--FireBall数据
local this = 
{
[-686817241]={
{delay=1900,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=600,range2=600,hz=10,decay_value=0.6},hits={0}},
{effect="cast1_hit",delay=1900,time=2000,type=0,pos_ref={ref_type=1,offset_row=-125,lock_col=1}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Gemini_attack_general"}
},
[1310282141]={
{effect="cast2_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Gemini_attack_skill_01"},
{delay=1500,time=3500,type=3,hits={0}}
},
[958292235]={
{delay=4200,time=4000,type=1,hit_type=1,hits={0}},
{effect="cast3_eff",time=10000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/fifteen.acb",cue_name="Gemini_attack_skill_02"},
{delay=8500,time=4000,type=1,hit_type=1,hit_creates={1776661962},hits={0}}
},
[1776661962]={
time=2000,type=0
},
[-1485114200]={
{time=12368,type=1,hit_type=1,hits={3900,4800,5400,7000,9450,9750,10050,11200}},
{effect="cast4_hit",time=12868,type=0,pos_ref={ref_type=2,offset_row=-100}},
{effect="cast4_eff",time=12868,type=0,pos_ref={ref_type=6}}
},
[-1609092943]={
{delay=500,time=3500,type=0,cue_sheet="fight/effect/fifteen.acb",cue_name="Castor_attack_general"},
{delay=1515,time=4000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=150,range2=150,hz=50,decay_value=0.6},hits={0}},
{effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=1}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;