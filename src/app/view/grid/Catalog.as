//
//  Grid
//
//  Created by Matthew on 2012-11-03.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//
package app.view.grid {
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
	 public class Catalog extends AppView{
		public var _catalog:MovieClip;
		public function Catalog(model:AppModel, controller:AppControl, holder:MovieClip) {
		super(model, controller, holder);
		}
	override public function update(e:Event):void {
			// get show data from dictionary
			var _rowMap = new Dictionary();
			_catalog = new MovieClip();
			var sets = this.model.dataSets;
			var catalog = this.model.catalog;
			var xpos = holder.stage.width/2
			var ypos = 100;
			var row_ypos = 0;
			addChild(_catalog);
			for each (var cat:String in catalog){
				trace(cat+"______________")
				var _entityrow:MovieClip = new MovieClip(); 
				_entityrow.y = row_ypos
				row_ypos = row_ypos+300
				_catalog.addChild(_entityrow)
				_rowMap[cat] = _entityrow
			}
			
			for ( var row:* in _rowMap){
				trace(row+_rowMap[row]);
				var btn_xpos = 0
				for each (var entity:* in sets[row]){
					trace(entity.title)
					var button:AppButton = new AppButton( entity.title, 220, 280 );
					button.x =	btn_xpos
					btn_xpos = btn_xpos+button.width+30
					_rowMap[row].addChild(button);
				}
			}
			_catalog.x = xpos/_catalog.width/2 +35
			_catalog.y = ypos

}

	}

};