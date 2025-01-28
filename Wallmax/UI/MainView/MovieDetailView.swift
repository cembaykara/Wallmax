//
//  MovieDetailView.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 23.01.2025.
//

import Foundation
import SwiftUI

public struct MovieDetailView: View {
	
	let movie: Movie
	let poster: Image
	
	public var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			HStack(alignment: .top, spacing: 16) {
				poster
					.resizable()
					.scaledToFit()
					.frame(width: 120, height: 180)
					.cornerRadius(10)
					.shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
					.padding(.leading, 16)
				
				VStack(alignment: .leading, spacing: 8) {
					Text(movie.title)
						.font(.title)
						.fontWeight(.heavy)
						.foregroundColor(.primary)
						.lineLimit(2)
					
					RatingItem(rating: movie.voteAverage)
					
					if !movie.releaseDate.isEmpty {
						ReleaseDateIndicator(releaseDate: movie.releaseDate, dateFormat: "dd.MM.yyyy")
					}
					
					
					ScrollView(.horizontal, showsIndicators: false) {
						HStack {
							ForEach(movie.genres, id: \.self) { genre in
								GenreItem(genre: genre)
							}
						}
					}
				}
				
				Spacer()
			}
			.padding(.vertical, 8)
			
			Divider()
				.background(Color.gray.opacity(0.2))
				.padding(.horizontal, 16)
			
			Text("Overview")
				.font(.title2)
				.fontWeight(.semibold)
				.foregroundColor(.primary)
				.padding(.horizontal, 16)
			
			Text(movie.overview)
				.font(.body)
				.foregroundColor(.secondary)
				.lineSpacing(4)
				.padding(.horizontal, 16)
			
			Spacer()
		}
		.background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
		.navigationTitle(movie.title)
		.navigationBarTitleDisplayMode(.inline)
	}
}

#Preview {
	let movie = Movie(
		movieId: 13,
		title: "Forrest Gump",
		overview: "A man with a low IQ has accomplished great things in his life and been present during significant historic events in each case, far exceeding what anyone imagined he could do. But despite all he has achieved, his one true love eludes him.",
		posterPath: "/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg",
		voteAverage: 8.470000000000001,
		genres: [.action, .adventure, .comedy, .horror],
		releaseDate: "2024-12-19"
	)
	
	MovieDetailView(
		movie: movie,
		poster: Image(systemName: "film"))
}
