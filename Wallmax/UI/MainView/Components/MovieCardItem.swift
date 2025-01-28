//
//
//  MovieCardItem.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 23.01.2025.
//

import Foundation
import SwiftUI

struct MovieCardItem: View {
	
	@Bindable var movie: Movie
	let poster: Image
	
	@State private var showSheet = false
	
	var body: some View {
		VStack(alignment: .leading) {
			poster
				.resizable()
				.scaledToFit()
				.frame(width: 154, height: 231)
				.cornerRadius(10)
				.shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
			
			Text(movie.title)
				.font(.headline)
				.lineLimit(2)
				.minimumScaleFactor(0.5)
			
			Spacer()
			
			HStack {
				RatingItem(rating: movie.voteAverage)
				
				if !movie.releaseDate.isEmpty {
					ReleaseDateIndicator(releaseDate: movie.releaseDate)
				}
			}
		}
		.frame(width: 150)
		.onTapGesture {
			withAnimation {
				showSheet.toggle()
			}
		}
		.sheet(isPresented: $showSheet) {
			MovieDetailView(movie: movie, poster: poster)
		}
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
		releaseDate: "2024-12-05"
	)
	
	MovieCardItem(
		movie: movie,
		poster: Image(systemName: "film"))
}
