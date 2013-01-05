package  
{
	import org.flixel.*;
	public class Globals 
	{
			[Embed(source = "images/menu.png")] static public var menu:Class
			[Embed(source="images/player.png")] static public var player:Class
			[Embed(source = "images/platform.png")] static public var platform:Class
			
			[Embed(source = "images/build.png")] static public var buildings:Class
			[Embed(source = "images/tiles.png")] static public var tiles:Class
			
			[Embed(source = 'Maps/Test/Buildings.txt', mimeType = "application/octet-stream")] static public var BuildMap:Class
			[Embed(source = 'Maps/Test/Tiles.txt' , mimeType = "application/octet-stream")] static public var TileMap:Class
			[Embed(source = 'Maps/Test/Sky.txt', mimeType = "application/octet-stream")] static public var SkyMap:Class
			
			
			
	}

}