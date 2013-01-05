package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		public var buildings:FlxTilemap = new FlxTilemap()
		public var sky:FlxTilemap = new FlxTilemap()
		public var tiles:FlxTilemap = new FlxTilemap()
		
		
		public var player:Player
		
		public var mapGroup:FlxGroup = new FlxGroup()
		
		override public function create():void {
			super.create();
			
			buildings.loadMap(new Globals.BuildMap, Globals.buildings, 64, 64, 0, 0, 1, 2)
			buildings.scrollFactor.x = 0.5
			buildings.scrollFactor.y = 0.5
			sky.loadMap(new Globals.SkyMap, Globals.tiles, 8, 8, 0 , 0, 1, 65)
			tiles.loadMap(new Globals.TileMap, Globals.tiles, 8 , 8, 0 , 0, 1, 65)
			
			player = new Player(0,0)
			
			
			mapGroup.add(sky)
			mapGroup.add(buildings)
			mapGroup.add(tiles)
			
			
			this.add(mapGroup)		
			this.add(player)
		
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER)
			FlxG.camera.setBounds(0, 0, sky.width, sky.height)
			
			
			FlxG.worldBounds.x = 0;
			FlxG.worldBounds.y = 0;
			FlxG.worldBounds.width = sky.width;
			FlxG.worldBounds.height = sky.height;
		}
		
		override public function update():void {
			super.update();
			FlxG.collide(mapGroup,player)	
		}
	
		
	}

}