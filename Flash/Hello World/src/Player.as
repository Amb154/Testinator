package  
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		public var jump:int = 12
		public var isSmall:Boolean = true
		public var animating:Boolean = false;

		public function Player(x:int,y:int) {
			super(x,y)
			this.loadGraphic(Globals.player, true, false, 8, 16)
			maxVelocity.x = 40;
			maxVelocity.y = 120;
			acceleration.y = 100;
			drag.x = 400;
			width = 8;
			height = 16;
			active = true;
			
			addAnimation("leftSmall", [1], 0, false)
			addAnimation("rightSmall", [0], 0, false)
			addAnimation("leftBig", [6], 0, false)
			addAnimation("rightBig", [5], 0, false)
			}
		
		override public function update():void 
		{
			super.update();
			acceleration.x = 0;
			if (FlxG.keys.D) {
				facing = RIGHT
				acceleration.x = drag.x
			}
			if (FlxG.keys.A) {
				facing = LEFT
				acceleration.x = -drag.x
			}
			if (_curAnim != null) {
				if (_curAnim.name == "shrink" || _curAnim.name == "grow") {
					animating = true;
					if (this._curFrame == 3) {
						_curAnim.name = "NONE";
						animating = false;
					}
				} else {
					animating = false;
				}
			} else {
				animating = false;
			}
			
			if(animating == false) {
				if (facing == LEFT) {
					if (isSmall) {
						play("leftSmall")
						
					} else {
						play("leftBig")
					}
				} else {
					if (isSmall) {
						play("rightSmall")
					} else {
						play("rightBig")
					}
				}
			}
			if (FlxG.keys.W) {
				velocity.y -= jump
			}
			
			if (FlxG.keys.X) {
				grow();
			}
			if (FlxG.keys.C) {
				shrink();
			}
			
		}
		
		private function grow():void {
			if (isSmall) {
				addAnimation("grow", [2, 3, 4, 7], 3, false)
				play("grow")
				isSmall = false
			}
		}
		private function shrink():void {
			if (!isSmall) {
				addAnimation("shrink", [4, 3, 2, 7], 3, false)
				play("shrink")
				isSmall = true
			}
		}
	}

}