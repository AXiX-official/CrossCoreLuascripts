--FireBall数据
local this = 
{
[1310282141]={
{time=12000,type=1,hit_type=1,hits={6150}},
{time=12000,type=1,hit_type=1,hits={6650,10800}},
{time=12000,type=1,hit_type=1,hit_creates={2124325257},hits={4400}},
{time=12000,type=1,hit_type=1,hits={11000}},
{effect="cast2_eff",time=13000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Moralltach_attack_skill_02"},
{time=12000,type=1,hit_type=1,hits={5150}},
{time=12000,type=1,hit_type=1,hits={5900}}
},
[2124325257]={
time=2000,type=0
},
[-686817241]={
{delay=1450,time=4000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=160,range2=100,hz=55,decay_value=0.4},hit_creates={1192467788},hits={0,450,900,1350}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Moralltach_attack_skill_01"}
},
[1192467788]={
time=2000,type=0
},
[-1609092943]={
{delay=1150,time=2000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=150,range2=100,hz=30,decay_value=0.3},hits={0,700}},
{effect="cast0_hit",delay=1100,time=2000,type=0,pos_ref={ref_type=3}},
{effect="cast0_eff",time=2650,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/seventeen.acb",cue_name="Moralltach_attack_general"}
},
[-1183793042]={
{effect="enter",time=3500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{effect="win",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;