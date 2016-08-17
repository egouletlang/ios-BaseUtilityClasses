//
//  ThreadHelper.swift
//  Bankroll
//
//  Created by Etienne Goulet-Lang on 5/25/16.
//  Copyright © 2016 Etienne Goulet-Lang. All rights reserved.
//

import Foundation

public class ThreadHelper {
    
    public class func executeOnMainThread(block block: (()->())) {
        dispatch_async(dispatch_get_main_queue()) {
            block()
            return
        }
    }
    public class func executeOnBackgroundThread(block block: ()->Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            block()
        }
    }
    
    /// Checks state of current thread. If foreground schedules block to be executed on background.
    /// If thread is not foreground, executes block on current thread
    public class func checkedExecuteOnBackgroundThread(block block: ()->Void) {
        if !NSThread.isMainThread() {
            block()
        } else {
            executeOnBackgroundThread(block: block)
        }
    }
    
    public class func checkedExecuteOnMainThread(block block: ()->Void) {
        if NSThread.isMainThread() {
            block()
        } else {
            ThreadHelper.executeOnMainThread(block: block)
        }
    }
    
    
    public class func delay(sec sec: Double, mainThread: Bool, block: ()->Void) {
        
        let delay = createDispatchTime(sec)
        
        if mainThread {
            dispatch_after(delay, dispatch_get_main_queue(), block)
        } else {
            dispatch_after(delay, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), block)
        }
    }
    
    /// Creates a dispatch_time based on number of seconds after "now"
    private class func createDispatchTime(seconds: Double) -> dispatch_time_t {
        return dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
    }
    
}