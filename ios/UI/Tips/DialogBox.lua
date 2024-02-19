--带确认取消的提示框
local canvasGroup = nil;
local isOpening=false;
function Awake()
	canvasGroup = ComUtil.GetCom(gameObject, "CanvasGroup");
end

function OnOpen()
	CSAPI.PlayUISound("ui_popup_open");
	if close_tween then --打开界面时正在播放关闭动画
		CSAPI.RemoveGO(close_tween.gameObject, 0);
		close_tween = nil;
		canvasGroup.alpha = 1;
	end
	if(data ~= nil) then
		CSAPI.SetText(txtTitle, data.title or LanguageMgr:GetByID(1045))
		CSAPI.SetText(content, data.content or "");
        if(StringUtil:IsEmpty(data.content))then
            LogError(string.format("tips error.%s",table.tostring(data,true)));
        end
		--CSAPI.SetText(text_title,data.title or StringConstant.hint);
		CSAPI.SetText(text_ok, data.okText or LanguageMgr:GetByID(1001));
		CSAPI.SetText(text_cancel, data.cancelText or LanguageMgr:GetByID(1002));

		LanguageMgr:SetEnText(text_ok1,1001)
		LanguageMgr:SetEnText(text_cancel1,1002)
	end
	ShowAction();
end

function OnClickOK()
	local callBack = data and data.okCallBack;
	data.okCallBack = nil;
	Close(callBack);
end

function OnClickCancel()
	local callBack = data and data.cancelCallBack;
	if data.cancelCallBack then
		data.cancelCallBack = nil;
	end	
	Close();

    if(callBack) then		
		callBack();				
	end
end


function OnClickClose()	
	if(data.isClickMask)then
		Close();
	end
end

function Close(callBack)	
	HideAction(function()
		if callBack then
			callBack()
		end
		
		data = nil;
		if(view and view.Close) then
			view:Close();
            view = nil;
		end
	end);
end

--入场动画
function ShowAction(callBack)
	if isOpening then
        do return end
    end
    if open_tween then
        open_tween:Play(function()
            isOpening=false;
            if callBack~=nil then
                callBack();
            end
        end);
    else
        isOpening=true;
        open_tween=CSAPI.ApplyAction(gameObject,"View_Open_Fade",function()
            isOpening=false;
            if callBack~=nil then
                callBack();
            end
        end);
    end
end

--退场动画
function HideAction(callBack)
	if close_tween then
		close_tween:Play(callBack);
	else
		close_tween = CSAPI.ApplyAction(gameObject, "View_Close_Fade", callBack);
	end
end 