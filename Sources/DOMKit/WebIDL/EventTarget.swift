
/*
 * The following code is auto generated using webidl2swift
 */

import JavaScriptKit

public class EventTarget: JSBridgedClass {
    public struct Token {
        var type: String
        var index: Int
    }
    public class var constructor: JSFunction { JSObject.global.EventTarget.function! }

    var eventListeners = [String: [JSClosure]]()

    public let jsObject: JSObject

    public required init(unsafelyWrapping jsObject: JSObject) {
        self.jsObject = jsObject
    }

    public convenience init() {
        self.init(unsafelyWrapping: EventTarget.constructor.new())
    }

    deinit {
        for (_, listeners) in eventListeners {
            for closure in listeners {
                closure.release()
            }
        }
    }

    public func addEventListener<EventListenerType: EventListener>(
        type: String,
        options: AddEventListenerOptionsOrBool = [:],
        callback: EventListenerType) {
        _ = jsObject.addEventListener!(type.jsValue(), callback.jsValue(), options.jsValue())
    }

    public func addEventListener(
        type: String,
        options: AddEventListenerOptionsOrBool = [:],
        callback: @escaping (Event) -> ()
    ) -> Token {
        let closure = JSClosure {
            callback($0[0].fromJSValue()!)

            return .undefined
        }
        let token: Token
        let listeners: [JSClosure]
        if var existingListeners = eventListeners[type] {
            token = Token(type: type, index: existingListeners.count)
            existingListeners.append(closure)
            listeners = existingListeners
        } else {
            token = Token(type: type, index: 0)
            listeners = [closure]
        }
        eventListeners[type] = listeners

        _ = jsObject.addEventListener!(type.jsValue(), closure, options.jsValue())

        return token
    }

    public func removeEventListener<EventListenerType: EventListener>(
        type: String,
        options: EventListenerOptionsOrBool = [:],
        callback: EventListenerType
    ) {
        _ = jsObject.removeEventListener!(type.jsValue(), callback.jsValue(), options.jsValue())
    }

    public func removeEventListener(
        type: String,
        token: Token,
        options: EventListenerOptionsOrBool = [:]
    ) {
        guard var listeners = eventListeners[type] else { return }

        let closure = listeners[token.index]
        _ = jsObject.removeEventListener!(type.jsValue(), closure, options.jsValue())
        listeners.remove(at: token.index)
        closure.release()
    }

    public func dispatchEvent(event: Event) -> Bool {
        return jsObject.dispatchEvent!(event.jsValue()).fromJSValue()!
    }
}
