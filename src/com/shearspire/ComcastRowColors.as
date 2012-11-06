package com.shearspire {
	import fl.controls.listClasses.CellRenderer;
	import fl.controls.listClasses.ICellRenderer;
	
	/**
	 * This class sets the upSkin style based on the current item's rowColor value 
	 * in the data provider.
	 * Make sure the class is marked "public" and in the case of our custom cell renderer, 
	 * extends the CellRenderer class and implements the ICellRenderer interface.
	 */
	public class ComcastRowColors extends CellRenderer implements ICellRenderer {
		
		/**
		 * Constructor.
		 */
		public function ComcastRowColors():void {
			super();
		}
		
		/**
		 * This method returns the style definition object from the CellRenderer class.
		 */
		public static function getStyleDefinition():Object {
			return CellRenderer.getStyleDefinition();
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