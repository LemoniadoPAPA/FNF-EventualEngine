package;

import flixel.FlxState;
import flixel.util.FlxTimer;
import states.TitleState;

class Start extends FlxState
{
	var timer:FlxTimer;

	override public function create()
	{
		super.create();

		timer = new FlxTimer().start(0.1, function(tmr:FlxTimer)
			{
				MusicBeatState.switchState(new TitleState());
			});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
