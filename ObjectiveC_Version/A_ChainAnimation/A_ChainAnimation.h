//
//  A_ChainAnimation.h
//  A_ChainAnimation
//
//  Created by Animax Deng on 3/8/17.
//  Copyright © 2017 Animx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface A_ChainAnimation : NSObject

- (A_ChainAnimation *)addAnimationWithduration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock;

- (A_ChainAnimation *)addAnimationWithduration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock completion:(void(^)(void))completionBlock;

- (A_ChainAnimation *)addAnimationWithWaitTime:(NSTimeInterval)waitTime duration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock;

- (A_ChainAnimation *)addAnimationWithWaitTime:(NSTimeInterval)waitTime duration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock completion:(void(^)(void))completionBlock;

- (void)run;

@end
