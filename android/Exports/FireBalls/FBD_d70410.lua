--FireBall数据
local this = 
{
[-865403415]={
{effect="call",time=12400,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/Blade_Stream_enter.acb",cue_name="Blade_Stream_enter"},
{time=12000,type=0}
},
[-686817241]={
{delay=300,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=150,range2=150,hz=30,decay_value=0.6},hits={0,900}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Buzzing_Blade_attack_skill_01"},
{effect="cast1_hit",time=5000,type=0,pos_ref={ref_type=1,offset_row=-250}}
},
[1310282141]={
{delay=11000,time=4000,type=1,hit_type=1,hit_creates={2124325257},hits={0,200,500,800,1100}},
{delay=9500,time=4000,type=1,hit_type=1,hits={0}},
{effect="cast2_eff",time=14000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Buzzing_Blade_attack_skill_02"},
{delay=6500,time=4000,type=1,hit_type=1,hits={0}}
},
[2124325257]={
time=2000,type=0
},
[-1609092943]={
{delay=150,time=4000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=50,range2=50,hz=30,decay_value=0.6},hits={0}},
{effect="cast0_hit",time=2000,type=0,pos_ref={ref_type=1,offset_row=-50}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Buzzing_Blade_attack_general"},
{delay=800,time=4000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=100,range2=100,hz=30,decay_value=0.6},hits={0}}
}
};

return this;