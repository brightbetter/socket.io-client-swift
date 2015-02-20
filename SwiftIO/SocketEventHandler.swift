//
//  EventHandler.swift
//  Socket.IO-Swift
//
//  Created by Erik Little on 1/18/15.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

class SocketEventHandler {
    let ack:SocketAckHandler!
    let event:String!
    let callback:NormalCallback?
    let callbackMult:MultipleCallback?
    var multiEvent = false
    
    init(event:String, callback:NormalCallback, ack:SocketAckHandler) {
        self.event = event
        self.callback = callback
        self.callbackMult = nil
        self.ack = ack
    }
    
    init(event:String, callback:MultipleCallback, ack:SocketAckHandler) {
        self.event = event
        self.callbackMult = callback
        self.callback = nil
        self.multiEvent = true
        self.ack = ack
    }
    
    func executeCallback(item:AnyObject?, items:NSArray? = nil) {
        if self.multiEvent {
            if items != nil {
                callbackMult?(items)
            } else if item != nil {
                callbackMult?([item!])
            } else {
                callbackMult?(nil)
            }
        } else {
            if items != nil {
                callback?(items)
            } else {
                callback?(item)
            }
        }
    }
}