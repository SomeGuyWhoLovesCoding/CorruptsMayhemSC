package ;
 
import flixel.system.FlxBasePreloader;
import flash.display.*;
import flash.text.*;
import flash.Lib;
import openfl.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
 
@:bitmap("art/gjBanner.png") class LogoImage extends BitmapData { }
@:font("assets/fonts/pixel.otf") class PixelFont extends Font {}
 
class Preloader extends FlxBasePreloader
{
    #if !js
    public function new(MinDisplayTime:Float=5, ?AllowedURLs:Array<String>) 
    {
        super(MinDisplayTime, AllowedURLs);
         
    }
     
    var logo:Sprite;
    var text:TextField;
     
    override function create():Void 
    {
        this._width = Lib.current.stage.stageWidth;
        this._height = Lib.current.stage.stageHeight;
         
        var ratio:Float = this._width / 1920;
         
        logo = new Sprite();
        logo.addChild(new Bitmap(new LogoImage(0,0)));
        logo.scaleX = logo.scaleY = ratio;
        logo.x = ((this._width) / 2) - ((logo.width) / 2);
        logo.y = (this._height / 2) - ((logo.height) / 2);
        addChild(logo);
         
        Font.registerFont(PixelFont);
        text = new TextField();
        text.defaultTextFormat = new TextFormat("Pixel Arial 11 Bold", 48, 0xffffff, false, false, false, "", "", TextFormatAlign.CENTER);
        text.embedFonts = true;
        text.selectable = false;
        text.multiline = false;
        text.x = 0;
        text.y = 5 * this._height / 7;
        text.width = _width;
        text.height = _height;
        text.text = "Loading";
        addChild(text);
         
        super.create();
    }
     
    override function update(Percent:Float):Void 
    {
        text.text = "Loading Files/Assets... [" + Std.int(Percent * 100) + "%]";
        super.update(Percent);
    }
    #end
}