import flash.display.BitmapData;
import flash.geom.Point;

import org.flixel.FlxCore;
import org.flixel.FlxSprite;

public class PPlxSprite extends FlxSprite {

    public var alphaThreshold:uint = 0xFF;
    public var doPerfectOverlap:Boolean = true;
    public var doPerfectCollide:Boolean = true;

    protected var _corePos:Point = new Point();
    protected var _thisPos:Point = new Point();

    public function PPlxSprite(X:int=0, Y:int=0, SimpleGraphic:Class=null) {
        super(X, Y, SimpleGraphic);
    }

    public function get framePixels():BitmapData { return this._framePixels; }

    override public function overlaps(Core:FlxCore):Boolean {
        var doesOverlap:Boolean = super.overlaps(Core);
        if (doesOverlap && this.doPerfectOverlap && Core is FlxSprite) {
            doesOverlap = this.perfectCollision(FlxSprite(Core));
        }
        return doesOverlap;
    }

    public function perfectCollision(Sprite:FlxSprite):Boolean {
        this._corePos = Sprite.getScreenXY(this._corePos);
        this._thisPos = this.getScreenXY(this._thisPos);

        var corePixels:BitmapData;
        if (Sprite is PPlxSprite) {
            corePixels = PPlxSprite(Sprite).framePixels;
        } else {
            // i guess other standard FlxSprites are boned if they are animted
            corePixels = Sprite.pixels;
        }

        return this._framePixels.hitTest(this._thisPos, this.alphaThreshold, corePixels, this._corePos);
    }

    override public function hitWall(Contact:FlxCore=null):Boolean { return this.hitSomething(Contact); }
    override public function hitFloor(Contact:FlxCore=null):Boolean { return this.hitSomething(Contact); }
    override public function hitCeiling(Contact:FlxCore=null):Boolean { return this.hitSomething(Contact); }

    public function hitSomething(Contact:FlxCore):Boolean {
        var didHit:Boolean = true;
        if (this.doPerfectCollide && Contact is FlxSprite) {
            didHit = this.perfectCollision(FlxSprite(Contact));
        }

        return didHit;
    }
}