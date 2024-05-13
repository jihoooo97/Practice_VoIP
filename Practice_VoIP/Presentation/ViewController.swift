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
    private let cxCallController = CXCallController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
        
        CXCallDirectoryManager.sharedInstance.reloadExtension(withIdentifier: "com.jiho.Practice-VoIP.CallDirectory") { error in
            if let error {
                print(error)
            }
        }
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
        let handle = CXHandle(type: .emailAddress, value: "yyyy@naver.com")
        
        let startCallAction = CXStartCallAction(call: UUID(), handle: handle)
        let transaction = CXTransaction(action: startCallAction)
        
        self.cxCallController.request(transaction) { error in
            if let error {
                print(error)
            }
        }
    }

}


extension ViewController: CXProviderDelegate {

    func providerDidReset(_ provider: CXProvider) {
        
    }
    
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        action.fulfill()
    }
    
}
