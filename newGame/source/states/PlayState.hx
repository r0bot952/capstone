package states;

import entities.Player;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	var player:Player;
	var guiBar:FlxSprite;
	var healthText:FlxText;
	var ammoText:FlxText;
	var guiGroup:FlxGroup;
	var leftBoundary:FlxObject;
	var rightBoundary:FlxObject;
	var topBoundary:FlxObject; // Add a top boundary

	override public function create():Void
	{
		super.create();

		var screenWidth:Int = Std.int(FlxG.width);
		var screenHeight:Int = Std.int(FlxG.height);

		var playerSize:Float = 16;
		var startX:Float = (screenWidth - playerSize) / 2;
		var startY:Float = (screenHeight - playerSize) / 2;

		// Create a gray GUI bar at the bottom
		var barHeight:Int = 50;
		guiBar = new FlxSprite(0, screenHeight - barHeight);
		guiBar.makeGraphic(screenWidth, barHeight, 0xFF808080);
		guiBar.immovable = true;
		add(guiBar);

		// Create boundaries for the screen edges
		leftBoundary = new FlxObject(0, 0, 1, screenHeight);
		leftBoundary.immovable = true;
		rightBoundary = new FlxObject(screenWidth - 1, 0, 1, screenHeight);
		rightBoundary.immovable = true;
		topBoundary = new FlxObject(0, 0, screenWidth, 1); // Add a top boundary
		topBoundary.immovable = true;
		add(leftBoundary);
		add(rightBoundary);
		add(topBoundary); // Add the top boundary

		guiGroup = new FlxGroup();
		add(guiGroup);

		player = new Player(startX, startY);
		add(player);

		var textY:Int = Std.int(screenHeight - barHeight + 10);
		healthText = new FlxText(10, textY, "Health: " + player.health);
		ammoText = new FlxText(screenWidth - 120, textY, "Ammo: " + player.gun.currentAmmo + " / " + player.gun.maxAmmo);
		healthText.setFormat(null, 16, 0xFFFFFF, "left");
		ammoText.setFormat(null, 16, 0xFFFFFF, "right");
		guiGroup.add(healthText);
		guiGroup.add(ammoText);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		// Check for collisions with boundaries
		FlxG.collide(player, guiBar);
		FlxG.collide(player, leftBoundary);
		FlxG.collide(player, rightBoundary);
		FlxG.collide(player, topBoundary); // Check for collisions with the top boundary

		// Update the health and ammo text
		healthText.text = "Health: " + player.health;
		ammoText.text = "Ammo: " + player.gun.currentAmmo + " / " + player.gun.maxAmmo;
	}
}
