package com.shearspire {
	import flash.display.*;
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class SSUtils {
		private static var loadTimer:int;
		private static var extended:Array = new Array("á","à","ä","é","è","ë","í","ì","ï","ó","ò","ö","ú","ù","ü","ñ","ř","ç","č");
		private static var basechar:Array = new Array("a","a","a","e","e","e","i","i","i","o","o","o","u","u","u","n","r","c","c");
		private static var apiURL:String;
		private static var theParent:MovieClip;
		public static var netcalls:Array;
		public static var theDays:Array = new Array("Sun","Mon","Tue","Wed","Thu","Fri","Sat");
		
		/**
		 * The SSUtils class contains public static functions for a variety of uses within the simulator
		 */
		public function SSUtils():void {
			//nothing here
		}
		/**
		 * Use the loadGraphics function to load images from local or online locations
		 * @param l Loader that will receive the image
		 * @param path String containing the path or url to the image file
		 * @param callBack Function for callback - this is usually a public function that smooths the image, adds it to the display list, and possibly resizes it
		 * @param errorCallBack Function for error callback in case there is a problem loading the file
		 * @example <code>SSUtils.loadGraphics(myLoader,"somedirectory/somefile.jpg",smoothFunction,errorFunction);</code>
		 * @returns nothing
		 */
		public static function loadGraphics(l:Loader,path:String,callBack:Function,errorCallBack:Function):void {
			trace('loading - ', path);
			l.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorCallBack);
			l.addEventListener(IOErrorEvent.IO_ERROR, errorCallBack);
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, callBack);
			var req:URLRequest=new URLRequest(path);
			l.load(req);
			//setTimeout(smoothLoader,500,l);
		}
		public static function setApiURL(url:String):void{
			apiURL = url;
		}
		/**
		 * setParent is a convenience function to store any object for later reference - rarely needed
		 * @param obj Any object such as a reference to the root
		 * @example <code>SSUtils.setParent(this);</code>
		 * @returns nothing
		 */
		public static function setParent(obj:*):void{
			theParent = obj as MovieClip;
		}
		/**
		 * a useful function for creating a clone of an object
		 * @param source Any object such as a reference to the root
		 * @example <code>SSUtils.clone(myObject);</code>
		 * @returns an object of unspecified type
		 */
		public static function clone(source:Object):* {
			var myBA:ByteArray = new ByteArray();
			myBA.writeObject(source);
			myBA.position = 0;
			return(myBA.readObject());
		}
		/**
		 * a useful function for determining if a child exists 
		 * @param instanceName the instance name whose existence you wish to confirm
		 * @param container a reference to the container you wish to examine
		 * @example <code>SSUtils.childExists("myChildClip",this.someDisplayObject);</code>
		 * @returns true or false
		 */
		public static function childExists(instanceName:String,container:Object):Boolean {
			return Boolean(container.getChildByName(instanceName))
		}
		/**
		 * searches through an array of objects for a property whose string content matches the search string
		 * @param array the Array of objects you wish to search
		 * @param prop string representation of the property to query
		 * @param searchTerm the string to search for
		 * @example <code>SSUtils.getObjectByProperty(arrayToSearch, 'objectProperty', 'searchterm');</code>
		 * @returns an object from the array that was searched
		 */
		public static function getObjectByProperty(array:Array, prop:String, searchTerm:String):Object{
			    for (var i:int = 0; i < array.length; i++) {
				        if (array[i][prop] == searchTerm) {
					         return array[i];
				        }
			    }
			    return null;
		}
		/**
		 * searches through an object to obtain all values associated with a given array of properties
		 * generally use this function when adding data to an sql database
		 * @param flds an array of property names
		 * @param row the object to search
		 * @example <code>SSUtils.getObjectData(arrayOfProps, someObject);</code>
		 * @returns an array of values (usually to add to an sql insert statement)
		 */
		public static function getObjectData(flds:Array,row:Object):Array {
			var returnArr:Array = new Array();
			for(var i:int=0;i<flds.length;i++){
				returnArr.push(row[flds[i]]);
			}
			return returnArr;
		}
		public static function vectorToArray(vector:*):Array {
			var n:int = vector.length;
			var a:Array = new Array();
			for (var i:int = 0; i < n; i++){
				a[i] = vector[i];
			}
			return a;
		}

		/**
		 * Generally not needed in our modern UTF-8 world
		 @return a string of base ascii lower case characters.
		 @param a String that may or may not contain extended ascii characters from the extended Array
		 @example <code>SSUtils.convertToBase("Beyoncé");</code>
		 */
		public static function convertToBase(s:String):String{
			var len:int = s.length;
			s = s.toLowerCase();
			var newText:String = "";
			for (var i:int=0;i<len;i++){
				var char:String = s.substring(i,i+1);
				for (var e:int = 0;e<extended.length;e++){
					if (extended[e] == char){
						char = basechar[e];
					}
				}
				newText += char;
			}
			return newText;
		}
		/**
		 * quick check to see if a character is a number or a letter
		 @return a boolean value indicating if the parameter passed was an alphanumeric character.
		 @param character a String consisting of one character (you can pass more but only the first is evaluated)
		 @example <code>SSUtils.isAlphaNumeric("d");</code>
	    */
		public static function isAlphaNumeric(character:String):Boolean {
			character = character.substring(0,1).toLowerCase();
			var validCharacters:Array = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9");
			for (var i:int=0;i<validCharacters.length;i++){
				if (validCharacters[i] == character){
					return true;
				}
			}
			return false;
		}
		public static function isLetter(character:String):Boolean {
			character = character.substring(0,1).toLowerCase();
			var validCharacters:Array = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z");
			for (var i:int=0;i<validCharacters.length;i++){
				if (validCharacters[i] == character){
					return true;
				}
			}
			return false;
		}
		/**
		 * obtains a random integer within a specified range of integers
		 * @param min minimum integer value to return
		 * @param max maximum integer value to return
		 * @example <code>SSUtils.randRange(1,10);</code>
		 * @returns a random integer within the specified range (inclusive)
		 */
		public static function randRange(min:int, max:int):int {
			var randomNum:Number = Math.floor(Math.random()*(max-min+1))+min;
			return randomNum;
		}
		/**
		 * obtains a suitable abbreviated string to fit within the bounds of the given text field
		 * @param txt a TextField containing some text
		 * @example <code>SSUtils.abbreviateText(myFld);</code>
		 * @returns a string wth ... at the end and assigns that string to the htmlText property of txt
		 */
		public static function abbreviateText(txt:TextField):String {
			var fldWidth:Number = txt.width;
			var newText:String = "";
			if (txt.textWidth>fldWidth) {
				var itFits:Boolean = false;
				while (!itFits) {
					var lastSpacePosition:Number = txt.text.lastIndexOf(" ");
					newText = txt.text.substring(0, lastSpacePosition)+"...";
					txt.htmlText = newText;
					if (txt.textWidth<=fldWidth) {
						itFits = true;
					}
				}
				return newText;
			} else {
				return txt.text;
			}
		}
		public static function toTitleCase( original:String ):String {
	      var words:Array = original.split( " " );
	      for (var i:int = 0; i < words.length; i++) {
	        words[i] = toInitialCap( words[i] );
	      }
	      return ( words.join( " " ) );
	    }
		public static function getCallLetters(netname:String):String {
			var newCall:String = netname.substring(0,6).toUpperCase();
			var tempCall:String = netcalls[netname.toLowerCase()] != undefined ? netcalls[netname.toLowerCase()] : "";
			if (tempCall != "") newCall = tempCall;
			if (newCall == "INDEMA") newCall = "";
			return newCall;			
		}
		public static function setNetCalls():void {
			trace ("Setting netCalls");
			netcalls = new Array();
			netcalls[String("COMCAST").toLowerCase()] = "";
			netcalls[String("INDEMAND").toLowerCase()] = "";
			
			netcalls[String("HBO").toLowerCase()] = "HBO";
			netcalls[String("Showtime").toLowerCase()] = "SHO";
			netcalls[String("Starz").toLowerCase()] = "STARZ";
			netcalls[String("Cinemax").toLowerCase()] = "MAX";
			netcalls[String("Encore").toLowerCase()] = "Encore";
			
			
			netcalls[String("ACTIVITY_TV").toLowerCase()] = "ATV";
			netcalls[String("ADULTSWIM").toLowerCase()] = "ADSM";
			netcalls[String("Funimation").toLowerCase()] = "FUN";
			netcalls[String("BOOMERANG").toLowerCase()] = "BOOM";
			netcalls[String("CARTOON NETWORK").toLowerCase()] = "TOON";
			netcalls[String("CARTOONNETWORK").toLowerCase()] = "TOON";
			netcalls[String("CBS_HD").toLowerCase()] = "CBS";
			netcalls[String("CBS_NETSHOWS").toLowerCase()] = "CBS";
			netcalls[String("COLLEGE_FBALL").toLowerCase()] = "CSS";
			
			netcalls[String("COMEDYCENTRAL").toLowerCase()] = "Comedy";
			netcalls[String("COMEDYCENTRAL_HD").toLowerCase()] = "Comedy";
			netcalls[String("Get Up & Dance").toLowerCase()] = "GUAD";
			netcalls[String("The Singles Life").toLowerCase()] = "SL";
			netcalls[String("Hip Hop On Demand").toLowerCase()] = "HHOD";
			netcalls[String("ESPN_HD").toLowerCase()] = "ESPN";
			netcalls[String("FEARNET").toLowerCase()] = "FEAR";
			netcalls[String("FEARNET_ESP").toLowerCase()] = "FEAR";
			netcalls[String("FEARNET_HD").toLowerCase()] = "FEAR";
			netcalls[String("Exercise TV").toLowerCase()] = "ExTV";
			netcalls[String("FOX_NETSHOWS").toLowerCase()] = "FOX";
			netcalls[String("FOX_NETSHOWS_C3").toLowerCase()] = "FOX";
			netcalls[String("FOX_NETSHOWS_HD").toLowerCase()] = "FOX";
			netcalls[String("FOXNETSHOWS_HD_C3").toLowerCase()] = "FOX";
			netcalls[String("GAMBLING").toLowerCase()] = "news";
			netcalls[String("GOLFCHANNEL").toLowerCase()] = "GOLF";
			netcalls[String("IFC In Theaters").toLowerCase()] = "IFCIT";
			netcalls[String("IFCINTHEATERS_HD").toLowerCase()] = "IFCIT";
			netcalls[String("IMPACT").toLowerCase()] = "IMPACT";
			netcalls[String("IMPACT_HD").toLowerCase()] = "IMPACT";
			netcalls[String("KABILLION").toLowerCase()] = "KAB";
			netcalls[String("").toLowerCase()] = "KABIL";
			netcalls[String("KARAOKE").toLowerCase()] = "TKC";
			netcalls[String("4 Kids TV").toLowerCase()] = "4KID";
			netcalls[String("KIDZBOP").toLowerCase()] = "KB";
			netcalls[String("KPOP").toLowerCase()] = "KPOP";
			netcalls[String("LEGO_TV").toLowerCase()] = "LEGO";
			netcalls[String("MARTHA_STEWART").toLowerCase()] = "MSTEW";
			netcalls[String("NBA").toLowerCase()] = "NBATV";
			netcalls[String("PARANORMAL").toLowerCase()] = "PARA";
			netcalls[String("Parents TV").toLowerCase()] = "PARTV";
			netcalls[String("PBS").toLowerCase()] = "PBS";
			netcalls[String("PBS_HD").toLowerCase()] = "PBS";
			netcalls[String("PENTHOUSE").toLowerCase()] = "PENTTV";
			netcalls[String("Pet Adoptions").toLowerCase()] = "PETS";
			netcalls[String("Baby Boost").toLowerCase()] = "BAB";
			netcalls[String("SCENE_IT").toLowerCase()] = "TRIV";
			netcalls[String("SCREENSAVERS").toLowerCase()] = "SCRSD";
			netcalls[String("SCREENSAVERS_HD").toLowerCase()] = "SCRHD";
			netcalls[String("SICKMOVES").toLowerCase()] = "SICK";
			netcalls[String("STUPID_VIDEOS").toLowerCase()] = "STUP";
			netcalls[String("TBS").toLowerCase()] = "TBS";
			netcalls[String("TCM").toLowerCase()] = "TCM";
			netcalls[String("TEN").toLowerCase()] = "TEN";
			netcalls[String("TNT").toLowerCase()] = "TNT";
			netcalls[String("TNT_HD").toLowerCase()] = "TNT";
			netcalls[String("Pre K Kids").toLowerCase()] = "PRE.K";
			netcalls[String("VERSUS").toLowerCase()] = "VERSUS";
			netcalls[String("VERSUS_HD").toLowerCase()] = "VERSUS";
			netcalls[String("VIDEODETECTIVE").toLowerCase()] = "TRAIL";
			netcalls[String("Something Weird").toLowerCase()] = "SW";
			netcalls[String("UFC event replays").toLowerCase()] = "UFC";
			netcalls[String("WWE event replays").toLowerCase()] = "WWE";
			netcalls[String("Too Much For TV").toLowerCase()] = "TMUCH";
			netcalls[String("Bollywood Hits").toLowerCase()] = "BOLLY";
			netcalls[String("Howard Stern").toLowerCase()] = "STERN";
			netcalls[String("AQUARIUS").toLowerCase()] = "Taboo";
			netcalls[String("BIG TEN NETWORK").toLowerCase()] = "BTN";
			netcalls[String("BIG10_HD").toLowerCase()] = "BTNHD";
			netcalls[String("BRAVO").toLowerCase()] = "Bravo";
			netcalls[String("BRAVO_HD").toLowerCase()] = "Bravo";
			netcalls[String("BuenaVista").toLowerCase()] = "DFM";
			netcalls[String("CONCERT").toLowerCase()] = "CTV";
			netcalls[String("FOODNETWORK").toLowerCase()] = "FOOD";
			netcalls[String("FUSE").toLowerCase()] = "fuse";
			netcalls[String("HGTV").toLowerCase()] = "HGTV";
			netcalls[String("HUSTLER TV").toLowerCase()] = "HUSTLR";
			netcalls[String("Lifetime").toLowerCase()] = "LIFE";
			netcalls[String("MAGRACK").toLowerCase()] = "MGRACK";
			netcalls[String("MUNDOS").toLowerCase()] = "mun2";
			netcalls[String("NATIONALGEOGRAPHIC").toLowerCase()] = "NATGEO ";
			netcalls[String("NBC_NETSHOWS").toLowerCase()] = "NBC";
			netcalls[String("NBC_NETSHOWS_HD").toLowerCase()] = "NBC";
			netcalls[String("NBU_UNI").toLowerCase()] = "NBC";
			netcalls[String("NFLNetwork").toLowerCase()] = "NFLN";
			netcalls[String("Ovation").toLowerCase()] = "OVTV";
			netcalls[String("SPSK").toLowerCase()] = "SPRTSK";
			netcalls[String("SUNDANCE").toLowerCase()] = "SUN";
			netcalls[String("Syfy").toLowerCase()] = "Syfy";
			netcalls[String("Sci Fi").toLowerCase()] = "Syfy";
			netcalls[String("Travel Channel Media").toLowerCase()] = "TRAV";
			netcalls[String("UFC").toLowerCase()] = "UFC";
			netcalls[String("UNIVERSAL").toLowerCase()] = "Syfy";
			netcalls[String("UNIVERSAL_HD").toLowerCase()] = "Syfy";
			netcalls[String("USA").toLowerCase()] = "usa";
			netcalls[String("USANETWORK").toLowerCase()] = "usa";
			netcalls[String("NBCU_DIGITAL").toLowerCase()] = "NBC";
			netcalls[String("NBCU_DIGITAL_HD").toLowerCase()] = "NBC";
			netcalls[String("Syfy_HD").toLowerCase()] = "Syfy";
			netcalls[String("TVN_GAY").toLowerCase()] = "HUSTLR";
			netcalls[String("USA_HD").toLowerCase()] = "usa";
			netcalls[String("THE SPORTSMAN CHANNEL").toLowerCase()] = "SPMN";
			netcalls[String("Spike TV").toLowerCase()] = "SPIKE";
			netcalls[String("Spike TV HD").toLowerCase()] = "SPIKE";
			netcalls[String("BLOOMBERG").toLowerCase()] = "BLOOM";
			netcalls[String("BET").toLowerCase()] = "BET";
			netcalls[String("BET HD").toLowerCase()] = "BETHD";
			netcalls[String("CMT").toLowerCase()] = "CMT";
			netcalls[String("LOGO").toLowerCase()] = "LOGO";
			netcalls[String("MTV").toLowerCase()] = "MTV";
			netcalls[String("MTVHD").toLowerCase()] = "MTVHD";
			netcalls[String("Comedy Central").toLowerCase()] = "Comedy";
			netcalls[String("Comedy Central HD").toLowerCase()] = "Comedy";
			netcalls[String("VH1").toLowerCase()] = "VH1";
			netcalls[String("VH1 HD").toLowerCase()] = "VH1HD";
			netcalls[String("Nickelodeon").toLowerCase()] = "nick";
			netcalls[String("Nickelodeon HD").toLowerCase()] = "nickHD";
			netcalls[String("TeenNick").toLowerCase()] = "TeenNk";
			netcalls[String("Nick Jr.").toLowerCase()] = "nickjr";
			netcalls[String("Food Network").toLowerCase()] = "FOODHD";
			netcalls[String("HGTV HD").toLowerCase()] = "HGTVHD";
			netcalls[String("Oxygen").toLowerCase()] = "Oxygen";
			netcalls[String("Telemundo").toLowerCase()] = "Tlmndo";
			netcalls[String("FUSE_HD").toLowerCase()] = "fuseHD";
		}
	    public static function getSortTitle(original:String):String {
			var newTitle:String = original;
	    	if (newTitle.toUpperCase().indexOf("THE ") == 0){
				newTitle = original.substring(4) + ", " + original.substring(0,3);
	    	}else{
				if (!isLetter(newTitle) && original.length > 0){
					//trace ("non-alpha start char detected as: " + original.substring(0,6) + " of " + original);
					if (original.indexOf("'")==0){
						newTitle = original.substring(1);
						//trace ("' detected, newTitle is: " + newTitle + " original was: " + original);
					}else{
						newTitle = "|##" + original;
					}
				}
	    	}
			return newTitle;
	    }
		public static function getDisplayTitle( original:String ):String {
			var theIndex:int = original.toUpperCase().indexOf(", THE");
			if (original.length >= 5 && theIndex == original.length-5){
				return "The " + original.substring(0,theIndex);
			}else{
				if (original.substring(0,3) == "|##"){
					return original.substring(3);
				}else{
					return original;
				}
			}
		}
	    public static function toInitialCap( original:String ):String {
	      return original.charAt( 0 ).toUpperCase(  ) + original.substr( 1 ).toLowerCase(  );
	    }
		/**
		 * converts seconds to minutes and returns a formatted string
		 * @param sec seconds
		 * @example <code>SSUtils.clockTime(72);</code>
		 * @returns a formatted string representing the clock time to display (ex. 01:12)
		 */
		public static function clockTime(sec:int):String{
			var minutes:int = Math.floor(sec/60);
			var seconds:int = sec - (minutes * 60);
			var clockString:String = minutes > 9 ? String(minutes) : "0" + String(minutes);
			clockString += ":";
			clockString += seconds > 9 ? String(seconds) : "0" + String(seconds);
			return clockString;
		}
		/**
		 * converts seconds to hours and minutes and returns a formatted string
		 * @param sec seconds
		 * @example <code>SSUtils.hourclockTime(5529);</code>
		 * @returns a formatted string representing the hourclockTime time to display (ex. 1:32:09)
		 */
		public static function hourclockTime(sec:int):String{
			var hours:int = Math.floor(sec/3600);
			var minutes:int = Math.floor((sec-(hours*3600))/60);
			var seconds:int = sec - (minutes * 60) - (hours*3600);
			var clockString:String = hours + ":";
			clockString += minutes > 9 ? String(minutes) : "0" + String(minutes);
			clockString += ":";
			clockString += seconds > 9 ? String(seconds) : "0" + String(seconds);
			return clockString;
		}
		/**
		 * converts epoch time (in milliseconds) to a local time string and formats for Comcast Simulator display
		 * modify this as needed if the standard way to display times needs to be changed
		 * @param utcms a standard epoch (UTC) time string
		 * @example <code>SSUtils.getDisplayTime(1246435200000);</code>
		 * @returns a formatted string representing the time to display (ex. 12:35p)
		 */
		public static function getDisplayTime(utcms:Number):String {
			var utc:Date = new Date(utcms);
			var hours:int = utc.getHours();
			var meridian:String = hours < 12 ? "a" : "p";
			var usahours = hours > 12 ? hours - 12 : hours;
			if (usahours == 0) usahours = 12;
			var minutes:int = utc.getMinutes();
			var seconds:int = utc.getSeconds();
			var clockString:String = usahours + ":";
			clockString += minutes > 9 ? String(minutes) : "0" + String(minutes);
			clockString += meridian.toLowerCase();
			return clockString;
		}
		/**
		 * get the day name to display
		 * @param utcms a standard epoch (UTC) time string
		 * @example <code>SSUtils.getDisplayDay(1246435200000);</code>
		 * @returns "Sun","Mon","Tue","Wed","Thu","Fri", or "Sat"
		 */
		public static function getDisplayDay(utcms:Number):String {
			var utc:Date = new Date(utcms);
			var day:String = theDays[utc.getDay()];
			return day;
		}
		/**
		 * get the date string to display - change this if you need a different format
		 * @param utcms a standard epoch (UTC) time string
		 * @example <code>SSUtils.getDisplayDate(1246435200000);</code>
		 * @returns a string representing the date (ex. 7/1/2009)
		 */
		public static function getDisplayDate(utcms:Number):String {
			var utc:Date = new Date(utcms);
			var datenum:int = utc.getDate();
			var monthnum:int = utc.getMonth() + 1;
			var yearnum:int = utc.getFullYear();
			var datestring:String = monthnum + "/" + datenum + "/" + (String(yearnum).substring(2));
			return datestring;
		}
		/**
		 * get the relative showtime as a formatted string - change this if you need a different format
		 * @param utc1 a standard epoch (UTC) time string
		 * @param utc2 a standard epoch (UTC) time string
		 * @example <code>SSUtils.getRelativeShowtime(1246435200000,1372550400000);</code>
		 * @returns a string representing the relative showtime (ex. "On Demand" or "Mon 1/23")
		 */
		public static function getRelativeShowtime(utc1:Number,utc2:Number):String {
			var utcdate1:Date = new Date(utc1);
			var datenum1:int = utcdate1.getDate();
			var monthnum1:int = utcdate1.getMonth() + 1;
			var yearnum1:int = utcdate1.getFullYear();
			
			var utcdate2:Date = new Date(utc2);
			var datenum2:int = utcdate2.getDate();
			var monthnum2:int = utcdate2.getMonth() + 1;
			var yearnum2:int = utcdate2.getFullYear();
			
			var now:Number = Search.getTonightNum();
			var midnight:Number = Search.getMidnight().time;
			var nowdate:Date = new Date(now);
			
			trace ("getRelativeShowtime received these ms values: " + utc1 + " " + utc2);
			trace ("getRelativeShowtime received these dates: " + new Date(utc1).toString() + " " + new Date(utc2).toString() );
			var sday:String = getDisplayDay(utc1);
			var eday:String = getDisplayDay(utc2);
			var sdate:String = getDisplayDate(utc1);
			var edate:String = getDisplayDate(utc2);
			var datesMatch:Boolean = (sdate == edate);
			var stime:String = getDisplayTime(utc1);
			var etime:String = getDisplayTime(utc2);
			var meridiansMatch:Boolean = (stime.substring(stime.length-1) == etime.substring(etime.length-1));
			var showtime:String = "";
			if (utc1 < midnight && utc2 < midnight){
				showtime = stime.substring(0,stime.length-1) + "-" + etime;
			}else{
				if (datenum1 - nowdate.getDate() > 6 || datenum1 - nowdate.getDate() < 0){
					sday = String(monthnum1) + "/" + String(datenum1);
				}
				showtime = sday + " " + stime;
				if (stime.indexOf(":00") > 0 && etime.indexOf(":00") > 0 && meridiansMatch){
					showtime = sday + " " + stime.substring(0,stime.indexOf(":")) + "-" + etime.substring(0,etime.indexOf(":")) + " " + etime.substring(etime.length-1);
				}
			}
			if (utcdate1.time < now) showtime = "On Now";
			if (utc1 == 0) showtime = "On Demand";
			return showtime;
		}
		/**
		 * get the next showtime as a formatted string - change this if you need a different format
		 * @param utc1 a standard epoch (UTC) time string
		 * @param utc2 a standard epoch (UTC) time string
		 * @example <code>SSUtils.getNextShowtime(1246435200000,1372550400000);</code>
		 * @returns a string representing the relative showtime (ex. "On Demand" or "Mon 1/23")
		 */
		public static function getNextShowtime(utc1:Number,utc2:Number):String {
			var utcdate1:Date = new Date(utc1);
			var datenum1:int = utcdate1.getDate();
			var monthnum1:int = utcdate1.getMonth() + 1;
			var yearnum1:int = utcdate1.getFullYear();
			
			var utcdate2:Date = new Date(utc2);
			var datenum2:int = utcdate2.getDate();
			var monthnum2:int = utcdate2.getMonth() + 1;
			var yearnum2:int = utcdate2.getFullYear();
			
			var now:Number = Search.getTonightNum();
			var midnight:Number = Search.getMidnight().time;
			var nowdate:Date = new Date(now);
			
			trace ("getNextShowtime received these ms values: " + utc1 + " " + utc2);
			trace ("getNextShowtime received these dates: " + new Date(utc1).toString() + " " + new Date(utc2).toString() );
			var sday:String = getDisplayDay(utc1);
			var eday:String = getDisplayDay(utc2);
			var sdate:String = getDisplayDate(utc1);
			var edate:String = getDisplayDate(utc2);
			var datesMatch:Boolean = (sdate == edate);
			var stime:String = getDisplayTime(utc1);
			var etime:String = getDisplayTime(utc2);
			var meridiansMatch:Boolean = (stime.substring(stime.length-1) == etime.substring(etime.length-1));
			var showtime:String = "";
			if (utc1 < midnight && utc2 < midnight){
				showtime = "Next on: " + stime.substring(0,stime.length-1) + "-" + etime;
			}else{
				if (datenum1 - nowdate.getDate() > 6 || datenum1 - nowdate.getDate() < 0){
					sday = String(monthnum1) + "/" + String(datenum1);
				}
				showtime = "Next on: " + sday + ", ";
				showtime += meridiansMatch ? stime.substring(0,stime.length-1) : stime;
				showtime += "-" + etime;
			}
			if (utcdate1.time < now) showtime = "On Now: " + stime.substring(0,stime.length-1) + "-" + etime;
			if (utc1 == 0) showtime = "On Demand";
			return showtime;
		}
		/**
		 * get an abbreviated showtime as a formatted string - change this if you need a different format
		 * @param utc1 a standard epoch (UTC) time string
		 * @param utc2 a standard epoch (UTC) time string
		 * @example <code>SSUtils.getNextShowtime(1246435200000,1372550400000);</code>
		 * @returns a string representing the relative showtime (ex. "On Demand" or "Mon 1/23")
		 */
		public static function getShortRelativeShowtime(utc1:Number,utc2:Number):String {
			var utcdate1:Date = new Date(utc1);
			var datenum1:int = utcdate1.getDate();
			var monthnum1:int = utcdate1.getMonth() + 1;
			var yearnum1:int = utcdate1.getFullYear();
			
			var utcdate2:Date = new Date(utc2);
			var datenum2:int = utcdate2.getDate();
			var monthnum2:int = utcdate2.getMonth() + 1;
			var yearnum2:int = utcdate2.getFullYear();
			
			var now:Number = Search.getTonightNum();
			var midnight:Number = Search.getMidnight().time;
			var nowdate:Date = new Date(now);
			trace ("getShortRelativeShowtime received these ms values: " + utc1 + " " + utc2);
			trace ("getShortRelativeShowtime received these dates: " + new Date(utc1).toString() + " " + new Date(utc2).toString() );
			var sday:String = getDisplayDay(utc1);
			var eday:String = getDisplayDay(utc2);
			var sdate:String = getDisplayDate(utc1);
			var edate:String = getDisplayDate(utc2);
			var datesMatch:Boolean = (sdate == edate);
			var stime:String = getDisplayTime(utc1);
			var etime:String = getDisplayTime(utc2);
			var smeridian:String = stime.substring(stime.length-1);
			var emeridian:String = etime.substring(stime.length-1);
			smeridian = smeridian == "p" ? "PM" : "AM";
			emeridian = emeridian == "p" ? "PM" : "AM";
			var meridiansMatch:Boolean = smeridian == emeridian;
			var showtime:String = "";
			if (utc1 < midnight && utc2 < midnight){
				showtime = stime.substring(0,stime.length-1) + " " + smeridian;
			}else{
				if (datenum1 - nowdate.getDate() > 6 || datenum1 - nowdate.getDate() < 0){
					sday = String(monthnum1) + "/" + String(datenum1);
				}
				showtime = sday;
			}
			if (utcdate1.time < now) showtime = "On Now";
			if (utc1 == 0) showtime = "On Demand";
			return showtime;
		}
		/**
		 * get the display showtime as a formatted string (for instant info) - change this if you need a different format
		 * @param utc1 a standard epoch (UTC) time string
		 * @param utc2 a standard epoch (UTC) time string
		 * @example <code>SSUtils.getNextShowtime(1246435200000,1372550400000);</code>
		 * @returns a string representing the relative showtime (ex. "Mon 1/23 7-9p")
		 */
		public static function getDisplayShowTime(utc1:Number,utc2:Number):String {
			//trace ("getDisplayShowTime received these ms values: " + utc1 + " " + utc2);
			//trace ("getDisplayShowTime received these dates: " + new Date(utc1).toString() + " " + new Date(utc2).toString() );
			var sday:String = getDisplayDay(utc1);
			var eday:String = getDisplayDay(utc2);
			var sdate:String = getDisplayDate(utc1);
			var edate:String = getDisplayDate(utc2);
			var datesMatch:Boolean = (sdate == edate);
			var stime:String = getDisplayTime(utc1);
			var etime:String = getDisplayTime(utc2);
			var meridiansMatch:Boolean = (stime.substring(stime.length-1) == etime.substring(etime.length-1));
			var showtime:String = "";
			if (datesMatch && meridiansMatch){
				showtime = sdate;// + " " + stime.substring(0,stime.length-1) + " - " + etime;
			}
			if (datesMatch && !meridiansMatch){
				showtime = sdate + " " + stime + " - " + etime;
			}
			if (!datesMatch){
				showtime = sdate + " " + stime + " - " + eday + " " + edate + " " + etime;
			}
			return showtime;
		}
		public static function getTimezone():Number	{
			// Create two dates: one summer and one winter
			var d1:Date = new Date(0,1,1);
			var d2:Date = new Date(0,6,1);
			 
			// largest value has no DST modifier
			var tzd:Number = Math.max( d1.timezoneOffset, d2.timezoneOffset );
			
			var now:Date = new Date();
			var ms:int = now.getTime() >= d2.getTime() ? d2.timezoneOffset : d1.timezoneOffset;;
			// convert to milliseconds
			return tzd * 60000;
			//return ms * 60000;
		}
		 
		public static function getDST( d:Date ):Number {
			var tzd:Number = getTimezone();
			var dst:Number = (d.timezoneOffset * 60000) - tzd;
			return dst;
		}
		public static function urlEncode(p:String):String {
			return escape(p);
		}
		public static function urlDecode(p:String):String {
			return unescape(p);
		}
		public static function convertEntities(p:String):String {
			var theEntities:Array = getEntities();
			var myPattern:RegExp;
			for (var e:int = 160; e<theEntities.length; e++) {
				if (theEntities[e]!=null) {
					myPattern = new RegExp(theEntities[e],"g");
					p = String(p.replace(myPattern, "&#"+e+";"));
				}
			}
			/*
			myPattern = new RegExp("{","gi");
			p = String(p.replace(myPattern, "<i>"));
			myPattern = new RegExp("}","gi");
			p = String(p.replace(myPattern, "</i>"));
			var squareBracketsFound:Boolean = p.indexOf("[")>=0 ? true : false;
			while (squareBracketsFound) {
				p = String(p.replace("[", "<b>"));
				p = String(p.replace("]", "</b>"));
				squareBracketsFound = p.indexOf("[")>=0 ? true : false;
			}
			*/
			return p;
		}
		public static function getCrossDomainImage(url:String, callback:Function):void {
			//download cross-domain image
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (event:Event):void 
			{
				//pipe the byteArray from the image to a new loader
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void
				{
					//The bytes that have been transformed into an image with no domain restrictions
					var pic = LoaderInfo(e.target).content;
					if(pic is flash.display.MovieClip) {
						var b:BitmapData = new BitmapData(pic.width, pic.height, true, 0x000000);
						b.draw(pic);
						pic = new Bitmap(b);
					}
					//send the image to the callback function
					callback(pic,url);
				});
				
				loader.loadBytes(event.target.bytes);
			});
			
			loader.load(new URLRequest(url));
		}
		/**
		 * loads an xml file and sends the event back to a callBack function
		 * @param xml a path to the xml file
		 * @param callBack a reference to a callback function to process the xml
		 * @example <code>SSUtils.loadXML("somedir/somefile.xml",this.processXML);</code>
		 * @returns nothing
		 */
		public static function loadXML(xml:String,callBack:Function):void {
			trace("xml path is: " + xml);
			var request1:URLRequest=new URLRequest(xml);
			var xmlLoader1:URLLoader=new URLLoader();
			xmlLoader1.addEventListener(Event.COMPLETE,callBack);
			xmlLoader1.addEventListener(IOErrorEvent.IO_ERROR,loadErrorHandler);
			xmlLoader1.load(request1);
		}
		/**
		 * removes namespace info from an xml object and returns a clean xml object
		 * @param resultXML an XML object
		 * @example <code>SSUtils.removeNS(myDirtyXML);</code>
		 * @returns an XML object with no namespace
		 */
		public static function removeNS(resultXML:XML):XML {
			// from http://brianmriley.wordpress.com/2008/03/14/remove-xml-namespaces-in-flex-or-as3/
			var xmlString:String;
			var xmlnsPattern:RegExp;
			var namespaceRemovedXML:String;
			var responseXML:XML;
			
			// convert it to a string
			xmlString = resultXML.toXMLString();
			
			// define the regex pattern to remove the namespaces from the string
			xmlnsPattern = new RegExp("xmlns[^\"]*\"[^\"]*\"", "gi");
			
			// remove the namespaces from the string representation of the XML
			namespaceRemovedXML = xmlString.replace(xmlnsPattern, "");
			
			// set the string rep. of the XML back to real XML
			responseXML = new XML(namespaceRemovedXML);
			
			return responseXML;
		}
		public static function loadErrorHandler(e:IOErrorEvent):void {
			trace("File not found.");
		}
		public static function goToURL(infoObj:Object,targetWindow:String):void {
			var url:String = infoObj.itemLocation;
            //var variables:URLVariables = new URLVariables();
            //variables.exampleSessionId = new Date().getTime();
            //variables.exampleUserLabel = "Your Name";
           	if (targetWindow == "") targetWindow = "_self";
            var request:URLRequest = new URLRequest(url);
            //request.data = variables;
            try {            
                navigateToURL(request,targetWindow);
            }
            catch (e:Error) {
                // handle error here
            }
        }
		public static function getEntities():Array {
			var entities:Array = new Array();
			entities[160]="&nbsp;";
			entities[161]="&iexcl;";
			entities[162]="&cent;";
			entities[163]="&pound;";
			entities[164]="&curren;";
			entities[165]="&yen;";
			entities[166]="&brvbar;";
			entities[167]="&sect;";
			entities[168]="&uml;";
			entities[169]="&copy;";
			entities[170]="&ordf;";
			entities[171]="&laquo;";
			entities[172]="&not;";
			entities[173]="&shy;";
			entities[174]="&reg;";
			entities[175]="&macr;";
			entities[176]="&deg;";
			entities[177]="&plusmn;";
			entities[178]="&sup2;";
			entities[179]="&sup3;";
			entities[180]="&acute;";
			entities[181]="&micro;";
			entities[182]="&para;";
			entities[183]="&middot;";
			entities[184]="&cedil;";
			entities[185]="&sup1;";
			entities[186]="&ordm;";
			entities[187]="&raquo;";
			entities[188]="&frac14;";
			entities[189]="&frac12;";
			entities[190]="&frac34;";
			entities[191]="&iquest;";
			entities[192]="&Agrave;";
			entities[193]="&Aacute;";
			entities[194]="&Acirc;";
			entities[195]="&Atilde;";
			entities[196]="&Auml;";
			entities[197]="&Aring;";
			entities[198]="&AElig;";
			entities[199]="&Ccedil;";
			entities[200]="&Egrave;";
			entities[201]="&Eacute;";
			entities[202]="&Ecirc;";
			entities[203]="&Euml;";
			entities[204]="&Igrave;";
			entities[205]="&Iacute;";
			entities[206]="&Icirc;";
			entities[207]="&Iuml;";
			entities[208]="&ETH;";
			entities[209]="&Ntilde;";
			entities[210]="&Ograve;";
			entities[211]="&Oacute;";
			entities[212]="&Ocirc;";
			entities[213]="&Otilde;";
			entities[214]="&Ouml;";
			entities[215]="&times;";
			entities[216]="&Oslash;";
			entities[217]="&Ugrave;";
			entities[218]="&Uacute;";
			entities[219]="&Ucirc;";
			entities[220]="&Uuml;";
			entities[221]="&Yacute;";
			entities[222]="&THORN;";
			entities[223]="&szlig;";
			entities[224]="&agrave;";
			entities[225]="&aacute;";
			entities[226]="&acirc;";
			entities[227]="&atilde;";
			entities[228]="&auml;";
			entities[229]="&aring;";
			entities[230]="&aelig;";
			entities[231]="&ccedil;";
			entities[232]="&egrave;";
			entities[233]="&eacute;";
			entities[234]="&ecirc;";
			entities[235]="&euml;";
			entities[236]="&igrave;";
			entities[237]="&iacute;";
			entities[238]="&icirc;";
			entities[239]="&iuml;";
			entities[240]="&eth;";
			entities[241]="&ntilde;";
			entities[242]="&ograve;";
			entities[243]="&oacute;";
			entities[244]="&ocirc;";
			entities[245]="&otilde;";
			entities[246]="&ouml;";
			entities[247]="&divide;";
			entities[248]="&oslash;";
			entities[249]="&ugrave;";
			entities[250]="&uacute;";
			entities[251]="&ucirc;";
			entities[252]="&uuml;";
			entities[253]="&yacute;";
			entities[254]="&thorn;";
			entities[255]="&yuml;";
			return entities;
		}
	}
}