/*
 * ==---------------------------------------------------------------------------------==
 *
 *  File            :   BytesKitTests.swift
 *  Project         :   BytesKit
 *  Author          :   ALEXIS AUBRY RADANOVIC
 *
 *  License         :   The MIT License (MIT)
 *
 * ==---------------------------------------------------------------------------------==
 *
 *	The MIT License (MIT)
 *	Copyright (c) 2016 ALEXIS AUBRY RADANOVIC
 *
 *	Permission is hereby granted, free of charge, to any person obtaining a copy of
 *	this software and associated documentation files (the "Software"), to deal in
 *	the Software without restriction, including without limitation the rights to
 *	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 *	the Software, and to permit persons to whom the Software is furnished to do so,
 *	subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be included in all
 *	copies or substantial portions of the Software.
 *
 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 *	FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 *	COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 *	IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 *	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * ==---------------------------------------------------------------------------------==
 */

import XCTest
import Foundation
@testable import BytesKit

///
/// A test case to test the features in the library.
///

class BytesKitTests: XCTestCase {
    
    // MARK: - Properties
    
    var data: Data!
    
    var string: String!
    
    var bytes: Array<UInt8>!
    
    var isSetUp = false
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        data = Data(bytes: [0x1a, 0x2b, 0x3c, 0x4d, 0x5e, 0x6f])
        string = "Bytes"
        bytes = [0x1a, 0x2b, 0x3c, 0x4d, 0x5e, 0x6f]
        
        isSetUp = true
        
    }
    
    override func tearDown() {
        super.tearDown()
        
        data = nil
        string = nil
        
    }
    
    func setupIfNeeded() {
        if !(isSetUp) { setUp() }
    }
    
    // MARK: - Tests
    
    // MARK: Bytes Convertible Conformance
    
    func testDataBytesConvertible() {
        setupIfNeeded()
        XCTAssertEqual(data.bytes, [0x1a, 0x2b, 0x3c, 0x4d, 0x5e, 0x6f])
    }
    
    func testEmptyDataBytesConvertible() {
        XCTAssertEqual(Data().bytes, [])
    }
    
    func testStringBytesConvertible() {
        setupIfNeeded()
        XCTAssertEqual(string.bytes, [0x42, 0x79, 0x74, 0x65, 0x73])
    }
    
    func testEmptyStringBytesConvertible() {
        XCTAssertEqual("".bytes, [])
    }
    
    // MARK: Charset
    
    func testHexStringAllowedCharset() {
        
        let charset = CharacterSet.hexStringAllowed
        
        XCTAssertTrue(charset.contains("0"))
        XCTAssertTrue(charset.contains("1"))
        XCTAssertTrue(charset.contains("2"))
        XCTAssertTrue(charset.contains("3"))
        XCTAssertTrue(charset.contains("4"))
        XCTAssertTrue(charset.contains("5"))
        XCTAssertTrue(charset.contains("6"))
        XCTAssertTrue(charset.contains("7"))
        XCTAssertTrue(charset.contains("8"))
        XCTAssertTrue(charset.contains("9"))
        XCTAssertTrue(charset.contains("A"))
        XCTAssertTrue(charset.contains("B"))
        XCTAssertTrue(charset.contains("C"))
        XCTAssertTrue(charset.contains("D"))
        XCTAssertTrue(charset.contains("E"))
        XCTAssertTrue(charset.contains("F"))
        XCTAssertTrue(charset.contains("a"))
        XCTAssertTrue(charset.contains("b"))
        XCTAssertTrue(charset.contains("c"))
        XCTAssertTrue(charset.contains("d"))
        XCTAssertTrue(charset.contains("e"))
        XCTAssertTrue(charset.contains("f"))
        
    }
    
    // MARK: Hex String Linting
    
    func testHexStringLintingWithValidHex() {
        XCTAssertTrue("1a2b3c4d5e6f".isValidHexString)
    }
    
    func testHexStringLintingWithUppercaseValidHex() {
        XCTAssertTrue("1A2B3C4D5E6F".isValidHexString)
    }
    
    func testHexStringLintingWithUpperAndLowercaseValidHex() {
        XCTAssertTrue("1A2b3C4d5E6f".isValidHexString)
    }
    
    func testHexStringLintingWithLetterBeforeNumberHexString() {
        XCTAssertTrue("A1B2C3D4E5F6".isValidHexString)
    }
    
    func testHexStringLintingWithPartiallyValidHexString() {
        XCTAssertFalse("1a2b3c4d5e6z".isValidHexString)
    }
    
    func testHexStringLintingWithInvalidHexString() {
        XCTAssertFalse("NOT_A_HEX".isValidHexString)
    }
    
    func testHexStringLintingWithEmptyString() {
        XCTAssertFalse("".isValidHexString)
    }
    
    // MARK: Hex String Generation
    
    func testDataToHexString() {
        
        setupIfNeeded()
        
        let hexString = data.hexString
        XCTAssertEqual(hexString, "1a2b3c4d5e6f")
        XCTAssertTrue(hexString.isValidHexString)
    
    }
    
    func testStringToHexString() {
        
        setupIfNeeded()
        
        let hexString = string.hexString
        XCTAssertEqual(hexString, "4279746573")
        XCTAssertTrue(hexString.isValidHexString)
    
    }
    
    // MARK: Hex String to Array
    
    func testBytesArrayFromHexString() {
        
        let bytes = Array<UInt8>.bytes(fromHexString: "1a2b3c4d5e6f")
        
        XCTAssertNotNil(bytes)
        
        guard bytes != nil else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(bytes!, [0x1a, 0x2b, 0x3c, 0x4d, 0x5e, 0x6f])

    }
    
    func testBytesArrayFromUppercaseHexString() {
        
        let bytes = Array<UInt8>.bytes(fromHexString: "1A2B3C4D5E6F")
        
        XCTAssertNotNil(bytes)
        
        guard bytes != nil else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(bytes!, [0x1a, 0x2b, 0x3c, 0x4d, 0x5e, 0x6f])
        
    }
    
    func testBytesArrayFromUpperAndLowercaseHexString() {
        
        let bytes = Array<UInt8>.bytes(fromHexString: "1A2b3C4d5E6f")
        
        XCTAssertNotNil(bytes)
        
        guard bytes != nil else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(bytes!, [0x1a, 0x2b, 0x3c, 0x4d, 0x5e, 0x6f])
        
    }
    
    func testBytesArrayFromLetterBeforeNumberHexString() {
        
        let bytes = Array<UInt8>.bytes(fromHexString: "A1B2C3D4E5F6")
        
        XCTAssertNotNil(bytes)
        
        guard bytes != nil else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(bytes!, [0xa1, 0xb2, 0xc3, 0xd4, 0xe5, 0xf6])
        
    }
    
    func testBytesArrayFromLettersOnlyHexString() {
        
        let bytes = Array<UInt8>.bytes(fromHexString: "abcdef")
        
        XCTAssertNotNil(bytes)
        
        guard bytes != nil else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(bytes!, [0xab, 0xcd, 0xef])
        
    }
    
    func testBytesArrayFromEvenHexString() {
        
        let bytes = Array<UInt8>.bytes(fromHexString: "1a2b3c4d5e6")
        
        XCTAssertNotNil(bytes)
        
        guard bytes != nil else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(bytes!, [0x1a, 0x2b, 0x3c, 0x4d, 0x5e, 0x6])

    }
    
    func testBytesArrayFromNonHexString() {
        let bytes = Array<UInt8>.bytes(fromHexString: "NOT_A_HEX")
        XCTAssertNil(bytes)
    }
    
    func testBytesArrayFromInvalidHexString() {
        let bytes = Array<UInt8>.bytes(fromHexString: "1z2y3x")
        XCTAssertNil(bytes)
        
    }
    
    func testBytesArrayFromEmptyString() {
        let bytes = Array<UInt8>.bytes(fromHexString: "")
        XCTAssertNil(bytes)
    }
    
    // MARK: Hex String to Data
    
    func testDataFromHexString() {
        
        let data = Data(hexString: "1a2b3c4d5e6f")
        XCTAssertNotNil(data)
        
        guard data != nil else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(data!, Data(bytes: [0x1a, 0x2b, 0x3c, 0x4d, 0x5e, 0x6f]))
        
    }
    
    func testDataFromUppercaseHexString() {
        
        let data = Data(hexString: "1A2B3C4D5E6F")
        XCTAssertNotNil(data)
        
        guard data != nil else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(data!, Data(bytes: [0x1a, 0x2b, 0x3c, 0x4d, 0x5e, 0x6f]))
        
    }
    
    func testDataFromInvalidHexString() {
        let data = Data(hexString: "NOT_A_HEX")
        XCTAssertNil(data)
    }
    
}

extension BytesKitTests {
    
    static var allTests : [(String, (BytesKitTests) -> () throws -> Void)] {
        return [
            ("testDataBytesConvertible", testDataBytesConvertible),
            ("testEmptyDataBytesConvertible", testEmptyDataBytesConvertible),
            ("testStringBytesConvertible", testStringBytesConvertible),
            ("testEmptyStringBytesConvertible", testEmptyStringBytesConvertible),
            ("testHexStringAllowedCharset", testHexStringAllowedCharset),
            ("testHexStringLintingWithValidHex", testHexStringLintingWithValidHex),
            ("testHexStringLintingWithUppercaseValidHex", testHexStringLintingWithUppercaseValidHex),
            ("testHexStringLintingWithUpperAndLowercaseValidHex", testHexStringLintingWithUpperAndLowercaseValidHex),
            ("testHexStringLintingWithLetterBeforeNumberHexString", testHexStringLintingWithLetterBeforeNumberHexString),
            ("testHexStringLintingWithPartiallyValidHexString", testHexStringLintingWithPartiallyValidHexString),
            ("testHexStringLintingWithInvalidHexString", testHexStringLintingWithInvalidHexString),
            ("testHexStringLintingWithEmptyString", testHexStringLintingWithEmptyString),
            ("testDataToHexString", testDataToHexString),
            ("testStringToHexString", testStringToHexString),
            ("testBytesArrayFromHexString", testBytesArrayFromHexString),
            ("testBytesArrayFromUppercaseHexString", testBytesArrayFromUppercaseHexString),
            ("testBytesArrayFromUpperAndLowercaseHexString", testBytesArrayFromUpperAndLowercaseHexString),
            ("testBytesArrayFromLetterBeforeNumberHexString", testBytesArrayFromLetterBeforeNumberHexString),
            ("testBytesArrayFromLettersOnlyHexString", testBytesArrayFromLettersOnlyHexString),
            ("testBytesArrayFromEvenHexString", testBytesArrayFromEvenHexString),
            ("testBytesArrayFromNonHexString", testBytesArrayFromNonHexString),
            ("testBytesArrayFromInvalidHexString", testBytesArrayFromInvalidHexString),
            ("testDataFromHexString", testDataFromHexString),
            ("testDataFromUppercaseHexString", testDataFromUppercaseHexString),
            ("testDataFromInvalidHexString", testDataFromInvalidHexString)
        ]
    }
    
}
