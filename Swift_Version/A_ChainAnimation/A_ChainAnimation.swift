//
//  A_SimpleChainAnimation.swift
//  A_ChainAnimation
//
//  Created by Animax Deng on 3/4/17.
//  Copyright © 2017 Animx. All rights reserved.
//

import UIKit

class A_ChainAnimation: NSObject {
    private class animationItem:NSObject {
        var duration:TimeInterval = 0.5
        var waitingTime:TimeInterval = 0
        var animationBlock:(() -> Swift.Void)? = nil
        var completedBlock:(() -> Swift.Void)? = nil
    }
    
    private var chainItems:[animationItem] = []
    
    func addAnimation(waitTime:TimeInterval = 0, duration:TimeInterval, animation: @escaping () -> Swift.Void, completion: (() -> Swift.Void)? = nil) -> A_ChainAnimation {
        let item = animationItem()
        item.duration = duration
        item.waitingTime = waitTime
        item.animationBlock = animation
        item.completedBlock = completion
        
        self.chainItems.append(item)
        return self
    }
    
    func run() {
        DispatchQueue.global().async {
            for item in self.chainItems {
                let inflightSemaphore = DispatchSemaphore(value: 0)
                DispatchQueue.global().asyncAfter(deadline: .now() + item.waitingTime, execute: {
                    DispatchQueue.main.async(execute: {
                        UIView.animate(withDuration: item.duration, animations: {
                            item.animationBlock?()
                        }) { (result) in
                            item.completedBlock?()
                            inflightSemaphore.signal()
                        }
                    })
                    
                })
                _ = inflightSemaphore.wait(timeout: .distantFuture)
            }
        }
    }
    
}

extension UIView {
    func addAnimation(withWaitTime:TimeInterval = 0, duration:TimeInterval, animation: @escaping () -> Swift.Void, completion: (() -> Swift.Void)? = nil) -> A_ChainAnimation {
        return A_ChainAnimation().addAnimation(waitTime: withWaitTime, duration: duration, animation: animation, completion: completion)
    }
}
