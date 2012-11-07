﻿package app.model {	import app.*;	import app.model.*;	import app.view.*;	import app.control.*;	import com.mhl.data.database;	import flash.utils.Dictionary; 	import flash.data.SQLResult;	import flash.data.SQLStatement;	import com.mhl.views.entity;	import flash.events.EventDispatcher;	import flash.events.Event;		public class AppModel extends EventDispatcher {		public static const UPDATE:String='update';		private var _dataConn:DataConn;		private var _dbResult:SQLResult;		private var _sets:Dictionary;		private var _catalog:Array;			public function AppModel() {		this._dataConn = new DataConn(this);		this._sets = new Dictionary();		this._catalog = new Array();	}	public function addData(cat:EntityData):void{		_sets[cat.title] = cat.entitymap;	}	public function get categories():Dictionary{		return _sets	}	public function set catalog(value:Array){		this._catalog = value;			notifyObservers();	}	public function get catalog():Array{		return _catalog;	}	public function get dataConn():DataConn{		return _dataConn	}	// Dispatch to View and Model	function notifyObservers():void {		dispatchEvent(new Event(AppModel.UPDATE));	}	}}