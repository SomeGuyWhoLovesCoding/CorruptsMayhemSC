function onCreate()
	makeLuaSprite('back','corrupt/MachineryBroken-back',-300,-300)
	makeLuaSprite('front','corrupt/MachineryBroken-front',-300,-300)
	addLuaSprite('back',false)
	addLuaSprite('front',false)
end
function onCreatePost()
	initLuaShader("imageScrollBroken")
	setSpriteShader('back', "imageScrollBroken")
end
function onUpdate(elapsed)
	setShaderFloat("back", "iTime", os.clock())
end