--选择皮肤
local curIndex = 1

function Awake()
	layout = ComUtil.GetCom(hsv, "UIInfinite")
	layout:Init("UIs/CRoleDisplay/CRoleSelectClothesItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
	local lua = layout:GetItemLua(index)
	if(lua) then
		local _data = curDatas[index]
		lua.SetIndex(index)
		lua.SetClickCB(ItemClickCB)
		local _isSelect = curIndex == index
		lua.Refresh(_data, {isSelect = _isSelect})
	end
end

function ItemClickCB(index)
	curIndex = index
	layout:UpdateList()
end

-- {data =CRoleInfo,cb =  }
function OnOpen()
	cRoleData = data.data
	
	curDatas = {}
	local _curDatas = cRoleData:GetAllSkinsArr()
	local len = #_curDatas
	local count = len > g_CRoleClothesCount and len or g_CRoleClothesCount
	for i = 1, count do
		if(i <= len) then
			table.insert(curDatas, _curDatas[i])
		else
			table.insert(curDatas, {isEmpty = true})  --补足长度
		end
	end
	layout:IEShowList(#curDatas)
end

--取消
function OnClickL()
	view:Close()
end

--确定
function OnClickR()
	if(data.cb) then
		local curModeId = curDatas[curIndex]:GetSkinID()
		data.cb(curModeId)
		view:Close()
	end
end

function OnClickBG()
	view:Close()
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
hsv=nil;
txtTitle=nil;
btnL=nil;
txtL1=nil;
btnR=nil;
txtR1=nil;
view=nil;
end
----#End#----