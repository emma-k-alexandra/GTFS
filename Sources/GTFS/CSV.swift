//
//  CSV.swift
//
//
//  Created by Emma K Alexandra on 1/28/20.
//

import Foundation

class StreamReader {
    let encoding: String.Encoding
    let chunkSize: Int
    var fileHandle: FileHandle!
    let delimData: Data
    var buffer: Data
    var atEof: Bool

    init?(path: URL, delimiter: String = "\n", encoding: String.Encoding = .utf8,
          chunkSize: Int = 4096) {
        do {
            let fileHandle = try FileHandle(forReadingFrom: path)
            self.fileHandle = fileHandle

        } catch {
            return nil
        }

        guard let delimData = delimiter.data(using: encoding) else {
            return nil
        }

        self.encoding = encoding
        self.chunkSize = chunkSize
        self.delimData = delimData
        buffer = Data(capacity: chunkSize)
        atEof = false
    }

    deinit {
        self.close()
    }

    /// Return next line, or nil on EOF.
    func nextLine() -> String? {
        precondition(fileHandle != nil, "Attempt to read from closed file")

        // Read data chunks from file until a line delimiter is found:
        while !atEof {
            if let range = buffer.range(of: delimData) {
                // Convert complete line (excluding the delimiter) to a string:
                let line = String(data: buffer.subdata(in: 0 ..< range.lowerBound), encoding: encoding)
                // Remove line (and the delimiter) from the buffer:
                buffer.removeSubrange(0 ..< range.upperBound)
                return line
            }
            let tmpData = fileHandle.readData(ofLength: chunkSize)
            if tmpData.count > 0 {
                buffer.append(tmpData)

            } else {
                // EOF or read error.
                atEof = true
                if buffer.count > 0 {
                    // Buffer contains last line in file (not terminated by delimiter).
                    let line = String(data: buffer as Data, encoding: encoding)
                    buffer.count = 0
                    return line
                }
            }
        }
        return nil
    }

    /// Start reading from the beginning of file.
    func rewind() {
        fileHandle.seek(toFileOffset: 0)
        buffer.count = 0
        atEof = false
    }

    /// Close the underlying file. No reading must be done after calling this method.
    func close() {
        fileHandle?.closeFile()
        fileHandle = nil
    }
}

extension StreamReader: Sequence {
    func makeIterator() -> AnyIterator<String> {
        AnyIterator {
            self.nextLine()
        }
    }
}

public struct CSVLine {
    public let keys: [String]
    public let values: [String]

    public var dict: [String: String] {
        Dictionary(uniqueKeysWithValues: zip(keys, values))
    }

    public subscript(key: String) -> String? {
        guard let index = keys.firstIndex(of: key) else {
            return nil
        }

        return values[index]
    }
}

public enum CSVError: Error {
    case unableToCreateReader
    case emptyFile
}

class CSVReader {
    let reader: StreamReader
    let header: [String]

    init(path: URL) throws {
        guard let reader = StreamReader(path: path) else {
            throw CSVError.unableToCreateReader
        }

        self.reader = reader

        guard let line = self.reader.nextLine() else {
            throw CSVError.emptyFile
        }

        header = line.splitAndClean()
    }

    deinit {
        self.reader.close()
    }
}

extension CSVReader: IteratorProtocol {
    typealias Element = CSVLine

    func next() -> CSVLine? {
        guard let line = reader.nextLine() else {
            return nil
        }

        return CSVLine(
            keys: header,
            values: line.splitAndClean()
        )
    }
}

extension CSVReader: Sequence {}

extension String {
    func splitAndClean() -> [String] {
        split(separator: ",", omittingEmptySubsequences: false).map {
            String($0)
                .replacingOccurrences(of: "\"", with: "")
                .replacingOccurrences(of: "/r", with: "")
                .trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}
