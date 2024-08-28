PetViewType={ --宠物切页类型
    Bag=62001, --背包
    Store=62002, --商店
    Sport=62003, --运动
    Book=62004, --图鉴
    Pet=62005,  --宠物
}

PetTweenType={ --宠物动画类型
    idle="idle",
    sleep="sleep",
    eat="eat",
    wash="wash",
    clean="clean",
    play="play",
    walk="walk",
    sport="sport",
    move="move",
}

PetSportType={
    Stop=0,--停止
    Move=1, --散步
    Run=2,  --跑步
}

PetHeadType={
    All=1,
    Wash=2,
    Food=3,
    Toy=4,
}

PetItemType={
    Toy=1,
    Food=2,
    Wash=3,
}
--宠物状态用于判断的属性类型
PetStateAttrType={
    Happy=1,
    Wash=2,
    Food=3,
    Life=4,
}

PetStateOption={
    Greater=1, --大于
    GreaterOrEqual=2,--大于等于
    Equal=3, --等于
    Less=5, --小于
    LessOrEqual=4,--小于等于
}

--台词框触发条件
PetTalkCondType={
    EnterView=1,
    EnterState=2,
    StayState=3,
    ExitState=4,
}

PetQualityColor={
    "c6ac91",
    "4aaf36",
    "72AEFF",
    "CE77FF",
    "FFb500",
    "FFb500",
}