--版本设置
local this = {};

function this:Init()
    --语言设置
    LanguageMgr:ChangeLanguage(1) --1234  中文，繁体，日语，英文
end


return this;