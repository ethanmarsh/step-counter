//
//  StepsCollectionViewHeader.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/12/21.
//

import Foundation
import UIKit

class StepsCollectionViewHeader: UICollectionReusableView {
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Step Counter"
		label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
		label.textColor = .white
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		self.configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureUI() {
		self.addSubview(self.titleLabel)

		self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		self.titleLabel.sizeToFit()
	}
}
