function onUpdate()
	setProperty('skipCountdown', true)
	for i = 0,3 do
	if curStep == 1 then
		setPropertyFromGroup('opponentStrums',i,'alpha',0)
		setProperty('dad.alpha', 0)
	doTweenAlpha('iconDadFadeEventTween', 'iconP2', 1, 0.1, 'linear');
	end
	end
	if curStep == 128 then
	for i = 0,3 do
	setPropertyFromGroup('opponentStrums',i,'alpha',1)
		doTweenAlpha('dadFadeEventTween', 'dad', 1, 0.1, 'linear');
		doTweenAlpha('iconDadFadeEventTween', 'iconP2', 1, 0.1, 'linear');
	end
	if curBeat == 543 then
		doTweenAlpha('dadFadeEventTween', 'dad', 0, 1.7, 'linear');
		doTweenAlpha('P2FadeEventTween', 'dad.alpha', 0, 1.5, 'linear');
		doTweenAlpha('iconDadFadeEventTween', 'iconP2', 0, 1.4, 'linear');
		end
	end
end