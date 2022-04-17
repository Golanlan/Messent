//
//  AboutViewController.swift
//  EasyMessage
//
//  Created by Golan Shoval Gil on 12/04/2022.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var iconCreditLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gesture = UITapGestureRecognizer(target: self, action: #selector(openIconURL))
        iconCreditLabel.addGestureRecognizer(gesture)
        iconCreditLabel.isUserInteractionEnabled = true
    }
    
    @objc private func openIconURL() {
        if let url = URL(string: "https://www.flaticon.com/free-icons/send") {
            UIApplication.shared.open(url)
        }
    }
}
