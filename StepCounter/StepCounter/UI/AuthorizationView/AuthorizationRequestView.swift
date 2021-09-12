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
		label.textColor = ColorUtils.textColor(isLightMode: self.isInLightMode)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var requestButton: UIButton = {
		let button = UIButton(type: .roundedRect)
		
		button.addTarget(self, action: #selector(didPressGrantAccessButton), for: .touchUpInside)
		
		let attributes = [
			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24),
			NSAttributedString.Key.foregroundColor: ColorUtils.textColor(isLightMode: self.isInLightMode),
		]
		let string = NSAttributedString(
			string: "GRANT ACCESS",
			attributes: attributes as [NSAttributedString.Key: AnyObject]?
		)
		button.setAttributedTitle(string, for: .normal)
		
		button.layer.borderWidth = 2
		button.layer.borderColor = ColorUtils.textColor(isLightMode: self.isInLightMode).cgColor
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
	
	// MARK: Private
	
	private func configureUI() {
		self.addSubview(self.stackView)
		self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		
		self.stackView.addArrangedSubview(self.requestLabel)
		self.stackView.addArrangedSubview(self.requestButton)
		
		self.requestLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
		self.requestButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
	}
	
	@objc private func didPressGrantAccessButton() {
		self.stepDataProvider.requestAuthorization { [weak self] _ in
			DispatchQueue.main.async {
				self?.delegate?.didUpdateAccess()
			}
		}
	}
}
