//
//  secondaryNav
//
//  Created by Matthew on 2012-10-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//
package com.mhl {
	
		import flash.display.MovieClip;	
		import com.greensock.*;
		import com.greensock.easing.*;
		import com.greensock.plugins.*;
		import com.greensock.loading.*;
		import com.greensock.events.LoaderEvent;
		import com.greensock.loading.display.*;
	
	 public class canvas extends MovieClip{
		public var _chrome:navChrome;
		public var _street:MovieClip;
		public var _library:MovieClip; 
		public var _backdrop:lighting;
		
		public function canvas(target:MovieClip) {
			_backdrop = new lighting();
			addChild(_backdrop);
			_backdrop.alpha=0;
		}
		public function dimBackdrop(num:Number){
			TweenLite.to(_backdrop, .6, { autoAlpha: num, ease:Expo.easeIn});
		}
		public function hideBackdrop(){
			TweenLite.to(_backdrop, .8, { autoAlpha:0, ease:Expo.easeIn});
		}

	}

};

