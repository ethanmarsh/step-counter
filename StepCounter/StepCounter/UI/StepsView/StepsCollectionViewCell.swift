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
	
	var viewModel: StepsViewModel?
	
	private lazy var dateLabel: UILabel = {
		let label = UILabel()
		label.text = "Date"
		label.font = StyleConstants.normalFont
		label.textColor = ColorUtils.textColor(isLightMode: self.isInLightMode)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var stepsLabel: UILabel = {
		let label = UILabel()
		label.text = Constants.stepsLabelFormat + "0"
		label.font = StyleConstants.normalFont
		label.textColor = ColorUtils.textColor(isLightMode: self.isInLightMode)
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
	
	func customizeCell(using viewModel: StepsViewModel) {
		self.set(numberOfSteps: viewModel.numberOfSteps)
		self.setDayCountingBackFromToday(viewModel.dayIndex)
		self.viewModel = viewModel
	}
	
	// MARK: Private
	
	private func configureUI() {
		self.backgroundColor = ColorUtils.normalBackgroundColor(isInLightMode: self.isInLightMode)
		self.layer.cornerRadius = StyleConstants.standardCornerRadius
		
		self.addSubview(self.dateLabel)
		self.dateLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
		self.dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		
		self.addSubview(self.stepsLabel)
		self.stepsLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
		self.stepsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
	}
	
	private func set(numberOfSteps: Int) {
		self.stepsLabel.text = Constants.stepsLabelFormat + "\(numberOfSteps)"
	}
	
	private func setDayCountingBackFromToday(_ day: Int) {
		self.dateLabel.text = DateUtils.naturalLanguageDate(from: day)
	}
} 
