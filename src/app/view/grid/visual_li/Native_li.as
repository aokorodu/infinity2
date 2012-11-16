package app.view.grid.visual_li {	import app.*;	import app.model.*;	import app.view.*;	import app.control.*;	import com.factory.*;	import flash.utils.Dictionary; 	import fl.controls.Button;	import flash.display.MovieClip;	import flash.geom.ColorTransform;	import flash.events.MouseEvent	import flash.events.TouchEvent;	import flash.events.Event	import com.greensock.*;	import com.greensock.easing.*;	import com.greensock.plugins.*;	import com.greensock.loading.*;	import com.greensock.events.LoaderEvent;	import com.greensock.loading.display.*;	import flash.display.*;	import flash.geom.*;		 public class Native_li extends Visual_li{		public var _factory:AppFactory;		public var poster;		public var textarea;		public function Native_li(model:AppModel, controller:AppControl, data:Entity ) {			 super(model, controller, data);			init();		}			override public function init():void{					TweenPlugin.activate([EndArrayPlugin, ColorMatrixFilterPlugin, TintPlugin, ColorTransformPlugin, AutoAlphaPlugin, ScrollRectPlugin]);						this._factory = new AppFactory();			Poster(entity.IMG_POSTER);						var desc:String = entity.SHORT_SYNOPSIS;			if (entity.TYPE=="Episode"){ desc = entity.EPISODE_TITLE; }						PosterText(entity.TITLE, desc, "Contextual information");									// hitbox for touch						var hit = new hitme();			hit.width = 200;			hit.height = 500;			hit.tabEnabled = false;			addChild(hit);									//_canvas = new AppButton(entity.TITLE, 220, 280, controller );			//addChild(_canvas);			//_canvas.tabEnabled = false;		};								public function Poster(path:String):void {			var mc = new MovieClip();			mc.sx = mc.sy = 0;			this.addChild(mc);			this.poster = mc;						mc.scal = mc.scaleX = mc.scaleY = 0.86;			var rect:Shape = new Shape;			rect.graphics.beginFill(0x333333);			rect.graphics.drawRect(0, 0, 212,283);			rect.graphics.endFill();			mc.addChild(rect);			_factory._queue.append( new ImageLoader(path, {container:mc, width:212, height:283, vAlign:"top", hAlign:"center", scaleMode:"proportionalOutside", crop:true}) );			_factory._queue.load();					}						public function PosterText(t:String, d:String, c:String):void {			var mc = new MovieClip();			mc.sx = mc.x = -16;			mc.sy = mc.y = 285;						this.addChild(mc)			this.textarea = mc;						if (d==null){ d= "no description."; }						var y = 0;						var title = _factory.Spr(mc, "title", [0,y], [1,1],				t, "nav", 1, "ccc", false, 600, 1);							y += 40;								var desc = _factory.Spr(mc, "description", [0,y], [1,1],				d, "body", 1, "666", false, 600, 2);						y += desc.getChildAt(0).textHeight + 12;				var context = _factory.Spr(mc, "context", [0,y], [1,1],				c, "body", 0, "17", false, 600);						_factory.Hide(mc);		}								public function Highlight(on:Boolean=true):void {						var s:Number = 1;			var x:Number = 16;			var y:Number = 23;			var a:Number = 1;						this.parent.setChildIndex(this, this.parent.numChildren-1);					if (!on){				s = poster.scal;				x = 0;				y = 0;				a = 0;			}						TweenLite.to(poster, 0.8, {x:poster.sx-x, y:poster.sy-y, scaleX:s, scaleY:s, ease:Expo.easeOut});			TweenLite.to(textarea, 0.6, {autoAlpha:a, ease:Expo.easeOut});					}						public function activate():void{			_canvas.tabEnabled = true;		}			}};