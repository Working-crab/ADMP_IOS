//
//  NetworkServiceProtocol.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 22.05.2023.
//

import Foundation

protocol NetworkServiceProtocol {
	func request<Request: DataRequest>(_ request: Request) async throws -> Request.Response
}
