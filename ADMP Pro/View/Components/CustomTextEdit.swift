//
//  SearchView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 27.04.2023.
//

import SwiftUI

struct CustomTextEdit: View {
	
	var placeholder: String
	@Binding var text: String
	var isSecure: Bool = false
	
	var body: some View {
		Group {
			if isSecure {
				SecureField(placeholder, text: $text)
			} else {
				TextField(placeholder, text: $text)
			}
		}
		.padding(10)
		.background(Color.init(.systemGray6))
		.clipShape(Capsule())
	}
}
