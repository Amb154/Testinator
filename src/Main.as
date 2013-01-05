package  
{
	/**
	 * ...
	 * @author Amb154 Balls
	 */
	
	import org.flixel.*; // Imports the flixel library
	[SWF(width = "1000", height = "500", backgroundColor = "#FF0000")]; // Sets the size and color of window
	
	public class Main extends FlxGame
	{
		public function Main() 
		{
			super(2000, 1000, PlayState, 0.5, 60); // Calls FlxGame constructor(Width, Height, Starting Gamestate, ZoomLevel)
			FlxG.mouse.show(Globals.Mouse, 0.197);
			forceDebugger = true;
		}
		
	}

}