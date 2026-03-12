//
//  TodoViewModelTests.swift
//  UnitTestingDemoTests
//
//  Created by Késia Silva Viana on 03/03/26.
//
import XCTest
// Importação que permite acessar métodos e propriedades internas do módulo principal
@testable import UnitTestingDemo2

// Classe de testes responsável por validar o comportamento do TodoViewModel
final class TodoViewModelTests: XCTestCase {
    
    // Variável que representa o "System Under Test" (SUT),
    // ou seja, o sistema/classe que estamos testando
    private var sut: TodoViewModel!
    
    // MARK: - Setup
    
    // Método executado antes de CADA teste
    // Usado para preparar o ambiente de teste
    override func setUp() {
        // Chamamos primeiro o setup da superclasse
        super.setUp()
        
        // Inicializamos o sistema em teste
        sut = TodoViewModel()
    }
    
    // MARK: - Teardown
    
    // Método executado depois de CADA teste
    // Usado para limpar o ambiente e evitar interferência entre testes
    override func tearDown() {
        
        // Liberamos a instância criada durante o teste
        sut = nil
        
        // Chamamos o teardown da superclasse
        super.tearDown()
    }
    
    
    // MARK: - Tests
    
    // Para que uma função seja considerada um teste pelo XCTest:
    // Ela deve estar dentro de uma classe que herda de XCTestCase
    // O nome da função deve começar com "test"
    // Uma boa prática é usar o padrão:
    // test_nomeDoMetodo_comportamentoEsperado
    
    func test_addTask() {
        
        // AAA Pattern (Arrange - Act - Assert)
        
        // Arrange (Preparação)
        // Criamos os dados necessários para executar o teste
        
        // Simula uma nova tarefa criada pelo usuário
        let newTodoTask = TodoTask(name: "New Task")
        
        // Guardamos a quantidade inicial de tarefas
        // para verificar se ela aumentará depois da ação
        let initialTaskCount = sut.tasks.count
        
        
        // Act (Ação)
        // Executamos o método que queremos testar
        sut.addTask(task: newTodoTask)
        
        
        // Assert (Verificação)
        // Verificamos se o resultado obtido é igual ao esperado
        
        // Esperamos que o número de tarefas tenha aumentado em 1
        XCTAssertEqual(sut.tasks.count, initialTaskCount + 1)
        
        // Verificamos se a última tarefa adicionada é realmente a que criamos
        XCTAssertEqual(sut.tasks.last?.id, newTodoTask.id)
    }
    
    
    func test_addTask_stress() {
        
        // Este teste simula múltiplas inserções de tarefas
        // para garantir que o método funciona mesmo com várias execuções
        
        var lastElement: TodoTask!
        
        // Quantidade inicial de tarefas
        let initialTaskCount = sut.tasks.count
        
        // Geramos um número aleatório de tarefas entre 10 e 100
        let amount = (10...100).randomElement()!
        
        
        // Act
        // Adicionamos várias tarefas em sequência
        for _ in 0..<amount {
            let newTodoTask = TodoTask(name: "New Task")
            sut.addTask(task: newTodoTask)
            lastElement = newTodoTask
        }
        
        
        // Assert
        
        // Verificamos se o total de tarefas aumentou corretamente
        XCTAssertEqual(sut.tasks.count, initialTaskCount + amount)
        
        // Garantimos que o último elemento inserido é realmente o último da lista
        XCTAssertEqual(sut.tasks.last?.id, lastElement.id)
    }
    
    
    func test_TodoTaskViewModel_removeTask_shouldRemoveElement() {
        
        // Arrange
        
        // Criamos uma tarefa para adicionar e depois remover
        let newTodoTask = TodoTask(name: "New Task")
        
        // Guardamos a quantidade inicial de tarefas
        let initialTaskCount = sut.tasks.count
        
        
        // Act
        
        // Primeiro adicionamos a tarefa
        sut.addTask(task: newTodoTask)
        
        // Depois removemos a mesma tarefa
        sut.removeTask(task: newTodoTask)
        
        
        // Assert
        
        // Verificamos se o número de tarefas voltou ao valor inicial
        XCTAssertEqual(sut.tasks.count, initialTaskCount)
        
        // Filtramos a lista procurando tarefas com o mesmo id
        let tasks = sut.tasks.filter { $0.id == newTodoTask.id }
        
        // Esperamos que nenhuma tarefa com esse id exista mais
        XCTAssertTrue(tasks.isEmpty)
    }

}
