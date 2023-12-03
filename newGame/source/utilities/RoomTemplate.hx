package utilities;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;

/**
 * RoomTemplates class manages the loading and storing of different room layouts.
 */
class RoomTemplates
{
	// An array to store the data of each room, including its type and tilemap.
	public static var rooms:Array<RoomData>;

	/**
	 * Initializes the rooms array and loads room data from a CSV file.
	 */
	public static function init():Void
	{
		// Initialize the rooms array to ensure it's empty before loading new data.
		rooms = [];

		// Load room data from a specified CSV file.
		loadRoomsFromCSV("assets/maps/rooms.csv");
	}

	/**
	 * Loads room layouts and their metadata from a CSV file.
	 * @param csvPath The path to the CSV file containing room data.
	 */
	private static function loadRoomsFromCSV(csvPath:String):Void
	{
		// Create a FlxText object to load and handle the CSV text
		var csvText:FlxText = new FlxText(0, 0, 0, "");
		csvText.loadGraphic(csvPath);

		var data:String = csvText.text;
		var lines:Array<String> = data.split("\n");

		// Temporary storage for accumulating lines for a single room.
		var currentRoom:Array<String> = [];
		// Temporarily stores the room type metadata.
		var roomType:String = "";
		for (line in lines)
		{
			// Check if the line is a metadata or delimiter.
			if (StringTools.startsWith(line, "#"))
			{
				// Process delimiter to finalize the current room.
				if (line == "#Delimiter")
				{
					if (currentRoom.length > 0)
					{
						rooms.push(new RoomData(roomType, createRoomFromLines(currentRoom)));
						// Reset for the next room.
						currentRoom = [];
						roomType = "";
					}
				}
				else if (StringTools.startsWith(line, "#RType:"))
				{
					// Extract room type from metadata.
					roomType = line.substr(7); // Remove '#RType:' prefix.
				}
			}
			else
			{
				// Accumulate room layout lines.
				currentRoom.push(line);
			}
		}

		// Add the last room if it exists.
		if (currentRoom.length > 0)
		{
			rooms.push(new RoomData(roomType, createRoomFromLines(currentRoom)));
		}
	}

	/**
	 * Creates a FlxTilemap from an array of string lines representing the room layout.
	 * @param lines The array of strings, each representing a line in the room's tilemap.
	 * @return The constructed FlxTilemap.
	 */
	private static function createRoomFromLines(lines:Array<String>):FlxTilemap
	{
		// Initialize a new tilemap for the room.
		var room:FlxTilemap = new FlxTilemap();
		// Convert the array of lines back into a single CSV string.
		var csv:String = lines.join("\n");
		// Load the tilemap from the CSV string.
		room.loadMapFromCSV(csv, FlxG.bitmap.add("assets/images/tileset.png"), 16, 16);
		return room;
	}
}

/**
 * RoomData class holds the metadata and the tilemap of a room.
 */
class RoomData
{
	// The type of the room as defined in the CSV file.
	public var rType:String;
	// The tilemap of the room.
	public var map:FlxTilemap;

	/**
	 * Constructor for RoomData.
	 * @param rType The type of the room.
	 * @param map The tilemap of the room.
	 */
	public function new(rType:String, map:FlxTilemap)
	{
		this.rType = rType;
		this.map = map;
	}
}
