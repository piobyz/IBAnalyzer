//
//  DirectoryContentsEnumeratorTests.swift
//  IBAnalyzer
//
//  Created by Arkadiusz Holko on 14/01/2017.
//  Copyright © 2017 Arkadiusz Holko. All rights reserved.
//

@testable import IBAnalyzer
import XCTest

// swiftlint:disable force_try
// swiftlint:disable line_length
class DirectoryContentsEnumeratorTests: XCTestCase {
    var directoryEnumerator = DirectoryContentsEnumerator()

    func testFlatDirectory() {
        guard let directoryURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(ProcessInfo.processInfo.globallyUniqueString, isDirectory: true) else {
            XCTFail("Flat directory does not exist")
            return
        }
        try! FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
        let fileURL = directoryURL.appendingPathComponent("file.txt")
        try! "test".data(using: .utf8)?.write(to: fileURL)

        let files = try! directoryEnumerator.files(at: directoryURL)
        XCTAssertEqual(files, [fileURL])
    }

    func testNestedDirectory() {
        guard let directoryURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(ProcessInfo.processInfo.globallyUniqueString, isDirectory: true) else {
            XCTFail("Nested directory does not exist")
            return
        }
        try! FileManager.default.createDirectory(at: directoryURL,
                                                 withIntermediateDirectories: true,
                                                 attributes: nil)
        let fileURL = directoryURL.appendingPathComponent("file.txt")
        try! "test".data(using: .utf8)?.write(to: fileURL)

        let subDirectoryURL = directoryURL.appendingPathComponent("sub", isDirectory: true)
        try! FileManager.default.createDirectory(at: subDirectoryURL,
                                                 withIntermediateDirectories: true,
                                                 attributes: nil)

        let fileInSubURL = subDirectoryURL.appendingPathComponent("file2.txt")
        try! "test2".data(using: .utf8)?.write(to: fileInSubURL)

        let files = try! directoryEnumerator.files(at: directoryURL)
        XCTAssertEqual(files, [fileURL, fileInSubURL])
    }

    func testEmptyForNonExistingDirectory() {
        let files = try! directoryEnumerator.files(at: URL(fileURLWithPath: "/incorrect/"))
        XCTAssertEqual(files, [])
    }
}
