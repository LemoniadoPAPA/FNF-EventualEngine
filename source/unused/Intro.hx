package backend;

import flixel.FlxState;

import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;

import states.TitleState;

class Intro extends FlxState
{
	public var lemo:FlxSprite;
	public var daCloseTimer:FlxTimer;
	public var lemoTimer:FlxTimer;

	override public function create()
	{
		super.create();

		lemo = new FlxSprite(-125).loadGraphic(Paths.image('intro/Lemo'));
		lemo.screenCenter(X);
		lemo.alpha = 0.0000001;
		FlxTween.tween(lemo, {alpha: 1}, 0.7, {ease: FlxEase.backInOut});
		add(lemo);

		lemoTimer = new FlxTimer().start(2, function(tmr:FlxTimer) {
			FlxTween.tween(lemo, {alpha: 0.00001}, 0.7, {ease: FlxEase.backInOut});
		});		

		FlxG.sound.play(Paths.sound('lemoIntro'), 0.7);

		daCloseTimer = new FlxTimer().start(3, function(tmr:FlxTimer) {
			MusicBeatState.switchState(new TitleState());
		});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
