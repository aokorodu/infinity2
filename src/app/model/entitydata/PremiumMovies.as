//
//  Recordings
//
//  Created by Matthew on 2012-11-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//
package app.model.entitydata {
	import com.mhl.*;
	import app.model.*;	
	import com.mhl.libs.recentActivity;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.Dictionary; 
	import fl.data.DataProvider;
	import flash.data.SQLResult;
	import flash.data.SQLConnection;
	import flash.filesystem.File;
	import flash.data.SQLStatement;
	import flash.data.SQLConnection;
	import flash.events.*;
	import flash.events.EventDispatcher;
	import flash.events.Event
	 public class PremiumMovies extends EntityData{
		public function PremiumMovies(model:AppModel) {
		 super(model);
		init();
		}
		override public function init():void{
			var Featured:String = "SELECT parentTitle, entityType, title, p, description FROM movies WHERE newforRelevance='true' ";
			this.title = "Premium Movies";	
			this.getData(Featured, Entity, 12);			
		}
		
		override public function createMap():void {
			pageCount++
			for(var movie:* in result.data) {
				this._entitymap.push(result.data[movie]);
			}
			this.model.addData(this);

		};

	}

};

