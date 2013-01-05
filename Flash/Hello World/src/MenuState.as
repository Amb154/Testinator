package  
{
	import org.flixel.*;
	public class MenuState extends FlxState
	{
		private var menuImg:FlxSprite = new FlxSprite(0,0)
		override public function create():void {
			super.create();
			menuImg.loadGraphic(Globals.menu, false, false, 200, 100)
			add(menuImg)
		}
		
		override public function update():void {
				super.update();
				if (FlxG.keys.ENTER) { 
					FlxG.switchState(new PlayState)
				}
		}
	}

}