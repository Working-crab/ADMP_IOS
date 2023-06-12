//
//  AuthViewModel.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 12.06.2023.
//

import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func register() async {
        
    }
}
