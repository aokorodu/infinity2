﻿////  Grid////  Created by Matthew on 2012-11-03.//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.////package app.view.grid.single {	import app.*;	import app.model.*;	import app.view.*;	import app.view.grid.catalog.*;	import app.view.grid.visual_li.*;	import app.view.grid.destination.*;	import app.control.*;	import flash.utils.Dictionary; 	import fl.controls.Button;	import flash.display.MovieClip;	import flash.geom.ColorTransform;	import flash.events.MouseEvent	import flash.events.TouchEvent;	import flash.events.Event	import flash.events.FocusEvent;	import flash.ui.Keyboard;	import com.greensock.*;	import com.greensock.easing.*;	import com.greensock.plugins.*;	import com.greensock.loading.*;	import com.greensock.events.LoaderEvent;	import com.greensock.loading.display.*;	 public class Tv extends Single{		/*		public var sy:Number;		public var rowheight:Number;		public var sel:Array;		public var sel_row:MovieClip;		public var sel_item:MovieClip;		private var single_catalog:Array*/;				public function Tv(model:AppModel, controller:AppControl, destinationEntity:Entity  ) {			super(model, controller, destinationEntity);			init();		}			override public function init():void {													var destination:Destination = new FullView( model, controller, destinationEntity );				addChild(destination)				_entitymap[destination] = destinationEntity;				destination.y = 100				var _episodes = new MovieClip()				addChild(_episodes)				single_catalog = new Array();				var xpos = 1024/2				var ypos = 600;				var row_ypos = 0;				for(var row:* in episodeSets ){					var _entityrow:MovieClip = new MovieClip(); 					_entityrow.sx = 0;					_entityrow.y = row_ypos					row_ypos = row_ypos+rowheight;					_entityrow.name = row					_episodes.addChild(_entityrow);					rowMap[row] = _entityrow					_controlMap[rowMap[row]] = new Array();					single_catalog.push(row);					var btn_xpos = 0					for each (var entity:* in episodeSets[row] ){						var button:Visual_li = new Native_li(model, controller, entity);						button.x =	btn_xpos						btn_xpos = btn_xpos+191;						button.name = entity.TITLE						rowMap[row].addChild(button);						_entitymap[button] = entity;						_controlMap[rowMap[row]].push(button);					}				}				destination.x = xpos/clip.width/2 +35				_episodes.x = xpos/clip.width/2 +35				_episodes.y = ypos								this.sy = this.y;				// initialize selection 				this.sel = [0,0];				this.sel_row = rowMap[single_catalog[0]];				this.sel_item = _controlMap[rowMap[single_catalog[0]]][0];				Select([0,0]);					}					}};