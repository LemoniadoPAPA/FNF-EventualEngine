package optionsesp;

import objects.Note;
import objects.StrumNote;
import objects.Alphabet;

class VisualsUISubState extends BaseOptionsMenu
{
	var noteOptionID:Int = -1;
	var notes:FlxTypedGroup<StrumNote>;
	var notesTween:Array<FlxTween> = [];
	var noteY:Float = 90;
	public function new()
	{
		title = 'Visuales y UI';
		rpcTitle = 'Menú de Opciones de Visuales y UI'; //for Discord Rich Presence

		// for note skins
		notes = new FlxTypedGroup<StrumNote>();
		for (i in 0...Note.colArray.length)
		{
			var note:StrumNote = new StrumNote(370 + (560 / Note.colArray.length) * i, -200, i, 0);
			note.centerOffsets();
			note.centerOrigin();
			note.playAnim('static');
			notes.add(note);
		}

		// options

		var noteSkins:Array<String> = Mods.mergeAllTextsNamed('images/noteSkins/list.txt');
		if(noteSkins.length > 0)
		{
			if(!noteSkins.contains(ClientPrefs.data.noteSkin))
				ClientPrefs.data.noteSkin = ClientPrefs.defaultData.noteSkin; //Reset to default if saved noteskin couldnt be found

			noteSkins.insert(0, ClientPrefs.defaultData.noteSkin); //Default skin always comes first
			var option:Option = new Option('Skin de las Notas:',
				"Selecciona tu Skin de Notas de Preferencia.",
				'noteSkin',
				'string',
				noteSkins);
			addOption(option);
			option.onChange = onChangeNoteSkin;
			noteOptionID = optionsArray.length - 1;
		}
		
		var noteSplashes:Array<String> = Mods.mergeAllTextsNamed('images/noteSplashes/list.txt');
		if(noteSplashes.length > 0)
		{
			if(!noteSplashes.contains(ClientPrefs.data.splashSkin))
				ClientPrefs.data.splashSkin = ClientPrefs.defaultData.splashSkin; //Reset to default if saved splashskin couldnt be found

			noteSplashes.insert(0, ClientPrefs.defaultData.splashSkin); //Default skin always comes first
			var option:Option = new Option('Note Splashes:',
				"Selecciona tu Skin de Note Splashes de Preferencia o desactivalo.",
				'splashSkin',
				'string',
				noteSplashes);
			addOption(option);
		}

		var option:Option = new Option('Opacidad de Note Splashes',
			'Que tan transparentes deberían ser los Note Splashes.',
			'splashAlpha',
			'percent');
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);

		/*var option:Option = new Option('Estilo de Barra de Tiempo:',
			"Que estilo usarías?",
			'timeBarStyle',
			'string',
			['Eventual', 'Psych', 'Kade']);
		addOption(option);*/

		/*var option:Option = new Option('Barra de Vida:',
			"Que barra de vida se debería mostrar?",
			'healthBarSprite',
			'string',
			['Eventual', 'Default Game']);
		addOption(option);*/

		var option:Option = new Option('Fondos Expandidos',
			'Si se marca, habrá una "Mejora" en algunos fondos.\nLAS MEJORAS PARECEN HECHAS EN PAINT',
			'expandedBG',
			'bool');
		//addOption(option);

		var option:Option = new Option('Datos Extra',
			"Si se desmarca, se ocultarán los Datos Extra como el Combo o el Combo Máximo",
			'judgementCounter',
			'bool');
		addOption(option);

		var option:Option = new Option('Tipo de Rebote de Iconos',
			"Qué tipo de Rebote de Iconos te gusta más?",
			'bounceType',
			'string',
			['New', 'Old', 'Disabled']);
		addOption(option);

		var option:Option = new Option('Fuente de Texto del ScoreTxt:',
			"Que Fuente de Texto se debería mostrar?",
			'scoreFont',
			'string',
			['vcr', 'comic sans', 'pixel']);
		addOption(option);

		var option:Option = new Option('Marca de Agua',
			'Si se desmarca, se ocultará la Marca de Agua.',
			'watermark',
			'bool');
		addOption(option);

		var option:Option = new Option('Ocultar HUD',
			'Si se marca, se ocultarán la mayoría de Elementos de Interfaz.',
			'hideHud',
			'bool');
		addOption(option);
		
		var option:Option = new Option('Barra de Tiempo:',
			"Cuál barra de tiempo se debería de mostrar?",
			'timeBarType',
			'string',
			['Time Left', 'Time Elapsed', 'Song Name', 'Disabled']);
		addOption(option);

		var option:Option = new Option('Luces Flash',
			"Desmarca esto si eres sensible a las Luces Flash!",
			'flashing',
			'bool');
		addOption(option);

		var option:Option = new Option('Zooms de la Cámara',
			"Si se desmarca, no habrá un Zoom en la Cámaraa en cada Latido.",
			'camZooms',
			'bool');
		addOption(option);

		var option:Option = new Option('Zoom al Texto de Puntuación',
			"Si se desmarca, ya no habrá un Zoom en el Texto de Puntuación\ncada vez que presionas una nota.",
			'scoreZoom',
			'bool');
		addOption(option);

		var option:Option = new Option('Opacidad de la Barra de Vida',
			'Que tan transparentes deberían ser la Barra de Vida y los Iconos.',
			'healthBarAlpha',
			'percent');
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);

		var option:Option = new Option('Opacidad del Subrallado de Carril',
			'Que tan transparente debería ser el Subrallado de Carril.',
			'laneUnderlayOpacity',
			'percent');
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		//addOption(option);

		var option:Option = new Option('Subrallado de carril del Oponente:',
		"Solo para el MiddleScroll. Si se marca, el oponente no tendrá el Subrallado de Carril. Añadiré esto para la gente sin MiddleScroll, lo prometo",
		'newRatings',
		'bool',);
		//addOption(option);
		
		#if !mobile
		var option:Option = new Option('Contador de FPS',
			'Si se desmarca, se ocultará el Contador de FPS.',
			'showFPS',
			'bool');
		addOption(option);
		option.onChange = onChangeFPSCounter;
		#end
		
		var option:Option = new Option('Language/Idioma:',
		"What language you speak? / ¿Que idioma hablas?",
		'language',
		'string',
		['English', 'Español']);
		addOption(option);
		//option.onChange = onChangeLanguage;

		var option:Option = new Option('Barra de Vida suave',
			'Si se desmarca, la Barra de Vida no estará suavizada, como en el juego Vanilla.',
			'smoothHealth',
			'bool');
		//addOption(option);

		var option:Option = new Option('Tipo de Menú:',
			"Que Tipo de Menú debería mostrarse?",
			'menuType',
			'string',
			['New', 'Classic', 'Dark'/*, 'Lemoniado Mod'*/]);
		addOption(option);

		var option:Option = new Option('Nuevos Ratings:',
		"Si se marca, lo Ratings serán diferentes (Como en el viejo Lemoniado Mod)",
		'newRatings',
		'bool',);
		//addOption(option);
		
	var option:Option = new Option('Canción de Pausa:',
			"Qué canción prefieres para el Menú de Pausa?",
			'pauseMusic',
			'string',
			['None', 'Breakfast', 'Tea Time']);
		addOption(option);
		option.onChange = onChangePauseMusic;
		
		#if CHECK_FOR_UPDATES
		var option:Option = new Option('Revisar por Actualizaciones',
			'En las Builds Release, activa esto si quieres que siempre se revise por una actualización y te avise.',
			'checkForUpdates',
			'bool');
		addOption(option);
		#end

		#if DISCORD_ALLOWED
		var option:Option = new Option('Discord Rich Presence',
			"Desactiva esto para prevenir Filtraciones Accidentales si haces un Mod, Ocultará el texto de \"Jugando\" en Discord",
			'discordRPC',
			'bool');
		addOption(option);
		#end

		var option:Option = new Option('Agrupación del Combo',
			"Si se desmarca, el Combo y los Ratings no se agruparán guardando Memoria del Sistema y haciéndolos más fáciles de leer",
			'comboStacking',
			'bool');
		addOption(option);

		super();
		add(notes);
	}

	override function changeSelection(change:Int = 0)
	{
		super.changeSelection(change);
		
		if(noteOptionID < 0) return;

		for (i in 0...Note.colArray.length)
		{
			var note:StrumNote = notes.members[i];
			if(notesTween[i] != null) notesTween[i].cancel();
			if(curSelected == noteOptionID)
				notesTween[i] = FlxTween.tween(note, {y: noteY}, Math.abs(note.y / (200 + noteY)) / 3, {ease: FlxEase.quadInOut});
			else
				notesTween[i] = FlxTween.tween(note, {y: -200}, Math.abs(note.y / (200 + noteY)) / 3, {ease: FlxEase.quadInOut});
		}
	}

	var changedMusic:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.data.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.pauseMusic)));

		changedMusic = true;
	}

	/*function onChangeLanguage()
		{
		}*/

	function onChangeNoteSkin()
	{
		notes.forEachAlive(function(note:StrumNote) {
			changeNoteSkin(note);
			note.centerOffsets();
			note.centerOrigin();
		});
	}

	function changeNoteSkin(note:StrumNote)
	{
		var skin:String = Note.defaultNoteSkin;
		var customSkin:String = skin + Note.getNoteSkinPostfix();
		if(Paths.fileExists('images/$customSkin.png', IMAGE)) skin = customSkin;

		note.texture = skin; //Load texture and anims
		note.reloadNote();
		note.playAnim('static');
	}

	override function destroy()
	{
		if(changedMusic && !OptionsState.onPlayState) FlxG.sound.playMusic(Paths.music('freakyMenu'), 1, true);
		super.destroy();
	}

	#if !mobile
	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.data.showFPS;
	}
	#end
}
