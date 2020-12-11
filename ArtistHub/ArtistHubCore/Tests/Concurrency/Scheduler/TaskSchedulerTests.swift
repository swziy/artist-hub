import Foundation
import XCTest
@testable import ArtistHubCore

class TaskSchedulerTests: XCTestCase {

    fileprivate var recordOutput: [RecordedTaskEvent]!
    var dispatcherStub: DispatcherStub!
    var sut: AnyTaskScheduler<String>!

    override func setUp() {
        super.setUp()
        recordOutput = []
        dispatcherStub = DispatcherStub()
        sut = AnyTaskScheduler(TaskScheduler(maxConcurrentTasks: 5,
                                             workDispatcher: dispatcherStub))
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        dispatcherStub = nil
        recordOutput = nil
    }

    func test_whenTaskIsScheduled_shouldExecuteGivenTask() {
        var executed: [String] = []

        let task = Task<String> {
            executed.append("2")
            return "1"
        } completion: { _ in
            executed.append("1")
        }

        sut.schedule(task: task)

        XCTAssertEqual(executed, ["2", "1"])
    }

    func test_whenMultipleTaskAreScheduled_shouldRunAllTasks() {
        for id in 1...4 {
            let task = createTask(id: "\(id)")
            sut.schedule(task: task)
        }

        XCTAssertEqual(recordOutput, [
            .init(id: "1", eventType: .execution), .init(id: "1", eventType: .completion),
            .init(id: "2", eventType: .execution), .init(id: "2", eventType: .completion),
            .init(id: "3", eventType: .execution), .init(id: "3", eventType: .completion),
            .init(id: "4", eventType: .execution), .init(id: "4", eventType: .completion)
        ])
    }

    func test_whenGroupIsScheduled_shouldCompleteAfterAllTasksFinish() {
        let firstGroupTask = createTask(id: "1")
        let secondGroupTask = createTask(id: "2")

        let lastCompletionExpectation = expectation(description: "should run execution closure")

        let queue = DispatchQueue(label: "notify.serial.queue")

        sut.schedule(group: [secondGroupTask, firstGroupTask], notifyQueue: queue) {
            lastCompletionExpectation.fulfill()
        }

        XCTAssertEqual(recordOutput, [
            .init(id: "2", eventType: .execution), .init(id: "2", eventType: .completion),
            .init(id: "1", eventType: .execution), .init(id: "1", eventType: .completion)
        ])

        wait(for: [lastCompletionExpectation], timeout: 1)
    }

    func test_whenGroupIsScheduledAfterSeriesOfTasks_shouldCompleteAfterAllTasksFinish() {
        for id in 1...10 {
            let task = createTask(id: "\(id)")
            sut.schedule(task: task)
        }

        let firstGroupTask = createTask(id: "groupTask1")
        let scondGroupTask = createTask(id: "groupTask2")

        let lastCompletionExpectation = expectation(description: "should run execution closure")

        let queue = DispatchQueue(label: "notify.serial.queue")

        sut.schedule(group: [firstGroupTask, scondGroupTask], notifyQueue: queue) {
            lastCompletionExpectation.fulfill()
        }

        for id in 11...12 {
            let task = createTask(id: "\(id)")
            sut.schedule(task: task)
        }

        XCTAssertEqual(recordOutput, [
            .init(id: "1", eventType: .execution), .init(id: "1", eventType: .completion),
            .init(id: "2", eventType: .execution), .init(id: "2", eventType: .completion),
            .init(id: "3", eventType: .execution), .init(id: "3", eventType: .completion),
            .init(id: "4", eventType: .execution), .init(id: "4", eventType: .completion),
            .init(id: "5", eventType: .execution), .init(id: "5", eventType: .completion),
            .init(id: "6", eventType: .execution), .init(id: "6", eventType: .completion),
            .init(id: "7", eventType: .execution), .init(id: "7", eventType: .completion),
            .init(id: "8", eventType: .execution), .init(id: "8", eventType: .completion),
            .init(id: "9", eventType: .execution), .init(id: "9", eventType: .completion),
            .init(id: "10", eventType: .execution), .init(id: "10", eventType: .completion),
            .init(id: "groupTask1", eventType: .execution), .init(id: "groupTask1", eventType: .completion),
            .init(id: "groupTask2", eventType: .execution), .init(id: "groupTask2", eventType: .completion),
            .init(id: "11", eventType: .execution), .init(id: "11", eventType: .completion),
            .init(id: "12", eventType: .execution), .init(id: "12", eventType: .completion)
        ])

        wait(for: [lastCompletionExpectation], timeout: 1)
    }
}

private struct RecordedTaskEvent: Equatable {
    enum EventType {
        case execution
        case completion
    }

    let id: String
    let eventType: EventType
}

private extension TaskSchedulerTests {

    func createTask(id: String) -> Task<String> {
        .init {
            self.recordOutput.append(.init(id: id, eventType: .execution))
            return id
        } completion: { result in
            self.recordOutput.append(.init(id: "\(result)", eventType: .completion))
        }
    }
}
