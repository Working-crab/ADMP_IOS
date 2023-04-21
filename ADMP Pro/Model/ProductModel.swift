//
//  ProductModel.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 21.04.2023.
//

import Foundation

struct Product: Identifiable {
	var id = UUID()
	var name: String
	var salesCount: Int
	
	init(id: UUID = UUID(), name: String, salesCount: Int) {
		self.id = id
		self.name = name
		self.salesCount = salesCount
	}
}
