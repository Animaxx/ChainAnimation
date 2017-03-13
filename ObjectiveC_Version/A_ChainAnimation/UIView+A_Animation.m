//
//  UIView+A_Extension.m
//  A_IOSHelper
//
//  Created by Animax on 3/13/15.
//  Copyright (c) 2015 AnimaxDeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+A_Animation.h"

#define defaultDurationTime 0.5f;

@implementation UIView (A_Animation)

- (UIImage*) A_ImageFromLayer {
    UIGraphicsBeginImageContext(self.layer.frame.size);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

#pragma mark - Simple Chian Animation
+ (A_ChainAnimation *)addAnimationWithDuration:(NSTimeInterval)duration
                                     aniamtion:(void(^)(void))animationBlock {
    return [[[A_ChainAnimation alloc] init] addAnimationWithWaitTime:0.0 duration:duration aniamtion:animationBlock completion:nil];
}

+ (A_ChainAnimation *)addAnimationWithDuration:(NSTimeInterval)duration
                                     aniamtion:(void(^)(void))animationBlock
                                    completion:(void(^)(void))completionBlock{
    return [[[A_ChainAnimation alloc] init] addAnimationWithWaitTime:0.0 duration:duration aniamtion:animationBlock completion:completionBlock];
}

+ (A_ChainAnimation *)addAnimationWithWaitTime:(NSTimeInterval)waitTime
                                      duration:(NSTimeInterval)duration
                                     aniamtion:(void(^)(void))animationBlock{
    return [[[A_ChainAnimation alloc] init] addAnimationWithWaitTime:waitTime duration:duration aniamtion:animationBlock completion:nil];
}

+ (A_ChainAnimation *)addAnimationWithWaitTime:(NSTimeInterval)waitTime
                                      duration:(NSTimeInterval)duration
                                     aniamtion:(void(^)(void))animationBlock
                                    completion:(void(^)(void))completionBlock{
    
    return [[[A_ChainAnimation alloc] init] addAnimationWithWaitTime:waitTime duration:duration aniamtion:animationBlock completion:completionBlock];
}

#pragma mark - Animation Effect
- (void) A_AnimationEffect:(A_AnimationEffectType)type Repeat:(float)repeat Duration:(double)duration CompletionBlock:(void (^)(void))block{
    
    CALayer *mirrorLayer = nil;
    
    if (duration <= 0)
        duration = defaultDurationTime;
    
    if ((int)type >= 200 && (int)type <= 299) {
        // appear effect group
        [self setHidden:NO];
        [self setAlpha:1.0f];
        [self.layer setHidden:NO];
    } else if ((int)type >= 1000 && (int)type <= 1999) {
        // mirror effect group
        UIImage *mirrorImage = [self A_ImageFromLayer];
        mirrorLayer = [CALayer layer];
        [mirrorLayer setContents:(id)mirrorImage.CGImage];
        [mirrorLayer setPosition:self.center];
        [mirrorLayer setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [mirrorLayer setOpacity:0.5f];
        [self.layer addSublayer:mirrorLayer];
    }
    
    [CATransaction begin]; {
        [CATransaction setCompletionBlock:^{
            if ((int)type >= 1000 && (int)type <= 1999 && mirrorLayer) {
                [mirrorLayer removeFromSuperlayer];
            }
            if (block) {
                block();
            }
        }];
        
        A_AnimationEffectType animationType = type;
        // generate normal effection when it's for mirror layer
        if ((int)animationType > 1000) {
            animationType = (A_AnimationEffectType)((int)animationType - 1000);
        }
        
        CAAnimationGroup *animations = [A_Animation A_GenerateEffect:animationType Duration:duration];
        if (repeat > 0) {
            animations.repeatCount = repeat;
        }
        
        if ((int)type >= 1000 && (int)type <= 1999) {
            // mirror effect group
            [mirrorLayer addAnimation:animations forKey:nil];
        } else {
            if ((int)type >= 300 && (int)type <= 399) {
                // disappear effect group
                animations.removedOnCompletion = NO;
            }
            [self.layer addAnimation:animations forKey:nil];
        }
    
    } [CATransaction commit];
    
    if ((int)type >= 300 && (int)type <= 399) {
        // disappear effect group
        [self.layer setOpacity:0.0];
    }
}
- (void) A_AnimationEffect:(A_AnimationEffectType)type Repeat:(float)repeat Duration:(double)duration{
    [self A_AnimationEffect:type Repeat:repeat Duration:duration CompletionBlock:nil];
}
- (void) A_AnimationEffect:(A_AnimationEffectType)type Repeat:(float)repeat CompletionBlock:(void (^)(void))block {
    [self A_AnimationEffect:type Repeat:repeat Duration:0 CompletionBlock:block];
}
- (void) A_AnimationEffect:(A_AnimationEffectType)type Repeat:(float)repeat{
    [self A_AnimationEffect:type Repeat:repeat Duration:0 CompletionBlock:nil];
}

- (void) A_AnimationEffect:(A_AnimationEffectType)type Duration:(double)duration CompletionBlock:(void (^)(void))block{
    [self A_AnimationEffect:type Repeat:0 Duration:duration CompletionBlock:block];
}
- (void) A_AnimationEffect:(A_AnimationEffectType)type Duration:(double)duration{
    [self A_AnimationEffect:type Repeat:0 Duration:duration CompletionBlock:nil];
}

- (void) A_AnimationEffect:(A_AnimationEffectType)type CompletionBlock:(void (^)(void))block {
    [self A_AnimationEffect:type Repeat:0 Duration:0 CompletionBlock:block];
}
- (void) A_AnimationEffect:(A_AnimationEffectType)type{
    [self A_AnimationEffect:type Repeat:0 Duration:0 CompletionBlock:nil];
}

@end

