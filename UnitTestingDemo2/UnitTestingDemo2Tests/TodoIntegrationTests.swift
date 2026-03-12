//
//  UnitTestingDemo2Tests.swift
//  UnitTestingDemo2Tests
//
//  Created by Késia Silva Viana on 12/03/26.
//

import XCTest
@testable import UnitTestingDemo2

final class TodoIntegrationTests: XCTestCase {

    var viewModel: TodoViewModel!

    override func setUp() {
        super.setUp()
        viewModel = TodoViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func test_addAndRemoveTask_integration() {

        // Arrange
        let task = TodoTask(name: "Study Swift")
        let initialCount = viewModel.tasks.count

        // Act
        viewModel.addTask(task: task)

        // Assert
        XCTAssertEqual(viewModel.tasks.count, initialCount + 1)
        XCTAssertEqual(viewModel.tasks.last?.name, "Study Swift")

        // Act - remover tarefa
        viewModel.removeTask(task: task)

        // Assert
        XCTAssertEqual(viewModel.tasks.count, initialCount)
    }
}
