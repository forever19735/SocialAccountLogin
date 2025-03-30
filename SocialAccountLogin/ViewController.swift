//
//  ViewController.swift
//  SocialAccountLogin
//
//  Created by 季紅 on 2025/3/27.
//

import UIKit

class ViewController: UIViewController {
    private let authenticator = ThirdPartyAuthenticator()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
            do {
                let model = try await authenticator.authenticate(with: .facebook, viewController: self)
                print(model)
            } catch {
                print("綁定失敗: \(error.localizedDescription)")
            }
        }
    }
}
