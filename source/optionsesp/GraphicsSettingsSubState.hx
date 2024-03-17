package optionsesp;

import objects.Character;
import openfl.Lib;

class GraphicsSettingsSubState extends BaseOptionsMenu
{
	var antialiasingOption:Int;
	var boyfriend:Character = null;
	public function new()
	{
		title = 'Gráficos';
		rpcTitle = 'Menú de Opciones de Gráficos'; //for Discord Rich Presence

		boyfriend = new Character(840, 170, 'bf', true);
		boyfriend.setGraphicSize(Std.int(boyfriend.width * 0.75));
		boyfriend.updateHitbox();
		boyfriend.dance();
		boyfriend.animation.finishCallback = function (name:String) boyfriend.dance();
		boyfriend.visible = false;

		//Sugiero usar "Calidad Baja" para hacer tu propia opción si no sabés como, ya que ess la más simple aqui
		var option:Option = new Option('Calidad Baja', //Nombre
			'Si se marca, desactiva algunos detalles,\nbaja los tiempos de carga y aumenta el Rendimiento.', //Descripción
			'lowQuality', //Nombre del guardado de datos de la Variable
			'bool'); //Tipo de Variable
		addOption(option);

		var option:Option = new Option('Preload',
			'Si se marca, se activa el Preload. Para hacerlo funcionar reinicia el juego.\n No lo actives si tienes una mala pc',
			'preload',
			'bool');
		//addOption(option);

		var option:Option = new Option('Pantalla Completa',
			'Si se marca, el juego estará en pantalla completa. Esta un poco Bugueado, así que cuidado.',
			'fullScreen',
			'bool');
			option.onChange = onChangeFullScreen;
		addOption(option);

		var option:Option = new Option('Anti-Aliasing',
			'Si se desmarca, desactiva el Anti-Aliasing, Aumenta el rendimiento\ncon el costo de visuales mucho menos suavizados.',
			'antialiasing',
			'bool');
		option.onChange = onChangeAntiAliasing; //Cambiando onChange solo es necesario si quieres una interacción después de cambiar el valor
		addOption(option);
		antialiasingOption = optionsArray.length-1;

		var option:Option = new Option('Shaders', //Nombre
			"Si se desmarca, desactiva los Shaders.\nSe usa para algunos efectos visuales, tambien usa mucho el CPU en PCs lentas.", //Descripción
			'shaders',
			'bool');
		addOption(option);

		var option:Option = new Option('GPU en Caché', //Nombre
			"Si se marca, le permite a la GPU almacenar las texturas en caché, Bajando el uso de la RAM.\nNo lo actives si tienes una mala GPU.", //Descripcion
			'cacheOnGPU',
			'bool');
		addOption(option);

		#if !html5 //Aparentemente otros fps máximos no son soportados en navegador? probablemente es alguna cosa de el V-Sync puesta por defecto
		var option:Option = new Option('FPS Máximos',
			"Se explica solo ¿No?",
			'framerate',
			'int');
		addOption(option);

		final refreshRate:Int = FlxG.stage.application.window.displayMode.refreshRate;
		option.minValue = 60;
		option.maxValue = 240;
		option.defaultValue = Std.int(FlxMath.bound(refreshRate, option.minValue, option.maxValue));
		option.displayFormat = '%v FPS';
		option.onChange = onChangeFramerate;
		#end

		super();
		insert(1, boyfriend);
	}

	function onChangeAntiAliasing()
	{
		for (sprite in members)
		{
			var sprite:FlxSprite = cast sprite;
			if(sprite != null && (sprite is FlxSprite) && !(sprite is FlxText)) {
				sprite.antialiasing = ClientPrefs.data.antialiasing;
			}
		}
	}
	
	function onChangeFullScreen()
		{
			Lib.application.window.maximized = false;
			FlxG.fullscreen = ClientPrefs.data.fullScreen;
		}

	function onChangeFramerate()
	{
		if(ClientPrefs.data.framerate > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = ClientPrefs.data.framerate;
			FlxG.drawFramerate = ClientPrefs.data.framerate;
		}
		else
		{
			FlxG.drawFramerate = ClientPrefs.data.framerate;
			FlxG.updateFramerate = ClientPrefs.data.framerate;
		}
	}

	override function changeSelection(change:Int = 0)
	{
		super.changeSelection(change);
		boyfriend.visible = (antialiasingOption == curSelected);
	}
}