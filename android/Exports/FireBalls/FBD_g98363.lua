--FireBall数据
local this = 
{
[-1457652640]={
effect="cast1_eff",time=2500,type=0,pos_ref={ref_type=4,part_index=1}
},
[-686817241]={
{time=2500,type=3,hit_creates={-1457652640},hits={0}}
},
[2124325257]={
effect="cast2_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=1}
},
[1310282141]={
{effect="cast2_eff",time=3000,type=0,pos_ref={ref_type=6},path_target={ref_type=1}},
{delay=1040,time=3000,type=1,hit_type=0,hit_creates={2124325257},hits={0}}
},
[1349028111]={
effect="cast0_hit",time=3000,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1609092943]={
{delay=592,time=3000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=150,range2=150,hz=20,decay_value=0.6},hit_creates={1349028111},hits={0}},
{effect="cast0_eff",time=3000,type=0,pos_ref={ref_type=6}}
}
};

return this;