function onCreate()
	makeLuaSprite('back','corrupt/street-back',-300,-300)
	makeLuaSprite('front','corrupt/street-front',-300,-300)
	addLuaSprite('back',false)
	addLuaSprite('front',false)
end
function onCreatePost()
	initLuaShader("imageScrollStreet1")
	initLuaShader("imageScrollStreet2")
	setSpriteShader('front', "imageScrollStreet1")
	setSpriteShader('back', "imageScrollStreet2")
end
function onUpdate(elapsed)
	setShaderFloat("front", "iTime", os.clock())
	setShaderFloat("back", "iTime", os.clock())
end