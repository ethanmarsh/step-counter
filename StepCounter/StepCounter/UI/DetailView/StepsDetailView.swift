//
//  StepsDetailView.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/12/21.
//

import Foundation
import UIKit

class StepsDetailView: UIView {
	private struct Constants {
		static let containerMargin: CGFloat = 10
	}
	
	private let viewModel: StepsViewModel
	
	private lazy var container: UIView = {
		let container = UIView()
		container.layer.cornerRadius = StyleConstants.standardCornerRadius
		container.translatesAutoresizingMaskIntoConstraints = false
		return container
	}()
	
	private lazy var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.spacing = StyleConstants.stackViewSpacing
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
	
	func refreshUI() {
		self.updateColors()
	}
	
	// MARK: Private
	private func configureUI() {
		self.backgroundColor = .systemBackground
		
		self.addSubview(self.container)
		
		self.container.addSubview(self.stackView)
		
		NSLayoutConstraint.activate([
			self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			self.container.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: -Constants.containerMargin),
			self.container.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: Constants.containerMargin),
			self.container.topAnchor.constraint(equalTo: self.stackView.topAnchor, constant: -Constants.containerMargin),
			self.container.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: Constants.containerMargin),
		])
		
		let isLightMode = self.isInLightMode
		
		let stepsText = "Number of steps: \(self.viewModel.numberOfSteps)"
		self.stackView.addArrangedSubview(Self.createLabel(with: stepsText, lightMode: isLightMode))
		
		if let distance = self.viewModel.stepData.distance {
			let distanceText = String(format: "Distance: %.2f meters", distance.floatValue)
			self.stackView.addArrangedSubview(Self.createLabel(with: distanceText, lightMode: isLightMode))
		}
		
		if let pace = self.viewModel.stepData.averageActivePace {
			let paceText = String(format: "Pace: %.2f meters/second", pace.floatValue)
			self.stackView.addArrangedSubview(Self.createLabel(with: paceText, lightMode: isLightMode))
		}
		
		if let floorsAscended = self.viewModel.stepData.floorsAscended {
			let floorsUpText = "Floors ascended: \(floorsAscended)"
			self.stackView.addArrangedSubview(Self.createLabel(with: floorsUpText, lightMode: isLightMode))
		}
		
		if let floorsDescended = self.viewModel.stepData.floorsDescended {
			let floorsDownText = "Floors descended: \(floorsDescended)"
			self.stackView.addArrangedSubview(Self.createLabel(with: floorsDownText, lightMode: isLightMode))
		}
		
		self.updateColors()
	}
	
	private func updateColors() {
		UIView.animate(withDuration: 0.5) { [weak self] in
			guard let self = self else { return }
			let isLightMode = self.isInLightMode
			
			self.container.backgroundColor = ColorUtils.normalBackgroundColor(isInLightMode: isLightMode)
			self.stackView.arrangedSubviews.forEach { view in
				guard let label = view as? UILabel else {
					print("Error - Expected to have UILabels in this stack view")
					return
				}
				
				label.textColor = ColorUtils.textColor(isLightMode: isLightMode)
			}
		}
	}
	
	private static func createLabel(with text: String, lightMode: Bool) -> UILabel {
		let label = UILabel()
		label.text = text
		label.font = StyleConstants.normalFont
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
} 
