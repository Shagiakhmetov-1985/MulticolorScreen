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
        let label = setupLabel(text: "0.00", size: 16)
        return label
    }()
    
    private lazy var labelNumberGreen: UILabel = {
        let label = setupLabel(text: "0.00", size: 16)
        return label
    }()
    
    private lazy var labelNumberBlue: UILabel = {
        let label = setupLabel(text: "0.00", size: 16)
        return label
    }()
    
    private lazy var sliderRed: UISlider = {
        let slider = setupSlider(color: .systemRed)
        slider.addTarget(self, action: #selector(sliderValue), for: .valueChanged)
        return slider
    }()
    
    private lazy var sliderGreen: UISlider = {
        let slider = setupSlider(color: .systemGreen)
        slider.addTarget(self, action: #selector(sliderValue), for: .valueChanged)
        return slider
    }()
    
    private lazy var sliderBlue: UISlider = {
        let slider = setupSlider(color: .systemBlue)
        slider.addTarget(self, action: #selector(sliderValue), for: .valueChanged)
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
    
    var delegate: BackgroundViewControllerDelegate!
    var currentColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        setupConstraints()
        acceptColorFromMain()
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
    
    @objc private func sliderValue(_ sender: UISlider) {
        setupViewColor()
        
        switch sender {
        case sliderRed:
            setupLabelText(from: sliderRed)
            setupTextFieldText(from: sliderRed)
        case sliderGreen:
            setupLabelText(from: sliderGreen)
            setupTextFieldText(from: sliderGreen)
        default:
            setupLabelText(from: sliderBlue)
            setupTextFieldText(from: sliderBlue)
        }
    }
    
    private func setupViewColor() {
        viewMultiColor.backgroundColor = UIColor(
            red: CGFloat(sliderRed.value),
            green: CGFloat(sliderGreen.value),
            blue: CGFloat(sliderBlue.value),
            alpha: 1)
    }
    
    private func setupLabelText(from sliders: UISlider...) {
        sliders.forEach { slider in
            switch slider {
            case sliderRed: labelNumberRed.text = string(from: sliderRed)
            case sliderGreen: labelNumberGreen.text = string(from: sliderGreen)
            default: labelNumberBlue.text = string(from: sliderBlue)
            }
        }
    }
    
    private func setupTextFieldText(from sliders: UISlider...) {
        sliders.forEach { slider in
            switch slider {
            case sliderRed: textFieldRed.text = string(from: sliderRed)
            case sliderGreen: textFieldGreen.text = string(from: sliderGreen)
            default: textFieldBlue.text = string(from: sliderBlue)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    @objc private func done() {
        delegate.setupColor(color: viewMultiColor.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    @objc private func doneButton() {
        view.endEditing(true)
    }
    
    private func acceptColorFromMain() {
        viewMultiColor.backgroundColor = currentColor
        
        let color = CIColor(color: currentColor)
        sliderRed.value = Float(color.red)
        sliderGreen.value = Float(color.green)
        sliderBlue.value = Float(color.blue)
        
        setupLabelText(from: sliderRed, sliderGreen, sliderBlue)
        setupTextFieldText(from: sliderRed, sliderGreen, sliderBlue)
    }
}
// MARK: - Setup contraints
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
            labelNumberGreen.leadingAnchor.constraint(equalTo: labelGreen.trailingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            labelNumberBlue.centerYAnchor.constraint(equalTo: labelBlue.centerYAnchor),
            labelNumberBlue.leadingAnchor.constraint(equalTo: labelNumberGreen.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            sliderRed.centerYAnchor.constraint(equalTo: labelRed.centerYAnchor),
            sliderRed.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            sliderRed.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100)
        ])
        
        NSLayoutConstraint.activate([
            sliderGreen.centerYAnchor.constraint(equalTo: labelGreen.centerYAnchor),
            sliderGreen.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            sliderGreen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100)
        ])
        
        NSLayoutConstraint.activate([
            sliderBlue.centerYAnchor.constraint(equalTo: labelBlue.centerYAnchor),
            sliderBlue.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            sliderBlue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100)
        ])
        
        NSLayoutConstraint.activate([
            textFieldRed.centerYAnchor.constraint(equalTo: labelRed.centerYAnchor),
            textFieldRed.leadingAnchor.constraint(equalTo: sliderRed.trailingAnchor, constant: 15),
            textFieldRed.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            textFieldGreen.centerYAnchor.constraint(equalTo: labelGreen.centerYAnchor),
            textFieldGreen.leadingAnchor.constraint(equalTo: sliderGreen.trailingAnchor, constant: 15),
            textFieldGreen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            textFieldBlue.centerYAnchor.constraint(equalTo: labelBlue.centerYAnchor),
            textFieldBlue.leadingAnchor.constraint(equalTo: sliderBlue.trailingAnchor, constant: 15),
            textFieldBlue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            buttonDone.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            buttonDone.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonDone.widthAnchor.constraint(equalToConstant: 180),
            buttonDone.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
// MARK: - Subviews
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
        textField.keyboardType = .decimalPad
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}
// MARK: - Work with textFields, UITextFieldDelegate
extension OptionsViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        
        if let value = Float(newValue) {
            switch textField {
            case textFieldRed:
                sliderRed.setValue(value, animated: true)
                sliderValue(sliderRed)
            case textFieldGreen:
                sliderGreen.setValue(value, animated: true)
                sliderValue(sliderGreen)
            default:
                sliderBlue.setValue(value, animated: true)
                sliderValue(sliderBlue)
            }
            return
        }
        
        showAlert(title: "Wrong format!", message: "Please type correct format: '0.00'")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolBar = UIToolbar()
        textField.inputAccessoryView = keyboardToolBar
        keyboardToolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneButton))
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)
        
        keyboardToolBar.items = [flexBarButton, doneButton]
    }
}

extension OptionsViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
