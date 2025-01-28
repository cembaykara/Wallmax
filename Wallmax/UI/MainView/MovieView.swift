//
//  MovieView.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 24.01.2025.
//

import Foundation
import SwiftUI
import SwiftData

struct MovieView: View {
	
	@Environment(MainViewModel.self) var viewModel
	
	@Query(sort: \Movie.voteAverage, order: .reverse)
	private var items: [Movie]
	
	@State private var manualRefreshId: UUID? = nil
	
	var body: some View {
		NavigationView {
			ScrollView {
				VStack(alignment: .leading, spacing: 20) {
					VStack(alignment: .leading) {
						Text("Top Rated")
							.font(.title2)
							.fontWeight(.bold)
							.padding(.horizontal)
						
						ScrollView(.horizontal, showsIndicators: false) {
							HStack(spacing: 20) {
								ForEach(items.prefix(21)) { movie in
									MovieCardItem(
										movie: movie,
										poster: viewModel.posterImage(
											for: movie.movieId,
											source: .w154(movie.posterPath ?? "")))
								}
							}
							.padding(.horizontal)
						}
					}
					
					VStack(alignment: .leading) {
						Text("Popular Movies")
							.font(.title2)
							.fontWeight(.bold)
							.padding(.horizontal)
						
						LazyVGrid(columns: [
							GridItem(.flexible()),
							GridItem(.flexible())
						], spacing: 15) {
							ForEach(items.filter { $0.isPopular == true }.prefix(21)) { movie in
								MovieGridItem(
									movie: movie,
									poster: viewModel.posterImage(
										for: movie.movieId,
										source: .w154(movie.posterPath ?? "")))
							}
						}
						.padding(.horizontal)
					}
				}
			}
			.navigationTitle("Movies")
			.refreshable {
				manualRefreshId = UUID()
			}
			.task(id: manualRefreshId, priority: .background) {
				await viewModel.update()
			}
		}
	}
}

#Preview {
	var sharedModelContainer: ModelContainer = {
		let schema = Schema([Movie.self])
		let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
		
		do {
			return try ModelContainer(for: schema, configurations: [modelConfiguration])
		} catch { fatalError("Could not create ModelContainer: \(error)") }
	}()
	
	let vm = MainViewModel(context: sharedModelContainer.mainContext)
	
	MovieView()
		.environment(vm)
		.modelContainer(sharedModelContainer)
}

