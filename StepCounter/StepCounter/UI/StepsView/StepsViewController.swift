//
//  StepsViewController.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/11/21.
//

import UIKit

class StepsViewController: UIViewController {
	
	weak var coordinator: Coordinator?
	
	private lazy var stepsView: StepsView = {
		let stepsView = StepsView(stepDataProvider: self.stepDataProvider)
		stepsView.delegate = self
		return stepsView
	}()
	
	private let stepDataProvider: StepDataProvider
	
	init(stepDataProvider: StepDataProvider, coordinator: Coordinator) {
		self.stepDataProvider = stepDataProvider
		self.coordinator = coordinator
		
		super.init(nibName: nil, bundle: nil)
		self.configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}


	// MARK: Private
	
	private func configureUI() {
		self.view = self.stepsView
		self.navigationController?.navigationBar.prefersLargeTitles = true
		self.title = "Step Counter"
		self.navigationController?.navigationBar.sizeToFit()
	}
	
	private func configureNotifications() {
		let notificationCenter = NotificationCenter.default
		notificationCenter.addObserver(
			self,
			selector: #selector(self.applicationWillEnterForeground),
			name: UIApplication.willEnterForegroundNotification,
			object: nil
		)
	}
	
	@objc private func applicationWillEnterForeground() {
		if !self.stepDataProvider.isAuthorizedForStepData {
			self.coordinator?.reloadPrimaryViewController()
		}
	}
}

extension StepsViewController: StepsViewDelegate {
	func didSelectCell(with data: StepsViewModel) {
		/// Display detail view for day
		let detailViewController = StepsDetailViewController(viewModel: data)
		self.navigationController?.pushViewController(detailViewController, animated: true)
	}
}

