--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_hit",time=3600,type=0,pos_ref={ref_type=3}},
{time=3000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=50,range2=50,hz=10,decay_value=0.6},hits={800,1208,1550}},
{effect="cast1_eff",time=3600,path_index=300,type=0,pos_ref={ref_type=6},path_target={ref_type=1}}
},
[1310282141]={
{effect="cast2_eff",time=3000,type=0,pos_ref={ref_type=13}}
},
[1349028111]={
effect="cast0_hit",time=2500,type=0,pos_ref={ref_type=4,part_index=1}
},
[-1609092943]={
{delay=729,time=3000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=300,range2=300,hz=10,decay_value=0.6},hit_creates={1349028111},hits={0}},
{effect="cast0_eff",time=2500,type=0,pos_ref={ref_type=6}}
}
};

return this;