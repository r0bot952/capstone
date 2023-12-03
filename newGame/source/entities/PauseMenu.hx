package entities;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.text.FlxText;

class PauseMenu extends FlxGroup
{
	public function new()
	{
		super();

		// Create menu options
		var resumeText = new FlxText(0, 100, FlxG.width, "Resume");
		var settingsText = new FlxText(0, 150, FlxG.width, "Settings");
		var quitText = new FlxText(0, 200, FlxG.width, "Quit to Menu");

		resumeText.setFormat(null, 16, 0xFFFFFF, "center");
		settingsText.setFormat(null, 16, 0xFFFFFF, "center");
		quitText.setFormat(null, 16, 0xFFFFFF, "center");

		// Add menu options to the group
		add(resumeText);
		add(settingsText);
		add(quitText);

		// Set initial visibility to false
		visible = false;
	}
}
