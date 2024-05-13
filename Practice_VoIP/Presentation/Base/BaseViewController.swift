//
//  BaseViewController.swift
//  Practice_VoIP
//
//  Created by 유지호 on 5/13/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        view.endEditing(true)
    }

}
