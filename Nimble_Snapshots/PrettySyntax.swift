import Nimble
import FBSnapshotTestCase
// MARK: - Nicer syntax using == operator

public struct Snapshot {
    let name: String?
    let identifier: String?
    let record: Bool
    let usesDrawRect: Bool
    let fileNameOptions: FBSnapshotTestCaseFileNameIncludeOption?

    init(name: String?, identifier: String?, record: Bool, usesDrawRect: Bool, fileNameOptions: FBSnapshotTestCaseFileNameIncludeOption? = nil) {
        self.name = name
        self.identifier = identifier
        self.record = record
        self.usesDrawRect = usesDrawRect
        self.fileNameOptions = fileNameOptions
    }
}

public func snapshot(_ name: String? = nil,
                     identifier: String? = nil,
                     usesDrawRect: Bool = false) -> Snapshot {
    return Snapshot(name: name, identifier: identifier, record: false, usesDrawRect: usesDrawRect)
}

public func recordSnapshot(_ name: String? = nil,
                           identifier: String? = nil,
                           usesDrawRect: Bool = false,
                           fileNameOptions: FBSnapshotTestCaseFileNameIncludeOption? = nil) -> Snapshot {
    return Snapshot(name: name, identifier: identifier, record: true, usesDrawRect: usesDrawRect, fileNameOptions: fileNameOptions)
}

public func == (lhs: Expectation<Snapshotable>, rhs: Snapshot) {
    if let name = rhs.name {
        if rhs.record {
            lhs.to(recordSnapshot(named: rhs.name, identifier: rhs.identifier, fileNameOptions: rhs.fileNameOptions, usesDrawRect: rhs.usesDrawRect))
        } else {
          lhs.to(haveValidSnapshot(named: rhs.name, identifier: rhs.identifier, usesDrawRect: rhs.usesDrawRect))
        }
    } else {
        if rhs.record {
            lhs.to(recordSnapshot(named: rhs.name, identifier: rhs.identifier, usesDrawRect: rhs.usesDrawRect))
        } else {
            lhs.to(haveValidSnapshot(named: rhs.name, identifier: rhs.identifier, usesDrawRect: rhs.usesDrawRect))
        }
    }
}

// MARK: - Nicer syntax using emoji

// swiftlint:disable:next identifier_name
public func 📷(_ file: FileString = #file, line: UInt = #line, snapshottable: Snapshotable) {
  expect(file: file, line: line, snapshottable).to(recordSnapshot())
}

// swiftlint:disable:next identifier_name
public func 📷(_ name: String, file: FileString = #file, line: UInt = #line, snapshottable: Snapshotable) {
  expect(file: file, line: line, snapshottable).to(recordSnapshot(named: name))
}
