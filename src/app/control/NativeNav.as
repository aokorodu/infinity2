//
//  Native Nav
//
//  Created by Matthew on 2012-11-03.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//
package app.control {
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
	 public class NativeNav extends MovieClip{

		public function NativeNav(model:AppModel, controller:AppControl, data:Entity ) {
			
			init();
		}
	
		public function init():void{
			//addChild(_canvas);
			
		};
		
		public function activate():void{
			
		}
		

	}

};