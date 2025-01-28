import SwiftUI
import SwiftData

struct MainView: View {
	
	@State var viewModel: MainViewModel
	@State private var searchText = ""
	
	var body: some View {
		TabView {
			MovieView()
				.tabItem {
					Image(systemName: "film")
					Text("Movies")
				}
			
			SearchView()
				.tabItem {
					Image(systemName: "magnifyingglass")
					Text("Search")
				}
		}
		.peekDialog(with: $viewModel.peekDialog)
		.environment(viewModel)
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
	
	MainView(viewModel: viewModel)
		.modelContainer(sharedModelContainer)
}
