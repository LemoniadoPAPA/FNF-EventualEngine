package optionsesp;

class GameplaySettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Opciones del Gameplay';
		rpcTitle = 'Menú de Opciones de Gameplay'; //Para la Rich Presence de Discord

		//Sugiero usar "Downscroll" para crear tu propia opción si no tenés mucha idea, ya que es la más simple aqui
		var option:Option = new Option('Downscroll', //Nombre
			'Si se marca, las notas irán hacia abajo en vez de hacia arriba, muy simple.', //Descripción
			'downScroll', //Nombre del guardado de datos de la Variable
			'bool'); //Tipo de variable
		addOption(option);

		var option:Option = new Option('Middlescroll',
			'Si se marca, las notas se centrarán.',
			'middleScroll',
			'bool');
		addOption(option);

		var option:Option = new Option('Notas del Oponente',
			'Si se desmarca, las Notas del Oponente se Ocultarán.',
			'opponentStrums',
			'bool');
		addOption(option);

		var option:Option = new Option('Ghost Tapping',
			"Si se marca, no recibirás fallos cuando toques teclas\ncuando no hayan notas que presionar.",
			'ghostTapping',
			'bool');
		addOption(option);
		
		var option:Option = new Option('Auto Pausa',
			"Si se marca, el juego se pausará automáticamente si la ventana no está enfocada.",
			'autoPause',
			'bool');
		addOption(option);
		option.onChange = onChangeAutoPause;

		var option:Option = new Option('Desactivar botón de Reiniciar',
			"Si se marca, presionando Reiniciar no hará nada.",
			'noReset',
			'bool');
		addOption(option);

		var option:Option = new Option('Volúmen del Hitsound',
			'Las notas no harán un sonido de \"Tick!\" cuando las presionas.',
			'hitsoundVolume',
			'percent');
		addOption(option);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		option.onChange = onChangeHitsoundVolume;

		var option:Option = new Option('Offset del Rating',
			'Cambia que tan tarde/temprano tienes que presionar para conseguir un "Sick!"\nValores más altos significan que tienes que presionar más tarde.',
			'ratingOffset',
			'int');
		option.displayFormat = '%vms';
		option.scrollSpeed = 20;
		option.minValue = -30;
		option.maxValue = 30;
		addOption(option);

		var option:Option = new Option('Ventana del Sick!',
			'Cambia el tiempo que tienes para\nconseguir un "Sick!"en Milisegundos.',
			'sickWindow',
			'int');
		option.displayFormat = '%vms';
		option.scrollSpeed = 15;
		option.minValue = 15;
		option.maxValue = 45;
		addOption(option);

		var option:Option = new Option('Ventana del Good',
			'Cambia el tiempo que tienes para\nconseguir un "Good!"en Milisegundos.',
			'goodWindow',
			'int');
		option.displayFormat = '%vms';
		option.scrollSpeed = 30;
		option.minValue = 15;
		option.maxValue = 90;
		addOption(option);

		var option:Option = new Option('Ventana del Bad',
			'Cambia el tiempo que tienes para\nconseguir un "Bad!"en Milisegundos..',
			'badWindow',
			'int');
		option.displayFormat = '%vms';
		option.scrollSpeed = 60;
		option.minValue = 15;
		option.maxValue = 135;
		addOption(option);

		var option:Option = new Option('Safe Frames',
			'Cambia que tantoss Frames tienes para\npresionar una nota más temprano/tarde.',
			'safeFrames',
			'float');
		option.scrollSpeed = 5;
		option.minValue = 2;
		option.maxValue = 10;
		option.changeValue = 0.1;
		addOption(option);

		var option:Option = new Option('Notas largas como una',
			"Si se marca, las notas largas no se pueden presionar si las fallas,\ny cuentan como un solo acierto/fallo.\nDesmarca esto si prefieres el sistema de antes.",
			'guitarHeroSustains',
			'bool');
		addOption(option);

		super();
	}

	function onChangeHitsoundVolume()
		FlxG.sound.play(Paths.sound('hitsound'), ClientPrefs.data.hitsoundVolume);

	function onChangeAutoPause()
		FlxG.autoPause = ClientPrefs.data.autoPause;
}