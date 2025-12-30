--核心兑换详情
local data={
    {id=1,stars=3,first={card=false,gets={10033,1}},second={card=true,gets={10034,5}},third={card=true,gets={10034,5}}},
    {id=1,stars=4,first={card=false,gets={10033,1}},second={card=true,gets={10034,30}},third={card=true,gets={10034,30}}},
    {id=1,stars=5,first={card=false,gets={10033,1}},second={card=true,gets={10033,5}},third={card=true,gets={10033,8}}},
    {id=1,stars=6,first={card=false,gets={10033,1}},second={card=true,gets={10033,10}},third={card=true,gets={10033,15}}},
}
local data2={
    {id=1,stars=3,gets={10034,5}},
    {id=1,stars=4,gets={10033,1}},
    {id=1,stars=5,gets={10033,5}},
    {id=1,stars=6,gets={10033,10}},
}
local items={};
local items2={};
function OnOpen()
    ItemUtil.AddItems("Shop/CoreExchangeItem", items, data, layout1, nil, 1);
    ItemUtil.AddItems("Shop/CoreExchangeItem3", items2, data2, layout2, nil, 1);
end

function OnClickClose()
    view:Close();
end