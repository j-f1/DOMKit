//
//  Created by Manuel Burghard. Licensed unter MIT.
//

import JavaScriptKit

public extension Window {
    var document: Document { Document(unsafelyWrapping: jsObject.document.object!) }
}

public extension Document {
    var body: HTMLElement {
        .init(unsafelyWrapping: jsObject.body.object!)
    }
}

public extension HTMLElement {
    convenience init?(from element: Element) {
        self.init(from: .object(element.jsObject))
    }
}

public let globalThis = Window(from: JSObject.global.jsValue())!

public class ReadableStream: JSBridgedClass {

    public static var constructor: JSFunction { JSObject.global.ReadableStream.function! }

    public let jsObject: JSObject

    public required init(unsafelyWrapping jsObject: JSObject) {
        self.jsObject = jsObject
    }

    public subscript(dynamicMember name: String) -> JSValue {
        get { jsObject[name] }
        set { jsObject[name] = newValue }
    }
}

@propertyWrapper public final class OptionalClosureHandler<ArgumentType, ReturnType> 
where ArgumentType: JSValueCompatible, ReturnType: JSValueCompatible {
    let jsObject: JSObject
    let name: String
    var closure: JSClosure?

    public init(jsObject: JSObject, name: String) {
        self.jsObject = jsObject
        self.name = name
    }

    deinit {
        closure?.release()
    }

    public var wrappedValue: ((ArgumentType) -> ReturnType)? {
        get {
            guard let function = jsObject[name].function else {
                return nil
            }
            return { function($0.jsValue()).fromJSValue()! }
        }
        set {
            if let closure = closure {
                closure.release()
            }
            if let newValue = newValue {
                let closure = JSClosure { newValue($0[0].fromJSValue()!).jsValue() }
                jsObject[name] = closure.jsValue()
                self.closure = closure
            } else {
                jsObject[name] = .null
            }
        }
    }
}

@propertyWrapper public struct ReadWriteAttribute<Wrapped: JSValueCompatible> {

    let jsObject: JSObject
    let name: String

    public init(jsObject: JSObject, name: String) {
        self.jsObject = jsObject
        self.name = name
    }

    public var wrappedValue: Wrapped {
        get {
            return jsObject[name].fromJSValue()!
        }
        set {
            jsObject[name] = newValue.jsValue()
        }
    }
}

@propertyWrapper public struct ReadonlyAttribute<Wrapped: ConstructibleFromJSValue> {

    let jsObject: JSObject
    let name: String

    public init(jsObject: JSObject, name: String) {
        self.jsObject = jsObject
        self.name = name
    }

    public var wrappedValue: Wrapped {
        get {
            return jsObject[name].fromJSValue()!
        }
    }
}

public class ValueIterableIterator<SequenceType: JSBridgedClass & Sequence>: IteratorProtocol where SequenceType.Element: ConstructibleFromJSValue {

    private var index: Int = 0
    private let sequence: SequenceType

    public init(sequence: SequenceType) {
        self.sequence = sequence
    }

    public func next() -> SequenceType.Element? {
        defer {
            index += 1
        }
        let value = sequence.jsObject[index]
        guard value != .undefined else {
            return nil
        }

        return value.fromJSValue()
    }
}

public protocol KeyValueSequence: Sequence where Element == (String, Value) {
    associatedtype Value
}

public class PairIterableIterator<SequenceType: JSBridgedClass & KeyValueSequence>: IteratorProtocol where SequenceType.Value: ConstructibleFromJSValue {

    private let iterator: JSObject
    private let sequence: SequenceType

    public init(sequence: SequenceType) {
        self.sequence = sequence
        self.iterator = sequence.jsObject.entries!().object!
    }

    public func next() -> SequenceType.Element? {

        let next: JSObject = iterator.next!().object!

        guard next.done.boolean! == false else {
            return nil
        }

        let keyValue: [JSValue] = next.value.fromJSValue()!
        return (keyValue[0].fromJSValue()!, keyValue[1].fromJSValue()!)
    }
}
