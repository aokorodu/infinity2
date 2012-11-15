//
//  Featured Movies
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
	 public class Episodes extends EntityData{
		private var _episodeSets:Dictionary;
		public function Episodes(model:AppModel) {
		 super(model);
		
	
		}
		override public function init():void{
			var query:String = "SELECT title, episode_title, season_number, episode_number, short_synopsis, type, runtime2, genre, rating, network, year, price, img_poster, img_poster_big, img_long, actors, is_adult, is_cc, is_hd, is_samedaydvd, user_bookmarked, user_recorded, user_recordingon, user_seriesrecording, user_downloaded, user_watched, airing_time, critic_score, license_start, license_end FROM master WHERE title ="+model.episodes+"";
			this.title = "Get Episodes"
			this.getData(query, Entity, 6);	
			this._episodeSets = new Dictionary();		
		}
		
		override public function createMap():void {
			pageCount++
			
			// Get Episodes, create singualar and Divide by Seasons
			var row_title = result.data[0].TITLE+"_"+pageCount;
			var _entityarr = new Array()
			for(var movie:* in result.data) {

				_entityarr.push(result.data[movie]);
			}
	/*		this.model.addEpisodes(row_title , _entityarr);*/
			this._episodeSets[row_title] = _entityarr;
		
			if(!result.complete){
				selectStmt.next(6)
			}else{this.model.episodeSets = _episodeSets /* this.model.notifyObservers();*/ }
/*			this.model.addEpisodes(this);*/
			

		};

	}

};

