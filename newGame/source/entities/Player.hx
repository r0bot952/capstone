package entities;

import entities.Gun;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	public var speed:Float;
	public var gun:Gun; // Gun class to be defined
	public var meleeDamage:Int;
	public var inventory:Array<Item>; // Item class to be defined

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		makeGraphic(16, 16, FlxColor.BLUE);

		// Set default values
		health = 100;
		speed = 200;
		gun = new Gun(); // Create a default gun
		meleeDamage = 10;
		inventory = new Array<Item>();

		// Set drag to slow down the player
		drag.x = drag.y = 800;
	}

	// Add functions to handle shooting, melee attacks, and inventory management
	public function getAimAngle():Float
	{
		// Get the player's position
		var playerX:Float = x + width / 2;
		var playerY:Float = y + height / 2;

		// Get the mouse pointer's position
		var mousePointerX:Float = FlxG.mouse.getWorldPosition().x;
		var mousePointerY:Float = FlxG.mouse.getWorldPosition().y;

		// Calculate the angle between the player and the mouse pointer
		var angle:Float = Math.atan2(mousePointerY - playerY, mousePointerX - playerX);

		return angle;
	}

	public function meleeAttack():Void
	{
		// Implement melee attack logic
	}

	public function addToInventory(item:Item):Void
	{
		inventory.push(item);
	}

	function updateMovement():Void
	{
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;

		// Check which keys are pressed
		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);

		// Cancel out opposing directions
		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;

		if (up || down || left || right)
		{
			// Determine the angle of movement
			var newAngle:Float = 0;
			if (up)
			{
				newAngle = -90;
				if (left)
					newAngle -= 45;
				else if (right)
					newAngle += 45;
			}
			else if (down)
			{
				newAngle = 90;
				if (left)
					newAngle += 45;
				else if (right)
					newAngle -= 45;
			}
			else if (left)
				newAngle = 180;
			else if (right)
				newAngle = 0;

			// Set the player's velocity based on angle and speed
			velocity.setPolarDegrees(speed, newAngle);
		}
		else
		{
			// Stop the player if no movement keys are pressed
			velocity.x = velocity.y = 0;
		}
	}

	public function handleInput():Void
	{
		// Check for mouse click to trigger shooting
		if (FlxG.mouse.justPressed)
		{
			gun.shoot(x + width / 2, y + height / 2, FlxG.mouse.getWorldPosition().x, FlxG.mouse.getWorldPosition().y);
		}
		// Handle other input, such as melee attacks or inventory management here
	}

	override function update(elapsed:Float):Void
	{
		updateMovement(); // Handle player movement
		handleInput(); // Handle input events

		super.update(elapsed);
	}
}
