function onCreate()
	makeLuaSprite('back','corrupt/MachineryEvening-back',-300,-300)
	makeLuaSprite('front','corrupt/MachineryEvening-front',-300,-300)
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