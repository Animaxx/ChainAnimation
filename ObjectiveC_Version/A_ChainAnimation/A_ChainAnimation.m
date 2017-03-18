//
//  A_ChainAnimation.m
//  A_ChainAnimation
//
//  Created by Animax Deng on 3/8/17.
//  Copyright © 2017 Animx. All rights reserved.
//

#import "A_ChainAnimation.h"

typedef enum : NSUInteger {
    animationType_AnimationBlock,
    animationType_CAAniamtion,
    animationType_Wait,
    animationType_Block,
} animationType;

@interface animationItem : NSObject

@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) NSTimeInterval waitingTime;
@property (nonatomic) animationType  type;

@property (strong, nonatomic) NSMutableArray<CAAnimation *> *animations;
@property (strong, nonatomic) NSMutableArray<CAAnimation *> *animationsForMirror;

@property (copy, nonatomic) void(^animationBlock)(void);
@property (copy, nonatomic) void(^completedBlock)(void);


@end

@implementation animationItem

- (instancetype)init {
    self = [super init];
    if (self) {
        self.duration = 0.5f;
    }
    return self;
}

@end


typedef enum : NSUInteger {
    chainAnimtionModeAsync,
    chainAnimtionModeSync,
} chainAnimtionMode;

@interface A_ChainAnimation()

@property (nonatomic, strong) animationItem *syncingChainItem;

@property (nonatomic, strong) NSMutableArray<animationItem *> *chainItems;
@property (atomic) chainAnimtionMode currectMode;

@end

@implementation A_ChainAnimation

@dynamic thenSync;
@dynamic then;

#pragma mark - private methods
- (void) _checkSetToChain {
    if (_syncingChainItem && (_syncingChainItem.waitingTime > 0 || _syncingChainItem.duration > 0 || (_syncingChainItem.animations && [_syncingChainItem.animations count] > 0) || _syncingChainItem.animations)) {
        [_chainItems addObject:_syncingChainItem];
    }
    _syncingChainItem = nil;
}

#pragma mark - Init
+ (A_ChainAnimation *)animate:(UIView *)target {
    A_ChainAnimation *animation = [[A_ChainAnimation alloc] init];
    animation.targetView = target;
    return animation;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _chainItems = [[NSMutableArray alloc] init];
        _currectMode = chainAnimtionModeAsync;
    }
    return self;
}

#pragma mark - Dynamic Property
- (A_ChainAnimation *)thenSync {
    [self _checkSetToChain];
    _currectMode = chainAnimtionModeSync;
    return self;
}
- (A_ChainAnimation *)then {
    [self _checkSetToChain];
    _currectMode = chainAnimtionModeAsync;
    return self;
}

#pragma mark - UIView block animation set
- (A_ChainAnimation *)addAnimationWithDuration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock {
    return [self addAnimationWithWaitTime:0.0 duration:duration aniamtion:animationBlock completion:nil];
}
- (A_ChainAnimation *)addAnimationWithDuration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock completion:(void(^)(void))completionBlock {
    return [self addAnimationWithWaitTime:0.0 duration:duration aniamtion:animationBlock completion:completionBlock];
}
- (A_ChainAnimation *)addAnimationWithWaitTime:(NSTimeInterval)waitTime duration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock {
    return [self addAnimationWithWaitTime:waitTime duration:duration aniamtion:animationBlock completion:nil];
}
- (A_ChainAnimation *)addAnimationWithWaitTime:(NSTimeInterval)waitTime duration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock completion:(void(^)(void))completionBlock {
    
    [self _checkSetToChain];
    
    animationItem *item = [[animationItem alloc] init];
    item.duration = duration;
    item.waitingTime = waitTime;
    item.animationBlock = animationBlock;
    item.completedBlock = completionBlock;
    item.type = animationType_AnimationBlock;
    
    [self.chainItems addObject:item];
    self.currectMode = chainAnimtionModeAsync;
    
    return self;
}

#pragma mark - A_AnimationEffect animation set
- (A_ChainAnimation *)addAnimationWithEffect:(A_AnimationEffectType)effect type:(A_AnimationType)type duration:(NSTimeInterval)duration {
    
    if (self.currectMode == chainAnimtionModeSync) {
        
        if (_syncingChainItem) {
            _syncingChainItem.duration = _syncingChainItem.duration > duration ? _syncingChainItem.duration : duration;
            _syncingChainItem.animations = [[NSMutableArray alloc] initWithObjects:[A_Animation A_GenerateEffect:effect Duration:duration], nil];
            
        } else {
            _syncingChainItem = [[animationItem alloc] init];
            _syncingChainItem.type = animationType_CAAniamtion;
            _syncingChainItem.duration = duration;
            _syncingChainItem.animations = [[NSMutableArray alloc] init];
            _syncingChainItem.animationsForMirror = [[NSMutableArray alloc] init];
            
            if ([A_Animation A_CheckIfMirrorEffect:effect]) {
                [_syncingChainItem.animationsForMirror addObject:[A_Animation A_GenerateEffect:effect Duration:duration]];
            } else {
                [_syncingChainItem.animations addObject:[A_Animation A_GenerateEffect:effect Duration:duration]];
            }
            
        }
        
    } else {
        animationItem *item = [[animationItem alloc] init];
        item.duration = duration;
        item.type = animationType_CAAniamtion;
        item.animations = [[NSMutableArray alloc] init];
        item.animationsForMirror = [[NSMutableArray alloc] init];
        
        if ([A_Animation A_CheckIfMirrorEffect:effect]) {
            [_syncingChainItem.animationsForMirror addObject:[A_Animation A_GenerateEffect:effect Duration:duration]];
        } else {
            [_syncingChainItem.animations addObject:[A_Animation A_GenerateEffect:effect Duration:duration]];
        }
        
        
        [self.chainItems addObject:item];
    }
    return self;
}


- (void)play {
    [self _checkSetToChain];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        
        for (animationItem *item in self.chainItems) {
            switch (item.type) {
                case animationType_Block: {
                    
                }
                break;
                case animationType_AnimationBlock: {
                    dispatch_semaphore_t inflightSemaphore= dispatch_semaphore_create(0);
                    
                    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(item.waitingTime * NSEC_PER_SEC));
                    dispatch_after(delayTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        dispatch_async(dispatch_get_main_queue(), ^ {
                            
                            [UIView animateWithDuration:item.duration animations:^{
                                if (item.animationBlock) {
                                    item.animationBlock();
                                }
                            } completion:^(BOOL finished) {
                                if (item.completedBlock) {
                                    item.completedBlock();
                                }
                                dispatch_semaphore_signal(inflightSemaphore);
                            }];
                            
                        });
                    });
                    
                    dispatch_semaphore_wait(inflightSemaphore, DISPATCH_TIME_FOREVER);
                }
                    break;
                case animationType_CAAniamtion: {
                    if (!self.targetView) {
                        break;
                    }
                    
                    dispatch_semaphore_t inflightSemaphore= dispatch_semaphore_create(0);
                    
                    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(item.waitingTime * NSEC_PER_SEC));
                    dispatch_after(delayTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        dispatch_async(dispatch_get_main_queue(), ^ {
                            
                            CALayer *mirrorLayer = nil;
                            if (item.animationsForMirror && [item.animationsForMirror count] > 0) {
                                UIGraphicsBeginImageContext(self.targetView.layer.frame.size);
                                [self.targetView.layer renderInContext:UIGraphicsGetCurrentContext()];
                                UIImage *mirrorImage = UIGraphicsGetImageFromCurrentImageContext();
                                UIGraphicsEndImageContext();
                                
                                mirrorLayer = [CALayer layer];
                                [mirrorLayer setContents:(id)mirrorImage.CGImage];
                                [mirrorLayer setPosition:self.targetView.center];
                                [mirrorLayer setFrame:CGRectMake(0, 0, self.targetView.frame.size.width, self.targetView.frame.size.height)];
                                [mirrorLayer setOpacity:0.5f];
                                [self.targetView.layer addSublayer:mirrorLayer];
                            }
                            
                            [CATransaction begin]; {
                                
                                [CATransaction setCompletionBlock:^{
                                    dispatch_semaphore_signal(inflightSemaphore);
                                    [mirrorLayer removeFromSuperlayer];
                                }];
                                
                                if (item.animations && [item.animations count] > 0) {
                                    CAAnimationGroup *group = [CAAnimationGroup animation];
                                    [group setRemovedOnCompletion:YES];
                                    [group setAnimations:item.animations];
                                    [group setDuration:item.duration];
                                    [self.targetView.layer addAnimation:group forKey:nil];
                                }
                                if (item.animationsForMirror && [item.animationsForMirror count] > 0) {
                                    
                                    CAAnimationGroup *group = [CAAnimationGroup animation];
                                    [group setRemovedOnCompletion:YES];
                                    [group setAnimations:item.animationsForMirror];
                                    [group setDuration:item.duration];
                                    [mirrorLayer addAnimation:group forKey:nil];
                                }
                                
                            } [CATransaction commit];
                            
                        });
                    });
                    
                    dispatch_semaphore_wait(inflightSemaphore, DISPATCH_TIME_FOREVER);
                    
                }
                    break;
                case animationType_Wait: {
                    
                }
                    break;
                default:
                    break;
            }
            
            

        }
    });
}


//- (void)dealloc {
//    NSLog(@"dealloc");
//}

@end



