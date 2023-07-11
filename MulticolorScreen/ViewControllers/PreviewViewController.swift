//
//  PreviewViewController.swift
//  MulticolorScreen
//
//  Created by Marat Shagiakhmetov on 04.07.2023.
//

import UIKit

class PreviewViewController: UIViewController {
    private lazy var labelPreview: UILabel = {
        let label = setupLabel(text: "", size: 21, weight: .semibold)
        return label
    }()
    
    private lazy var labelToBack: UILabel = {
        let label = setupLabel(text: "Tap me to exit", size: 19, weight: .light)
        return label
    }()
    
    var delegate: BackgroundViewControllerDelegate!
    var currentColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        setupConstraints()
        acceptColorForView()
        acceptColorForLabel()
    }
    
    private func setupDesign() {
        setupSubviews(subviews: labelPreview, labelToBack)
    }
    
    private func setupSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func acceptColorForView() {
        view.backgroundColor = currentColor
    }
    
    private func acceptColorForLabel() {
        let color = CIColor(color: currentColor)
        let red = CGFloat(color.red)
        let green = CGFloat(color.green)
        let blue = CGFloat(color.blue)
        let colorHEX = UIColor(red: red, green: green, blue: blue, alpha: 1).toHex()
        let colorRGB = UIColor(red: red, green: green, blue: blue, alpha: 1).toRgb()
        
        labelPreview.text = """
        \(colorHEX)
        \(colorRGB)
        """
    }
}
// MARK: - Setup contraints
extension PreviewViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            labelPreview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelPreview.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            labelPreview.heightAnchor.constraint(equalToConstant: 55)
        ])
        
        NSLayoutConstraint.activate([
            labelToBack.topAnchor.constraint(equalTo: labelPreview.bottomAnchor, constant: 30),
            labelToBack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelToBack.widthAnchor.constraint(equalToConstant: 150),
            labelToBack.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
// MARK: - Subviews
extension PreviewViewController {
    private func setupLabel(text: String, size: CGFloat, weight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.backgroundColor = .white.withAlphaComponent(0.4)
        label.clipsToBounds = true
        label.layer.cornerRadius = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

extension PreviewViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: true)
    }
}
