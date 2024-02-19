local items = {}
local height = 199
local num = 0
local tweenDelay = 0

function Refresh(_data, _elseData)
	AddItem(_data, _elseData)
end

function AddItem(list, _elseData)
	if(list) then
		items = items or {}
		for i, v in ipairs(list) do
			num = num + 1
			ResUtil:CreateUIGOAsync("DungeonDetail/DungeonGoodsItem", passNode, function(go)
				local lua = ComUtil.GetLuaTable(go)
				lua.SetIndex(num)
				lua.Refresh(v, _elseData)
				lua.SetTween(tweenDelay)
				table.insert(items, lua)
			end)
		end
		SetLayoutHeight(math.floor(num / 8))
	end
end

function SetLayoutHeight(idx)
	local w, _ = CSAPI.GetRTSize(gameObject)
	CSAPI.SetRTSize(gameObject, w, height + idx * 222)
end

function ShowLine(isShow)
	CSAPI.SetGOActive(lineObj, isShow)
end

function SetTitle(_id)
	LanguageMgr:SetText(txt_title, _id)
end

function SetTweenDelay(idx)
	tweenDelay = 50 *(idx - 1)
end 