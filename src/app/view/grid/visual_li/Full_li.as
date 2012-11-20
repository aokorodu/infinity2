﻿package app.view.grid.visual_li {	import app.*;	import app.model.*;	import app.view.*;	import app.control.*;	import com.factory.*;	import app.view.grid.nav_li.*;	import flash.utils.Dictionary; 	import fl.controls.Button;	import flash.display.MovieClip;	import flash.geom.ColorTransform;	import flash.events.MouseEvent	import flash.events.TouchEvent;	import flash.events.Event	import com.greensock.*;	import com.greensock.easing.*;	import com.greensock.plugins.*;	import com.greensock.loading.*;	import com.greensock.events.LoaderEvent;	import com.greensock.loading.display.*;	import flash.display.*;	import flash.geom.*;		 public class Full_li extends Visual_li{		public var _factory:AppFactory;		public var poster;		public var textarea = null;		public var actionbar = null;		public function Full_li(model:AppModel, controller:AppControl, data:Entity ) {			 super(model, controller, data);			init();		}			override public function init():void{					TweenPlugin.activate([EndArrayPlugin, ColorMatrixFilterPlugin, TintPlugin, ColorTransformPlugin, AutoAlphaPlugin, ScrollRectPlugin]);						this._factory = new AppFactory();			var poster:String = entity.IMG_POSTER_BIG;			if (poster==null){  poster = entity.IMG_POSTER; }									Poster(poster);						var desc:String = entity.SHORT_SYNOPSIS;			if (entity.TYPE=="Episode"){ desc = entity.EPISODE_TITLE; }						PosterText(entity.TITLE, entity.ACTORS, desc, entity.YEAR + "  /  " + entity.RATING + "  /  " + "HD" + "  /  " + entity.NETWORK);						Actions(true);								};								public function Poster(path:String):void {			var mc = new MovieClip();			mc.sx = mc.sy = 0;			this.addChild(mc);			this.poster = mc;						mc.scal = mc.scaleX = mc.scaleY = 1;			var r:MovieClip = new rect();			r.width = 311;			r.height = 413;			mc.addChild(r);						_factory._queue.append( new ImageLoader(path, {container:mc, width:311, height:413, vAlign:"top", hAlign:"center", scaleMode:"proportionalOutside", crop:true}) );			_factory._queue.load();					}						public function PosterText(t:String, a:String, d:String, yr:String):void {			var mc = new MovieClip();			mc.sx = mc.x = 366;			mc.sy = mc.y = 28;						this.addChild(mc)			this.textarea = mc;						if (d==null){ d= "no description."; }						var y:Number = 0;												var title = _factory.Spr(mc, "title", [0,y], [1,1],				t, "super", 3, "ccc", false, 600, 1);							y += title.getChildAt(0).textHeight + 5;												var actors = _factory.Spr(mc, "actors", [0,y], [1,1],				a, "medium", 1, "ccc", false, 600, 5);						y += actors.getChildAt(0).textHeight + 22;														var desc = _factory.Spr(mc, "description", [0,y], [1,1],				d, "body", 1, "ccc", false, 600, 5);						y += desc.getChildAt(0).textHeight + 36;																var x:Number = 0;						var year = _factory.Spr(mc, "year", [x,y], [1,1],				yr, "body", 1, "666", false, 600);					}								public function Highlight(on:Boolean=true):void {			this.state = on;						var s:Number = 1;			var x:Number = 16;			var y:Number = 23;			var a:Number = 1;						this.parent.setChildIndex(this, this.parent.numChildren-1);					if (!on){				s = poster.scal;				x = 0;				y = 0;				a = 0;			}						TweenLite.to(poster, 0.8, {x:poster.sx-x, y:poster.sy-y, scaleX:s, scaleY:s, ease:Expo.easeOut});			TweenLite.to(textarea, 0.6, {autoAlpha:a, ease:Expo.easeOut});					}						public function Actions(on:Boolean=true):void {						if (actionbar==null){				actionbar = new Nav_li(model, controller, entity);				actionbar.x = 366;				actionbar.y = 325;								addChild(actionbar);							}						actionbar.Show(on);			actionbar.lines.x = 0;					}								public function activate():void{			_canvas.tabEnabled = true;		}			}};