//
//  MovieSearchItem.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 24.01.2025.
//

import SwiftUI

struct SearchItem: View {
	
	let movie: Movie
	let poster: Image
	
	var body: some View {
		HStack {
			if let posterPath = movie.posterPath, let imageUrl = ImageEndpoint.w92(posterPath).url() {
				AsyncImage(url: imageUrl) { phase in
					switch phase {
						case .empty:
							ProgressView()
								.frame(width: 24, height: 36)
							
						case .success(let image):
							image
								.resizable()
								.scaledToFit()
								.frame(width: 24, height: 36)
							
						case .failure:
							Image(systemName: "photo")
								.resizable()
								.scaledToFit()
								.frame(width: 24, height: 36)
								.foregroundColor(.gray)
							
						@unknown default:
							EmptyView()
					}
				}
			}
			
			Text(movie.title)
			Spacer()
			
			if !movie.releaseDate.isEmpty {
				ReleaseDateIndicator(releaseDate: movie.releaseDate)
				RatingItem(rating: movie.voteAverage)
			}
			
		}
		.frame(height: 48)
		.padding(.horizontal)
	}
}

#Preview {
	let movie = Movie(
		movieId: 13,
		title: "Forrest Gump",
		overview: "A man with a low IQ has accomplished great things in his life and been present during significant historic events in each case, far exceeding what anyone imagined he could do. But despite all he has achieved, his one true love eludes him.",
		posterPath: "/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg",
		voteAverage: 8.470000000000001,
		releaseDate: "2024-12-04"
	)
	SearchItem(movie: movie, poster: Image(systemName: "film"))
}
