//
//  UIView+A_Extension.h
//  A_IOSHelper
//
//  Created by Animax on 3/13/15.
//  Copyright (c) 2015 AnimaxDeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "A_Animation.h"
#import "A_ChainAnimation.h"

@interface UIView (A_Animation)

#pragma mark - Simple Chian Animation
+ (A_ChainAnimation *)addAnimationWithDuration:(NSTimeInterval)duration
                                     aniamtion:(void(^)(void))animationBlock;

+ (A_ChainAnimation *)addAnimationWithDuration:(NSTimeInterval)duration
                                     aniamtion:(void(^)(void))animationBlock
                                    completion:(void(^)(void))completionBlock;

+ (A_ChainAnimation *)addAnimationWithWaitTime:(NSTimeInterval)waitTime
                                      duration:(NSTimeInterval)duration
                                     aniamtion:(void(^)(void))animationBlock;

+ (A_ChainAnimation *)addAnimationWithWaitTime:(NSTimeInterval)waitTime
                                      duration:(NSTimeInterval)duration
                                     aniamtion:(void(^)(void))animationBlock
                                    completion:(void(^)(void))completionBlock;


#pragma mark - Animation Effect Express
- (void) A_AnimationEffect:(A_AnimationEffectType)type Repeat:(float)repeat Duration:(double)duration CompletionBlock:(void (^)(void))block;
- (void) A_AnimationEffect:(A_AnimationEffectType)type Repeat:(float)repeat Duration:(double)duration;
- (void) A_AnimationEffect:(A_AnimationEffectType)type Repeat:(float)repeat CompletionBlock:(void (^)(void))block;
- (void) A_AnimationEffect:(A_AnimationEffectType)type Repeat:(float)repeat;

- (void) A_AnimationEffect:(A_AnimationEffectType)type Duration:(double)duration CompletionBlock:(void (^)(void))block;
- (void) A_AnimationEffect:(A_AnimationEffectType)type Duration:(double)duration;

- (void) A_AnimationEffect:(A_AnimationEffectType)type CompletionBlock:(void (^)(void))block;
- (void) A_AnimationEffect:(A_AnimationEffectType)type;

@end
