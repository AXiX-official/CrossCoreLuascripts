--FireBall数据
local this = 
{
[-1609092943]={
{effect="cast0_eff",time=2000,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/monsters_cast.acb",cue_name="mob2_attack_skill_01",path_target={ref_type=1}},
{delay=1100,time=2000,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hit_creates={661633433,-838067028},hits={0}}
},
[661633433]={
effect="cast0_hit",delay=1000,time=2000,type=0,pos_ref={ref_type=1}
},
[-838067028]={
effect="qc_shoot_hit1",effect_pack="common_hit",delay=1000,time=2000,type=0,pos_ref={ref_type=1}
}
};

return this;