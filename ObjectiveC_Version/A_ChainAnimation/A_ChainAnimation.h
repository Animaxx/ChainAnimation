//
//  A_ChainAnimation.h
//  A_ChainAnimation
//
//  Created by Animax Deng on 3/8/17.
//  Copyright © 2017 Animx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "A_Animation.h"
#import "A_AnimationEnumeration.h"
#import "A_AnimationKeyframeProvider.h"
#import "CALayer+A_Animation.h"
#import "UIView+A_Animation.h"

@interface A_ChainAnimation : NSObject

/**
 Target object
 */
@property (weak, nonatomic) UIView *targetView;


/**
 Set to sync, adding animations after this set will be rander at same time.
 */
@property (assign, readonly) A_ChainAnimation *thenSync;

/**
 Set to async.
 */
@property (assign, readonly) A_ChainAnimation *then;

/**
 Initialize animation with target UIView

 @param target Target UIView
 @return A_ChainAnimation
 */
+ (A_ChainAnimation *)animate:(UIView *)target;

/**
 Run the whole animations chain.
 */
- (void)play;

#pragma mark - UIView block animation set

- (A_ChainAnimation *)addAnimationWithDuration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock;

- (A_ChainAnimation *)addAnimationWithDuration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock completion:(void(^)(void))completionBlock;

- (A_ChainAnimation *)addAnimationWithWaitTime:(NSTimeInterval)waitTime duration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock;

- (A_ChainAnimation *)addAnimationWithWaitTime:(NSTimeInterval)waitTime duration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock completion:(void(^)(void))completionBlock;

#pragma mark - A_AnimationEffect animation set
- (A_ChainAnimation *)addAnimationWithEffect:(A_AnimationEffectType)effect type:(A_AnimationType)type duration:(NSTimeInterval)duration ;



@end
