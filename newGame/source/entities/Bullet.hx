package entities;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Bullet extends FlxSprite
{
	public var damage:Int;
	public var range:Float;

	private var initialX:Float;
	private var initialY:Float;

	public function new(x:Float, y:Float, damage:Int, range:Float)
	{
		super(x, y);

		// Set bullet appearance and size (replace with your bullet sprite)
		loadGraphic("assets/images/bullet_blob.png"); // Example: Load a blob image

		// Set bullet properties
		this.damage = damage;
		this.range = range;

		initialX = x; // Store the initial x position
		initialY = y; // Store the initial y position

		// Set the initial velocity to zero
		velocity.x = 0;
		velocity.y = 0;
	}

	// Update the bullet's velocity to move towards a target point
	public function setVelocityTowards(targetX:Float, targetY:Float, speed:Float):Void
	{
		var direction:FlxPoint = new FlxPoint(targetX - x, targetY - y);
		direction.normalize();
		velocity.x = direction.x * speed;
		velocity.y = direction.y * speed;

		updateRotation(); // Call the new function to update the sprite's rotation
	}

	// Update the sprite's rotation based on its velocity
	private function updateRotation():Void
	{
		angle = Math.atan2(velocity.y, velocity.x);

		// Flip the sprite horizontally if shooting to the right
		if (velocity.x > 0)
		{
			setFacingFlip(RIGHT, false, true);
		}
		else
		{
			scale.x = 1; // Reset the sprite's scale if shooting to the left
		}
	}

	public function hitObject(Contact:FlxObject, Velocity:FlxPoint):Bool
	{
		// Implement collision behavior here
		return true;
	}

	private function distanceTraveled():Float
	{
		// Calculate the distance traveled by the bullet
		var distanceX:Float = x - initialX;
		var distanceY:Float = y - initialY;
		return Math.sqrt(distanceX * distanceX + distanceY * distanceY);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		// Check if the bullet has traveled its maximum range
		if (distanceTraveled() >= range)
		{
			// If it has, remove the bullet
			kill();
		}
	}
}
