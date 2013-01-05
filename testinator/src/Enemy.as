package  
{
	import org.Flixel.*;
	import mx.core.FlexSprite;
	
	public class Enemy extends FlxSprite 
	{
		public var jumpStrength:int = null;
		public var moveSpeed:int = null;
		public var maxHealth: int = null;
		public var currentHealth: int = null;
		public var damageStrength: int = null;
		
		public function Enemy(x=int, y=int) 
		{
			super(x,y)
			this.loadGraphic("")
			maxVelocity.x = null;
			maxVelocity.y = null;
			acceleration.y = null;
			drag.x = null;
			width = null;
			height = null;
			active = true;
		
		}
		
		override public function update():void {
			super.update();
		}
		
		public function jump():void {
			velocity.y = -jumpStrength;
		}
		
	}

}