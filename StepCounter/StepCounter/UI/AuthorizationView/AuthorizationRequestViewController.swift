//
//  AuthorizationRequestViewController.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/12/21.
//

import Foundation
import UIKit

class AuthorizationRequestViewController: UIViewController {
	
	weak var coordinator: Coordinator?
	
	private let stepDataProvider: StepDataProvider
	
	private lazy var requestView: AuthorizationRequestView = {
		let requestView = AuthorizationRequestView(stepDataProvider: self.stepDataProvider)
		requestView.delegate = self
		return requestView
	}()
	
	init(stepDataProvider: StepDataProvider, coordinator: Coordinator) {
		self.stepDataProvider = stepDataProvider
		self.coordinator = coordinator
		
		super.init(nibName: nil, bundle: nil)
		self.configureUI()
		self.configureNotifications()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Private
	
	private func configureUI() {
		self.view = self.requestView
		self.title = "Motion Data Permission"
	}
	
	private func configureNotifications() {
		let notificationCenter = NotificationCenter.default
		notificationCenter.addObserver(
			self,
			selector: #selector(self.applicationWillEnterForeground),
			name: UIApplication.willEnterForegroundNotification,
			object: nil
		)
		notificationCenter.addObserver(
			self, 
			selector: #selector(applicationDidBecomeActive), 
			name: UIApplication.didBecomeActiveNotification, 
			object: nil
		)
	}
	
	@objc private func applicationWillEnterForeground() {
		self.coordinator?.reloadPrimaryViewController()
	} 
	
	@objc private func applicationDidBecomeActive() {
		self.requestView.refreshUI()
	}
}

extension AuthorizationRequestViewController: AuthorizationRequestDelegate {
	func didUpdateAccess() {
		self.coordinator?.reloadPrimaryViewController()
	}
}
