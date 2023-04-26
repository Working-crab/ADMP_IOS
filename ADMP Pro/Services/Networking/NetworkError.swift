//
//  NetworkError.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 26.04.2023.
//

import Foundation

enum NetworkError: Error {
	case badURL
	case badRequest
	case badResponse
}
