function onCreate()
	makeLuaSprite('back','corrupt/Machinery-back',-300,-300)
	makeLuaSprite('front','corrupt/Machinery-front',-300,-300)
	addLuaSprite('back',false)
	addLuaSprite('front',false)
end
function onCreatePost()
	initLuaShader("imageScroll")
	setSpriteShader('back', "imageScroll")
end
function onUpdate(elapsed)
	setShaderFloat("back", "iTime", os.clock())
end