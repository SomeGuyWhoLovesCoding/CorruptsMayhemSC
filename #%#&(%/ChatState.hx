package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class ChatState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.color = 0xFF222222;
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width,
			"
			I'M SORRY TO SAY THIS, BUT THIS\n
			FEATURE IS LIMITED FOR DEMOS.\n
			\n
			Thank you for playing this Mod Tho!\n
			It was such a fun day to release it,\n
			but it's Unfinished...",
			32);
		warnText.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		warnText.screenCenter();
		add(warnText);
	}

	override function update(elapsed:Float)
	{
		if(FlxG.keys.pressed.SEVEN) {
			PlayState.SONG = Song.loadFromJson('unknown', 'unknown');
			
			// This mess...

			warnText.text = "
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE
			DONE DONE DONE DONE DONE DONE DONE";

			warnText.y = -50;

			FlxG.sound.play(Paths.sound('teleport-empty'), 16);
			new FlxTimer().start(0.02, function(tmr:FlxTimer)
			{
					LoadingState.loadAndSwitchState(new PlayState()); 
			});
		}
		if(!leftState) {
			if(controls.ACCEPT) {
				leftState = true;
			}

			if(leftState)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(warnText, {y: warnText.y + 5, alpha: 0}, 0.64, {
					onComplete: function (twn:FlxTween) {
						MusicBeatState.switchState(new MainMenuState());
					}
				});
			}
		}
		super.update(elapsed);
	}
}