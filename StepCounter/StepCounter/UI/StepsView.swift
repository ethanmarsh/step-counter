//
//  StepsView.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/11/21.
//

import Foundation
import UIKit

class StepsView: UIView {
	private lazy var testTitle: UILabel = {
		let label = UILabel()
		label.text = "Step Counter"
		label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
		label.textColor = .yellow
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
		self.backgroundColor = .blue
		
		self.addSubview(self.testTitle)

		self.testTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
		self.testTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
	}
}
