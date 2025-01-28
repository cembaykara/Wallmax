//
//  MovieGridItem.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 23.01.2025.
//

import Foundation
import SwiftUI

struct MovieGridItem: View {
	
	@Bindable var movie: Movie
	let poster: Image
	
	@State private var showSheet = false
	
	var body: some View {
		VStack(alignment: .leading) {
			
			poster
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(height: 200)
				.cornerRadius(10)
			
			Spacer()
			
			Text(movie.title)
				.font(.subheadline)
				.lineLimit(2)
			
			RatingItem(rating: movie.voteAverage)
		}
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
