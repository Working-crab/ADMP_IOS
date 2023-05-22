//
//  URLManager.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 26.04.2023.
//

import Foundation

class URLManager {
	static let shared = URLManager()
	
	private init () {}
	
	private let tunnel = "https://"
	private let server = "stage.admp.pro/api/v1"
	
	func createURL(endPoint point: EndPoint) -> String {
		let url = tunnel + server + point.rawValue
		return url
	}
}

enum EndPoint: String {
	case gpt = "/gpt-generate-card-description"
	case search = "/search-campaign-depth-of-market"
	case error = "/test500"
}
