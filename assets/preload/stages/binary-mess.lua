function onCreate()
	makeLuaSprite('back','trial/binaryBack',0,0)
	makeLuaSprite('front','trial/bottom_floor',0,0)
	addLuaSprite('back',false)
	addLuaSprite('front',false)
end
function onCreatePost()
	initLuaShader("imageScroll")
	initLuaShader("imageScrollMess")
	setSpriteShader('back', "imageScroll")
	setSpriteShader('front', "imageScrollMess")
end
function onUpdate(elapsed)
	setShaderFloat("back", "iTime", os.clock())
	setShaderFloat("front", "iTime", os.clock())
end