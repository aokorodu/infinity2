﻿////  Grid////  Created by Matthew on 2012-11-03.//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.////package app.view.grid.catalog {	import app.*;	import app.model.*;	import app.view.*;	import app.view.grid.catalog.*;	import app.view.grid.visual_li.*;	import app.control.*;	import flash.utils.Dictionary; 	import fl.controls.Button;	import flash.display.MovieClip;	import flash.geom.ColorTransform;	import flash.events.MouseEvent	import flash.events.TouchEvent;	import flash.events.Event	import flash.events.FocusEvent;	import flash.events.KeyboardEvent;	import flash.ui.Keyboard;	import com.greensock.*;	import com.greensock.easing.*;	import com.greensock.plugins.*;	import com.greensock.loading.*;	import com.greensock.events.LoaderEvent;	import com.greensock.loading.display.*;	import flash.geom.Point;	 public class Browse extends Catalog{			private var xpos:int			private var ypos:int			private var row_ypos:int			private var count:int		public function Browse(model:AppModel, controller:AppControl) {			super(model, controller);						//local vars						this.rowheight = 300;			this.xpos = 1024/2			this.ypos = 100;			this.row_ypos = 0;			this.count = 0			init();		}			override public function init():void {			for each (var cat:String in catalog){				count++				var _entityrow:MovieClip = new MovieClip();				_entityrow.sx = 0;				_entityrow.y = row_ypos				row_ypos = row_ypos+rowheight;				_entityrow.name = cat				_entityrow.id = "row"+count				_entityrow.state = false				addChild(_entityrow)				rowMap[cat] = _entityrow				_controlMap[rowMap[cat]] = new Array();				var rowPoint:Point = new Point(_entityrow.x, _entityrow.y);			}			for ( var row:* in rowMap){				var btn_xpos = 0				for each (var entity:* in sets[row]){					var button:Visual_li = new Native_li(model, controller, entity);					button.x =	btn_xpos					btn_xpos = btn_xpos+button.width+30					button.name = entity.parentTitle					button.row = row;						rowMap[row].addChild(button);					_entitymap[button] = entity; 					_controlMap[rowMap[row]].push(button);				}							}						this.x = xpos/clip.width/2 +35			this.y = ypos;			this.sy = this.y;						// initialize selection 						this.sel = [0,0];			this.sel_row = rowMap[catalog[0]];			this.sel_item = _controlMap[rowMap[catalog[0]]][0];			Select([0,0]);		}		///manipulate entire row by name 		public function activate(row:String){			for (var i:Number=0; i<= _controlMap[rowMap[row]].length; i++){								if(_controlMap[rowMap[row]][i]==undefined){ }else{_controlMap[rowMap[row]][i].activate();}			}		}					}};