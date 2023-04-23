//
//  ProductModel.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 21.04.2023.
//

import Foundation

struct ProductRequest: Query {
	var keyword: String
}

struct ProductResponse: Query {
	var data: String
}

