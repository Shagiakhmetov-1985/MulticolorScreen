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
    private lazy var viewMultiColor: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 14
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var labelHEX: UILabel = {
        let label = setupLabel(text: "HEX", size: 17, weight: .light)
        return label
    }()
    
    private lazy var labelHEXCode: UILabel = {
        let label = setupLabel(text: "#FFFFFF", size: 17, weight: .light,
                               radius: 6, border: 0.75, background: .white)
        return label
    }()
    
    private lazy var labelRGB: UILabel = {
        let label = setupLabel(text: "RGB", size: 17, weight: .light)
        return label
    }()
    
    private lazy var labelRed: UILabel = {
        let label = setupLabel(text: "Red", size: 17, weight: .light)
        return label
    }()
    
    private lazy var labelRedCode: UILabel = {
        let label = setupLabel(text: "255", size: 17, weight: .light,
                               radius: 6, border: 0.75, background: .white)
        return label
    }()
    
    private lazy var labelGreen: UILabel = {
        let label = setupLabel(text: "Green", size: 17, weight: .light)
        return label
    }()
    
    private lazy var labelGreenCode: UILabel = {
        let label = setupLabel(text: "255", size: 17, weight: .light,
                               radius: 6, border: 0.75, background: .white)
        return label
    }()
    
    private lazy var labelBlue: UILabel = {
        let label = setupLabel(text: "Blue", size: 17, weight: .light)
        return label
    }()
    
    private lazy var labelBlueCode: UILabel = {
        let label = setupLabel(text: "255", size: 17, weight: .light,
                               radius: 6, border: 0.75, background: .white)
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
        viewMultiColor.backgroundColor = UIColor(
            red: color.red,
            green: color.green,
            blue: color.blue,
            alpha: 1)
        setupGradient(content: view)
        setupSubviews(subviews: viewMultiColor, labelHEX, labelHEXCode, labelRGB,
                      labelRed, labelRedCode, labelGreen, labelGreenCode,
                      labelBlue, labelBlueCode, sliderRed, sliderGreen, sliderBlue,
                      textFieldRed, textFieldGreen, textFieldBlue)
        dataSliders(red: color.red, green: color.green, blue: color.blue)
        setupLabelTextRGB(from: sliderRed, sliderGreen, sliderBlue)
        setupTextFieldText(from: sliderRed, sliderGreen, sliderBlue)
    }
    
    private func dataSliders(red: CGFloat, green: CGFloat, blue: CGFloat) {
        sliderRed.value = Float(red)
        sliderGreen.value = Float(green)
        sliderBlue.value = Float(blue)
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
        optionsVC.currentColor = viewMultiColor.backgroundColor
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
    
    @objc private func sliderValue(_ sender: UISlider) {
        setupViewColor()
        
        switch sender {
        case sliderRed:
            setupLabelTextRGB(from: sliderRed)
            setupTextFieldText(from: sliderRed)
        case sliderGreen:
            setupLabelTextRGB(from: sliderGreen)
            setupTextFieldText(from: sliderGreen)
        default:
            setupLabelTextRGB(from: sliderBlue)
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
    
    private func setupLabelTextRGB(from sliders: UISlider...) {
        sliders.forEach { slider in
            switch slider {
            case sliderRed: labelRedCode.text = convertToRGB(from: sliderRed)
            case sliderGreen: labelGreenCode.text = convertToRGB(from: sliderGreen)
            default: labelBlueCode.text = convertToRGB(from: sliderBlue)
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
    
    private func convertToRGB(from slider: UISlider) -> String {
        let color = slider.value * 255
        let colorRGB = String(format: "%.0f", color)
        return colorRGB
    }
    
    @objc private func doneButton() {
        view.endEditing(true)
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
// MARK: - Subviews
extension BackgroundViewController {
    private func setupLabel(text: String, size: CGFloat, weight: UIFont.Weight,
                            radius: CGFloat? = nil, border: CGFloat? = nil,
                            background: UIColor? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.backgroundColor = background ?? .clear
        label.clipsToBounds = true
        label.layer.cornerRadius = radius ?? 0
        label.layer.borderWidth = border ?? 0
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
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
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.textAlignment = .center
        textField.keyboardType = .decimalPad
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}
// MARK: - Constraints
extension BackgroundViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            viewMultiColor.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            viewMultiColor.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewMultiColor.heightAnchor.constraint(equalToConstant: view.frame.width - 120),
            viewMultiColor.widthAnchor.constraint(equalToConstant: view.frame.width - 40)
        ])
        
        NSLayoutConstraint.activate([
            labelHEX.topAnchor.constraint(equalTo: viewMultiColor.bottomAnchor, constant: 20),
            labelHEX.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelHEX.heightAnchor.constraint(equalToConstant: 30),
            labelHEX.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            labelHEXCode.topAnchor.constraint(equalTo: viewMultiColor.bottomAnchor, constant: 20),
            labelHEXCode.leadingAnchor.constraint(equalTo: labelHEX.trailingAnchor, constant: 5),
            labelHEXCode.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelHEXCode.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            labelRGB.topAnchor.constraint(equalTo: labelHEX.bottomAnchor, constant: 20),
            labelRGB.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelRGB.heightAnchor.constraint(equalToConstant: 30),
            labelRGB.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            labelRed.topAnchor.constraint(equalTo: labelHEXCode.bottomAnchor, constant: 20),
            labelRed.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            labelRedCode.topAnchor.constraint(equalTo: labelHEXCode.bottomAnchor, constant: 20),
            labelRedCode.leadingAnchor.constraint(equalTo: labelRed.trailingAnchor, constant: 7),
            labelRedCode.heightAnchor.constraint(equalToConstant: 30),
            labelRedCode.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            labelGreen.topAnchor.constraint(equalTo: labelHEXCode.bottomAnchor, constant: 20),
            labelGreen.leadingAnchor.constraint(equalTo: labelRedCode.trailingAnchor, constant: 7),
            labelGreen.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            labelGreenCode.topAnchor.constraint(equalTo: labelHEXCode.bottomAnchor, constant: 20),
            labelGreenCode.leadingAnchor.constraint(equalTo: labelGreen.trailingAnchor, constant: 7),
            labelGreenCode.heightAnchor.constraint(equalToConstant: 30),
            labelGreenCode.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            labelBlue.topAnchor.constraint(equalTo: labelHEXCode.bottomAnchor, constant: 20),
            labelBlue.leadingAnchor.constraint(equalTo: labelGreenCode.trailingAnchor, constant: 7),
            labelBlue.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            labelBlueCode.topAnchor.constraint(equalTo: labelHEXCode.bottomAnchor, constant: 20),
            labelBlueCode.leadingAnchor.constraint(equalTo: labelBlue.trailingAnchor, constant: 7),
            labelBlueCode.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelBlueCode.heightAnchor.constraint(equalToConstant: 30),
            labelBlueCode.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            sliderRed.topAnchor.constraint(equalTo: labelRGB.bottomAnchor, constant: 20),
            sliderRed.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sliderRed.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            sliderRed.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            sliderGreen.topAnchor.constraint(equalTo: sliderRed.bottomAnchor, constant: 20),
            sliderGreen.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sliderGreen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            sliderGreen.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            sliderBlue.topAnchor.constraint(equalTo: sliderGreen.bottomAnchor, constant: 20),
            sliderBlue.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sliderBlue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            sliderBlue.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            textFieldRed.topAnchor.constraint(equalTo: labelRGB.bottomAnchor, constant: 20),
            textFieldRed.leadingAnchor.constraint(equalTo: sliderRed.trailingAnchor, constant: 10),
            textFieldRed.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textFieldRed.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            textFieldGreen.topAnchor.constraint(equalTo: textFieldRed.bottomAnchor, constant: 20),
            textFieldGreen.leadingAnchor.constraint(equalTo: sliderGreen.trailingAnchor, constant: 10),
            textFieldGreen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textFieldGreen.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            textFieldBlue.topAnchor.constraint(equalTo: textFieldGreen.bottomAnchor, constant: 20),
            textFieldBlue.leadingAnchor.constraint(equalTo: sliderBlue.trailingAnchor, constant: 10),
            textFieldBlue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textFieldBlue.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
// MARK: - Work with textFields, UITextFieldDelegate
extension BackgroundViewController: UITextFieldDelegate {
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
// MARK: - Alert controller
extension BackgroundViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
// MARK: - Gradient
extension BackgroundViewController {
    private func setupGradient(content: UIView) {
        let gradientLayer = CAGradientLayer()
        let gray = #colorLiteral(red: 0.6518173814, green: 0.6577214599, blue: 0.6729313731, alpha: 1)
        let ligthGray = #colorLiteral(red: 0.9468761086, green: 0.9587963223, blue: 0.9585867524, alpha: 1)
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [gray.cgColor, ligthGray.cgColor, gray.cgColor]
        content.layer.addSublayer(gradientLayer)
    }
}
