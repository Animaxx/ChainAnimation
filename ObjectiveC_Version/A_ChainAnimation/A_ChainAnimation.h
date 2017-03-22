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

#pragma mark - Dynamic Properties
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

#pragma mark - Initializtion
/**
 Initialize animation with target UIView

 @param target Target UIView
 @return A_ChainAnimation
 */
+ (A_ChainAnimation *)animate:(UIView *)target;

#pragma mark - Execute animate
/**
 Run the whole animations chain.
 */
- (void)play;

#pragma mark - UIView block animation set

- (A_ChainAnimation *)addAnimateWithDuration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock;

- (A_ChainAnimation *)addAnimateWithDuration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock completion:(void(^)(void))completionBlock;

- (A_ChainAnimation *)addAnimateWithWaitTime:(NSTimeInterval)waitTime duration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock;

- (A_ChainAnimation *)addAnimateWithWaitTime:(NSTimeInterval)waitTime duration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock completion:(void(^)(void))completionBlock;

#pragma mark - A_AnimationEffect animation set
- (A_ChainAnimation *)addAnimateWithEffect:(A_AnimationEffectType)effect type:(A_AnimationType)type duration:(NSTimeInterval)duration ;

#pragma mark - CALayer animation set
#pragma mark: Animation Layer Setting
- (A_ChainAnimation *) addAnimateSetAnchorPoint:(CGPoint)value AnimtionType:(A_AnimationType)type;
- (A_ChainAnimation *) addAnimateSetAnchorPoint:(CGPoint)value AnimtionType:(A_AnimationType)type Duraion:(double)duration;
- (A_ChainAnimation *) addAnimateSetBackgroundColor:(UIColor*)value AnimtionType:(A_AnimationType)type;
- (A_ChainAnimation *) addAnimateSetBackgroundColor:(UIColor*)value AnimtionType:(A_AnimationType)type Duraion:(double)duration;
- (A_ChainAnimation *) addAnimateSetOpacity:(CGFloat)value AnimtionType:(A_AnimationType)type;
- (A_ChainAnimation *) addAnimateSetOpacity:(CGFloat)value AnimtionType:(A_AnimationType)type Duraion:(double)duration;
- (A_ChainAnimation *) addAnimateSetPosition:(CGPoint)value AnimtionType:(A_AnimationType)type;
- (A_ChainAnimation *) addAnimateSetPosition:(CGPoint)value AnimtionType:(A_AnimationType)type Duraion:(double)duration;
- (A_ChainAnimation *) addAnimateSetPositionX:(CGFloat)value AnimtionType:(A_AnimationType)type;
- (A_ChainAnimation *) addAnimateSetPositionX:(CGFloat)value AnimtionType:(A_AnimationType)type Duraion:(double)duration;
- (A_ChainAnimation *) addAnimateSetPositionY:(CGFloat)value AnimtionType:(A_AnimationType)type;
- (A_ChainAnimation *) addAnimateSetPositionY:(CGFloat)value AnimtionType:(A_AnimationType)type Duraion:(double)duration;

- (A_ChainAnimation *) addAnimateSetBounds:(CGRect)value AnimtionType:(A_AnimationType)type;
- (A_ChainAnimation *) addAnimateSetBounds:(CGRect)value AnimtionType:(A_AnimationType)type Duraion:(double)duration;
- (A_ChainAnimation *) addAnimateSetBorderWidth:(CGFloat)value AnimtionType:(A_AnimationType)type;
- (A_ChainAnimation *) addAnimateSetBorderWidth:(CGFloat)value AnimtionType:(A_AnimationType)type Duraion:(double)duration;
- (A_ChainAnimation *) addAnimateSetBorderColor:(UIColor*)value AnimtionType:(A_AnimationType)type;
- (A_ChainAnimation *) addAnimateSetBorderColor:(UIColor*)value AnimtionType:(A_AnimationType)type Duraion:(double)duration;
- (A_ChainAnimation *) addAnimateSetContentsRect:(CGRect)value AnimtionType:(A_AnimationType)type;
- (A_ChainAnimation *) addAnimateSetContentsRect:(CGRect)value AnimtionType:(A_AnimationType)type Duraion:(double)duration;
- (A_ChainAnimation *) addAnimateSetCornerRadius:(CGFloat)value AnimtionType:(A_AnimationType)type;
- (A_ChainAnimation *) addAnimateSetCornerRadius:(CGFloat)value AnimtionType:(A_AnimationType)type Duraion:(double)duration;

- (A_ChainAnimation *) addAnimateSetShadowOffset:(CGSize)value AnimtionType:(A_AnimationType)type;
- (A_ChainAnimation *) addAnimateSetShadowOffset:(CGSize)value AnimtionType:(A_AnimationType)type Duraion:(double)duration;
- (A_ChainAnimation *) addAnimateSetShadowOpacity:(CGFloat)value AnimtionType:(A_AnimationType)type;
- (A_ChainAnimation *) addAnimateSetShadowOpacity:(CGFloat)value AnimtionType:(A_AnimationType)type Duraion:(double)duration;
- (A_ChainAnimation *) addAnimateSetShadowRadius:(CGFloat)value AnimtionType:(A_AnimationType)type;
- (A_ChainAnimation *) addAnimateSetShadowRadius:(CGFloat)value AnimtionType:(A_AnimationType)type Duraion:(double)duration;
- (A_ChainAnimation *) addAnimateSetSublayerTransform:(CATransform3D)value AnimtionType:(A_AnimationType)type;
- (A_ChainAnimation *) addAnimateSetSublayerTransform:(CATransform3D)value AnimtionType:(A_AnimationType)type Duraion:(double)duration;

- (A_ChainAnimation *) addAnimateSetZPosition:(CGFloat)value AnimtionType:(A_AnimationType)type;
- (A_ChainAnimation *) addAnimateSetZPosition:(CGFloat)value AnimtionType:(A_AnimationType)type Duraion:(double)duration;

- (A_ChainAnimation *) addAnimateSetSize:(CGSize)value AnimtionType:(A_AnimationType)type;
- (A_ChainAnimation *) addAnimateSetSize:(CGSize)value AnimtionType:(A_AnimationType)type Duraion:(double)duration;

- (A_ChainAnimation *) addAnimateSetTransform:(CATransform3D)value AnimtionType:(A_AnimationType)type;
- (A_ChainAnimation *) addAnimateSetTransform:(CATransform3D)value AnimtionType:(A_AnimationType)type Duraion:(double)duration;

@end
