local grids={};

function Refresh(_d)
    if _d then
        CSAPI.SetText(txtRound,_d.round);
        --显示奖励内容
        ItemUtil.AddItems("Grid/GridItem", grids, _d.reward, gridNode,OnClickGrid , 0.6)
        CSAPI.SetGOActive(btnS,_d.state==2);
        CSAPI.SetGOActive(txtTips,_d.state==1);
    else
        CSAPI.SetGOActive(btnS,false);
        CSAPI.SetGOActive(txtTips,false);
    end
end


function OnClickGrid(tab)
    if tab and tab.data then
        local data=BagMgr:GetFakeData(tab.data:GetID());
        UIUtil:OpenGoodsInfo(data, 3);
    end
end

function OnClickS()
    EventMgr.Dispatch(EventType.MTB_Click_Reward);
end
