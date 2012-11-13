﻿////  Grid////  Created by Matthew on 2012-11-03.//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.////package app.view.grid.single {	import app.*;	import app.model.*;	import app.view.*;	import app.view.grid.catalog.*;	import app.control.*;	import flash.utils.Dictionary; 	import fl.controls.Button;	import flash.display.MovieClip;	import flash.geom.ColorTransform;	import flash.events.MouseEvent	import flash.events.TouchEvent;	import flash.events.Event	import flash.events.FocusEvent;	import flash.events.KeyboardEvent;	import com.greensock.*;	import com.greensock.easing.*;	import com.greensock.plugins.*;	import com.greensock.loading.*;	import com.greensock.events.LoaderEvent;	import com.greensock.loading.display.*;	 public class Tv extends Single{		private var _entitymap:Dictionary;		private var _controlMap:Dictionary;		public function Tv(model:AppModel, controller:AppControl, destinationEntity:Entity  ) {			super(model, controller, destinationEntity);			this._entitymap = new Dictionary();				this._controlMap = new Dictionary();			init();		}			override public function init():void {				var destination:Destination = new Destination( destinationEntity.title, 960, 480 );				addChild(destination)				_entitymap[destination] = destinationEntity;				destination.y = 100				this.focusmem = destination;				var _episodes = new MovieClip()				addChild(_episodes)				var xpos = 1024/2				var ypos = 600;				var row_ypos = 0;				for(var row:* in sets ){					var _entityrow:MovieClip = new MovieClip(); 					_entityrow.y = row_ypos					row_ypos = row_ypos+300					_episodes.addChild(_entityrow);					rowMap[row] = _entityrow					_controlMap[rowMap[row]] = new Array();					var btn_xpos = 0					for each (var entity:* in sets[row] ){						var button:AppButton = new AppButton( entity.title, 220, 280, null );						button.x =	btn_xpos						btn_xpos = btn_xpos+button.width+30						button.name = entity.parentTitle						rowMap[row].addChild(button);						_entitymap[button] = entity;						_controlMap[rowMap[row]].push(button);					}				}				destination.x = xpos/clip.width/2 +35				_episodes.x = xpos/clip.width/2 +35				_episodes.y = ypos		}		public function get controlMap():Dictionary{			return _controlMap;		}		public function get entitymap():Dictionary{			return _entitymap		}	}};