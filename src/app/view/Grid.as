﻿////  Grid////  Created by Matthew on 2012-11-03.//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.////package app.view {	import app.*;	import app.model.*;	import app.view.*;	import app.control.*;	import flash.utils.Dictionary; 	import fl.controls.Button;	import flash.display.MovieClip;	import flash.geom.ColorTransform;	import flash.events.MouseEvent	import flash.events.TouchEvent;	import flash.events.Event	import com.greensock.*;	import com.greensock.easing.*;	import com.greensock.plugins.*;	import com.greensock.loading.*;	import com.greensock.events.LoaderEvent;	import com.greensock.loading.display.*;	 public class Grid extends AppView{		public var _row:MovieClip;		public function Grid(model:AppModel, controller:AppControl, holder:MovieClip) {		super(model, controller, holder);		}	override public function update(e:Event):void {			// get show data from dictionary			_row = new MovieClip();			var _sets = this.model.dataSets;			var _catalog = this.model.catalog;			var xpos = holder.stage.width/2			var ypos = 768/2 - 80;			var btn_xpos = 0			_row.x = xpos			_row.y = ypos			for each (var cat:String in _catalog){				trace(cat+":"+_sets[cat][0].title)				var button:AppButton = new AppButton( _sets[cat][0].title, 150,80 );				_row.addChild(button);				button.x = btn_xpos				btn_xpos += button.width+30			}			addChild(_row);					}	}};