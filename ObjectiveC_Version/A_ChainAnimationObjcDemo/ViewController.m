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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    __weak UIView *box = [cell viewWithTag:1];
    __weak UILabel *titleLabel = (UILabel *)[cell viewWithTag:10];
    
    [titleLabel setText:@""];
    [box setHidden:NO];
    
    switch (indexPath.row) {
        case 0:
            if (box) {
                // Two UIView block animation chain
                [titleLabel setText:@"UIView block animation chian example"];
                
                [[[box addAnimateWithDuration:1.0 aniamtion:^{
                    [box setAlpha:0.0];
                }] addAnimateWithDuration:1.0 aniamtion:^{
                    [box setAlpha:1.0];
                }] play];
            }
            break;
        case 1:
            if (box) {
                // Two effection aniamtion chain
                [titleLabel setText:@"Effection animation chian example"];
                
                [[[box addAnimateWithEffect:A_AnimationEffectType_pulse type:A_AnimationType_easeInBack duration:1.0]
                  addAnimateWithEffect:A_AnimationEffectType_squeeze type:A_AnimationType_bigSpring duration:1.0]
                 play];
            }
            break;
        case 2:
            if (box) {
                // UIView block and effection animatiom mix
                [titleLabel setText:@"UIView block animation and Effection animation chian mix"];
                
                [[[[[box addAnimateWithDuration:1.0 aniamtion:^{
                    [box setAlpha:0.3];
                }] addAnimateWithEffect:A_AnimationEffectType_pulse type:A_AnimationType_easeInBack duration:1.0]
                   addAnimateWithDuration:1.0 aniamtion:^{
                       [box setAlpha:1.0];
                   }] addAnimateWithEffect:A_AnimationEffectType_squeeze type:A_AnimationType_easeOutElastic duration:1.0]
                 play];
            }
            break;
        case 3:
            if (box) {
                // Single effection animation
                [titleLabel setText:@"UIView block animation and Effection animation chian mix"];
                
                [box A_AnimationEffect:A_AnimationEffectType_zoomOut Duration:1.0 CompletionBlock:^{
                    [box setHidden:YES];
                }];
            }
            break;
        case 4:
            if (box) {
                // Sync effection animation combin
                [titleLabel setText:@"Sync effection animation combin"];
                
                [[[[box syncChainAnimation] addAnimateWithEffect:A_AnimationEffectType_squeeze type:A_AnimationType_easeInBack duration:1.0]
                  addAnimateWithEffect:A_AnimationEffectType_mirror_zoomOut type:A_AnimationType_easeInExpo duration:1.5] play];
            }
            break;
        case 5:
            if (box) {
                [titleLabel setText:@"CALayer animation"];
                
                [[[box syncChainAnimation] addAnimateSetPositionX:10 AnimtionType:A_AnimationType_spring Duraion:2.0] play];
                
//                [[[[box syncChainAnimation] addAnimateWithEffect:A_AnimationEffectType_squeeze type:A_AnimationType_easeInBack duration:1.0]
//                  addAnimateWithEffect:A_AnimationEffectType_mirror_zoomOut type:A_AnimationType_easeInExpo duration:1.5] play];
            }
            break;
        default:
            break;
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
