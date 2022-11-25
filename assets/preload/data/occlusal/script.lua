Chromacrap = 0;

function boundTo(value, min, max)
	return math.max(min, math.min(max, value))
end
function math.lerp(from,to,i)return from+(to-from)*i end

function setChrome(chromeOffset)
	setShaderFloat("chroma", "rOffset", chromeOffset);
	setShaderFloat("chroma", "gOffset", 0.0);
	setShaderFloat("chroma", "bOffset", chromeOffset * -1);
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
	Chromacrap = Chromacrap + 0.015
end

function onCreatePost()
	luaDebugMode = true
	initLuaShader("chroma")
    
	makeLuaSprite("chroma")
	makeGraphic("chroma", screenWidth, screenHeight)
    
	setSpriteShader("chroma", "chroma")
    
	addHaxeLibrary("ShaderFilter", "openfl.filters")
	runHaxeCode([[
		trace(ShaderFilter);
		game.camGame.setFilters([new ShaderFilter(game.getLuaObject("chroma").shader)]);
		game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("chroma").shader)]);
	]])
end

function onUpdate(elapsed)
	Chromacrap = math.lerp(Chromacrap, 0, boundTo(elapsed * 32, 0, 1))
		setChrome(Chromacrap)
end