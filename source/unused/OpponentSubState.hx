package substates;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import states.FreeplayState;
import states.PlayState;

class OpponenSubtState extends MusicBeatSubstate
{
	var bfStarting:FlxSprite;
	var opponent:FlxSprite;
	var ready:FlxSprite;

	var daTimer:FlxTimer;
	//This is the first substate i coded :money_mouth:
	override public function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.6;
		bg.screenCenter(X);
		bg.scrollFactor.set();
		add(bg);

		bfStarting = new FlxSprite(-80).loadGraphic(Paths.image('starting/BF' + FlxG.random.int(0, 2)));
		add(bfStarting);

		opponent = new FlxSprite(-125).loadGraphic(Paths.image('starting/' + PlayState.dad.curCharacter));
		add(opponent);

		ready = new FlxSprite(-125).loadGraphic(Paths.image('starting/ready'));
		ready.screenCenter(X);
		add(ready);

		var escapeShit:FlxText = new FlxText(12, FlxG.height - 200, 0, "Press Enter to go back", 12);
		escapeShit.scrollFactor.set();
		escapeShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(escapeShit);

		daTimer = new FlxTimer().start(5, function(tmr:FlxTimer)
			{
				close();
				PlayState.itStarted = true;
			});
		
		//FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if(FlxG.keys.justPressed.ENTER)
			{
				close();
			}
	}
}
