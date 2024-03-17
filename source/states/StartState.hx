package states;

import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import states.editors.MasterEditorMenu;
import optionsesp.OptionsState;
import optionseng.OptionsState;

import flixel.addons.display.FlxBackdrop;

class StartState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.7.3';
	public static var eventualEngineVersion:String = '1.0'; // This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var checker:FlxBackdrop = new FlxBackdrop(Paths.image('coso'));
	var side:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('sidetwo'));
	var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat')); //Don't use the another var bg
	var menuItemX:Int = 110;
	var menuItemAngle:Float = 0; //Unused

	var menuItems:FlxTypedGroup<FlxSprite>;

	var optionShit:Array<String> = [
		'play',
		#if MODS_ALLOWED 'about', #end
		'credits',
		#if !switch 'donate', #end
		#if ACHIEVEMENTS_ALLOWED 'awards', #end
		'options',
		'exit',
	];

	var magenta:FlxSprite;
	var camFollow:FlxObject;

	override function create()
	{
		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		//var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG')); //Go to the other var bg
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.scrollFactor.set(0, yScroll);
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.color = 0xff00ffea;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.antialiasing = ClientPrefs.data.antialiasing;
		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.color = 0xFFfd719b;
		add(magenta);

		add(checker);
		checker.scrollFactor.set(0, 0.07);

		side.scrollFactor.x = 0;
		side.scrollFactor.y = 0;
		//side.scrollFactor.set(0, yScroll);
		side.height = 3;
		side.antialiasing = true;
		add(side);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var enter:FlxSprite;
		enter = new FlxSprite(950,590);
		enter.loadGraphic(Paths.image('enter' + FlxG.random.int(0, 1)));
		enter.scrollFactor.set(0, 0);
		enter.setGraphicSize(Std.int(enter.width * 1));
		enter.antialiasing = ClientPrefs.data.antialiasing;
		add(enter);

		var escape:FlxSprite;
		escape = new FlxSprite(950,490);
		escape.loadGraphic(Paths.image('escape' + FlxG.random.int(0, 1)));
		escape.scrollFactor.set(0, 0);
		escape.setGraphicSize(Std.int(escape.width * 1));
		escape.antialiasing = ClientPrefs.data.antialiasing;
		add(escape);

		var debug:FlxSprite;
		debug = new FlxSprite(950,390);
		debug.loadGraphic(Paths.image('debug' + FlxG.random.int(0, 1)));
		debug.scrollFactor.set(0, 0);
		debug.setGraphicSize(Std.int(debug.width * 1));
		debug.antialiasing = ClientPrefs.data.antialiasing;
		add(debug);

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140) + offset);
			menuItem.antialiasing = ClientPrefs.data.antialiasing;
			menuItem.frames = Paths.getSparrowAtlas('startmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if (optionShit.length < 6)
				scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.updateHitbox();
			//menuItem.screenCenter(X);
			menuItem.x = menuItemX;
			//menuItem.angle = -7;
		
			switch(i)
			{
				//case 0: //Play, uses default, do not uncomment
					//shitty values
				case 1: //About
					menuItem.x = menuItemX + 75;
				case 2: //Credits
					menuItem.x = menuItemX + 150;
				case 3: //Donate
					menuItem.x = menuItemX + 225;
				case 4: //Awards
					menuItem.x = menuItemX + 300;
				case 5: //Options
					menuItem.x = menuItemX + 300;
				case 6: //Exit
					menuItem.x = menuItemX + 475;
			}
		}

		var eventualVer:FlxText = new FlxText(12, FlxG.height - 64, 0, "Eventual Engine v" + eventualEngineVersion, 12);
		eventualVer.scrollFactor.set();
		eventualVer.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(eventualVer);
		var psychVer:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		psychVer.scrollFactor.set();
		psychVer.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(psychVer);
		var fnfVer:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		fnfVer.scrollFactor.set();
		fnfVer.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(fnfVer);
		changeItem();

		/*function getIntroTextShit():Array<Array<String>>
			{
				#if MODS_ALLOWED
				var firstArray:Array<String> = Mods.mergeAllTextsNamed('data/randomMenuTxt.txt', Paths.getPreloadPath());
				#else
				var fullText:String = Assets.getText(Paths.txt('randomMenuTxt'));
				var firstArray:Array<String> = fullText.split('\n');
				#end
				var swagGoodArray:Array<Array<String>> = [];
		
				for (i in firstArray)
				{
					swagGoodArray.push(i.split('--'));
				}
		
				return swagGoodArray;
			}*/

		#if ACHIEVEMENTS_ALLOWED
		// Unlocks "Freaky on a Friday Night" achievement if it's a Friday and between 18:00 PM and 23:59 PM
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18)
			Achievements.unlock('friday_night_play');

		#if MODS_ALLOWED
		Achievements.reloadList();
		#end
		#end

		super.create();

		FlxG.camera.follow(camFollow, null, 9);
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		checker.x += .5*(elapsed/(1/120));
		checker.y -= 0.16 / (ClientPrefs.data.framerate / 60); 
		
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * elapsed;
			if (FreeplayState.vocals != null)
				FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
				changeItem(-1);

			if (controls.UI_DOWN_P)
				changeItem(1);

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else if (optionShit[curSelected] == 'exit')
				{
					menuItems.forEach(function(spr:FlxSprite)
					{
						FlxTween.tween(spr, {alpha: 0}, 1.3, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween)
							{
								spr.kill();
								Sys.exit(0); //Don't worry if this gives you a error, it doesn't affect
											 //No te preocupes si esto te da un error, no afecta en nada
							}
						});
					});
					FlxG.camera.fade(FlxColor.BLACK, 1.3, false);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(4, 1.3);
				}
				else
				{
					selectedSomethin = true;

					if (ClientPrefs.data.flashing)
						FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					FlxFlicker.flicker(menuItems.members[curSelected], 1, 0.06, false, false, function(flick:FlxFlicker)
					{
						switch (optionShit[curSelected])
						{
							case 'play':
								if(ClientPrefs.data.menuType != 'Classic')
									MusicBeatState.switchState(new MainMenuState());
									
								else
									MusicBeatState.switchState(new MainMenuStateClassic());
							case 'credits':
								CreditsState.inMainMenuState = false;
								CreditsStateEspanol.inMainMenuState = false;
								if(ClientPrefs.data.language != 'English')
									MusicBeatState.switchState(new CreditsStateEspanol());
								else
									MusicBeatState.switchState(new CreditsState());
									
							case 'about':
								if(ClientPrefs.data.language != 'English')
									MusicBeatState.switchState(new AboutStateEsp());
								else
									MusicBeatState.switchState(new AboutState());
							#if ACHIEVEMENTS_ALLOWED
							case 'awards':
								MusicBeatState.switchState(new AchievementsMenuState());
							#end
							case 'options':
								if(ClientPrefs.data.language != 'English')
									LoadingState.loadAndSwitchState(new optionsesp.OptionsState());	
								else
									LoadingState.loadAndSwitchState(new optionseng.OptionsState());
								OptionsState.onPlayState = false;
								OptionsState.onMainMenuState = false;
								if (PlayState.SONG != null)
								{
									PlayState.SONG.arrowSkin = null;
									PlayState.SONG.splashSkin = null;
									PlayState.stageUI = 'normal';
								}
						}
					});

					for (i in 0...menuItems.members.length)
					{
						if (i == curSelected)
							continue;
						FlxTween.tween(menuItems.members[i], {alpha: 0}, 0.4, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween)
							{
								menuItems.members[i].kill();
							}
						});
					}
				}
			}
			#if desktop
			if (controls.justPressed('debug_1'))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
			{
				//spr.screenCenter(X);
	
				checker.x -= 0.45 / (ClientPrefs.data.framerate / 60);
				checker.y -= 0.16 / (ClientPrefs.data.framerate / 60);
			});
	}

	function changeItem(huh:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'));
		menuItems.members[curSelected].animation.play('idle');
		menuItems.members[curSelected].updateHitbox();
		//menuItems.members[curSelected].screenCenter(X);

		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.members[curSelected].animation.play('selected');
		menuItems.members[curSelected].centerOffsets();
		//menuItems.members[curSelected].screenCenter(X);

		camFollow.setPosition(menuItems.members[curSelected].getGraphicMidpoint().x,
			menuItems.members[curSelected].getGraphicMidpoint().y - (menuItems.length > 4 ? menuItems.length * 8 : 0));
	}
}
