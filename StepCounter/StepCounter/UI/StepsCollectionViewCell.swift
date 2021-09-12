//
//  StepsViewCell.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/12/21.
//

import Foundation
import UIKit

class StepsCollectionViewCell: UICollectionViewCell {
	private struct Constants {
		static let stepsLabelFormat = "Steps - "
	}
	
	private lazy var stepsLabel: UILabel = {
		let label = UILabel()
		label.text = Constants.stepsLabelFormat + "0"
		label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
		label.textColor = .yellow
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	// MARK: Public
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func set(numberOfSteps: Int) {
		self.stepsLabel.text = Constants.stepsLabelFormat + "\(numberOfSteps)"
	}
	
	// MARK: Private
	
	private func configureUI() {
		self.addSubview(self.stepsLabel)
		self.stepsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		self.stepsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
	}
} 
