--FireBall数据
local this = 
{
[-686817241]={
{time=6500,type=0,cue_sheet="cv/Mist.acb",cue_name="Mist_10",cue_feature=1},
{delay=1800,time=6500,type=1,hit_type=0,hit_creates={1192467788},hits={0}},
{effect="cast1_eff",time=6500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thirteen.acb",cue_name="Mist_attack_skill_01",path_target={ref_type=1}},
{delay=2100,time=6500,type=1,hit_type=0,hits={0}},
{delay=1900,time=6500,type=1,hit_type=0,hits={0}}
},
[1192467788]={
effect="cast1_hit",time=6500,type=0,pos_ref={ref_type=4,part_index=0}
},
[1310282141]={
{time=6500,type=1,hit_type=0,hits={2000,2400,2800,3200,6000,6400}},
{time=8500,type=0,cue_sheet="cv/Mist.acb",cue_name="Mist_11",cue_feature=1},
{effect="cast2_eff",time=8500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thirteen.acb",cue_name="Mist_attack_skill_02"}
},
[-1609092943]={
{time=2500,type=0,cue_sheet="cv/Mist.acb",cue_name="Mist_09",cue_feature=1},
{time=6500,type=1,hit_type=0,camera_shake={time=400,shake_dir=1,range=300,range2=300,hz=30,decay_value=0.3},hit_creates={1349028111},hits={1000,1200}},
{effect="cast0_eff",time=2500,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/thirteen.acb",cue_name="Mist_attack_general"}
},
[1349028111]={
effect="cast0_hit",time=2900,type=0,pos_ref={ref_type=4,part_index=0}
},
[-316323548]={
{effect="dead_eff",time=2500,type=0,pos_ref={ref_type=6}}
},
[-1183793042]={
{effect="enter_eff",time=2500,type=0,pos_ref={ref_type=6}}
},
[-1328923786]={
{time=2500,type=0}
}
};

return this;