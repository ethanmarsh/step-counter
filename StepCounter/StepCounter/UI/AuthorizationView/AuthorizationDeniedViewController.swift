//
//  AuthorizationDeniedViewController.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/12/21.
//

import Foundation
import UIKit

class AuthorizationDeniedViewController: UIViewController {
	
	weak var coordinator: Coordinator?
	
	private let stepDataProvider: StepDataProvider
	
	private let deniedView: AuthorizationDeniedView = {
		AuthorizationDeniedView()
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
		self.view = self.deniedView
		self.title = "Motion Access Denied"
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
		if self.stepDataProvider.isAuthorizedForStepData {
			self.coordinator?.reloadPrimaryViewController()
		}
	}
}
