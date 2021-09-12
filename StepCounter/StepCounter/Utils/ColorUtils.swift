//
//  ColorUtils.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/12/21.
//

import Foundation
import UIKit

struct ColorUtils {	
	static func textColor(isLightMode: Bool) -> UIColor {
		isLightMode ? .darkText : .lightText
	}
	
	static func normalBackgroundColor(isInLightMode: Bool) -> UIColor {
		isInLightMode ? .lightGray : .darkGray
	}
	
	static func highlighedBackgroundColor(isInLightMode: Bool) -> UIColor {
		isInLightMode ? .darkGray : .lightGray
	}
	
	
}
