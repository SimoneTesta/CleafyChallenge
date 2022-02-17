//
//  ViewModel.swift
//  SecureApp
//
//  Created by Simone Testa on 17/02/22.
//

import Foundation
import SecureSDK

final class ViewModel {
    private var model: [StarGazersResponse]
    private var listener: ((Result<Void, Error>) -> Void)?
    
    var stargazers: [StarGazersResponse] { return model }
    
    var owner: String?
    var repository: String?
    
    init(model: [StarGazersResponse] = []) {
        self.model = model
    }
    
    func setCategoriesListener(listener: @escaping (Result<Void, Error>) -> Void) {
        self.listener = listener
    }
    
    func getStargazers() {
        guard let _owner = owner else { return }
        guard let _repository = repository else { return }
        
        GithubService.shared.checkDeviceAndGetStargazers(for: _owner, in: _repository) { [weak self] result in
            switch result {
            case .success(let stagazers):
                self?.model = stagazers
                self?.listener?(.success(()))
            case .failure(let error):
                self?.listener?(.failure(error))
            }
        }
    }
}
