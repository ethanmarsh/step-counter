//
//  StepsDetailViewController.swift
//  StepCounter
//
//  Created by Ethan Marsh on 9/12/21.
//

import Foundation
import UIKit

class StepsDetailViewController: UIViewController {
	private let viewModel: StepsViewModel
	
	private lazy var detailView: StepsDetailView = {
		StepsDetailView(viewModel: self.viewModel)
	}()
	
	init(viewModel: StepsViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		self.configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Private
	
	private func configureUI() {
		self.view = self.detailView
		self.title = DateUtils.naturalLanguageDate(from: self.viewModel.dayIndex)
	}
}
