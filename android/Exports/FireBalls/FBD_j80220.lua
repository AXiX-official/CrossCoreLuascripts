--FireBall数据
local this = 
{
[958292235]={
{effect="cast3_eff",time=3000,type=0,pos_ref={ref_type=6}},
{time=3000,type=3,work_delay=1000,hit_creates={1776661962},hits={0}}
},
[1776661962]={
effect="cast3_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-646510353]={
effect="cast1_hit02",time=3000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-686817241]={
{time=3000,type=1,hit_type=0,hit_creates={-646510353},hits={2000}},
{effect="cast1_eff",time=3000,type=0,pos_ref={ref_type=0,offset_row=-550}},
{time=3000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=200,hz=100,decay_value=0.6},hit_creates={1192467788},hits={1800}}
},
[1192467788]={
effect="cast1_hit01",time=3000,type=0,pos_ref={ref_type=4,part_index=1}
},
[1310282141]={
{delay=6550,time=4000,type=1,hit_type=1,hit_creates={2124325257},hits={0}},
{effect="cast2_eff02",time=12500,type=0,pos_ref={ref_type=6}},
{delay=6550,time=4000,type=1,hit_type=1,hits={561}},
{delay=6550,time=4000,type=1,hit_type=1,hits={2281}},
{effect="cast2_eff01",time=12500,type=0,pos_ref={ref_type=6}},
{delay=6550,time=4000,type=1,hit_type=1,hits={1281}},
{delay=6550,time=4000,type=1,hit_type=1,hits={1481}},
{delay=6550,time=4000,type=1,hit_type=1,hits={981}}
},
[2124325257]={
time=2000,type=0
},
[-1609092943]={
{time=5000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=200,hz=80,decay_value=0.5},hit_creates={-838067028},hits={1000}},
{effect="cast0_eff",time=3000,type=0,pos_ref={ref_type=6}},
{time=5000,type=1,hit_type=0,camera_shake={time=200,shake_dir=1,range=100,hz=80,decay_value=0.5},hit_creates={1349028111},hits={500}}
},
[1349028111]={
effect="cast0_hit01",time=3000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-838067028]={
effect="cast0_hit02",time=3000,type=0,pos_ref={ref_type=4,part_index=1}
}
};

return this;