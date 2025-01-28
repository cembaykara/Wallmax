//
//  SearchView.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 24.01.2025.
//

import SwiftUI
import SwiftData

struct SearchView: View {
	
	@Environment(MainViewModel.self) var viewModel
	
	@State private var searchQuery: String = ""
	@State private var selectedMovie: Movie? = nil
	@State private var searchResults: [Movie] = []
	@State private var runningTaskId: UUID?
	
	@Query(sort: \Movie.voteAverage, order: .reverse)
	private var items: [Movie]
	
	var body: some View {
		NavigationView {
			ScrollView {
				ForEach(searchResults) { result in
					SearchItem(
						movie: result,
						poster: viewModel.posterImage(
							for: result.movieId, source: .w92(result.posterPath ?? "")))
					.onTapGesture {
						selectedMovie = result
					}
				}
				.searchable(text: $searchQuery)
				.onChange(of: searchQuery) { _, newValue in

					let taskId = UUID()
					runningTaskId = taskId
					
					Task {
						do {
							if !searchQuery.isEmpty {
								try await Task.sleep(for: .milliseconds(500))
							}
							
							if taskId == runningTaskId {
								await performSearch(query: newValue)
							}
						} catch {
							viewModel.setPeekDialog(
								PeekDialogModel(delay: .medium,
												state: .warning,
												text: LocalizedStringKey(error.localizedDescription)))
						}
					}
				}
				.sheet(item: $selectedMovie) { movie in
					MovieDetailView(
						movie: movie, poster: viewModel.posterImage(for: movie.movieId, source: .w154(movie.posterPath ?? "")))
				}
				.navigationTitle("Search")
			}
		}
		.overlay {
			if searchQuery.isEmpty {
				VStack {
					Image(systemName: "magnifyingglass")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 60)
						.foregroundStyle(.secondary)
					
					Text("Search for movies...")
						.font(.caption)
				}
			}
		}
	}
}

extension SearchView {
	
	fileprivate func performSearch(query: String) async {
		
		let localResults = items.filter {
			$0.title.localizedCaseInsensitiveContains(query)
		}
		
		if !query.isEmpty {
			searchResults = await viewModel.searchMovies(query: query)
		} else { searchResults = localResults }
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
	
	let viewModel = MainViewModel(context: sharedModelContainer.mainContext)
	
	SearchView()
		.environment(viewModel)
		.modelContainer(sharedModelContainer)
}
