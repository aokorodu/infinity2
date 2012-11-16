﻿////  Grid////  Created by Matthew on 2012-11-03.//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.////package app.view.grid.catalog {	import app.*;	import app.model.*;	import app.view.*;	import app.view.grid.catalog.*;	import app.view.grid.visual_li.*;	import app.control.*;	import com.factory.*;	import flash.utils.Dictionary; 	import fl.controls.Button;	import flash.display.MovieClip;	import flash.geom.ColorTransform;	import flash.events.MouseEvent	import flash.events.TouchEvent;	import flash.events.Event	import flash.events.FocusEvent;	import flash.events.KeyboardEvent;	import flash.ui.Keyboard;	import com.greensock.*;	import com.greensock.easing.*;	import com.greensock.plugins.*;	import com.greensock.loading.*;	import com.greensock.events.LoaderEvent;	import com.greensock.loading.display.*;	import flash.geom.Point;	 public class Browse extends Catalog{			private var xpos:int			private var ypos:int			private var row_ypos:int			private var count:int						private var dragging:Boolean;			private var touchx:Number;			private var touchy:Number;			private var velocity:Number;			private var dy:Number;						private var _factory:AppFactory;					public function Browse(model:AppModel, controller:AppControl) {			super(model, controller);						//local vars			this._factory = new AppFactory();						this.rowheight = 503;			this.xpos = 1024/2			this.ypos = 180;			this.row_ypos = 0;			this.count = 0			init();		}			override public function init():void {			for each (var cat:String in catalog){				count++														var _rowtitle:MovieClip = new MovieClip();							var title = _factory.Spr(_rowtitle, "title"+count, [0,row_ypos-82], [1,1],					cat, "super", 3, "ccc", false);								addChild(_rowtitle);								var _entityrow:MovieClip = new MovieClip();				_entityrow.sx = 0;				_entityrow.y = row_ypos;				row_ypos = row_ypos+rowheight;				_entityrow.name = cat;				_entityrow.id = "row"+count				_entityrow.state = false				addChild(_entityrow)				rowMap[cat] = _entityrow				_controlMap[rowMap[cat]] = new Array();				var rowPoint:Point = new Point(_entityrow.x, _entityrow.y);															}			for ( var row:* in rowMap){				var btn_xpos = 0							for each (var entity:* in sets[row]){					var button:Visual_li = new Native_li(model, controller, entity);					button.x =	btn_xpos					btn_xpos = btn_xpos+191;					button.name = entity.TITLE;					button.row = row;						rowMap[row].addChild(button);					_entitymap[button] = entity; 					_controlMap[rowMap[row]].push(button);								}							}						this.x = xpos/clip.width/2 +35			this.y = ypos;			this.sy = this.y;						// initialize selection 						this.sel = [0,0];			this.sel_row = rowMap[catalog[0]];			this.sel_item = _controlMap[rowMap[catalog[0]]][0];			Select([0,0]);		}								public function TouchSelect(e:TouchEvent){			//var item = e.target.parent.parent.parent;						var item = e.target.parent;			var row = item.parent;						if (row!=sel_row){				Select([1,0]);			}						Desel();			sel_item = item;			Sel();		}						public function TouchBegin(e:TouchEvent){			//trace("begin, " + e.stageX, e.stageY);						TweenLite.killTweensOf(sel_row);			TweenLite.killTweensOf(this);						touchx = e.stageX;			touchy = e.stageY;						dragging = true;			velocity = 0;			this.dy = this.y;						sel_row.dragging = true;			sel_row.velocity = 0;			sel_row.dx = sel_row.x;								}				public function TouchMove(e:TouchEvent){			var speed:Number;						/*if (dragging){							dy += (e.stageY-touchy);							touchy = e.stageY;							speed = 1.5;							velocity = (this.y-this.dy);							this.y -= (this.y-this.dy) / speed;							// stop horizontal scroll if vertical velocity is high													if (velocity>4){ 								sel_row.dragging = false;							}												if (this.dy > this.sy){ 	this.dy = this.sy; 	}							if (this.dy < -(this.height-1000) ){  this.dy = -(this.height-1000); }						}			*/			if (sel_row.dragging){							sel_row.dx += (e.stageX-touchx);				touchx = e.stageX;				speed = 1.5;							sel_row.velocity = (sel_row.x-sel_row.dx);				sel_row.x -= (sel_row.x-sel_row.dx) / speed;							// stop vertical scroll if horizontal velocity is high							if (sel_row.velocity>4){ 					dragging = false;				}							if (sel_row.dx > sel_row.sx){ 	sel_row.dx = sel_row.sx; 	}				if (sel_row.dx < -(sel_row.width-1000) ){  sel_row.dx = -(sel_row.width-1000); }			}		}				public function TouchEnd(e:TouchEvent){					/*if (dragging){						dragging = false;				this.dy -= velocity*10;						if (this.dy > this.sy){ 	this.dy = this.sy; 	}				if (this.dy < -(this.height-1000) ){  this.dy = -(this.height-1000); }							TweenLite.to(this, 1.4, {x:this.dy, ease:Expo.easeOut});			}*/			if (sel_row.dragging){ 				sel_row.dragging = false;				sel_row.dx -= sel_row.velocity*10;							if (sel_row.dx > sel_row.sx){ 	sel_row.dx = sel_row.sx; 	}				if (sel_row.dx < -(sel_row.width-1000) ){  sel_row.dx = -(sel_row.width-1000); }							TweenLite.to(sel_row, 1.4, {x:sel_row.dx, ease:Expo.easeOut});			}											}												///manipulate entire row by name 		public function activate(row:String){			for (var i:Number=0; i<= _controlMap[rowMap[row]].length; i++){								if(_controlMap[rowMap[row]][i]==undefined){ }else{_controlMap[rowMap[row]][i].activate();}			}		}					}};