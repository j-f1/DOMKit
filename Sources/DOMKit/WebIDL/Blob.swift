
/*
 * The following code is auto generated using webidl2swift
 */

import JavaScriptKit

public class Blob: JSBridgedClass {
    public class var constructor: JSFunction { JSObject.global.Blob.function! }

    public let jsObject: JSObject

    public required init(unsafelyWrapping jsObject: JSObject) {
        _size = ReadonlyAttribute(jsObject: jsObject, name: "size")
        _type = ReadonlyAttribute(jsObject: jsObject, name: "type")
        self.jsObject = jsObject
    }

    public convenience init(blobParts: [BlobPart], options: BlobPropertyBag = [:]) {
        self.init(unsafelyWrapping: Blob.constructor.new(blobParts.jsValue(), options.jsValue()))
    }

    public convenience init() {
        self.init(unsafelyWrapping: Blob.constructor.new())
    }

    @ReadonlyAttribute
    public var size: UInt64

    @ReadonlyAttribute
    public var type: String

    public func slice(start: Int64, end: Int64, contentType: String) -> Blob {
        return jsObject.slice!(start.jsValue(), end.jsValue(), contentType.jsValue()).fromJSValue()!
    }

    public func slice(start: Int64, end: Int64) -> Blob {
        return jsObject.slice!(start.jsValue(), end.jsValue()).fromJSValue()!
    }

    public func slice(start: Int64) -> Blob {
        return jsObject.slice!(start.jsValue()).fromJSValue()!
    }

    public func slice() -> Blob {
        return jsObject.slice!().fromJSValue()!
    }

    public func stream() -> ReadableStream {
        return jsObject.stream!().fromJSValue()!
    }

    public func text() -> JSPromise {
        return jsObject.text!().fromJSValue()!
    }

    public func arrayBuffer() -> JSPromise {
        return jsObject.arrayBuffer!().fromJSValue()!
    }
}
