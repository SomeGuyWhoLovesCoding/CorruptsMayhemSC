--    CREDITS TIME   --
--[[

First of all this is a port based from this : https://github.com/DuskieWhy/Transparent-and-MultiWindow-FNF
            People who did the original one:
[  
]
[DuskieWhy] (https://twitter.com/DuskieWhy)
[TaeYai] (https://twitter.com/TaeYai)
[BreezyMelee] (https://twitter.com/BreezyMelee)
[YoshiCrafter] (https://twitter.com/YoshiCrafter29) - Additional help
[KadeDev] (https://twitter.com/kade0912) - Transparent window .hx file code

]

The Person that Port Multi Window with Character
[

[Laztrix] (https://twitter.com/non_Laztrix) (Laztrix#5670)
[gaminbottomtext#3433] - help a bit stuff

]

The Person that Make Transparent Window possible in Lua (or something idk)
[

[Mayo78#7878]

]

aight thats all. love you (no gay)
]]--

function onSongStart()
    -- luaDebugMode = true    -- remove the comment if you want to see the debug error spamming in the screen :troll:

    -- change window stuff here
    runHaxeCode([[
        windowDad = Application.current.createWindow({
            title: '',
            width: 600,
            height: 600,
            borderless: true,    
            alwaysOnTop: true     
        });
]])
     setTransparency(0x000c0c0c)
    runHaxeCode([[
        windowBf = Application.current.createWindow({
            title: '',
            width: 600,
            height: 600,
            borderless: true,
            alwaysOnTop: true
        });
               ]])
     setTransparency(0x000c0c0c)

        runHaxeCode([[
                // want to put the window somewhere? change value below
                windowDad.x = 229;
                windowDad.y = 202;

                windowBf.x = 1034;
                windowBf.y = 362;

                // none of your business
                windowDad.stage.color = 0x000c0c0c;
                windowBf.stage.color = 0x000c0c0c;

                FlxG.autoPause = false;
                Application.current.window.focus();

                // fr???
            ]])
    
    runHaxeCode([[
    // owo whats this :clueless:
        dadWin = new Sprite();
        bfWin = new Sprite();
    
        var m = new Matrix();
    
        dadWin.graphics.beginBitmapFill(game.dad.pixels, m);
        dadWin.graphics.drawRect(0, 0, game.dad.pixels.width, game.dad.pixels.height);
        dadWin.graphics.endFill();
        windowDad.stage.addChild(dadWin);

        bfWin.graphics.beginBitmapFill(game.boyfriend.pixels, m);
        bfWin.graphics.drawRect(0, 0, game.boyfriend.pixels.width, game.boyfriend.pixels.height);
        bfWin.graphics.endFill();
        windowBf.stage.addChild(bfWin);

        dadWin.scaleX = 0.7;
        dadWin.scaleY = 0.7;
    
        bfWin.scaleX = 0.7;
        bfWin.scaleY = 0.7;
    ]])
end
-- what the actual fuck :tro:
local yourlifeisnothingyouservezeropurposeyoushouldkillyourselfnow = -29292929

function onDestroy() -- uh fixing uh you know uhhhh
    setTransparency(yourlifeisnothingyouservezeropurposeyoushouldkillyourselfnow)
    runHaxeCode([[
        windowDad.close();
        windowBf.close();
        FlxG.autoPause = true;
       ]])
end

function onUpdate(elapsed)
    setProperty('dad.visible',false)
    setProperty('boyfriend.visible',false)
            runHaxeCode([[
                var dadFrame = game.dad._frame;
                var bfFrame = game.boyfriend._frame;

                // prevents crashes (i think???)
                if (dadFrame == null || dadFrame.frame == null) return;
                if (bfFrame == null || bfFrame.frame == null) return;

                var rectDad = new Rectangle(dadFrame.frame.x, dadFrame.frame.y, dadFrame.frame.width, dadFrame.frame.height);
                var rectBf = new Rectangle(bfFrame.frame.x, bfFrame.frame.y, bfFrame.frame.width, bfFrame.frame.height);
 
                dadWin.scrollRect = rectDad;
                bfWin.scrollRect = rectBf;

                dadWin.x = ( 150 + ((dadFrame.offset.x) - (game.dad.offset.x)) * dadWin.scaleX);
                dadWin.y = ( 100  + ((dadFrame.offset.y) - (game.dad.offset.y)) * dadWin.scaleY);
    
                bfWin.x = ( 150 + ((bfFrame.offset.x) - (game.boyfriend.offset.x)) * bfWin.scaleX);
                bfWin.y = ( 100 + ((bfFrame.offset.y) - (game.boyfriend.offset.y)) * bfWin.scaleY);
                ]])
end

-- LIBRARY STUFF

function onCreate()
        addHaxeLibrary('Lib', 'openfl')
        addHaxeLibrary('Application', 'openfl.display')
        addHaxeLibrary('Application', 'lime.app')
        addHaxeLibrary('FlxG', 'flixel')
        addHaxeLibrary('Matrix', 'openfl.geom')
        addHaxeLibrary('Rectangle', 'openfl.geom')
        addHaxeLibrary('Sprite', 'openfl.display')
    end

    
ffi = require "ffi"

ffi.cdef [[
    typedef int BOOL;
        typedef int BYTE;
        typedef int LONG;
        typedef LONG DWORD;
        typedef DWORD COLORREF;
    typedef unsigned long HANDLE;
    typedef HANDLE HWND;
    typedef int bInvert;
        
        HWND GetActiveWindow(void);
        
        LONG SetWindowLongA(HWND hWnd, int nIndex, LONG dwNewLong);
        
    HWND SetLayeredWindowAttributes(HWND hwnd, COLORREF crKey, BYTE bAlpha, DWORD dwFlags);
        
        DWORD GetLastError();
]]

function setTransparency(color) -- did remove the debugprint for some reason
    local win = ffi.C.GetActiveWindow()

    if win == nil then
    end
    if ffi.C.SetWindowLongA(win, -20, 0x00080000) == 0 then
    end
    if ffi.C.SetLayeredWindowAttributes(win, color, 0, 0x00000001) == 0 then
    end
end