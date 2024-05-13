//
//  ViewController.swift
//  Practice_VoIP
//
//  Created by 유지호 on 5/13/24.
//

import UIKit

final class ViewController: BaseViewController {

    private lazy var receivingButton: UIButton = {
        let button = UIButton()
        button.setTitle("전화받기", for: .normal)
        button.configuration = .borderedProminent()
        button.addTarget(self, action: #selector(didTapReceivingButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var callingButton: UIButton = {
        let button = UIButton()
        button.setTitle("전화걸기", for: .normal)
        button.configuration = .borderedProminent()
        button.addTarget(self, action: #selector(didTapCallingButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
    }

    
    private func initLayout() {
        view.addSubview(receivingButton)
        view.addSubview(callingButton)
        
        NSLayoutConstraint.activate([
            receivingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            receivingButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            callingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            callingButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40)
        ])
    }
    
    @objc
    private func didTapReceivingButton() {
        print("receiving action")
    }
    
    @objc
    private func didTapCallingButton() {
        print("calling action")
    }

}

