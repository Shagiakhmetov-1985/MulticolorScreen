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
        let view = setupView(border: 2, radius: 14)
        return view
    }()
    
    private lazy var viewHEX: UIView = {
        let view = setupView(radius: 8, color: .white)
        return view
    }()
    
    private lazy var viewRGB: UIView = {
        let view = setupView(radius: 8, color: .white)
        return view
    }()
    
    private lazy var labelRGB: UILabel = {
        let label = setupLabel(text: "RGB", size: 13, weight: .light,
                               alignment: .center)
        return label
    }()
    
    private lazy var labelRed: UILabel = {
        let label = setupLabel(text: "Red", size: 19, weight: .semibold)
        return label
    }()
    
    private lazy var labelRedCode: UILabel = {
        let label = setupLabel(text: "255", size: 19, weight: .semibold, alignment: .right)
        return label
    }()
    
    private lazy var labelGreen: UILabel = {
        let label = setupLabel(text: "Green", size: 19, weight: .semibold)
        return label
    }()
    
    private lazy var labelGreenCode: UILabel = {
        let label = setupLabel(text: "255", size: 19, weight: .semibold, alignment: .right)
        return label
    }()
    
    private lazy var labelBlue: UILabel = {
        let label = setupLabel(text: "Blue", size: 19, weight: .semibold)
        return label
    }()
    
    private lazy var labelBlueCode: UILabel = {
        let label = setupLabel(text: "255", size: 19, weight: .semibold, alignment: .right)
        return label
    }()
    
    private lazy var viewValueOfColors: UIView = {
        let view = setupView(radius: 8, color: .white)
        return view
    }()
    
    private lazy var labelValueOfColors: UILabel = {
        let label = setupLabel(text: "Value of colors", size: 13, weight: .light,
                               alignment: .center)
        return label
    }()
    
    private lazy var labelValueRed: UILabel = {
        let label = setupLabel(text: "Red", size: 19, weight: .semibold)
        return label
    }()
    
    private lazy var textFieldRed: UITextField = {
        let textField = setupTextField(text: "0.00")
        return textField
    }()
    
    private lazy var labelValueGreen: UILabel = {
        let label = setupLabel(text: "Green", size: 19, weight: .semibold)
        return label
    }()
    
    private lazy var textFieldGreen: UITextField = {
        let textField = setupTextField(text: "0.00")
        return textField
    }()
    
    private lazy var labelValueBlue: UILabel = {
        let label = setupLabel(text: "Blue", size: 19, weight: .semibold)
        return label
    }()
    
    private lazy var textFieldBlue: UITextField = {
        let textField = setupTextField(text: "0.00")
        return textField
    }()
    
    private lazy var labelHEX: UILabel = {
        let label = setupLabel(text: "HEX", size: 13, weight: .light,
                               alignment: .center)
        return label
    }()
    
    private lazy var labelHEXCode: UILabel = {
        let label = setupLabel(text: "#FFFFFF", size: 19, weight: .semibold,
                               alignment: .center)
        return label
    }()
    
    private lazy var viewSliders: UIView = {
        let view = setupView(radius: 8, color: .white)
        return view
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
    
    private lazy var buttonPreview: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Preview", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2973288298, green: 0.2973288298, blue: 0.2973288298, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showOptions), for: .touchUpInside)
        return button
    }()
    
    var currentColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupDesign()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupNavigationController() {
        title = "Multicolor Screen"
        navigationController?.navigationBar.prefersLargeTitles = false
        let appearance = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    private func setupDesign() {
        let color = StorageManager.shared.fetchBackgroundColor()
        viewMultiColor.backgroundColor = UIColor(
            red: color.red,
            green: color.green,
            blue: color.blue,
            alpha: 1)
        setupGradient(content: view)
        dataSliders(red: color.red, green: color.green, blue: color.blue)
        setupLabelTextRGB(from: sliderRed, sliderGreen, sliderBlue)
        setupTextFieldText(from: sliderRed, sliderGreen, sliderBlue)
        setupLabelTextHEX()
    }
    
    private func setupSubviews() {
        setupSubviews(subviews: viewMultiColor, viewHEX, labelHEX, labelHEXCode,
                      viewRGB, labelRGB, labelRed, labelRedCode, labelGreen,
                      labelGreenCode, labelBlue, labelBlueCode, viewValueOfColors,
                      labelValueOfColors, labelValueRed, labelValueGreen, labelValueBlue,
                      textFieldRed, textFieldGreen, textFieldBlue, viewSliders,
                      sliderRed, sliderGreen, sliderBlue, buttonPreview)
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
        
        setupLabelTextHEX()
        saveColor(color: viewMultiColor.backgroundColor ?? .white)
    }
    
    private func saveColor(color: UIColor) {
        let color = CIColor(color: color)
        let red = CGFloat(color.red)
        let green = CGFloat(color.green)
        let blue = CGFloat(color.blue)
        let background = Color(red: red, green: green, blue: blue)
        StorageManager.shared.saveBackground(color: background)
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
    
    private func setupLabelTextHEX() {
        labelHEXCode.text = viewMultiColor.backgroundColor?.toHex()
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
        saveColor(color: color)
        view.backgroundColor = color
    }
}
// MARK: - Subviews
extension BackgroundViewController {
    private func setupView(border: CGFloat? = nil, radius: CGFloat, color: UIColor? = nil) -> UIView {
        let view = UIView()
        view.layer.borderWidth = border ?? 0
        view.layer.cornerRadius = radius
        view.backgroundColor = color?.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func setupLabel(text: String, size: CGFloat, weight: UIFont.Weight,
                            alignment: NSTextAlignment? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = alignment ?? .left
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func setupSlider(color: UIColor) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.5
        slider.minimumTrackTintColor = color.withAlphaComponent(0.7)
        slider.maximumTrackTintColor = color.withAlphaComponent(0.7)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }
    
    private func setupTextField(text: String) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.text = text
        textField.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
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
            viewMultiColor.heightAnchor.constraint(equalToConstant: view.frame.width - 200),
            viewMultiColor.widthAnchor.constraint(equalToConstant: view.frame.width - 40)
        ])
        
        NSLayoutConstraint.activate([
            viewRGB.topAnchor.constraint(equalTo: viewMultiColor.bottomAnchor, constant: 20),
            viewRGB.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            viewRGB.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            viewRGB.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            labelRGB.topAnchor.constraint(equalTo: viewRGB.centerYAnchor, constant: 50),
            labelRGB.centerXAnchor.constraint(equalTo: viewRGB.centerXAnchor),
            labelRGB.heightAnchor.constraint(equalToConstant: 15),
            labelRGB.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            labelRed.bottomAnchor.constraint(equalTo: viewRGB.centerYAnchor, constant: -40),
            labelRed.centerXAnchor.constraint(equalTo: viewRGB.centerXAnchor, constant: -30),
            labelRed.heightAnchor.constraint(equalToConstant: 25),
            labelRed.widthAnchor.constraint(equalToConstant: 55)
        ])
        
        NSLayoutConstraint.activate([
            labelRedCode.bottomAnchor.constraint(equalTo: viewRGB.centerYAnchor, constant: -40),
            labelRedCode.centerXAnchor.constraint(equalTo: viewRGB.centerXAnchor, constant: 35),
            labelRedCode.heightAnchor.constraint(equalToConstant: 25),
            labelRedCode.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            labelGreen.topAnchor.constraint(equalTo: labelRed.bottomAnchor, constant: 15),
            labelGreen.centerXAnchor.constraint(equalTo: viewRGB.centerXAnchor, constant: -30),
            labelGreen.heightAnchor.constraint(equalToConstant: 25),
            labelGreen.widthAnchor.constraint(equalToConstant: 55)
        ])
        
        NSLayoutConstraint.activate([
            labelGreenCode.topAnchor.constraint(equalTo: labelRedCode.bottomAnchor, constant: 15),
            labelGreenCode.centerXAnchor.constraint(equalTo: viewRGB.centerXAnchor, constant: 35),
            labelGreenCode.heightAnchor.constraint(equalToConstant: 25),
            labelGreenCode.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            labelBlue.topAnchor.constraint(equalTo: labelGreen.bottomAnchor, constant: 15),
            labelBlue.centerXAnchor.constraint(equalTo: viewRGB.centerXAnchor, constant: -30),
            labelBlue.heightAnchor.constraint(equalToConstant: 25),
            labelBlue.widthAnchor.constraint(equalToConstant: 55)
        ])
        
        NSLayoutConstraint.activate([
            labelBlueCode.topAnchor.constraint(equalTo: labelGreenCode.bottomAnchor, constant: 15),
            labelBlueCode.centerXAnchor.constraint(equalTo: viewRGB.centerXAnchor, constant: 35),
            labelBlueCode.heightAnchor.constraint(equalToConstant: 25),
            labelBlueCode.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            viewValueOfColors.topAnchor.constraint(equalTo: viewMultiColor.bottomAnchor, constant: 20),
            viewValueOfColors.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewValueOfColors.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            viewValueOfColors.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            labelValueOfColors.topAnchor.constraint(equalTo: viewValueOfColors.centerYAnchor, constant: 50),
            labelValueOfColors.centerXAnchor.constraint(equalTo: viewValueOfColors.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            viewHEX.topAnchor.constraint(equalTo: viewRGB.bottomAnchor, constant: 20),
            viewHEX.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewHEX.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            viewHEX.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            labelHEX.topAnchor.constraint(equalTo: viewHEX.centerYAnchor, constant: 5),
            labelHEX.centerXAnchor.constraint(equalTo: viewHEX.centerXAnchor),
            labelHEX.heightAnchor.constraint(equalToConstant: 15),
            labelHEX.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            labelHEXCode.bottomAnchor.constraint(equalTo: viewHEX.centerYAnchor, constant: 2.5),
            labelHEXCode.centerXAnchor.constraint(equalTo: viewHEX.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelValueRed.bottomAnchor.constraint(equalTo: viewValueOfColors.centerYAnchor, constant: -40),
            labelValueRed.centerXAnchor.constraint(equalTo: viewValueOfColors.centerXAnchor, constant: -30),
            labelValueRed.heightAnchor.constraint(equalToConstant: 25),
            labelValueRed.widthAnchor.constraint(equalToConstant: 55)
        ])
        
        NSLayoutConstraint.activate([
            textFieldRed.bottomAnchor.constraint(equalTo: viewValueOfColors.centerYAnchor, constant: -40),
            textFieldRed.centerXAnchor.constraint(equalTo: viewValueOfColors.centerXAnchor, constant: 35),
            textFieldRed.heightAnchor.constraint(equalToConstant: 25),
            textFieldRed.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            labelValueGreen.topAnchor.constraint(equalTo: labelValueRed.bottomAnchor, constant: 15),
            labelValueGreen.centerXAnchor.constraint(equalTo: viewValueOfColors.centerXAnchor, constant: -30),
            labelValueGreen.heightAnchor.constraint(equalToConstant: 25),
            labelValueGreen.widthAnchor.constraint(equalToConstant: 55)
        ])
        
        NSLayoutConstraint.activate([
            textFieldGreen.topAnchor.constraint(equalTo: textFieldRed.bottomAnchor, constant: 15),
            textFieldGreen.centerXAnchor.constraint(equalTo: viewValueOfColors.centerXAnchor, constant: 35),
            textFieldGreen.heightAnchor.constraint(equalToConstant: 25),
            textFieldGreen.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            labelValueBlue.topAnchor.constraint(equalTo: labelValueGreen.bottomAnchor, constant: 15),
            labelValueBlue.centerXAnchor.constraint(equalTo: viewValueOfColors.centerXAnchor, constant: -30),
            labelValueBlue.heightAnchor.constraint(equalToConstant: 25),
            labelValueBlue.widthAnchor.constraint(equalToConstant: 55)
        ])
        
        NSLayoutConstraint.activate([
            textFieldBlue.topAnchor.constraint(equalTo: textFieldGreen.bottomAnchor, constant: 15),
            textFieldBlue.centerXAnchor.constraint(equalTo: viewValueOfColors.centerXAnchor, constant: 35),
            textFieldBlue.heightAnchor.constraint(equalToConstant: 25),
            textFieldBlue.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            viewSliders.topAnchor.constraint(equalTo: viewHEX.bottomAnchor, constant: 20),
            viewSliders.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewSliders.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            viewSliders.bottomAnchor.constraint(equalTo: sliderBlue.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            sliderRed.topAnchor.constraint(equalTo: viewSliders.topAnchor, constant: 10),
            sliderRed.leadingAnchor.constraint(equalTo: viewSliders.leadingAnchor, constant: 10),
            sliderRed.trailingAnchor.constraint(equalTo: viewSliders.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            sliderGreen.topAnchor.constraint(equalTo: sliderRed.bottomAnchor, constant: 10),
            sliderGreen.leadingAnchor.constraint(equalTo: viewSliders.leadingAnchor, constant: 10),
            sliderGreen.trailingAnchor.constraint(equalTo: viewSliders.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            sliderBlue.topAnchor.constraint(equalTo: sliderGreen.bottomAnchor, constant: 10),
            sliderBlue.leadingAnchor.constraint(equalTo: viewSliders.leadingAnchor, constant: 10),
            sliderBlue.trailingAnchor.constraint(equalTo: viewSliders.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            buttonPreview.topAnchor.constraint(equalTo: viewSliders.bottomAnchor, constant: 20),
            buttonPreview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonPreview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonPreview.heightAnchor.constraint(equalToConstant: 40)
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
        let gray = #colorLiteral(red: 0.5040225983, green: 0.5054638982, blue: 0.5244438648, alpha: 1)
        let ligthGray = #colorLiteral(red: 0.7863100767, green: 0.8085659146, blue: 0.8167006373, alpha: 1)
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [gray.cgColor, ligthGray.cgColor, gray.cgColor]
        content.layer.addSublayer(gradientLayer)
    }
}
