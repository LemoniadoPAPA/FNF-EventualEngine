package optionsesp;

import states.MainMenuState;
import states.MainMenuStateClassic;
import states.StartState;
import backend.StageData;

class OptionsState extends MusicBeatState
{
	var options:Array<String> = ['Colores de las Notas', 'Controles', 'Ajustar Delay y Combo', 'Gráficos', 'Visuales y UI', 'Gameplay'];
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;
	public static var onPlayState:Bool = false;
	public static var onMainMenuState:Bool = false;

	function openSelectedSubstate(label:String) {
		switch(label) {
			case 'Colores de las Notas':
				openSubState(new optionsesp.NotesSubState());
			case 'Controles':
				openSubState(new optionsesp.ControlsSubState());
			case 'Gráficos':
				openSubState(new optionsesp.GraphicsSettingsSubState());
			case 'Visuales y UI':
				openSubState(new optionsesp.VisualsUISubState());
			case 'Gameplay':
				openSubState(new optionsesp.GameplaySettingsSubState());
			case 'Ajustar Delay y Combo':
				MusicBeatState.switchState(new optionsesp.NoteOffsetState());
		}
	}

	var selectorLeft:Alphabet;
	var selectorRight:Alphabet;

	override function create() {
		#if DISCORD_ALLOWED
		DiscordClient.changePresence("Menú de Opciones", null);
		#end

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.color = 0xFFea71fd;
		bg.updateHitbox();

		bg.screenCenter();
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, 0, options[i], true);
			optionText.screenCenter();
			optionText.y += (100 * (i - (options.length / 2))) + 50;
			grpOptions.add(optionText);
		}

		selectorLeft = new Alphabet(0, 0, '>', true);
		add(selectorLeft);
		selectorRight = new Alphabet(0, 0, '<', true);
		add(selectorRight);

		changeSelection();
		ClientPrefs.saveSettings();

		super.create();
	}

	override function closeSubState() {
		super.closeSubState();
		ClientPrefs.saveSettings();
		#if DISCORD_ALLOWED
		DiscordClient.changePresence("Menú de Opciones", null);
		#end
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (controls.UI_UP_P) {
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P) {
			changeSelection(1);
		}

		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			if(onPlayState)
				{
					StageData.loadDirectory(PlayState.SONG);
					LoadingState.loadAndSwitchState(new PlayState());
					FlxG.sound.music.volume = 0;
				}
			else
			if(onMainMenuState)
				switch(ClientPrefs.data.menuType) {
					case 'Classic':
						MusicBeatState.switchState(new MainMenuStateClassic());
					default:
						MusicBeatState.switchState(new MainMenuState());
				}
			else
				MusicBeatState.switchState(new StartState());
		}
		else if (controls.ACCEPT) openSelectedSubstate(options[curSelected]);
	}
	
	function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
				selectorLeft.x = item.x - 63;
				selectorLeft.y = item.y;
				selectorRight.x = item.x + item.width + 15;
				selectorRight.y = item.y;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	override function destroy()
	{
		ClientPrefs.loadPrefs();
		super.destroy();
	}
}