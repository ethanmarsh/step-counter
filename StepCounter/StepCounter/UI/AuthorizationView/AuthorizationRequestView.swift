//
//  AuthorizationRequestView.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/12/21.
//

import Foundation
import UIKit

protocol AuthorizationRequestDelegate: AnyObject {
	func didUpdateAccess()
}

class AuthorizationRequestView: UIView {
	weak var delegate: AuthorizationRequestDelegate?
	
	private let stepDataProvider: StepDataProvider
	
	private lazy var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.spacing = StyleConstants.stackViewSpacing
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	private lazy var requestLabel: UILabel = {
		let label = UILabel()
		label.text = "This app requires access to your motion data in order to run."
		label.text = "This app requires access to your motion data in order to run.\nPlease go to Settings and enable access."
		label.numberOfLines = 0
		label.textAlignment = .center
		label.font = StyleConstants.normalFont
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var requestButton: UIButton = {
		let button = UIButton(type: .roundedRect)
		button.addTarget(self, action: #selector(didPressGrantAccessButton), for: .touchUpInside)
		button.layer.borderWidth = 2
		button.layer.cornerRadius = StyleConstants.roundedButtonRadius
		return button
	}()
	
	init(stepDataProvider: StepDataProvider) {
		self.stepDataProvider = stepDataProvider
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
		
		self.addSubview(self.stackView)
		NSLayoutConstraint.activate([
			self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
		])
		
		self.stackView.addArrangedSubview(self.requestLabel)
		self.stackView.addArrangedSubview(self.requestButton)
		
		NSLayoutConstraint.activate([
			self.requestLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
			self.requestButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
		])
		
		self.updateColors()
	}
	
	private func updateColors() {
		self.requestLabel.textColor = ColorUtils.textColor(isLightMode: self.isInLightMode)
		let attributes = [
			NSAttributedString.Key.font: StyleConstants.buttonFont,
			NSAttributedString.Key.foregroundColor: ColorUtils.textColor(isLightMode: self.isInLightMode),
		]
		let string = NSAttributedString(
			string: "GRANT ACCESS",
			attributes: attributes as [NSAttributedString.Key: AnyObject]?
		)
		self.requestButton.setAttributedTitle(string, for: .normal)
		self.requestButton.layer.borderColor = ColorUtils.textColor(isLightMode: self.isInLightMode).cgColor
	}
	
	@objc private func didPressGrantAccessButton() {
		self.stepDataProvider.requestAuthorization { [weak self] _ in
			DispatchQueue.main.async {
				self?.delegate?.didUpdateAccess()
			}
		}
	}
}
