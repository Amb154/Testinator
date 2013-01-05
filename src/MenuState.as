package  
{
	/**
	 * ...
	 * @author Amb054
	 */
	import org.flixel.*;
	
	public class MenuState extends FlxState {
		
		public var startButton:FlxButton = new FlxButton(25, 20, null, start);
		public var optionsButton:FlxButton = new FlxButton(0, 0, null, options);
		public var controlsButton:FlxButton = new FlxButton(25, 60, null, controls);
		public var backButton:FlxButton = new FlxButton(5, 80, null, back);
		
		override public function create():void {
			super.create()
			startButton.loadGraphic(Globals.StartButton);
			controlsButton.loadGraphic(Globals.ControlsButton);
			startButton.width = 050;
			startButton.height = 20;
			controlsButton.width = 050;
			controlsButton.height = 20;
			
			backButton.loadGraphic(Globals.BackButton);
			backButton.width = 40;
			backButton.height = 05;
			
			this.add(startButton);
			this.add(controlsButton);
			
			
			startButton.onOver = function():void { startButton.loadGraphic(Globals.StartButtonOver) };
			startButton.onOut = function():void { startButton.loadGraphic(Globals.StartButton) };
			startButton.onDown = function():void { startButton.loadGraphic(Globals.StartButtonClicked) };
			
			controlsButton.onOver = function():void { controlsButton.loadGraphic(Globals.ControlsButtonOver) };
			controlsButton.onOut = function():void { controlsButton.loadGraphic(Globals.ControlsButton) };
			controlsButton.onDown = function():void { controlsButton.loadGraphic(Globals.ControlsButtonClicked) };
			
			backButton.onOver = function():void { backButton.loadGraphic(Globals.BackButtonOver) };
			backButton.onOut = function():void { backButton.loadGraphic(Globals.BackButton) };
			backButton.onDown = function():void { backButton.loadGraphic(Globals.BackButtonClicked) };
			
		}
		
		private function start():void {
			FlxG.fade(0x4F0000, 0.75);
			FlxG.switchState(new PlayState());
		}
		
		private function controls():void {
			this.remove(startButton);
			this.remove(controlsButton);
			this.add(backButton);
			
			this.add(new FlxText(0, 0, FlxG.width, " WSAD :: Move/Jump \n UpDownLeftRight :: Move/JetPack \n P :: Particle Explosion \n H :: Hurt \n Mouse0 :: MiningLaser"));
			controlsButton.status = FlxButton.NORMAL;
			controlsButton.onOut();
		}
		
		private function back():void {
			clear();
			this.remove(backButton);
			this.add(controlsButton);
			this.add(startButton);
			backButton.status = FlxButton.NORMAL;
			backButton.onOut();
		}
	}

}