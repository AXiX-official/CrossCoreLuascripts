
function SetClickCB(_cb)
	cb = _cb
end

function SetIndex(_i)
	index = _i
end

function Refresh(_data, _elseData)
	data = _data	
	Select(_elseData == index)	
end  
            
function Select(b)
	--name
	local str = StringUtil:SetByColor(data, b and "000000" or "ffffff")
	CSAPI.SetText(txtName, str)
	--CanvasGroup
	if(bgCanvasGroup == nil) then
		bgCanvasGroup = ComUtil.GetCom(bg, "CanvasGroup")
	end
	bgCanvasGroup.alpha = b and 1 or 0.5
end


function OnClick()
	if(cb) then
		cb(index)
	end
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
bg=nil;
txtName=nil;
view=nil;
end
----#End#----