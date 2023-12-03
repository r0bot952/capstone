package states;

import flash.system.System;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	private var playButton:FlxButton;
	private var quitButton:FlxButton;

	override public function create():Void
	{
		// Create the "Play" button
		playButton = new FlxButton(0, 0, "Start", clickPlay);
		playButton.setGraphicSize(200, 60); // Set the button size (width and height)
		playButton.screenCenter(); // Center the button on the screen
		add(playButton);

		// Create the "Quit" button
		quitButton = new FlxButton(0, 0, "Quit", clickQuit);
		quitButton.setGraphicSize(200, 60);
		quitButton.screenCenter(); // Center the button on the screen
		quitButton.y += playButton.height + 40; // Position it below the "Start" button
		add(quitButton);
	}

	private function clickPlay():Void
	{
		// Switch to the PlayState when the "Start" button is clicked
		FlxG.switchState(new PlayState());
	}

	private function clickQuit():Void
	{
		System.exit(0);
	}
}
