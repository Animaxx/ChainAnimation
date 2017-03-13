//
//  A_ChainAnimation.m
//  A_ChainAnimation
//
//  Created by Animax Deng on 3/8/17.
//  Copyright © 2017 Animx. All rights reserved.
//

#import "A_ChainAnimation.h"

@interface animationItem : NSObject

@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) NSTimeInterval waitingTime;
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


@interface A_ChainAnimation()

@property (nonatomic, strong) NSMutableArray<animationItem *> *chainItems;

@end

@implementation A_ChainAnimation

- (instancetype)init {
    self = [super init];
    if (self) {
        _chainItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (A_ChainAnimation *)addAnimationWithduration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock {
    return [self addAnimationWithWaitTime:0.0 duration:duration aniamtion:animationBlock completion:nil];
}
- (A_ChainAnimation *)addAnimationWithduration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock completion:(void(^)(void))completionBlock {
    return [self addAnimationWithWaitTime:0.0 duration:duration aniamtion:animationBlock completion:completionBlock];
}
- (A_ChainAnimation *)addAnimationWithWaitTime:(NSTimeInterval)waitTime duration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock {
    return [self addAnimationWithWaitTime:waitTime duration:duration aniamtion:animationBlock completion:nil];
}
- (A_ChainAnimation *)addAnimationWithWaitTime:(NSTimeInterval)waitTime duration:(NSTimeInterval)duration aniamtion:(void(^)(void))animationBlock completion:(void(^)(void))completionBlock {
    
    animationItem *item = [[animationItem alloc] init];
    item.duration = duration;
    item.waitingTime = waitTime;
    item.animationBlock = animationBlock;
    item.completedBlock = completionBlock;
    
    [self.chainItems addObject:item];
    
    return self;
}

- (void)run {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        
        for (animationItem *item in self.chainItems) {
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
    });
}
//- (void)dealloc {
//    NSLog(@"dealloc");
//}

@end



