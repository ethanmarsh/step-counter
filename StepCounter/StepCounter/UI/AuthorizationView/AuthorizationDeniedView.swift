//
//  AuthorizationDeniedView.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/12/21.
//

import Foundation
import UIKit

class AuthorizationDeniedView: UIView {
	private lazy var deniedLabel: UILabel = {
		let label = UILabel()
		label.text = "This app requires access to your motion data in order to run.\nPlease go to Settings and enable access."
		label.numberOfLines = 0
		label.textAlignment = .center
		label.font = StyleConstants.normalFont
		label.textColor = ColorUtils.textColor(isLightMode: self.isInLightMode)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	init() {
		super.init(frame: .zero)
		self.configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Private
	
	private func configureUI() {
		self.addSubview(self.deniedLabel)
		self.deniedLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		self.deniedLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		self.deniedLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
	}
}
