package com.mhl.libs {
	
		import flash.display.MovieClip;	
		import com.greensock.*;
		import com.greensock.easing.*;
		import com.greensock.plugins.*;
		import com.greensock.loading.*;
		import com.greensock.events.LoaderEvent;
		import com.greensock.loading.display.*;
	
	 public class searchResults extends MovieClip{
		public var _library:MovieClip; 
		public var _holder:MovieClip;
		public var _daylight:lighting;
		
		public function searchResults(holder:MovieClip) {
			
			this._holder = holder;
		}
		public function create():void{
			
			this._library = new MovieClip;
			addChild(_library);
			
			_daylight = new lighting();
			_library.addChild(_daylight);
			_daylight.name = "_daylight"
			_daylight.alpha= .8;
			_daylight._txt.text = "searchResults"
			
		}
		
		public function kill():void{
			
			removeChild(_library);
			
			
		}
		
		public function moreDaylight(num:Number){
			TweenLite.to(_daylight, .6, { autoAlpha: num, ease:Expo.easeIn});
		}
		public function lessDaylight(){
			TweenLite.to(_daylight, .8, { autoAlpha:0, ease:Expo.easeIn});
		}

	}

};

