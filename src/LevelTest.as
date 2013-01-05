package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxTilemap;
	/**
	 * ...
	 * @author Amb054
	 */
	public class LevelTest extends Level {
		
		public function LevelTest() {
			var maps:FlxGroup = new FlxGroup();
			var tempMap:FlxTilemap = new FlxTilemap();
			// var skybox
			tempMap.loadMap(new Globals.TestMap, Globals.Tiles, Globals.TILE_SIZE, Globals.TILE_SIZE, 0, 0, 0, 5);
			maps.add(tempMap);

			super(0, 1000, 100, 20, maps);
			
		}
		
		override public function update():void {
			super.update();
		}
		
	}

}