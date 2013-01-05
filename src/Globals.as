package  
{
	/**
	 * ...
	 * @author Amb054
	 */
	public class Globals 
	{
		//Menus
		//[Embed(source = 'IMG/Menu/StartButton.png')] static public var StartButton:Class;
		
		static public var TILE_SIZE:int = 64;
		
		[Embed(source = 'IMG/Menu/Mouse.png')] static public var Mouse:Class;
		
		//Tiles
		[Embed(source = 'IMG/Tiles/Tiles.png')] static public var Tiles:Class;
		
		//Sprites
		[Embed(source = 'IMG/Sprites/Player.png')] static public var Player:Class;
		
		//Maps
		[Embed(source = 'Maps/Test/Test.txt', mimeType = "application/octet-stream")] static public var TestMap:Class;
	}

}