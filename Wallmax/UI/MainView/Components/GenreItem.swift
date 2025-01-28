//
//  GenreItem.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 27.01.2025.
//

import SwiftUI

struct GenreItem: View {
	
	let genre: Genre
	
	var body: some View {
		HStack(spacing: 4) {
			Image(systemName: "popcorn")
				.font(.caption)
				.foregroundColor(.purple)
			
			Text(genre.name)
				.font(.caption)
				.fontWeight(.medium)
				.foregroundColor(.purple)
		}
		.padding(.horizontal, 8)
		.padding(.vertical, 6)
		.background {
			Capsule()
				.fill(Color.purple.opacity(0.2))
		}
		.overlay {
			Capsule()
				.stroke(Color.purple.opacity(0.4), lineWidth: 1)
		}
	}
}

#Preview {
	let genre: Genre = .action
	GenreItem(genre: genre)
}
