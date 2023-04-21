//
//  GenerateProductView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 21.04.2023.
//

import SwiftUI

struct GenerateProductView: View {
    var body: some View {
			NavigationStack {
				Section {
					Text("test screen")
				} header: {
					Text("Header")
				}
				.navigationTitle("dwda")
				.navigationBarTitleDisplayMode(.inline)
				.toolbar {
					ToolbarItem {
						Text("dwawwwwssdwa")
					}
				}
			}
    }
}

struct GenerateProductView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateProductView()
    }
}
