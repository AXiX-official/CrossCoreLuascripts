--FireBall数据
local this = 
{
[1120628288]={
{effect="enter_eff",effect_pack="s50011",time=5000,type=0,pos_ref={ref_type=6},cue_sheet="cv/Queen_Bee.acb",cue_name="Queen_Bee_41",cue_feature=1}
},
[1310282141]={
{delay=500,time=11800,type=0,cue_sheet="cv/Queen_Bee.acb",cue_name="Queen_Bee_49",cue_feature=1},
{delay=9500,time=5000,type=1,hit_type=1,hits={0}},
{time=12000,type=0,cue_sheet="fight/effect/nineth.acb",cue_name="homology_Queenbee_attack_skill_02"},
{delay=5800,time=5000,type=1,hit_type=1,hits={0}},
{delay=7000,time=11800,type=0,cue_sheet="cv/Queen_Bee.acb",cue_name="Queen_Bee_50",cue_feature=1},
{delay=8452,time=5000,type=1,hit_type=1,hits={0}},
{delay=10000,time=5000,type=1,hit_type=1,hits={0}},
{delay=11000,time=5000,type=1,hit_type=1,hits={0}},
{effect="cast2_eff",effect_pack="s50011",time=11800,type=0,pos_ref={ref_type=6}},
{delay=6000,time=5000,type=1,hit_type=1,hits={0}}
},
[-686817241]={
{effect="cast1_hit",effect_pack="s50011",time=5000,type=0,pos_ref={ref_type=3,offset_row=-50}},
{delay=3400,time=2000,type=1,hit_type=0,hits={0}},
{delay=2800,time=2000,type=1,hit_type=0,is_fake=1,fake_damage=1,camera_shake={time=900,shake_dir=1,range=200,range1=50,range2=200,hz=60,decay_value=0.6},hits={0}},
{effect="cast1_eff",effect_pack="s50011",time=5000,type=0,pos_ref={ref_type=3,offset_row=-450},cue_sheet="cv/Queen_Bee.acb",cue_name="Queen_Bee_48",cue_feature=1},
{time=5000,type=0,cue_sheet="fight/effect/nineth.acb",cue_name="homology_Queenbee_attack_skill_01"},
{effect="cast1_eff2",effect_pack="s50011",time=5000,type=0,pos_ref={ref_type=6}},
{delay=1600,time=2000,type=1,hit_type=0,camera_shake={time=250,shake_dir=1,range=500,range1=50,range2=500,hz=20,decay_value=0.6},hits={0}}
},
[-601574123]={
{time=1500,type=0}
},
[-1609092943]={
{effect="cast0_eff2",effect_pack="s50011",time=2800,type=0,pos_ref={ref_type=6},cue_sheet="fight/effect/nineth.acb",cue_name="homology_Queenbee_attack_general"},
{effect="cast0_eff",effect_pack="s50011",time=2800,type=0,pos_ref={ref_type=0,offset_row=-150,lock_row=1},cue_sheet="cv/Queen_Bee.acb",cue_name="Queen_Bee_47",cue_names={"Queen_Bee_43","Queen_Bee_44","Queen_Bee_45","Queen_Bee_46"},cue_feature=1},
{delay=1400,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=300,range1=50,range2=300,hz=40,decay_value=0.6},hit_creates={-838067028},hits={0}}
},
[-838067028]={
effect="common_hit2",effect_pack="common_hit",time=2800,type=0,pos_ref={ref_type=4,part_index=1}
},
[-316323548]={
{time=2800,type=0,cue_sheet="cv/Queen_Bee.acb",cue_name="Queen_Bee_52",cue_feature=1},
{delay=1400,time=2000,type=1,hit_type=0,camera_shake={time=300,shake_dir=1,range=300,range1=50,range2=300,hz=40,decay_value=0.6},hits={0}}
}
};

return this;