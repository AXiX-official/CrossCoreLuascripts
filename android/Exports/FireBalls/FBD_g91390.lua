--FireBall数据
local this = 
{
[-686817241]={
{effect="cast1_hit03",effect_pack="j80360",time=3000,type=0,pos_ref={ref_type=1,offset_row=-200}},
{effect="cast1_eff",effect_pack="j80360",time=2000,type=0,pos_ref={ref_type=6}},
{delay=300,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=1200,range2=1200,hz=10,decay_value=0.6},hits={1200}},
{effect="cast1_hit02",effect_pack="j80360",delay=800,time=2000,type=0,pos_ref={ref_type=1,offset_row=-250}},
{delay=300,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=100,range2=100,hz=25,decay_value=0.6},hits={700}},
{effect="cast1_hit01",effect_pack="j80360",delay=200,time=2000,type=0,pos_ref={ref_type=1,offset_row=-200}},
{delay=300,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=100,range2=100,hz=25,decay_value=0.6},hits={0}}
},
[958292235]={
{effect="cast3_eff",time=14500,type=0,pos_ref={ref_type=6}},
{time=2000,type=1,hit_type=0,hit_creates={1776661962},hits={0,0,0,0,0,0}}
},
[1776661962]={
time=2000,type=0
},
[-1609092943]={
{effect="cast0_eff",effect_pack="j80360",time=2000,type=0,pos_ref={ref_type=6}},
{time=2500,type=1,hit_type=1,camera_shake={time=400,shake_dir=1,range=200,range2=200,hz=20,decay_value=0.5},hits={1900}},
{time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=200,range2=200,hz=10,decay_value=0.6},hit_creates={1349028111},hits={1400}}
},
[1349028111]={
effect="cast0_hit",effect_pack="j80360",time=4000,type=0,pos_ref={ref_type=4,part_index=0}
},
[-1328923786]={
{effect="win",effect_pack="j80360",delay=766,time=2000,type=0,pos_ref={ref_type=6}}
}
};

return this;