package states;

import flixel.FlxState;
import flixel.text.FlxText;

class AboutState extends MusicBeatState
{
	var logoBl:FlxSprite;
	var daDescTxt:FlxText;
	var creatorTxt:FlxText;
	var bg:FlxSprite;

	override public function create()
	{
		super.create();

		bg = new FlxSprite(-80).loadGraphic(Paths.image('menuBlack'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);

		logoBl = new FlxSprite(-60, -100);
		logoBl.frames = Paths.getSparrowAtlas('logoBumpinEventual');
		logoBl.antialiasing = ClientPrefs.data.antialiasing;

		add(logoBl);

		daDescTxt = new FlxText(800, 60, 0, "Eventual Engine is a mod
		made by Lemoniado Endemoniado.
		It's an engine wich
		is enfocated in adding
		New Events and visual effects.
		Formerly, this mod was called
		Another Psych Engine
		Fork (APEF).
		In the past, the mod was built
		in PE 0.6.3 and in PE 0.7.0, and
		now is made in PE 0.7.3.
		If you want, you can go to the Assets
		or to the Source Code
		to see unused stuff of the Engine", 54);
		daDescTxt.size = 54;
		daDescTxt.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(daDescTxt);

		daDescTxt = new FlxText(800, 600, 0, "Press DOWN to see about\nthe Creator", 24);
		add(daDescTxt);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.BACK)
			{
				MusicBeatState.switchState(new StartState());
			}

		if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				MusicBeatState.switchState(new AboutStatePTwo());
			}
	}
}
