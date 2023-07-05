//
//  BackgroundViewController.swift
//  MulticolorScreen
//
//  Created by Marat Shagiakhmetov on 04.07.2023.
//

import UIKit

protocol BackgroundViewControllerDelegate {
    func setupColor(color: UIColor)
}

class BackgroundViewController: UIViewController {
    var currentColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupBarButton()
        setupDesign()
    }
    
    private func setupNavigationController() {
        title = "Multicolor Screen"
        navigationController?.navigationBar.prefersLargeTitles = false
        let appearance = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupBarButton() {
        let optionsBarButton = UIBarButtonItem(
            barButtonSystemItem: .compose,
            target: self,
            action: #selector(showOptions))
        
        navigationItem.rightBarButtonItem = optionsBarButton
    }
    
    private func setupDesign() {
        let color = StorageManager.shared.fetchBackgroundColor()
        view.backgroundColor = UIColor(
            red: color.red,
            green: color.green,
            blue: color.blue,
            alpha: 1)
    }
    
    @objc private func showOptions() {
        let optionsVC = OptionsViewController()
        let navigationVC = UINavigationController(rootViewController: optionsVC)
        navigationVC.modalPresentationStyle = .fullScreen
        optionsVC.delegate = self
        optionsVC.currentColor = view.backgroundColor
        present(navigationVC, animated: true)
    }
}

extension BackgroundViewController: BackgroundViewControllerDelegate {
    func setupColor(color: UIColor) {
        let color = CIColor(color: color)
        let red = CGFloat(color.red)
        let green = CGFloat(color.green)
        let blue = CGFloat(color.blue)
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        let background = Color(red: red, green: green, blue: blue)
        StorageManager.shared.saveBackground(color: background)
    }
}

