//
//  AppController.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/12/21.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
	func reloadPrimaryViewController()
}

class AppController {
	
	var rootViewController: UIViewController
	
	private lazy var stepViewController: StepsViewController = {
		StepsViewController(stepDataProvider: self.stepDataProvider, coordinator: self)
	}()
	
	private lazy var authorizationRequestViewController: AuthorizationRequestViewController = {
		AuthorizationRequestViewController(stepDataProvider: self.stepDataProvider, coordinator: self)
	}()
	
	private lazy var authorizationDeniedViewController: AuthorizationDeniedViewController = {
		AuthorizationDeniedViewController(stepDataProvider: self.stepDataProvider, coordinator: self)
	}()
	
	private let navigationController: UINavigationController = {
		UINavigationController()
	}()
	
	private lazy var stepDataProvider: StepDataProvider = {
		let realProvider = CMStepDataProvider()
		if realProvider.isStepCountingAvailable {
			return realProvider
		} else {
			return MockStepDataProvider()
		}
	}()
	
	init() {
		self.rootViewController = self.navigationController
		self.loadPrimaryViewController()
	}
	
	private func loadPrimaryViewController() {
		if !self.stepDataProvider.hasAskedForAuthorization {
			self.navigationController.setViewControllers([self.authorizationRequestViewController], animated: false)
		} else if !self.stepDataProvider.isAuthorizedForStepData {
			self.navigationController.setViewControllers([self.authorizationDeniedViewController], animated: false)
		} else {
			self.navigationController.setViewControllers([self.stepViewController], animated: false)
		}
	}
}

extension AppController: Coordinator {
	func reloadPrimaryViewController() {
		self.loadPrimaryViewController()
	}
}
