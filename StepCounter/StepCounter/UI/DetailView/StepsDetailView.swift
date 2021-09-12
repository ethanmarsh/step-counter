//
//  StepsDetailView.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/12/21.
//

import Foundation
import UIKit

class StepsDetailView: UIView {
	private let viewModel: StepsViewModel
	
	private lazy var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.spacing = 16
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	init(viewModel: StepsViewModel) {
		self.viewModel = viewModel
		super.init(frame: .zero)
		self.configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Private
	private func configureUI() {
		self.addSubview(self.stackView)
		self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		
		let stepsText = "Number of steps - \(self.viewModel.numberOfSteps)"
		self.stackView.addArrangedSubview(Self.createLabel(with: stepsText))
		
		if let distance = self.viewModel.stepData.distance {
			let distanceText = String(format: "Distance - %.2f meters", distance.floatValue)
			self.stackView.addArrangedSubview(Self.createLabel(with: distanceText))
		}
		
		if let pace = self.viewModel.stepData.averageActivePace {
			let paceText = String(format: "Pace - %.2f meters/second", pace.floatValue)
			self.stackView.addArrangedSubview(Self.createLabel(with: paceText))
		}
		
		if let floorsAscended = self.viewModel.stepData.floorsAscended {
			let floorsUpText = "Floors ascended - \(floorsAscended)"
			self.stackView.addArrangedSubview(Self.createLabel(with: floorsUpText))
		}
		
		if let floorsDescended = self.viewModel.stepData.floorsDescended {
			let floorsDownText = "Floors descended - \(floorsDescended)"
			self.stackView.addArrangedSubview(Self.createLabel(with: floorsDownText))
		}
	}
	
	private static func createLabel(with text: String) -> UILabel {
		let label = UILabel()
		label.text = text
		label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
		label.textColor = .yellow
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
} 
