//
//  MainViewController.swift
//  WalletApp
//
//  Created by Мах Ol on 07.03.2023.
//

import UIKit
import UniqueSDK

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Unique.setConfiguration(.opal)
    }
}

