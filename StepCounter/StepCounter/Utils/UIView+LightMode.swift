//
//  UIView+LightMode.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/12/21.
//

import Foundation
import UIKit

extension UIView {
	var isInLightMode: Bool {
		self.traitCollection.userInterfaceStyle == .light
	}
}
