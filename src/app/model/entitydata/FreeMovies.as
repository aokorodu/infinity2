//
//  Free Movies
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
	 public class FreeMovies extends EntityData{
		public function FreeMovies(model:AppModel) {
		 super(model);
		init();
		}
		override public function init():void{

			var query:String = "SELECT title, episode_title, season_number, episode_number, short_synopsis, type, runtime2, genre, rating, network, year, price, img_poster, img_poster_big, img_long, actors, is_adult, is_cc, is_hd, is_samedaydvd, user_bookmarked, user_recorded, user_recordingon, user_seriesrecording, user_downloaded, user_watched, airing_time, critic_score, license_start, license_end FROM master WHERE type = 'Movie' AND (price IS NULL OR price = '0')  GROUP BY title ORDER BY year DESC";
			this.title = "Free Movies";	
			this.getData(query, Entity, 12);							
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

