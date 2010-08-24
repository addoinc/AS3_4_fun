package {

  import flash.display.Sprite;
  import flash.geom.Rectangle;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.events.Event;
  import flash.events.MouseEvent;

  [SWF(width="400", height="400", backgroundColor="#000000", frameRate="31")]

  public class Craft extends Sprite {

    private var kpax:Sprite = new Sprite();
    private var spaceCraft:Sprite = new Sprite();
    private var kpax_x:Number = 100;
    private var kpax_y:Number = 100;
    private var craftLbl:TextField;
    
    public function Craft() {

      kpax.graphics.beginFill( 0x0000FF );
      kpax.graphics.drawCircle(kpax_x, kpax_y, 20);
      addChild( kpax );
   
      spaceCraft.graphics.beginFill( 0x00FF00 );
      spaceCraft.graphics.drawRect(300, 300, 10, 10);
      spaceCraft.addEventListener(MouseEvent.MOUSE_DOWN, moveCraft);
      spaceCraft.addEventListener(MouseEvent.MOUSE_UP, stopCraft);
      addChild( spaceCraft );

      var format:TextFormat = new TextFormat();
      //format.font = "Nimbus Sans L";
      format.font = "Verdana";
      format.color = 0x0000FF;
      format.size = 10;
      format.underline = false;

      craftLbl = new TextField();
      craftLbl.embedFonts = false;
      craftLbl.defaultTextFormat = format;
      craftLbl.x = 100;
      craftLbl.y = 10;
      craftLbl.width = 200;
      craftLbl.height = 20;
      addChild( craftLbl );
      craftLbl.background = true;
      craftLbl.border = true;
      calcDistance();
    }

    private function moveCraft(e:MouseEvent):void {
      e.target.startDrag();
      e.target.addEventListener(Event.ENTER_FRAME, updateDistance);
    }

    private function stopCraft(e:MouseEvent):void {
      e.target.stopDrag();
      e.target.removeEventListener(Event.ENTER_FRAME, updateDistance);
    }

    private function updateDistance(event:Event):void {
      calcDistance();
    }

    private function calcDistance():void {
      var kpax_coords:Rectangle = kpax.getBounds( this );
      var scraft_coords:Rectangle = spaceCraft.getBounds( this );
      var x:Number = kpax_coords.x - scraft_coords.x;
      var y:Number = kpax_coords.y - scraft_coords.y;
      var dist:Number = Math.round( Math.sqrt( (x*x) + (y*y) ) );

      craftLbl.text = "Distance from kpax : " + dist;
    }
  }

}
