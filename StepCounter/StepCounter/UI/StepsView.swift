//
//  StepsView.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/11/21.
//

import Foundation
import UIKit

class StepsView: UIView {
	private struct Constants {
		static let stepsViewCellIdentifier = "StepsViewCell"
		static let collectionViewItemSpacing: CGFloat = 16
		static let collectionViewHorizontalMargins: CGFloat = 32
		
		static let numberOfDaysToDisplay = 10
	}
	
	let collectionView = UICollectionView(
		frame: .zero,
		collectionViewLayout: UICollectionViewFlowLayout()
	)
	
	private let stepDataProvider: StepDataProvider
	
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
		self.backgroundColor = .systemBackground
		
		let collectionView = self.collectionView
		
		let layout = UICollectionViewFlowLayout()
		layout.sectionInsetReference = .fromSafeArea
		collectionView.collectionViewLayout = layout
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.allowsMultipleSelection = false
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = UIColor.clear
		collectionView.delaysContentTouches = false
		collectionView.isAccessibilityElement = false
		collectionView.register(
			StepsCollectionViewCell.self,
			forCellWithReuseIdentifier: Constants.stepsViewCellIdentifier
		)
		
		self.addSubview(collectionView)
		collectionView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
		collectionView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
		collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
	}
}

extension StepsView: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		Constants.numberOfDaysToDisplay
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = self.collectionView.dequeueReusableCell(
			withReuseIdentifier: Constants.stepsViewCellIdentifier,
			for: indexPath as IndexPath
		) as? StepsCollectionViewCell else {
			// Failed to case the cell to our expected type
			return UICollectionViewCell()
		}
		
		self.stepDataProvider.getStepData(forDayFromToday: indexPath.row) { stepData, error in
			guard let stepData = stepData else {
				return
			}
			DispatchQueue.main.async {
				cell.set(numberOfSteps: stepData.numberOfSteps.intValue)
				cell.setDayCountingBackFromToday(indexPath.row)
			}
		}
		
		return cell
	}
}

extension StepsView: UICollectionViewDelegate {
	func collectionView(
		_ collectionView: UICollectionView,
		didSelectItemAt indexPath: IndexPath
	) {
		
	}
}

extension StepsView: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAt section: Int
	) -> UIEdgeInsets {
		return UIEdgeInsets(
			top: 0,
			left: Constants.collectionViewHorizontalMargins,
			bottom: 0,
			right: Constants.collectionViewHorizontalMargins
		)
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumInteritemSpacingForSectionAt section: Int
	) -> CGFloat {
		Constants.collectionViewItemSpacing
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumLineSpacingForSectionAt section: Int
	) -> CGFloat {
		Constants.collectionViewItemSpacing
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		let width = self.frame.width - (Constants.collectionViewHorizontalMargins*2)
		return CGSize(width: width, height: 50)
	}
}
