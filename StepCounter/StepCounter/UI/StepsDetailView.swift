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
	
	private lazy var stepsLabel: UILabel = {
		let label = UILabel()
		label.text = "Number of steps - \(self.viewModel.numberOfSteps)"
		label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
		label.textColor = .yellow
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
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
		self.addSubview(self.stepsLabel)
		self.stepsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		self.stepsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
	}
} 
