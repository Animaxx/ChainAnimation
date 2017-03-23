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
                [titleLabel setText:@"UIView block animation chain example"];
                
                [[[box addAnimateWithDuration:1.0 aniamtion:^{
                    [box setAlpha:0.0];
                }] addAnimateWithDuration:1.0 aniamtion:^{
                    [box setAlpha:1.0];
                }] play];
            }
            break;
        case 1:
            if (box) {
                [titleLabel setText:@"Effection animation chain example"];
                
                [[[box addAnimateWithEffect:A_AnimationEffectType_pulse type:A_AnimationType_easeInBack duration:1.0]
                  addAnimateWithEffect:A_AnimationEffectType_squeeze type:A_AnimationType_bigSpring duration:1.0]
                 play];
            }
            break;
        case 2:
            if (box) {
                [titleLabel setText:@"UIView block animation and Effection animation chain mix example"];
                
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
                [titleLabel setText:@"UIView block animation and Effection animation chain mix example"];
                
                [box A_AnimationEffect:A_AnimationEffectType_zoomOut Duration:1.0 CompletionBlock:^{
                    [box setHidden:YES];
                }];
            }
            break;
        case 4:
            if (box) {
                [titleLabel setText:@"Sync effection animation chain combin example"];
                
                [[[[box syncAnimate] addAnimateWithEffect:A_AnimationEffectType_squeeze type:A_AnimationType_easeInBack duration:1.0]
                  addAnimateWithEffect:A_AnimationEffectType_mirror_zoomOut type:A_AnimationType_easeInExpo duration:1.5] play];
            }
            break;
        case 5:
            if (box) {
                [titleLabel setText:@"CALayer animation chain example"];
                
                [[[[[box syncAnimate]
                   addAnimateSetPositionX:20 AnimtionType:A_AnimationType_spring Duraion:2.0]
                  addAnimateSetSize:CGSizeMake(5, 5) AnimtionType:A_AnimationType_bigLongSpring Duraion:3.0].then
                 addAnimateSetCornerRadius:10 AnimtionType:A_AnimationType_noEffect]
                 play];
            }
            break;
        case 6:
            if (box) {
                [titleLabel setText:@"Custom oblique animation chain example"];
                
                
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    
                    [[[box animate] addAnimateCustomLeftOblique:1.0 AnimtionType:A_AnimationType_easeInBack Duraion:1.0] play];

//                    [[[[box animate] addAnimateCustomLeftOblique:1.0 AnimtionType:A_AnimationType_easeInBack Duraion:1.0]
//                         addAnimateCustomTopOblique:1.0 AnimtionType:A_AnimationType_easeInQuad Duraion:1.0]
//                     play];
                    
//                    [[[[[[[box animate] addAnimateCustomLeftOblique:1.0 AnimtionType:A_AnimationType_easeInBack Duraion:1.0]
//                    addAnimateCustomTopOblique:1.0 AnimtionType:A_AnimationType_easeInQuad Duraion:1.0]
//                    addAnimateCustomRightOblique:1.0 AnimtionType:A_AnimationType_easeInCirc Duraion:1.0]
//                    addAnimateCustomBottomOblique:1.0 AnimtionType:A_AnimationType_easeInOutSine Duraion:1.0]
//                      addAnimateCustomRecoverOblique:A_AnimationType_easeInOutBounce Duraion:1.0]
//                     play];
                });
                
//                [box.layer A_AnimationCustomLeftOblique:1.0 AnimtionType:A_AnimationType_easeInBack];
                

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
