local inputID=nil;
local inputCond=nil;
local items={};
local cond=nil;
local teamData=nil;
function Awake()
    inputCond = ComUtil.GetCom(input_cond, "InputField");
    inputID = ComUtil.GetCom(input_id, "InputField");
    -- inputCond.text="3,20,16"
    -- inputCond.text="120010|120020"
    -- inputCond.text="498011,199013,230050"--必须编入总队长、禁止编入治疗角色,队伍人数只能三个
    -- inputCond.text="110040,120010";
    -- inputCond.text="120020|120030"; --只能编入乐团或者不朽的角色
    inputCond.text="310063";
    inputID.text="60110";
    teamData=GetTeamData();
    LogError(teamData:GetData())
end

function GetTeamData()
    -- local d={
    --     index = 1,
    --     leader = 10040,
    --     name = FormationUtil.GetDefaultName(1),
    --     data = {
    --         -- {
	-- 		-- 	cid = 10040,
	-- 		-- 	row = 1,
	-- 		-- 	col = 1,
	-- 		-- 	index =1,
	-- 		-- 	isLeader=true,
	-- 		-- },
    --         -- {
	-- 		-- 	cid = 10010,
	-- 		-- 	row = 2,
	-- 		-- 	col = 2,
	-- 		-- 	index =2,
	-- 		-- }
    --     },
    -- }
    -- local team=TeamData.New();
    -- team:SetData(d)
    local team=TeamMgr:GetTeamData(1,true);
    return team;
end

function OnClickClose()
  CSAPI.SetGOActive(gameObject,false)
end

--验证
function OnClick()
    local condStr=nil;
    local id=nil;
    if inputCond.text~=nil and inputCond.text~="" then
        condStr=inputCond.text;
    end
    if inputID.text~=nil and inputID.text~="" then
        id=inputID.text;
    end
    if condStr==nil then
        LogError("条件不得为空！");
        return
    end
    cond=TeamCondition.New();
	cond:Init(condStr)
    local list={};
    if id==nil then
        for k,v in pairs(Cfgs.CardData:GetAll()) do
            if v.get_from_gm then
                local card=RoleMgr:GetFakeData(v.id);
                local result=cond:CheckCard(teamData,card)
                if result then
                    table.insert(list,card);
                end
                LogError(card:GetCfgID().."\t"..card:GetName().."\t"..tostring(result))
            end
        end
    else
        local card=RoleMgr:GetFakeData(tonumber(id));
        if card~=nil and cond:CheckCard(teamData,card) then
            table.insert(list,card);
        end
    end
    Output(list);
end

function Output(list)
    local num=0;
    if list~=nil then
        num=#list;
    end
    local realNum=num>=#items and num or #items;
    for i=1,realNum do
        local lua=#items>=i and items[i] or nil;
        if lua~=nil then
            if i>num then
                lua.Hide();
            else
                lua.Show(list[i]);
            end
        elseif i<=num then
            ResUtil:CreateUIGOAsync("GMConditionTestItem", Content,function(go)
                lua=ComUtil.GetLuaTable(go)
                lua.Show(list[i]);
                table.insert(items,lua);
            end)
        end
    end
end