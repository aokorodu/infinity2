//
//  Guide
//
//  Created by Matthew on 2012-11-03.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//
package app.view {
	import app.*;
	import app.model.*;
	import app.view.*;
	import app.control.*;
	import flash.utils.Dictionary; 
	import fl.controls.Button;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import flash.events.MouseEvent
	import flash.events.TouchEvent;
	import flash.events.Event
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.display.*;
	 public class Guide extends AppView{
		
		public function Guide(model:AppModel, controller:AppControl, holder:MovieClip) {
		super(model, controller, holder);
		}
	override public function update(e:Event):void {
			// get show data from dictionary
			trace("Update: Guide");
/*			var _entity = this.model.entitymap;
			for (var show:* in _entity["Episode"]){
				trace(_entity["Episode"][show].title);
			}
			for (var movie:* in _entity["Movie"]){
				trace(_entity["Movie"][movie].title);
			}*/
			
		}

	}

};