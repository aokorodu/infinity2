//
//  Grid
//
//  Created by Matthew on 2012-11-03.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//
package app.view.catalog {
	import app.*;
	import app.model.*;
	import app.view.*;
	import app.view.catalog.*;
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
	 public class Browse extends Catalog{

		public function Browse(sets:Dictionary, catalog:Array, clip:MovieClip) {
			super(sets,catalog, clip)
			init();
		}
		///ABSTRACT METHOD FOR OVERRIDE
			override public function init():void {
				trace(sets);
					var xpos = 1024/2
					var ypos = 100;
					var row_ypos = 0;
					addChild(clip);
					for each (var cat:String in catalog){
						trace(cat+"______________")
						var _entityrow:MovieClip = new MovieClip(); 
						_entityrow.y = row_ypos
						row_ypos = row_ypos+300
						clip.addChild(_entityrow)
						rowMap[cat] = _entityrow
					}
					for ( var row:* in rowMap){
						trace(row+rowMap[row]);
						var btn_xpos = 0
						for each (var entity:* in sets[row]){
							trace(entity.title)
							var button:AppButton = new AppButton( entity.title, 220, 280 );
							button.x =	btn_xpos
							btn_xpos = btn_xpos+button.width+30
							rowMap[row].addChild(button);
						}
					}
					clip.x = xpos/clip.width/2 +35
					clip.y = ypos

		}

	}

};