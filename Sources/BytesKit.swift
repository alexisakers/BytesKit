/*
 * ==---------------------------------------------------------------------------------==
 *
 *  File            :   BytesKit.swift
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

import Foundation

#if os(OSX) || os(iOS) || os(tvOS) || os(watchOS)
    internal typealias Regex = NSRegularExpression
#else
    internal typealias Regex = RegularExpression
#endif

// MARK: - Core

///
/// A set of requirements for objects that can be converted to an array of bytes.
///

public protocol BytesConvertible {
    
    ///
    /// The bytes held by the object.
    ///
    
    var bytes: Array<UInt8> { get }
    
}


// MARK: - Conformance

extension Data: BytesConvertible {
    
    public var bytes: Array<UInt8> {
        
        var _bytes = Array<UInt8>(repeating: 0, count: count)
        copyBytes(to: &_bytes, count: count)
        
        return _bytes
        
    }
    
}

extension String: BytesConvertible {
    
    public var bytes: Array<UInt8> {
        return utf8.map { $0 }
    }
    
}

// MARK: - Public Extensions

extension CharacterSet {
    
    ///
    /// The characters allowed in a hex string.
    ///
    
    public static var hexStringAllowed: CharacterSet {
        return CharacterSet(charactersIn: "0123456789ABCDEFabcdef")
    }
    
}

extension String {
    
    ///
    /// A Boolean indicating whether the string is a valid Hex String.
    ///
    /// - warning: This Boolean only indicates that the syntax of the string is valid. It does not check whether its content is valid.
    ///
    
    public var isValidHexString: Bool {
        
        guard !(self.isEmpty) else {
            return false
        }
        
        let charset = CharacterSet.hexStringAllowed
        
        for scalar in self.unicodeScalars {
            
            guard charset.contains(scalar) else {
                return false
            }
            
        }
        
        return true
        
    }
    
}

extension BytesConvertible {
    
    ///
    /// The hexadecimal textual representation of the object.
    ///
    /// - note: The returned string is lowercased.
    ///
    
    public var hexString: String {
        return bytes.map { String(format: "%02x", $0) }.joined()
    }
    
}

extension Array {
    
    ///
    /// Get the bytes contained in a hexadecimal string.
    ///
    /// - parameter hexString: A valid hexadecimal string.
    ///
    /// - returns: The bytes contained in the hex string.
    ///
    
    public static func bytes(fromHexString hexString: String) -> Array<UInt8>? {
        
        guard hexString.isValidHexString else {
            return nil
        }
        
        guard let regex = try? Regex(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive) else {
            return nil
        }
        
        var array = Array<UInt8>()
        
        var hasFailure = false
        
        regex.enumerateMatches(in: hexString, options: [], range: NSMakeRange(0, hexString.characters.count)) {
            match, flags, stop in
            
            guard let match = match else {
                hasFailure = true
                return
            }
            
            let rangeStart = hexString.index(hexString.startIndex, offsetBy: match.range.location)
            let rangeEnd = hexString.index(rangeStart, offsetBy: match.range.length)
            
            let byteString = hexString.substring(with: rangeStart ..< rangeEnd)
            
            guard let num = UInt8(byteString, radix: 16) else {
                hasFailure = true
                return
            }
            
            array.append(num)
            
        }
        
        if hasFailure || array.count <= 0 {
            return nil
        }
        
        return array
        
    }
    
}

extension Data {
    
    ///
    /// Create a data object from a hexadecimal representation.
    ///
    /// - parameter hexString: A valid hexadecimal string to use to create the data object.
    ///
    
    public init?(hexString: String) {
        
        guard let bytes = Array<UInt8>.bytes(fromHexString: hexString) else {
            return nil
        }
        
        self = Data(bytes: bytes)
        
    }
    
}
