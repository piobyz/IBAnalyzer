//
//  RunnerFilesTests.swift
//  IBAnalyzerTests
//
//  Created by Piotr Byzia on 17/02/2018.
//  Copyright © 2018 Arkadiusz Holko. All rights reserved.
//

@testable import IBAnalyzer
import XCTest

class RunnerFilesTests: XCTestCase {
    func testNibFiles() {
        let runner = Runner(path: "example", directoryEnumerator: StubFineDirectoryContentsEnumerator())
        XCTAssertEqual(try runner.nibFiles(), ["c.xib", "d.storyboard"].map { URL(fileURLWithPath: $0) })
    }

    func testSwiftFiles() {
        let runner = Runner(path: "example", directoryEnumerator: StubFineDirectoryContentsEnumerator())
        XCTAssertEqual(try runner.swiftFiles(), ["a.swift", "e.swift"].map { URL(fileURLWithPath: $0) })
    }

    func testNibFilesThrows() {
        let runner = Runner(path: "example", directoryEnumerator: StubThrowingDirectoryContentsEnumerator())
        XCTAssertThrowsError(try runner.nibFiles())
    }

    func testSwiftFilesThrows() {
        let runner = Runner(path: "example", directoryEnumerator: StubThrowingDirectoryContentsEnumerator())
        XCTAssertThrowsError(try runner.swiftFiles())
    }
}
