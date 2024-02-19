--剧情故事界面子物体
local content = "";
local fade = nil

function Refresh(plot)
	if plot then
		CSAPI.SetGOActive(iconObj, false);
		if plot:GetKey() == "PlotData" then
			local talkName = ""
			if plot:IsLeader() then --玩家正常对话
				talkName = PlayerClient:GetName()
				if PlayerClient:GetIconName() then
					CSAPI.SetGOActive(iconObj, true)
					ResUtil.RoleCard:Load(icon, PlayerClient:GetIconName(), true)
				end
			elseif plot:GetTalkName() ~= "" and plot:GetTalkName() ~= nil then
				talkName = plot:GetTalkName();
				--获取配置表头像
				local isShowIcon = plot:IsShowIcon()
				CSAPI.SetGOActive(iconObj, isShowIcon)
				if isShowIcon then
					local talkInfo = plot:GetTalkInfo();
					ResUtil.RoleCard:Load(icon, talkInfo:GetIcon());
					-- CSAPI.SetRTSize(icon, 127, 127)
				end
			end
			CSAPI.SetText(txt_name, talkName);
		else --玩家选项对话
			if PlayerClient:GetSex() > 0 then
				CSAPI.SetText(txt_name, PlayerClient:GetName());
				if PlayerClient:GetIconName() then
					CSAPI.SetGOActive(iconObj, true)
					ResUtil.RoleCard:Load(icon, PlayerClient:GetIconName(), true)
				end
			else
				CSAPI.SetText(txt_name, "？？？？");
			end
		end
		content = string.gsub(plot:GetContent(), "<[%p%w]->", "")
		content = string.gsub(content, "^%s*(.-)%s*$", "%1")
		CSAPI.SetText(txt_content, content);
	end
end

function GetHeight()
	local height = 45;
	local list = StringUtil:SubStrByLength(content, 46);
	height = height + 45 * #list;
	height = height > 180 and height or 180
	return height;
end

function SetFadeIn(idx)
	idx = idx or 0
	if not fade then
		fade = ComUtil.GetCom(gameObject, "ActionFade")
	end
	fade:Play(0, 1, 250, idx * 100)
end
function OnDestroy()	
	ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	iconObj = nil;
	icon = nil;
	txt_name = nil;
	txt_content = nil;
	view = nil;
end
----#End#----
