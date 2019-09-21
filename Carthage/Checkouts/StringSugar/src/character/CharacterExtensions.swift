import Foundation

extension Character {
    public var cgFloat: CGFloat { return CGFloat(Double(String(self))!) }
    public var double: Double { return Double(String(self))! }
    public var uint: UInt { return UInt(Float(String(self))!) }
    public var int: Int { return Int(String(self))! }
}
