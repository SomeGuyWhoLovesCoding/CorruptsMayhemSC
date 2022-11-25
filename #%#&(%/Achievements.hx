import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;

using StringTools;

class Achievements {
	public static var achievementsStuff:Array<Dynamic> = [ //Name, Description, Achievement save tag, Hidden achievement
		["You know what, I'm leaving.",		"Beat The Corrupt's Machinery Week with less than 5 misses.",				'machinery_beaten',			false],
		["Ow- *glitching noises*",		"Somehow Press 7 and pause at the same time, then Unlock the Extras menu.",				'extras_unlocked',			false],
		["Grahhhhhh!",		"Collect all the Index Characters.",				'index_cracked',			false],
		["Why",		"Beat Unknown with less than 5 misses.",				'secret_beaten',			false],
		["I'M NOT A MACHINE!",		"Beat Empty after beating Corrupt's Machinery.",				'empty_beaten',			false]
	];
	public static var achievementsMap:Map<String, Bool> = new Map<String, Bool>();
	public static function unlockAchievement(name:String):Void {
		FlxG.log.add('Completed achievement "' + name +'"');
		achievementsMap.set(name, true);
		FlxG.sound.play(Paths.sound('screaming'), 0.5);
	}

	public static function isAchievementUnlocked(name:String) {
		if(achievementsMap.exists(name) && achievementsMap.get(name)) {
			return true;
		}
		return false;
	}

	public static function getAchievementIndex(name:String) {
		for (i in 0...achievementsStuff.length) {
			if(achievementsStuff[i][2] == name) {
				return i;
			}
		}
		return -1;
	}

	public static function loadAchievements():Void {
		if(FlxG.save.data != null) {
			if(FlxG.save.data.achievementsMap != null) {
				achievementsMap = FlxG.save.data.achievementsMap;
			}
		}
	}
}

class AttachedAchievement extends FlxSprite {
	public var sprTracker:FlxSprite;
	private var tag:String;
	public function new(x:Float = 0, y:Float = 0, name:String) {
		super(x, y);

		changeAchievement(name);
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function changeAchievement(tag:String) {
		this.tag = tag;
		reloadAchievementImage();
	}

	public function reloadAchievementImage() {
		if(Achievements.isAchievementUnlocked(tag)) {
			loadGraphic(Paths.image('achievements/' + tag));
		} else {
			loadGraphic(Paths.image('achievements/locked_achievement'));
		}
		scale.set(0.7, 0.7);
		updateHitbox();
	}

	override function update(elapsed:Float) {
		if (sprTracker != null)
			setPosition(sprTracker.x - 130, sprTracker.y + 25);
		super.update(elapsed);
	}
}

class AchievementObject extends FlxSpriteGroup {
	public var onFinish:Void->Void = null;
	var alphaTween:FlxTween;
	public function new(name:String, ?camera:FlxCamera = null)
	{
		super(x, y);
		ClientPrefs.saveSettings();

		var id:Int = Achievements.getAchievementIndex(name);

		var achievementBG:FlxSprite = new FlxSprite(-630, 15);
		achievementBG.frames = Paths.getSparrowAtlas('corrupt/GLITCHBG'); // The Fucking Mod's Achievement Background lmao
		achievementBG.animation.addByPrefix('moment when', 'Glitch BG Instance', 16, true);
		achievementBG.animation.play('moment when');
		achievementBG.antialiasing = true;
		achievementBG.scrollFactor.set();

		var achievementIcon:FlxSprite = new FlxSprite(achievementBG.x + 10, achievementBG.y + 10).loadGraphic(Paths.image('achievements/' + name));
		achievementIcon.setGraphicSize(Std.int(achievementIcon.width * (2 / 4)));
		achievementIcon.updateHitbox();
		achievementIcon.scrollFactor.set();
		achievementIcon.antialiasing = ClientPrefs.globalAntialiasing;

		var achievementName:FlxText = new FlxText(achievementIcon.x + 75, achievementIcon.y + 5, 365, Achievements.achievementsStuff[id][0], 24);
		achievementName.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.BLACK, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		achievementName.borderSize = 1.5;
		achievementName.scrollFactor.set();

		var achievementText:FlxText = new FlxText(achievementIcon.x + 75, achievementName.y + 22, 365, Achievements.achievementsStuff[id][1], 12);
		achievementText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.BLACK, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		achievementText.borderSize = 1.5;
		achievementText.scrollFactor.set();

		add(achievementBG);
		add(achievementName);
		add(achievementText);
		add(achievementIcon);

		var cam:Array<FlxCamera> = FlxCamera.defaultCameras;
		if(camera != null) {
			cam = [camera];
		}
		alpha = 1;
		achievementBG.cameras = cam;
		achievementName.cameras = cam;
		achievementText.cameras = cam;
		achievementIcon.cameras = cam;
		alphaTween = FlxTween.tween(this, {x: 645}, 0.7, {ease: FlxEase.expoOut, onComplete: function (twn:FlxTween) {
			alphaTween = FlxTween.tween(this, {x: -645}, 1.1, {ease: FlxEase.expoInOut, startDelay: 8.8,
				onComplete: function(twn:FlxTween) {
					alphaTween = null;
					remove(this);
					if(onFinish != null) onFinish();
				}
			});
		}});
	}

	override function destroy() {
		if(alphaTween != null) {
			alphaTween.cancel();
		}
		super.destroy();
	}
}