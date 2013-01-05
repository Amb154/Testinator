package
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Amb054
	 */
	public class Player extends FlxExtendedSprite
	{
		private var moveSpeed = 2000;
		private var jumpPower = 800;
		private var maxHealth = 10;
		private var currentHealth = maxHealth;
		private var ammo = 100;
		private var laserIndex = ammo;
		private var hurtCooldown = 1;
		private var hurtTimer = 0;
		private var justHurt = false;
		private var canHurt = true;
		private var canJump = false;
		
		private var aimAngle:Number = 0;
		
		public var level:Level;
		public var layer:FlxGroup;
		
		public var emit:FlxEmitter = new FlxEmitter();
		
		public function Player(x:int, y:int, layer:FlxGroup, level:Level)
		{
			super(x, y);
			
			this.loadGraphic(Globals.Player, true, false, 60, 128);
			
			this.level = level;
			this.layer = layer;
			
			maxVelocity.x = 600;
			maxVelocity.y = 3200;
			
			acceleration.y = 2400;
			
			drag.x = 12800;
			
			width = 60;
			height = 128;
		}
		
		override public function update():void
		{
			acceleration.x = 0;
			if (FlxG.keys.RIGHT || FlxG.keys.D) {
				facing = RIGHT;
				acceleration.x = drag.x;
			}
			
			if (FlxG.keys.LEFT || FlxG.keys.A) {
				facing = LEFT;
				acceleration.x = -drag.x;
			}
			
			if (FlxG.keys.UP || FlxG.keys.W && canJump){
				velocity.y = -jumpPower;
				canJump = false;
			}
			
			if (FlxG.keys.H) {
				hurt(1);
			}
				
			if (justHurt) {
				if (hurtTimer >= hurtCooldown) {
					justHurt = false;
					hurtTimer = 0;
					canHurt = true;
				} else {
					canHurt = false;
				}
				hurtTimer += FlxG.elapsed;
			} 
			super.update();
			
			if (justTouched(FLOOR)) {
				canJump = true;
			}
		}
		
		override public function hurt(amount:Number):void {
			if (canHurt) {
				currentHealth -= amount;
				justHurt = true;
			}
		}
		
		private function setAimAngle():void{
			aimAngle = FlxU.getAngle(new FlxPoint(x + (width / 2), y + (height / 2)), FlxG.mouse.getWorldPosition());
		}
	}

}