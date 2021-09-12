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
		static let stepsLabelFormat = " steps"
	}
	
	var viewModel: StepsViewModel?
	
	private lazy var dateLabel: UILabel = {
		let label = UILabel()
		label.text = "Date"
		label.font = StyleConstants.normalFont
		
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var stepsLabel: UILabel = {
		let label = UILabel()
		label.text = "0" + Constants.stepsLabelFormat
		label.font = StyleConstants.normalFont
		
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
	
	func refreshUI() {
		self.updateColors()
	}
	
	// MARK: Private
	
	private func configureUI() {
		self.layer.cornerRadius = StyleConstants.standardCornerRadius
		
		self.addSubview(self.dateLabel)
		NSLayoutConstraint.activate([
			self.dateLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
			self.dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
		])
		
		self.addSubview(self.stepsLabel)
		NSLayoutConstraint.activate([
			self.stepsLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
			self.stepsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
		])
		
		self.updateColors()
	}
	
	private func updateColors() {
		UIView.animate(withDuration: 0.5) { [weak self] in
			guard let self = self else { return }
			self.backgroundColor = ColorUtils.normalBackgroundColor(isInLightMode: self.isInLightMode)
			self.dateLabel.textColor = ColorUtils.textColor(isLightMode: self.isInLightMode)
			self.stepsLabel.textColor = ColorUtils.textColor(isLightMode: self.isInLightMode)
		}
	}
	
	private func set(numberOfSteps: Int) {
		self.stepsLabel.text = "\(numberOfSteps)" + Constants.stepsLabelFormat
	}
	
	private func setDayCountingBackFromToday(_ day: Int) {
		self.dateLabel.text = DateUtils.naturalLanguageDate(from: day)
	}
} 
