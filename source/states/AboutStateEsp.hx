package states;

import flixel.FlxState;
import flixel.text.FlxText;

class AboutStateEsp extends MusicBeatState
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

		daDescTxt = new FlxText(800, 60, 0, "Eventual Engine es un Mod/Engine
		hecho por Lemoniado Endemoniado,
		esta enfocado en añadir Nuevos 
		Eventos y efectos visuales.
		Antes se llamaba
		Another Psych 
		Engine Fork(APEF).
		En el pasado, el mod estaba
		hecho en PE 0.6.3 y 0.7.0,
		ahora está en PE 0.7.3.
		Si quieres, puedes ir a  
		los archivos o al código
		fuente para ver cosas sin usar", 54);
		daDescTxt.size = 54;
		daDescTxt.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(daDescTxt);

		daDescTxt = new FlxText(800, 600, 0, "Presiona ABAJO para\n ver sobre el creador", 24);
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

		if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				MusicBeatState.switchState(new AboutStatePTwoEsp());
			}
	}
}
