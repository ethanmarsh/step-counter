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
	
	private static let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		if let locale = Locale.preferredLanguages.first {
			formatter.locale = Locale(identifier: locale)
		}
		
		formatter.setLocalizedDateFormatFromTemplate("M.d.yyyy")
		return formatter
	}()
	
	private lazy var dateLabel: UILabel = {
		let label = UILabel()
		label.text = "Date"
		label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
		label.textColor = .yellow
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
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
	
	func setDayCountingBackFromToday(_ day: Int) {
		let dayString: String = {
			if day == 0 {
				return "Today"
			} else if day == 1 {
				return "Yesterday"
			} else {
				let calendar = Calendar.current
				let startOfToday = calendar.startOfDay(for: Date())
				guard let date = calendar.date(byAdding: .day, value: -day, to: startOfToday) else {
					return ""
				}
				
				return Self.dateFormatter.string(from: date)
			}
		}()
		
		self.dateLabel.text = dayString
	}
	
	// MARK: Private
	
	private func configureUI() {
		self.backgroundColor = .purple.withAlphaComponent(0.6)
		
		self.addSubview(self.dateLabel)
		self.dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		self.dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		
		self.addSubview(self.stepsLabel)
		self.stepsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		self.stepsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
	}
} 
