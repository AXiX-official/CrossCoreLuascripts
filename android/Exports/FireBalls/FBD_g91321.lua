--FireBall数据
local this = 
{
[-686817241]={
{time=2000,type=3,hits={1200}},
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=6}}
},
[-520473558]={
time=10000,type=0
},
[1310282141]={
{delay=1000,time=10000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=400,range2=400,hz=10,decay_value=0.6},hits={1000}},
{effect="cast2_eff",time=10000,type=0,pos_ref={ref_type=6}},
{delay=1000,time=10000,type=1,hit_type=0,camera_shake={time=900,shake_dir=1,range=200,range2=200,hz=200,decay_value=0.6},hits={0}},
{delay=1000,time=10000,type=1,hit_type=0,hit_creates={-520473558},hits={200,400,600,800}}
},
[1776661962]={
time=10000,type=0
},
[958292235]={
{delay=2000,time=10000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=300,range2=300,hz=100,decay_value=0.6},hits={0}},
{effect="cast3_eff",time=10000,type=0,pos_ref={ref_type=6}},
{delay=1100,time=10000,type=1,hit_type=1,camera_shake={time=500,shake_dir=1,range=250,range2=250,hz=10,decay_value=0.6},hits={0}},
{delay=4000,time=10000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=150,range2=150,hz=100,decay_value=0.66},hit_creates={1776661962},hits={200,300,0,100}}
},
[-838067028]={
time=10000,type=0
},
[-1609092943]={
{effect="cast0_eff",delay=600,time=10000,type=0,pos_ref={ref_type=1,offset_row=-400}},
{time=10000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=250,range2=250,hz=20,decay_value=0.6},hit_creates={-838067028},hits={800,1300}},
{effect="cast0_hit",time=10000,type=0,pos_ref={ref_type=1,offset_row=-400}}
}
};

return this;