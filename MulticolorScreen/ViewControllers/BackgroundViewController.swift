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
    private lazy var labelHEX: UILabel = {
        let label = setupLabel(text: "", size: 23)
        return label
    }()
    
    private lazy var labelRGB: UILabel = {
        let label = setupLabel(text: "", size: 23)
        return label
    }()
    
    var currentColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupBarButton()
        setupDesign()
        setupConstraints()
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
        setupSubviews(subviews: labelHEX, labelRGB)
        setupData(red: color.red, green: color.green, blue: color.blue)
    }
    
    private func setupSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    @objc private func showOptions() {
        let optionsVC = OptionsViewController()
        let navigationVC = UINavigationController(rootViewController: optionsVC)
        navigationVC.modalPresentationStyle = .fullScreen
        optionsVC.delegate = self
        optionsVC.currentColor = view.backgroundColor
        present(navigationVC, animated: true)
    }
    
    private func labelForHEX(red: CGFloat, green: CGFloat, blue: CGFloat) -> String {
        UIColor(red: red, green: green, blue: blue, alpha: 1).toHex()
    }
    
    private func labelForRGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> String {
        UIColor(red: red, green: green, blue: blue, alpha: 1).toRgb()
    }
    
    private func setupData(red: CGFloat, green: CGFloat, blue: CGFloat) {
        labelHEX.text = labelForHEX(red: red, green: green, blue: blue)
        labelRGB.text = labelForRGB(red: red, green: green, blue: blue)
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
        setupData(red: red, green: green, blue: blue)
    }
}

extension BackgroundViewController {
    private func setupLabel(text: String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.backgroundColor = .white.withAlphaComponent(0.4)
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.font = UIFont.systemFont(ofSize: size, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

extension BackgroundViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            labelHEX.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelHEX.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelHEX.bottomAnchor.constraint(equalTo: labelRGB.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            labelRGB.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelRGB.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelRGB.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
