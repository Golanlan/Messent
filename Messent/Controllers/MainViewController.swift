//
//  MainViewController.swift
//  EasyMessage
//
//  Created by Golan Shoval Gil on 12/04/2022.
//

import UIKit
import PhoneNumberKit

enum CustomError: Error {
    case urlError
}

class MainViewController: UIViewController {
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var pasteButton: UIButton!
    @IBOutlet weak var phoneTextField: PhoneNumberTextField!
    
    let phoneNumberKit = PhoneNumberKit()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTextField()
    }
    
    @IBAction func pasteButtonTapped(_ sender: UIButton) {
        phoneTextField.text =  UIPasteboard.general.string
    }
    
    private func setupNavigation() {
        let button = UIBarButtonItem(image: UIImage(systemName: "info"), style: .plain, target: self, action: #selector(openAboutController))
        
        navigationItem.setRightBarButton(button, animated: true)
    }
    
    private func setupTextField() {
        phoneTextField.withFlag = true
        phoneTextField.withExamplePlaceholder = true
        phoneTextField.withDefaultPickerUI = true
    }
    
    @objc private func openAboutController() {
        let viewController = AboutViewController(nibName: "AboutViewController", bundle: nil)
        present(viewController, animated: true)
    }


    @IBAction func sendButtonTapped(_ sender: UIButton) {
        do {
            let phoneNumber = try phoneNumberKit.parse(phoneTextField.text ?? "")
            let countryCode = phoneNumber.countryCode
            let nationalNumber = phoneNumber.nationalNumber
            
            guard let url = URL(string: "https://wa.me/\(countryCode)\(nationalNumber)") else {
                showError(CustomError.urlError)
                return
            }
            
            UIApplication.shared.open(url)
            
        } catch {
            showError(error)
        }
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

