--编成预设面板
local itemList = nil;
local layout=nil;
local eventMgr=nil;
local stateList={};
function Awake()
	layout = ComUtil.GetCom(vsv, "UISV")
	layout:Init("UIs/FormatPreset/TeamPresetItem",LayoutCallBack,true)
	-- UIUtil:AddTop(gameObject, OnReturn)
	eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Team_Preset_Open, OnOpenPreset);
	eventMgr:AddListener(EventType.Team_Preset_Buy, OnPresetBuyRet);
end

function OnEnable()
	CSAPI.ApplyAction(gameObject, "Fade_In_200");
	InitView();
end

function OnDestroy()
	eventMgr:ClearListener();
	ReleaseCSComRefs();
end

function InitView()
	curDatas={};
	stateList={};
	for i = 1, g_FormationMaxNum do
		table.insert(curDatas,i);
		table.insert(stateList,false);
	end
	layout:IEShowList(#curDatas)
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local elseData={
		isLock=_data>TeamMgr:GetPresetNum();
		team=TeamMgr:GetTeamData(eTeamType.Preset + _data),
		index=index,
		isClick=stateList[index]==true;
	}
	local item=layout:GetItemLua(index);
	item.Refresh(_data,elseData);
	item.SetClickCB(OnClickItem);
end

function OnClickItem(lua,isOn)
	stateList[lua.GetIndex()]=isOn;
end

function OnClickReturn()
	CSAPI.ApplyAction(gameObject, "Fade_Out_100",function()
		CSAPI.SetGOActive(gameObject, false);
	end);
end

function OnOpenPreset()
	OnClickReturn();
end

function OnPresetBuyRet()
	layout:UpdateList();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
panelNode=nil;
vsv=nil;
view=nil;
end
----#End#----