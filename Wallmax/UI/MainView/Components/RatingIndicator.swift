//
//  RatingItem.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 27.01.2025.
//

import SwiftUI

struct RatingItem: View {
	let rating: Double
	
	var body: some View {
		HStack {
			Image(systemName: "star.fill")
				.foregroundStyle(.white)
				.font(.footnote)
				.padding(.leading, 6)
			
			Text(String(format: "%.1f", rating))
				.font(.footnote)
				.fontWeight(.medium)
				.foregroundStyle(.white)
				.padding(.trailing, 6)
		}
		.padding(.vertical, 6)
		.background {
			Capsule()
				.fill(ratingColor(for: rating))
		}
	}
}

#Preview {
	VStack(alignment: .leading) {
		RatingItem(rating: 6.8)
		RatingItem(rating: 10)
	}
}

extension RatingItem {
	
	fileprivate func ratingColor(for rating: Double) -> Color {
		switch rating {
			case 0..<5: Color.red.opacity(0.8)
			case 5..<7.5: Color.orange.opacity(0.8)
			case 7.5...10: Color.green.opacity(0.8)
			default: Color.gray.opacity(0.8)
		}
	}
	
}
