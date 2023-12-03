package entities;

import entities.Bullet;
import flixel.FlxG;
import flixel.sound.FlxSound;

class Gun
{
	public var damage:Int;
	public var bulletSpeed:Float;
	public var range:Float;
	public var bulletSize:Float;
	public var maxAmmo:Int;
	public var currentAmmo:Int;
	public var reloadTime:Float;
	public var shootSpeed:Float;
	public var gunshotSound:FlxSound;

	public function new()
	{
		// Initialize gun properties with default values
		damage = 100;
		bulletSpeed = 400;
		range = 200;
		bulletSize = 4;
		maxAmmo = 6; // Set the maximum ammo count
		currentAmmo = maxAmmo; // Start with full ammo
		reloadTime = 3.0; // Set the reload time in seconds (adjust as needed)
		shootSpeed = 0;

		// loading sound effects
		gunshotSound = new FlxSound();
		gunshotSound.loadEmbedded("assets/sounds/gunshot.wav"); // Corrected path
		// ^ This line will load and embed the "gunshot.wav" file from your assets folder.
	}

	public function shoot(x:Float, y:Float, targetX:Float, targetY:Float):Bullet
	{
		// Check if there's enough time since the last shot and if there's ammo
		if (currentAmmo > 0)
		{
			// Check if the sound is not playing to avoid overlapping sounds
			if (!gunshotSound.active)
			{
				// Create a new bullet using the Bullet class
				var bullet:Bullet = new Bullet(x, y, damage, range);

				// Set the bullet's velocity towards the target point (where the player was aiming)
				bullet.setVelocityTowards(targetX, targetY, bulletSpeed);

				// Play the sound effect
				gunshotSound.play();

				// Reduce ammo count
				currentAmmo--;

				// Add the bullet to the game state (this displays it on the screen)
				FlxG.state.add(bullet);

				// Reset the timer
				shootSpeed = 0;

				// Return the created bullet
				return bullet;
			}
		}
		else if (currentAmmo == 0)
		{
			// Reloading logic (if ammo is depleted)
			shootSpeed = 0;
			currentAmmo = maxAmmo; // Refill the magazine
		}

		// Return null if not ready to shoot
		return null;
	}
}
