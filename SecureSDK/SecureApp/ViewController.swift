//
//  ViewController.swift
//  SecureApp
//
//  Created by Simone Testa on 12/02/22.
//

import UIKit
import SecureSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        GithubService.shared.checkDeviceAndGetStargazers(for: "octocat", in: "hello-world") { result in
            switch result {
            case .success(let stagazers):
                print(stagazers)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        // Do any additional setup after loading the view.
    }


}

