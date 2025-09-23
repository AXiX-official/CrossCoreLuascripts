--FireBall数据
local this = 
{
[1192467788]={
effect="cast1_hit",time=2500,type=0,pos_ref={ref_type=4,part_index=1}
},
[-686817241]={
{time=2500,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=150,range2=150,hz=50,decay_value=0.6},hit_creates={1192467788},hits={780,1120,1490}},
{effect="cast1_eff",time=2500,type=0,pos_ref={ref_type=6},path_target={ref_type=1}}
},
[2124325257]={
time=3000,type=0
},
[1310282141]={
{delay=1138,time=3000,type=1,hit_type=0,camera_shake={time=500,shake_dir=1,range=150,range2=150,hz=50,decay_value=0.6},hit_creates={2124325257},hits={0,300}},
{effect="cast2_eff",time=3000,type=0,pos_ref={ref_type=6,offset_row=-15}}
},
[958292235]={
{effect="cast3_eff",time=3000,type=0,pos_ref={ref_type=6}}
},
[1349028111]={
effect="cast0_hit",delay=320,time=3000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1609092943]={
{delay=320,time=3000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=150,range2=150,hz=50,decay_value=0.5},hit_creates={1349028111},hits={0}},
{effect="cast0_eff",time=3000,type=0,pos_ref={ref_type=6},path_target={ref_type=1}}
}
};

return this;