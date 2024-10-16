--FireBall数据
local this = 
{
[-686817241]={
{delay=1900,time=4000,type=1,hit_type=1,camera_shake={time=800,shake_dir=1,range=120,range2=120,hz=60,decay_value=0.5},hits={0}},
{effect="cast1_hit",delay=1866,time=2000,type=0,pos_ref={ref_type=1}},
{delay=1900,time=4000,type=1,hit_type=1,camera_shake={time=300,shake_dir=1,range=300,range2=300,hz=60,decay_value=0.5},hits={400}},
{effect="cast1_eff",time=3500,type=0,pos_ref={ref_type=6},path_target={ref_type=1,lock_col=1}}
},
[1310282141]={
{effect="cast2_eff",time=3500,type=0,pos_ref={ref_type=6}},
{delay=1400,time=3500,type=3,hits={0}}
},
[1776661962]={
time=3500,type=0
},
[958292235]={
{effect="cast3_eff",time=12000,type=0,pos_ref={ref_type=6}},
{delay=4800,time=7000,type=1,hit_type=0,hit_creates={1776661962},hits={0,250,500,750,4050,4400,5150,5500}}
},
[-1609092943]={
{delay=900,time=4000,type=1,hit_type=0,camera_shake={time=350,shake_dir=1,range=170,range2=100,hz=55,decay_value=0.4},hits={0}},
{effect="cast0_hit",delay=900,time=2000,type=0,pos_ref={ref_type=1}},
{delay=1120,time=4000,type=1,hit_type=0,camera_shake={time=350,shake_dir=1,range=170,range2=100,hz=55,decay_value=0.4},hits={0}},
{effect="cast0_eff",time=3500,type=0,pos_ref={ref_type=6}}
}
};

return this;