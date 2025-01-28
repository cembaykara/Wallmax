//
//  MAinViewModel.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 21.01.2025.
//

import Foundation
import SwiftUI
import SwiftData

@Observable class MainViewModel {
	
	private let movieRepository: SwiftDataRepository<Movie>
	private let context: ModelContext
	
	var peekDialog: PeekDialogModel?
	
	init(context: ModelContext) {
		self.context = context
		self.movieRepository = .init(context: context)
	}
	
	func setPeekDialog(_ dialog: PeekDialogModel?) {
		self.peekDialog = dialog
	}
	
	func update() async {
		do {
			let movieService = MovieService()
			
			let topRated = try await movieService.getMovies(.topRated)
			let mostPopular = try await movieService.getMovies(.mostPopular)
			
			// I do not think it is necessary to separate these into separate functions
			// since the use-case is very simple.
			
			try await MainActor.run {
				for movie in topRated.results {
					let movieEntity = movie.toEntity
					try movieRepository.upsert(element: movieEntity)
				}
				
				for movie in mostPopular.results {
					let movieEntity = movie.toEntity
					
					// We set this field so we can distinguish and keep using one container
					// for the view rather than having two separated data containers.
					movieEntity.isPopular = true
					try movieRepository.upsert(element: movieEntity)
				}
			}
		} catch {
			peekDialog = PeekDialogModel(delay: .medium,
										 state: .warning,
										 text: LocalizedStringKey(error.localizedDescription))
		}
	}
	
	@MainActor
	func posterImage(for movieId: Int, source: ImageEndpoint) -> Image {
		let imageRepo = SwiftDataRepository<MovieImages>(context: context)
		
		do	{
			let movieImages = try imageRepo.findByMovieId(movieId)
			
			if let imageData = movieImages?.posters?[source.size],
			let uiImage = UIImage(data: imageData) {
				return Image(uiImage: uiImage)
			}
			
			var downloadedData = Data()
			
			Task {
				downloadedData = try await downloadPosterImage(for: source)
				
				if let movieImages = movieImages {
					movieImages.posters?[source.size] = downloadedData
					try imageRepo.upsert(element: movieImages)
				} else {
					let newMovieImages = MovieImages(movieId: movieId, posters: [:])
					newMovieImages.posters?[source.size] = downloadedData
					try imageRepo.upsert(element: newMovieImages)
				}
			}						
		} catch {
			peekDialog = PeekDialogModel(delay: .medium,
										 state: .warning,
										 text: LocalizedStringKey(error.localizedDescription))
		}
		
		// We could do a bit better here but we'll see
		return Image(systemName: "film")
	}
	
	private func downloadPosterImage(for source: ImageEndpoint) async throws -> Data {
		let imageService = ImageService()
		let imagedata = try await imageService.fetchImage(from: source)
		
		return imagedata
	}
	
	@MainActor
	func searchMovies(query: String) async -> [Movie] {
		
		do {
			let searchService = SearchService()
			let searchRes = try await searchService.search(with: [.query(query)])
			
			for movie in searchRes.results {
				let movieEntity = movie.toEntity
				try movieRepository.upsert(element: movieEntity)
			}
			return searchRes.results.compactMap(\.toEntity)
		} catch {
			peekDialog = PeekDialogModel(delay: .medium,
										 state: .warning,
										 text: LocalizedStringKey(error.localizedDescription))
			
			return []
		}
	}
}
