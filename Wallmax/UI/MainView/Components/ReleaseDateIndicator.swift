//
//  ReleaseDateIndicator.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 28.01.2025.
//

import SwiftUI

struct ReleaseDateIndicator: View {
	
	let releaseDate: String
	let dateFormat: String
	
	init(releaseDate: String, dateFormat: String = "YYYY") {
		self.releaseDate = releaseDate
		self.dateFormat = dateFormat
	}
	
	var body: some View {
		HStack {
			Image(systemName: "calendar")
				.foregroundStyle(.white)
				.font(.footnote)
				.padding(.leading, 6)
			
			Text(releaseDate.dateString(withFormat: dateFormat))
				.font(.footnote)
				.fontWeight(.medium)
				.foregroundStyle(.white)
				.padding(.trailing, 6)
		}
		.padding(.vertical, 6)
		.background {
			Capsule()
				.fill(Color.blue.opacity(0.8))
		}
	}
}

#Preview {
	ReleaseDateIndicator(releaseDate: "2004-12-05", dateFormat: "YYYY")
}
