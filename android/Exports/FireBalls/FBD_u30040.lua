--FireBall数据
local this = 
{
[-686817241]={
{delay=1700,time=6000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=250,range2=250,hz=60,decay_value=0.5},hits={380,780}},
{effect="cast1_hit",time=6000,type=0,pos_ref={ref_type=5}},
{effect="cast1_eff",time=6000,type=0,pos_ref={ref_type=6},path_target={ref_type=1}}
},
[1310282141]={
{delay=5700,time=3000,type=1,hit_type=1,hits={0}},
{effect="cast2_hit",delay=5000,time=5000,type=0,pos_ref={ref_type=3}},
{effect="cast2_eff",time=6000,type=0,pos_ref={ref_type=6}}
},
[-1609092943]={
{delay=1000,time=4000,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=250,range2=250,hz=30,decay_value=0.5},hit_creates={1349028111},hits={0}},
{effect="cast0_eff",time=5000,type=0,pos_ref={ref_type=6},path_target={ref_type=1}}
},
[1349028111]={
effect="cast0_hit",time=5000,type=0,pos_ref={ref_type=4,part_index=0}
}
};

return this;