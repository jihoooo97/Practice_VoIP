//
//  ViewController.swift
//  Practice_VoIP
//
//  Created by 유지호 on 5/13/24.
//

import UIKit
import CallKit

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
    
    private let cxProvider = CXProvider(configuration: .init())
    
    
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
        cxProvider.setDelegate(self, queue: nil)
        
        let update = CXCallUpdate()
        update.remoteHandle = .init(type: .generic, value: "Jiho9")
        
        cxProvider.reportNewIncomingCall(with: UUID(), update: update) { error in
            if let error {
                print(error)
            }
        }
    }
    
    @objc
    private func didTapCallingButton() {
        print("calling action")
    }

}


extension ViewController: CXProviderDelegate {

    func providerDidReset(_ provider: CXProvider) {
        
    }
    
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        action.fulfill()
    }
    
}
