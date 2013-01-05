package game
{
	import com.adamatomic.flixel.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;

	public class PlayStateTiles extends FlxState
	{
		[Embed(source="data/coin.mp3")] private var SndCoin:Class;
		[Embed(source="data/laugh.mp3")] private var SndLaugh:Class;
		[Embed(source="data/boom.mp3")] private var SndBoom:Class;
		[Embed(source="data/flan_logo.png")] private var ImgFlanLogo:Class;
		[Embed(source="data/flixel_logo.png")] private var ImgFlixelLogo:Class;
		[Embed(source="data/gibs.png")] private var ImgGibs:Class;
		[Embed(source="data/1_hour_bonus_LOOP.mp3")] private var Music:Class;

		//PUT THE FOLLOWING INSIDE YOUR DERIVED FlxState CLASS (i.e. under 'class MyState { ...')
		private var _map:MapBase;

		private var _player:Player;
		private var _coins:FlxArray = new FlxArray;
		private var _restart:Number;
		private var _alreadyBoomed:Boolean;
		
		
		protected function onMapAddCallback(spr:FlxSprite):void
		{
			if(spr is Player) {
				_player = spr as Player;
			}
			else if(spr is Coin)
				_coins.add(spr);
		}
		
		private var totalCoins_:uint;
		
		function PlayStateTiles():void {
			super();
			
			FlxG.setMusic(Music);
			
			//IF IN DOUBT PUT THE FOLLOWING INSIDE YOUR DERIVED FlxState CLASS' CONSTRUCTOR (i.e. inside function MyState()...)
			_map = new MapLevel1;
			//Add the background (a bit hacky but works)
			var bgColorSprite:FlxSprite = new FlxSprite(null, 0, 0, false, false, FlxG.width, FlxG.height, _map.bgColor);
			bgColorSprite.scrollFactor.x = 0;
			bgColorSprite.scrollFactor.y = 0;
			FlxG.state.add(bgColorSprite);

			//Create the map and add the layers to current the FlxState
			FlxG.state.add(_map.layerBackgroundSky);
			FlxG.state.add(_map.layerBackgroundDirt);
			FlxG.state.add(_map.layerMain);
			_map.addSpritesToLayerBackgroundSky(onMapAddCallback);
			_map.addSpritesToLayerBackgroundDirt(onMapAddCallback);
			_map.addSpritesToLayerMain(onMapAddCallback);

			/*_player = new Player(_map.layerMain.width/2-4, _map.layerMain.height/2-4);
			this.add(_player);*/

			//This coin is specially added
			var coin:Coin = new Coin(_map.layerMain.width/2-4+50, _map.layerMain.height/2-4-90);
			_coins.add(coin);
			this.add(coin);

			FlxG.follow(_player,2.5);
			FlxG.followAdjust(0.5,0.0);
			FlxG.followBounds(_map.boundsMinX, _map.boundsMinY, _map.boundsMaxX, _map.boundsMaxY);
			
			var logo:FlxSprite = new FlxSprite(ImgFlanLogo, 0, 0);
			logo.scrollFactor.x=0;
			logo.scrollFactor.y=0;
			logo.x=FlxG.width-logo.width-1;
			logo.y=FlxG.height-logo.height-1;
			this.add(logo);

			logo = new FlxSprite(ImgFlixelLogo, 0, 0);
			logo.scrollFactor.x=0;
			logo.scrollFactor.y=0;
			logo.x=1;
			logo.y=FlxG.height-logo.height-1;
			this.add(logo);

			totalCoins_ = _coins.length;
			
			var howToPlay:FlxText;
			howToPlay = new FlxText(0, FlxG.height-24, FlxG.width, 16, "Click to play", 0x000000, null, 8, "center");
			howToPlay.scrollFactor.x=0;
			howToPlay.scrollFactor.y=0;
			this.add(howToPlay);
			howToPlay = new FlxText(0, FlxG.height-16, FlxG.width, 16, "Arrows: Move & Jump", 0x000000, null, 8, "center");
			howToPlay.scrollFactor.x=0;
			howToPlay.scrollFactor.y=0;
			this.add(howToPlay);
			
			FlxG.flash(0xff131c1b);
		}
		
		protected function overlapPlayerCoin(coin:Coin, player:Player):void
		{
			FlxG.play(SndCoin);
			coin.kill();
			totalCoins_--;
			_player.scale.x+=0.15;
			_player.scale.y+=0.05;
			if(totalCoins_==0) {
				_restart=5.8;
				_alreadyBoomed=false;
				FlxG.play(SndLaugh);
			}
			adjustPlayerSize();
		}
		
/*		protected function adjustSizeToScale(spr:FlxSprite):void
		{
			spr.offset.x=ORIGINAL_OFFSET_X + Math.floor(ORIGINAL_WIDTH  * -(spr.scale.x - 1)/2);
			spr.offset.y=ORIGINAL_OFFSET_Y + Math.floor(ORIGINAL_HEIGHT * -(spr.scale.y - 1)/2);
			spr.width= ORIGINAL_WIDTH  * (spr.scale.x);
			spr.height=ORIGINAL_HEIGHT * (spr.scale.y);
		}*/


		protected function adjustPlayerSize():void
		{
			_player.offset.x=Math.floor(16*-(_player.scale.x - 1)/2);
			_player.offset.y=Math.floor(16*-(_player.scale.y - 1)/2);
			_player.width=16*(_player.scale.x);
			_player.height=16*(_player.scale.y);
		}

		override public function update():void
		{
			//if(FlxG.justPressed(FlxG.B)) { totalCoins_=0; _restart=1; _alreadyBoomed=false; FlxG.play(SndLaugh); }
		
			if(totalCoins_ == 0) {
				_restart-=FlxG.elapsed;
				if(!_alreadyBoomed) {
					_player.scale.x+=0.80 * FlxG.elapsed;
					_player.scale.y+=0.35 * FlxG.elapsed;
					adjustPlayerSize();
				}
				if(_restart <= 0) {
					if(!_alreadyBoomed) {
						_alreadyBoomed=true;
						FlxG.play(SndBoom);
						_restart=5;
						var emitter:FlxEmitter = new FlxEmitter(_player.x+_player.width/4, _player.y+_player.height/4, _player.width/2, _player.height/2, null, -3, -150, 150, -200, -10, -360, 360, 300, 0, ImgGibs, 300, true);
						this.add(emitter);
						emitter.reset();
						_player.kill();
						
						var shadow:FlxText = new FlxText(0,(FlxG.height-80)/2, FlxG.width, 80, "Money will never\nmake you happy!", 0x000000, null, 24, "center");
						shadow.scrollFactor.x=0;
						shadow.scrollFactor.y=0;
						this.add(shadow);
						var text:FlxText = new FlxText(shadow.x+2,shadow.y-2, FlxG.width, 80, "Money will never\nmake you happy!", 0xffffff, null, 24, "center");
						text.scrollFactor.x=0;
						text.scrollFactor.y=0;
						this.add(text);
						
						shadow = new FlxText(0,(FlxG.height-80)/2+80, FlxG.width, 80, "Be there for your loved ones", 0x000000, null, 16, "center");
						shadow.scrollFactor.x=0;
						shadow.scrollFactor.y=0;
						this.add(shadow);
						text= new FlxText(shadow.x+2,shadow.y-2, FlxG.width, 80, "Be there for your loved ones", 0xffffff, null, 16, "center");
						text.scrollFactor.x=0;
						text.scrollFactor.y=0;
						this.add(text);
					}
					else
						FlxG.switchState(PlayStateTiles);
				}				
			}
			super.update();
			_map.layerMain.collide(_player);			
			FlxG.overlapArray(_coins, _player, overlapPlayerCoin);
		}
	}
}
