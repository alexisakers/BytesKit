# `import BytesKit`

![Swift 3.0](https://img.shields.io/badge/Swift-3.0-ee4f37.svg) ![Licence](https://img.shields.io/cocoapods/l/BytesKit.svg) ![Build Status](https://img.shields.io/travis/alexaubry/BytesKit.svg) ![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-41BC51D.svg) ![CocoaPods](https://img.shields.io/cocoapods/v/BytesKit.svg)

`BytesKit` allows you to manipulate bytes in Swift objects in a protocol-oriented manner.

## Features

- [x] Protocol-oriented
- [x] Object to array of bytes conversion
- [x] Object to hex string conversion
- [x] Hex string to array of bytes conversion
- [x] Hex string to `Data` conversion 
- [x] Hex string validation

## Platforms

- [x] iOS 8.0 and above
- [x] macOS 10.10 and above
- [x] tvOS 9.0 and above
- [x] watchOS 2.0 and above
- [x] Linux (Swift 3)

## Installation

### Swift Package Manager

Add this line to your `Package.swift` file (in the dependencies array) :

~~~swift
.Package(url: "https://github.com/alexaubry/BytesKit.git", majorVersion: 1)
~~~

### CocoaPods

Add this line to your `Podfile` :

~~~ruby
pod 'BytesKit' ~> '1.0'
~~~

### Carthage

Add this line to your `Cartfile` :

~~~ruby
github 'alexaubry/BytesKit'
~~~

### Manually

Drop the `BytesKit.swift` file into your project.

## Usage

### Protocol-orientation

This library defines the `BytesConvertible` protocol, which is the root of all of its features.

`String` and `Data` conform to this protocol out of the box, and you can make your own custom types conform to it as well.

### Convert an object to an array of bytes

Objects that conform to the former protocol expose the `bytes` property, which returns the receiver converted to an array of bytes.

~~~swift
let data = Data(bytes: [0x1a, 0x2b, 0x3c, 0x4d])
let string = "ABCD"

let dataBytes = data.bytes // returns [0x1a, 0x2b, 0x3c, 0x4d]
let stringBytes = string.bytes // returns [0x41, 0x42, 0x43, 0x44]
~~~

### Convert an object to a hex string

You can get the hex representation of an object that conform to the protocol using the `hexString` property :

~~~swift
let dataHexString = data.hexString // returns "1a2b3c4d"
let stringHexString = string.hexString // returns "41424344"
~~~

### Convert a hex string to an array of bytes

You can convert a hex string to an array of bytes by calling `Array<UInt8>.bytes(fromHexString:)`. The hex string will automatically be verified before the conversion.

~~~swift
let hexString = "A1B2C3"

if let bytes = Array<UInt8>.bytes(fromHexString: hexString) {
    print("Bytes : \(bytes)")
} else {
    print("The hex string '\(hexString)' is invalid.")
}
~~~

### Convert a hex string to a Data object

Similarly, you can convert a hex string to a `Data` object using the `init?(hexString:)` initializer.

~~~swift
if let convertedData = Data(hexString: hexString) {
    print("Bytes : \(convertedData.bytes)")
} else {
    print("The hex string '\(hexString)' is invalid.")
}
~~~

### Validate a hex string

To check if a string contains only HEX-compatible characters—that is `0123456789ABCDEFabcdef`—, use the `isValidHexString` property.

~~~swift
let hex1 = "ABCDEF"
print(hex1.isValidHexString) // prints "true"

let hex2 = "ABCDEFG"
print(hex2.isValidHexString) // prints "false"
~~~
