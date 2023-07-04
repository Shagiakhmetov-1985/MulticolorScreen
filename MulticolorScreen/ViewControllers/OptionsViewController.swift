//
//  OptionsViewController.swift
//  MulticolorScreen
//
//  Created by Marat Shagiakhmetov on 04.07.2023.
//

import UIKit

class OptionsViewController: UIViewController {
    private lazy var viewMultiColor: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 14
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var labelRed: UILabel = {
        let label = setupLabel(text: "Red", size: 16)
        return label
    }()
    
    private lazy var labelGreen: UILabel = {
        let label = setupLabel(text: "Green", size: 16)
        return label
    }()
    
    private lazy var labelBlue: UILabel = {
        let label = setupLabel(text: "Blue", size: 16)
        return label
    }()
    
    private lazy var labelNumberRed: UILabel = {
        let label = setupLabel(text: "0.00", size: 13)
        return label
    }()
    
    private lazy var labelNumberGreen: UILabel = {
        let label = setupLabel(text: "0.00", size: 13)
        return label
    }()
    
    private lazy var labelNumberBlue: UILabel = {
        let label = setupLabel(text: "0.00", size: 13)
        return label
    }()
    
    private lazy var sliderRed: UISlider = {
        let slider = setupSlider(color: .systemRed)
        return slider
    }()
    
    private lazy var sliderGreen: UISlider = {
        let slider = setupSlider(color: .systemGreen)
        return slider
    }()
    
    private lazy var sliderBlue: UISlider = {
        let slider = setupSlider(color: .systemBlue)
        return slider
    }()
    
    private lazy var textFieldRed: UITextField = {
        let textField = setupTextField(text: "0.00")
        return textField
    }()
    
    private lazy var textFieldGreen: UITextField = {
        let textField = setupTextField(text: "0.00")
        return textField
    }()
    
    private lazy var textFieldBlue: UITextField = {
        let textField = setupTextField(text: "0.00")
        return textField
    }()
    
    private lazy var buttonDone: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 11
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(done), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        setupConstraints()
    }
    
    private func setupDesign() {
        title = "Options"
        view.backgroundColor = .white
        setupSubviews(subviews: viewMultiColor,
                      labelRed, labelGreen, labelBlue, labelNumberRed,
                      labelNumberGreen, labelNumberBlue, buttonDone,
                      sliderRed, sliderGreen, sliderBlue,
                      textFieldRed, textFieldGreen, textFieldBlue)
    }
    
    private func setupSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    @objc private func done() {
        dismiss(animated: true)
    }
}

extension OptionsViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            viewMultiColor.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            viewMultiColor.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewMultiColor.heightAnchor.constraint(equalToConstant: 160),
            viewMultiColor.widthAnchor.constraint(equalToConstant: view.frame.width - 40)
        ])
        
        NSLayoutConstraint.activate([
            labelRed.topAnchor.constraint(equalTo: viewMultiColor.bottomAnchor, constant: 40),
            labelRed.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            labelGreen.topAnchor.constraint(equalTo: labelRed.bottomAnchor, constant: 20),
            labelGreen.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            labelBlue.topAnchor.constraint(equalTo: labelGreen.bottomAnchor, constant: 20),
            labelBlue.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            labelNumberRed.centerYAnchor.constraint(equalTo: labelRed.centerYAnchor),
            labelNumberRed.leadingAnchor.constraint(equalTo: labelNumberGreen.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelNumberGreen.centerYAnchor.constraint(equalTo: labelGreen.centerYAnchor),
            labelNumberGreen.leadingAnchor.constraint(equalTo: labelGreen.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            labelNumberBlue.centerYAnchor.constraint(equalTo: labelBlue.centerYAnchor),
            labelNumberBlue.leadingAnchor.constraint(equalTo: labelNumberGreen.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            sliderRed.centerYAnchor.constraint(equalTo: labelRed.centerYAnchor),
            sliderRed.leadingAnchor.constraint(equalTo: labelNumberRed.trailingAnchor, constant: 15),
            sliderRed.widthAnchor.constraint(equalToConstant: 170)
        ])
        
        NSLayoutConstraint.activate([
            sliderGreen.centerYAnchor.constraint(equalTo: labelGreen.centerYAnchor),
            sliderGreen.leadingAnchor.constraint(equalTo: labelNumberGreen.trailingAnchor, constant: 15),
            sliderGreen.widthAnchor.constraint(equalToConstant: 170)
        ])
        
        NSLayoutConstraint.activate([
            sliderBlue.centerYAnchor.constraint(equalTo: labelBlue.centerYAnchor),
            sliderBlue.leadingAnchor.constraint(equalTo: labelNumberBlue.trailingAnchor, constant: 15),
            sliderBlue.widthAnchor.constraint(equalToConstant: 170)
        ])
        
        NSLayoutConstraint.activate([
            textFieldRed.centerYAnchor.constraint(equalTo: labelRed.centerYAnchor),
            textFieldRed.leadingAnchor.constraint(equalTo: sliderRed.trailingAnchor, constant: 10),
            textFieldRed.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            textFieldGreen.centerYAnchor.constraint(equalTo: labelGreen.centerYAnchor),
            textFieldGreen.leadingAnchor.constraint(equalTo: sliderGreen.trailingAnchor, constant: 10),
            textFieldGreen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            textFieldBlue.centerYAnchor.constraint(equalTo: labelBlue.centerYAnchor),
            textFieldBlue.leadingAnchor.constraint(equalTo: sliderBlue.trailingAnchor, constant: 10),
            textFieldBlue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            buttonDone.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            buttonDone.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonDone.widthAnchor.constraint(equalToConstant: 140),
            buttonDone.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension OptionsViewController {
    private func setupLabel(text: String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: size)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func setupSlider(color: UIColor) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.5
        slider.minimumTrackTintColor = color
        slider.maximumTrackTintColor = color
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }
    
    private func setupTextField(text: String) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.text = text
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}
