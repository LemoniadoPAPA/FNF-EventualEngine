package states;

import flixel.FlxState;
import flixel.text.FlxText;

class AboutStatePTwo extends MusicBeatState
{
	var lemo:FlxSprite;
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

		lemo = new FlxSprite(125, -100).loadGraphic(Paths.image('lemistic'));
		lemo.antialiasing = ClientPrefs.data.antialiasing;
		lemo.updateHitbox();
		lemo.screenCenter();
		lemo.x = 150;
		add(lemo);

		daDescTxt = new FlxText(800, 60, 0, "My name is Lemoniado, i started
		playing FNF on february 2021, i wanted
		to start making my own mods on august of
		the same year, and i published my first mod
		on November.
		My first mod was Lemoniado Mod, it added
		different sprites and dialogues to the songs, and
		originally it was made in Kade Mod Tool, a
		modification of kade engine wich makes
		easier the process of making mods (like
		Psych Engine now).
		I am from argentina, and i like very much GD,
		Rhythm Doctor and Sonic Games.
		Usually i listen to the Nirvana or Green Day's
		music", 62);
		daDescTxt.size = 62;
		daDescTxt.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(daDescTxt);

		daDescTxt = new FlxText(800, 600, 0, "Press UP to see about\nthe Mod", 24);
		add(daDescTxt);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.BACK)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new StartState());
			}
		
		if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				MusicBeatState.switchState(new AboutState());
			}
	}
}
