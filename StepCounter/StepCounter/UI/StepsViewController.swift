//
//  ViewController.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/11/21.
//

import UIKit

class StepsViewController: UIViewController {
	private lazy var stepsView: StepsView = {
		StepsView()
	}()
	
	init() {
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
	}
}

