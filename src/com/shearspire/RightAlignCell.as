package com.shearspire {
	/* Import the required classes. Note that since this is an external .AS file and 
	not an .FLA file, most classes will not be automatically imported for you. */
	import fl.controls.listClasses.ICellRenderer;
	import fl.controls.listClasses.CellRenderer;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * The main class definition. Make sure the class is marked "public" and in the case
	 * of our custom cell renderer, extends the CellRenderer class and implements the
	 * ICellRenderer interface.
	 */
	public class RightAlignCell extends CellRenderer implements ICellRenderer {
		// Create a new private variable to hold the custom text format.
		private var tf:TextFormat;
		
		/**
		 * This method defines the TextFormat object and sets the align
		 * property to "right".
		 */
		public function RightAlignCell() {
			tf = new TextFormat();
			tf.align = TextFormatAlign.RIGHT;
		}
		
		/**
		 * Override the inherited drawLayout() method from the CellRenderer class.
		 * This method sets the text field's width to the width of the data grid column,
		 * applies the new text format using the setTextFormat() method, and calls the
		 * parent class's drawLayout() method. 
		 */
		override protected function drawLayout():void {
			textField.width = this.width;
			textField.setTextFormat(tf);
			super.drawLayout();
		}
		
		/** 
		 * This method overrides the inherited drawBackground() method and sets the renderer's
		 * upSkin style based on the row's rowColor value in the data provider. For example, 
		 * if the item's rowColor value is "green," the upSkin style is set to the 
		 * CellRenderer_upSkinGreen linkage in the library. If the rowColor value is "red," the
		 * upSkin style is set to the CellRenderer_upSkinRed linkage in the library.
		 */
		override protected function drawBackground():void {
			setStyle("overSkin",CellRenderer_overSkin_grid);
			switch (data.topCategoryName) {
				case "Movies" :
					setStyle("upSkin", CellRenderer_upSkinPurple);
					break;
				case "Sports" :
					setStyle("upSkin", CellRenderer_upSkinGreen);
					break;
				case "Kids" :
					setStyle("upSkin", CellRenderer_upSkinBlue);
					break;
				case "Other" :
					setStyle("upSkin", CellRenderer_upSkinNavy);
					break;
				default :
					setStyle("upSkin", CellRenderer_upSkinNavy);
					break;
			}
			super.drawBackground();
		}
	}
}