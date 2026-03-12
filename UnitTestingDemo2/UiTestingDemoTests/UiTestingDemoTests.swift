//
//  UiTestingDemoTests.swift
//  UiTestingDemoTests
//
//  Created by Késia Silva Viana on 03/03/26.
//

import XCTest

final class UiTestingDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Este método roda antes de cada teste de UI
        
        // Se qualquer falha acontecer, o teste para imediatamente
        // Isso é importante em testes de interface para evitar
        // que ações continuem em uma tela quebrada
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Executado após cada teste
        // Pode ser usado para limpar estado ou dados criados no teste
    }

    
    // Teste de UI que verifica se é possível:
    // Digitar uma tarefa, Adicionar na lista e Remover a tarefa da lista
    
    @MainActor
    func test_addAndDeleteTodoTask() throws {
        
        // MARK: - Arrange
        
        // Inicializa a aplicação que será testada
        let app = XCUIApplication()
        
        // Abre o app em um estado limpo
        app.launch()
        
        
        // MARK: - Act
        
        // Localiza o campo de texto onde o usuário digita a tarefa
        let textField = app.textFields["Enter a todo task"]
        
        // Espera até 5 segundos para o campo aparecer na tela
        XCTAssertTrue(textField.waitForExistence(timeout: 5))
        
        // Simula o usuário tocando no campo
        textField.tap()
        
        // Simula o usuário digitando uma tarefa
        textField.typeText("Kesia")
        
        // Localiza o botão de adicionar tarefa
        let addButton = app.buttons["Add Task"]
        
        // Simula o clique no botão
        addButton.tap()
        
        
        // MARK: - Assert
        
        // Verifica se a tarefa adicionada apareceu na lista
        let createdTask = app.staticTexts["Kesia"]
        
        XCTAssertTrue(createdTask.waitForExistence(timeout: 2))
        
        
        // MARK: - Act (remoção)
        
        // Simula gesto de swipe para revelar o botão de deletar
        createdTask.swipeLeft()
        
        // Toca no botão de deletar
        app.buttons["Delete"].tap()
        
        
        // MARK: - Assert (remoção)
        
        // Verifica se o item foi removido da tela
        XCTAssertFalse(createdTask.exists)
    }

    
    // Teste de performance que mede o tempo de inicialização do app
    @MainActor
    func testLaunchPerformance() throws {
        
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
