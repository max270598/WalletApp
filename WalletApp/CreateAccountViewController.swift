//
//  CreateAccountViewController.swift
//  WalletApp
//
//  Created by Мах Ol on 07.03.2023.
//

import UIKit
import UniqueSDK

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var mnemonicTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func saveButtonAction(_ sender: Any) {
        guard let name = nameTextField.text,
              let address = addressTextField.text,
              let mnemonic = mnemonicTextField.text else { return }
        
        let account = UNQAccount(name: name, address: address, mnemonic: mnemonic)
        Unique.Account.addAccount(account)
        navigationController?.popViewController(animated: true)        
    }
}
