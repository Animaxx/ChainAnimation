//
//  ViewController.m
//  A_ChainAnimationObjcDemo
//
//  Created by Animax Deng on 3/7/17.
//  Copyright © 2017 Animx. All rights reserved.
//

#import "ViewController.h"
#import "A_ChainAnimation.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - implement UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    __weak UIView *box = [cell viewWithTag:0];
    
    switch (indexPath.row) {
        case 10:
            if (box) {
                [[[box addAnimationWithDuration:1.0 aniamtion:^{
                    [box setAlpha:0.0];
                }] addAnimationWithDuration:1.0 aniamtion:^{
                    [box setAlpha:1.0];
                }] play];
            }
            break;
        case 1:
            if (box) {
                [[[box addAnimationWithEffect:A_AnimationEffectType_pulse type:A_AnimationType_easeInBack duration:1.0]
                  addAnimationWithEffect:A_AnimationEffectType_squeeze type:A_AnimationType_bigSpring duration:1.0]
                 play];
            }
            break;
        case 2:
            if (box) {
                [[[[[box addAnimationWithDuration:1.0 aniamtion:^{
                    [box setAlpha:0.3];
                }] addAnimationWithEffect:A_AnimationEffectType_pulse type:A_AnimationType_easeInBack duration:1.0]
                   addAnimationWithDuration:1.0 aniamtion:^{
                       [box setAlpha:1.0];
                   }] addAnimationWithEffect:A_AnimationEffectType_squeeze type:A_AnimationType_easeOutElastic duration:1.0]
                 play];
            }
            break;
        case 0:
            if (box) {
//                [box A_AnimationEffect:A_AnimationEffectType_mirror_zoomOut Duration:1.0];
//                [box A_AnimationEffect:A_AnimationEffectType_zoomOut Duration:1.0];
                [box A_AnimationEffect:A_AnimationEffectType_zoomOut Duration:1.0 CompletionBlock:^{
                    [box setHidden:YES];
                }];
            }
            break;
        default:
            break;
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
