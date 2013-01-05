package game {
	import com.adamatomic.flixel.*;

	public class Coin extends FlxSprite
	{
		[Embed(source="data/coin.png")] private var ImgCoin:Class;
		
		public function Coin(X:int,Y:int)
		{
			super(ImgCoin,X,Y,true,true);

			//animations
			addAnimation("coin", [0, 1, 2, 3, 4], 8);
			play("coin");
		}
	}
}