package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Amb054
	 */
	public class Level extends FlxGroup
	{
		//Tilemaps
		public var map:FlxTilemap = new FlxTilemap();
		public var skyBox:FlxTilemap = new FlxTilemap();
		
		//Layers
		public var layerStage:FlxGroup = new FlxGroup();
		public var layerEntities:FlxGroup = new FlxGroup();
		
		//Entities
		public var player:Player;
		public var droppedItems:FlxGroup = new FlxGroup();
		public var lasers:FlxGroup = new FlxGroup();
		public var enemyList:FlxGroup = new FlxGroup();
		
		//Particles
		public var emit:FlxEmitter = new FlxEmitter();
		
		/**
		 * You must load 'map' and 'skymap'.
		 */
		public function Level(pX:int, pY:int, mapWidth:int, mapHeight:int, tileMaps:FlxGroup) {
			player = new Player(pX, pY, layerEntities, this);
			
			layerStage = tileMaps;
			
			layerEntities.add(player);
			layerEntities.add(enemyList);
			layerEntities.add(emit);
			
			this.add(layerStage);
			this.add(layerEntities);
			
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
			FlxG.camera.setBounds(0, 0, mapWidth * Globals.TILE_SIZE, mapHeight * Globals.TILE_SIZE);
			
			FlxG.worldBounds.x = 0;
			FlxG.worldBounds.y = 0;
			FlxG.worldBounds.width = mapWidth * Globals.TILE_SIZE;
			FlxG.worldBounds.height = mapHeight * Globals.TILE_SIZE;
		}
		
		override public function update():void {
			//Logic
			
			
			//Update
			super.update();
			
			//Collide
			FlxG.collide(layerStage, layerEntities);
		}
		
	}

}