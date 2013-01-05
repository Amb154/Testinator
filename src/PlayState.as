package
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Amb054
	 */
	public class PlayState extends FlxState
	{
		public var level1:LevelTest;
		override public function create():void {
			super.create();
			level1 = new LevelTest();
			this.add(level0);
		}
	}
}