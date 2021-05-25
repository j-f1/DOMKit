
/*
 * The following code is auto generated using webidl2swift
 */

import JavaScriptKit

public class MutationObserver: JSBridgedClass {
    public class var constructor: JSFunction { JSObject.global.MutationObserver.function! }

    public let jsObject: JSObject
    var closure: JSClosure?

    public required init(unsafelyWrapping jsObject: JSObject) {
        self.jsObject = jsObject
    }

    public convenience init(callback: @escaping MutationCallback) {
        let closure = JSClosure {
            callback($0[0].fromJSValue()!, $0[1].fromJSValue()!)

            return .undefined
        }
        self.init(unsafelyWrapping: MutationObserver.constructor.new(closure))
        self.closure = closure
    }

    deinit {
        closure?.release()
    }

    public func observe(target: Node, options: MutationObserverInit = [:]) {
        _ = jsObject.observe!(target.jsValue(), options.jsValue())
    }

    public func disconnect() {
        _ = jsObject.disconnect!()
    }

    public func takeRecords() -> [MutationRecord] {
        return jsObject.takeRecords!().fromJSValue()!
    }
}
