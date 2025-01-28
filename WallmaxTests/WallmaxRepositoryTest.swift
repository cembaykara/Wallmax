//
//  WallmaxRepositoryTest.swift
//  WallmaxTests
//
//  Created by Baris Cem Baykara on 28.01.2025.
//

import Testing
import Foundation
import SwiftData
@testable import Wallmax

@Model
final class TestModel {
	var id: UUID
	var name: String
	
	init(id: UUID = UUID(), name: String) {
		self.id = id
		self.name = name
	}
}

@Suite
struct SwiftDataRepositoryTests {
	var context: ModelContext
	var repository: SwiftDataRepository<TestModel>
	
	init() throws {
		let schema = Schema([TestModel.self])
		let config = ModelConfiguration(isStoredInMemoryOnly: true)
		let container = try ModelContainer(for: schema, configurations: config)
		context = ModelContext(container)
		repository = SwiftDataRepository(context: context)
	}
	
	
	@Test("list the collection")
	func testList() throws {

		let model1 = TestModel(name: "Test 1")
		let model2 = TestModel(name: "Test 2")
		try repository.upsert(contentsOf: [model1, model2])
		
		let result = try repository.list()
		
		#expect(result.count == 2)
		#expect(result.contains(where: { $0.name == "Test 1" }))
		#expect(result.contains(where: { $0.name == "Test 2" }))
	}
	
	@Test("upserting an element")
	func testUpsertElement() throws {

		let model = TestModel(name: "Test Upsert")
		
		let result = try repository.upsert(element: model)
		
		#expect(result.name == "Test Upsert")
		
		let fetchedModels = try repository.list()
		#expect(fetchedModels.contains(where: { $0.name == "Test Upsert" }))
	}
	
	@Test("upserting an array of elements")
	func testUpsertContentsOf() throws {

		let models = [
			TestModel(name: "Test 1"),
			TestModel(name: "Test 2")
		]
		
		let result = try repository.upsert(contentsOf: models)
		
		#expect(result.count == 2)
		
		let fetchedModels = try repository.list()
		#expect(fetchedModels.contains(where: { $0.name == "Test 1" }))
		#expect(fetchedModels.contains(where: { $0.name == "Test 2" }))
	}
	
	@Test("removing an element")
	func testRemoveElement() throws {

		let model = TestModel(name: "Test Remove")
		
		try repository.upsert(element: model)
		
		try repository.remove(element: model)
		
		let fetchedModels = try repository.list()
		#expect(!fetchedModels.contains(where: { $0.name == "Test Remove" }))
	}
	
	@Test("dropping a whole collection")
	func testDrop() throws {

		let models = [
			TestModel(name: "Test 1"),
			TestModel(name: "Test 2")
		]
		try repository.upsert(contentsOf: models)
		
		try repository.drop()
		
		let fetchedModels = try repository.list()
		#expect(fetchedModels.isEmpty)
	}
}
