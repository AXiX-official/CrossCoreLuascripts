
--UI自适应数据配置 词典
AdaptiveConfiguration={}
local this=AdaptiveConfiguration;

local Screen=UnityEngine.Screen;

local orientation=nil;
function this.OnInit()
     --print("初始化屏幕状态："..tostring(Screen.orientation));
    orientation=Screen.orientation;

end
---监听执行数据
function this.MonitorExecutiondata()
    if orientation~=Screen.orientation then
        --print("屏幕发生变化："..tostring(Screen.orientation))
        orientation=Screen.orientation;
        this.ScreenRotationOccurs()
    end
end
---自适应UI集合
this.AdaptiveSet={};
--自适应
function this.SetLuaUIFit(UIkey,Item)
    CSAPI.SetUIFit(Item)
    local tableItem=
    {
        key=UIkey,
        value=Item,
    };
    table.insert(this.AdaptiveSet,tableItem);
    print("打印："..table.tostring(this.AdaptiveSet))
end

---屏幕发生旋转调用
function this.ScreenRotationOccurs()
    if #this.AdaptiveSet>0 then
        for i, v in pairs(this.AdaptiveSet) do
            if this.AdaptiveSet[i].value~=nil then
                CSAPI.SetUIFit(this.AdaptiveSet[i].value)
            end
        end
    end
end

function this.RemoveLuaUIFit(UIkey)
    ---print("RemoveLuaUIFit: "..table.tostring(this.AdaptiveSet))
    if #this.AdaptiveSet>0 then
        local index=0;
        for i, v in pairs(this.AdaptiveSet) do
            index=index+1
            ---print("  输出："..this.AdaptiveSet[i].key)
            if tostring( this.AdaptiveSet[i].key)==tostring(UIkey) then
                -- print("移除key："..UIkey);
                table.remove(this.AdaptiveSet,index);
                -- print("打印："..table.tostring(this.AdaptiveSet))
                return;
            end
        end
    end
end





--
--this.UIAdaptiveDic=
--{
--    ["huawei lio-an00"]=
--    {
--        id="huawei lio-an00",
--        topOffset=40,
--        bottomOffset=0,
--        des="",
--    },
--    ["honor ann-an00"]=
--    {
--        id="honor ann-an00",
--        topOffset=40,
--        bottomOffset=0,
--        des="",
--    },
--    ["HUAWEI JKM-LX1"]=
--    {
--        id="HUAWEI JKM-LX1",
--        topOffset=58,
--        bottomOffset=0,
--        des="",
--    },
--    ["HUAWEI OXP-AN00"]=
--    {
--        id="HUAWEI OXP-AN00",
--        topOffset=58,
--        bottomOffset=0,
--        des="",
--    },
--    ["vivo v2073a"]=
--    {
--        id="vivo v2073a",
--        topOffset=50,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 4"]=
--    {
--        id="iPhone 4",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--
--    ["iPhone 4S"]=
--    {
--        id="iPhone 4S",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--
--    ["iPhone 5"]=
--    {
--        id="iPhone 5",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 5S"]=
--    {
--        id="iPhone 5S",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 5C"]=
--    {
--        id="iPhone 5C",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone SE"]=
--    {
--        id="iPhone SE",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 6"]=
--    {
--        id="vivo v2073a",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 6 Plus"]=
--    {
--        id="iPhone 6 Plus",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 6S"]=
--    {
--        id="iPhone 6S",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 6S Plus"]=
--    {
--        id="iPhone 6S Plus",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 7"]=
--    {
--        id="iPhone 7",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 8"]=
--    {
--        id="iPhone 8",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 8 Plus"]=
--    {
--        id="iPhone 8 Plus",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone X"]=
--    {
--        id="iPhone X",
--        topOffset=83,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone XS"]=
--    {
--        id="iPhone XS",
--        topOffset=83,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone XS Max"]=
--    {
--        id="iPhone XS Max",
--        topOffset=83,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone XR"]=
--    {
--        id="iPhone XR",
--        topOffset=83,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone 11"]=
--    {
--        id="iPhone 11",
--        topOffset=83,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone 11 Pro"]=
--    {
--        id="iPhone 11 Pro",
--        topOffset=83,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone 11 Pro Max"]=
--    {
--        id="iPhone 11 Pro Max",
--        topOffset=83,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone 12 mini"]=
--    {
--        id="iPhone 12 mini",
--        topOffset=44,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone 12"]=
--    {
--        id="iPhone 12",
--        topOffset=47,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone 12 Pro"]=
--    {
--        id="iPhone 12 Pro",
--        topOffset=47,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone 12 Pro Max"]=
--    {
--        id="iPhone 12 Pro Max",
--        topOffset=47,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone 13 Pro"]=
--    {
--        id="iPhone 13 Pro",
--        topOffset=47,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 13 mini"]=
--    {
--        id="iPhone 13 mini",
--        topOffset=47,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 13 Pro Max"]=
--    {
--        id="iPhone 13 Pro Max",
--        topOffset=47,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 14"]=
--    {
--        id="iPhone 14",
--        topOffset=50,
--        bottomOffset=20,
--        des="",
--    },
--    ["iPhone 14 Pro"]=
--    {
--        id="iPhone 14 Pro",
--        topOffset=50,
--        bottomOffset=20,
--        des="",
--    },
--    ["iPhone 14 plus"]=
--    {
--        id="iPhone 14 plus",
--        topOffset=50,
--        bottomOffset=20,
--        des="",
--    },
--    ["iPhone 14 Pro Max"]=
--    {
--        id="iPhone 14 Pro Max",
--        topOffset=50,
--        bottomOffset=20,
--        des="",
--    },
--
--}
--
--function this.AddUIAdaptive(id,topOffset,bottomOffset)
--     local IsKey=false;
--    for i, v in pairs(this.UIAdaptiveDic) do
--        print("key:"+i.." "..table.tostring(v));
--        if i==id then
--            IsKey=true;
--            break;
--        end
--    end
--    if IsKey==false then
--        local tableItem=
--        {
--            id=id,
--            topOffset=topOffset,
--            bottomOffset=bottomOffset,
--            des="",
--        }
--        table.insert(this.UIAdaptiveDic,id,tableItem);
--        print(" 添加数据成功 "..table.tostring(this.UIAdaptiveDic))
--    else
--        this.UIAdaptiveDic[id].topOffset=topOffset;
--        this.UIAdaptiveDic[id].bottomOffset=bottomOffset;
--        print("刷新数据："..table.tostring(this.UIAdaptiveDic[id]));
--    end
--end
--
--function this.RemoveAdaptive(id,topOffset,bottomOffset)
--    local IsKey=false;
--     local Removeindex=0;
--    for i, v in pairs(this.UIAdaptiveDic) do
--        ---print("key:"+i.." "..table.tostring(v));
--        Removeindex=Removeindex+1;
--        if i==id then
--            IsKey=true;
--            break;
--        end
--    end
--    if IsKey then
--        print("移除数据ID："..id)
--        table.remove(this.UIAdaptiveDic,Removeindex);
--        print(" 添加数据成功 "..table.tostring(this.UIAdaptiveDic))
--    end
--end