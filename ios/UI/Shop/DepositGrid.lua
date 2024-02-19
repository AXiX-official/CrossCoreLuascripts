--礼包格子
-- local cid=nil;
local data=nil;
local grid=nil;
local textMove=nil
function Awake()
    textMove=ComUtil.GetCom(nameObj,"TextMove");
end
function Init(_d)
    CSAPI.SetGOActive(node1, _d ~= nil)
    CSAPI.SetGOActive(node2, _d == nil)
	--初始化格子
    if _d then
        data=_d;
        -- if data.type==RandRewardType.CARD then
        --     CSAPI.SetScale(gridNode,0.8,0.8,0.8);
        --     local go=ResUtil:CreateUIGO("RoleCard/RoleLittleCard",gridNode.transform);
        --     grid=ComUtil.GetLuagridle(go);
        --     grid.SetIcon(data.icon);
        --     grid.SetBgIcon(data.quality);
        --     grid.ActiveClick(true);
        --     grid.SetLv(0);
        -- else
            CSAPI.SetScale(gridNode,0.8,0.8,0.8);
            if grid==nil then
                _,grid= ResUtil:CreateGridItem(gridNode.transform);
            end
            grid.Refresh(data);
            -- grid.Clean();
            grid.SetClickCB(OnClickSelf);
            -- grid.LoadIcon(data.icon);
            -- grid.LoadFrame(data.quality);
            -- if data.type==RandRewardType.EQUIP or data.type==RandRewardType.CARD then
            --     grid.SetStar(data.quality);
            -- end
            grid.SetClickState(true);
            -- grid.SetCount(data.num);
        -- end
        -- local nameStr=data.name
        -- if data.num~=nil and data.num~="" then
        --     nameStr=nameStr.."X"..tostring(data.num);
        -- end
        CSAPI.SetText(name,"");
        -- textMove:SetMove();
		this.grid=grid;
	end
end 

-- --点击
function OnClickSelf()
    if data  then
        -- local goods=BagMgr:GetData(cid);
        -- if goods==nil then
        --     goods=GoodsData();
        --     goods:InitCfg(cid);
        -- end
        GridClickFunc.OpenInfoSmiple({data=data});
    end
end

function ShowDesc(isShow)
    CSAPI.SetGOActive(tipsObj,isShow==true);
end

function SetDesc(str)
    str=str==nil and "" or str
    CSAPI.SetText(txt_tips,tostring(str));
end

function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
node1=nil;
gridNode=nil;
nameObj=nil;
name=nil;
tipsObj=nil;
txt_tips=nil;
node2=nil;
view=nil;
end
----#End#----