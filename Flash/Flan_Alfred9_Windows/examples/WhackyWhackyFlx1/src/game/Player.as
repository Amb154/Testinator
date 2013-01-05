package game {
	import com.adamatomic.flixel.*;

	public class Player extends FlxSprite
	{
		[Embed(source="data/flaco.png")] private var ImgFlaco:Class;
		[Embed(source="data/jump.mp3")] private var SndJump:Class;
		[Embed(source="data/land.mp3")] private var SndLand:Class;
		
		private var _jumpPower:int;
		
		public function Player(X:int,Y:int)
		{
			super(ImgFlaco,X,Y,true,true);
			
			var runSpeed:uint = 120;
			drag.x = runSpeed*8;
			acceleration.y = 420;
			_jumpPower = 250;
			maxVelocity.x = runSpeed;
			maxVelocity.y = _jumpPower;
			
			//animations
			addAnimation("idle", [0]);
			addAnimation("run", [0, 1, 2], 15);
			addAnimation("jump", [3]);
		}
		
		override public function update():void
		{
			//MOVEMENT
			acceleration.x = 0;
			if(FlxG.kLeft) {
				facing = LEFT;
				acceleration.x -= drag.x;
			}
			else if(FlxG.kRight) {
				facing = RIGHT;
				acceleration.x += drag.x;
			}
			if(FlxG.justPressed(FlxG.UP) && velocity.y == 0) {
				velocity.y = -_jumpPower;
				FlxG.play(SndJump);
			}
			
			//ANIMATION
			if(velocity.y != 0)
			{
				play("jump");
			}
			else if(velocity.x == 0)
			{
				play("idle");
			}
			else
			{
				play("run");
			}
				
			//UPDATE POSITION AND ANIMATION
			super.update();
		}
		
		override public function hitCeiling():Boolean
		{
			if(velocity.y < 50)
				FlxG.play(SndLand);
			return super.hitCeiling();
		}		
		
		override public function hitFloor():Boolean
		{
			if(velocity.y > 50)
				FlxG.play(SndLand);
			return super.hitFloor();
		}

	}
}