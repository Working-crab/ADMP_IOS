//
//  GPTRequest.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 23.04.2023.
//

import Foundation

struct GPTRequest: Query {
	var keyword: String
}

struct GPTResponse: Query {
	var data: String
}
