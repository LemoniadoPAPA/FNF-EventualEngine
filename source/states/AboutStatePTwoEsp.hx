package states;

import flixel.FlxState;
import flixel.text.FlxText;

class AboutStatePTwoEsp extends MusicBeatState
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

		daDescTxt = new FlxText(800, 60, 0, "Mi nombre es Lemoniado, empecé
		empecé a jugar FNF en febrero de 2021,
		quise empezar a hacer mods en Agosto de
		ese mismo año y publiqué mi primer
		mod en Octubre
		Mi primer grán mod fue Lemoniado Mod, añadía
		diferentes Sprites y cambiab algunos charts.
		Originalmente estaba hecho en Kade Mod Tool, 
		Una modificación de Kade Engine que hacía
		mucho más fácil y accesible crear mods (como
		Psych Engine Ahora).
		Soy de Argentina, me gusta mucho GD,
		Rhythm Doctor y los juegos de Sonic.
		Usualmente escucho la música de Nirvana
		o de Green Day", 62);
		daDescTxt.size = 62;
		daDescTxt.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(daDescTxt);

		daDescTxt = new FlxText(800, 600, 0, "Presiona Arriba para\nver sobre el mod", 24);
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
