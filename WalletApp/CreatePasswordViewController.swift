//
//  CreatePasswordViewController.swift
//  WalletApp
//
//  Created by Мах Ol on 07.03.2023.
//

import UIKit
import UniqueSDK

class CreatePasswordViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        guard let text = passwordTextField.text else { return }
        Unique.savePasscode(text)
        navigationController?.popViewController(animated: true)
    }
}
