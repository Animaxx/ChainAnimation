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
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    __weak UIView *box = [cell viewWithTag:1];
    __weak UILabel *titleLabel = (UILabel *)[cell viewWithTag:10];
    
    [[box layer] setTransform:CATransform3DIdentity];
    [[box layer] setBackgroundColor:[UIColor blackColor].CGColor];
    
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
                [titleLabel setText:@"Sync effection animation chain combin example"];
                
                [[[[box syncAnimate] addAnimateWithEffect:A_AnimationEffectType_wobble type:A_AnimationType_easeInBack duration:1.0]
                  addAnimateWithEffect:A_AnimationEffectType_mirror_zoomOut type:A_AnimationType_easeInExpo duration:1.5] play];
            }
            break;
        case 4:
            if (box) {
                [titleLabel setText:@"CALayer animation chain example"];
                
                [[[[[box syncAnimate]
                   setPositionX:20 AnimtionType:A_AnimationType_spring Duraion:2.0]
                  setSize:CGSizeMake(5, 5) AnimtionType:A_AnimationType_bigLongSpring Duraion:3.0].then
                 setCornerRadius:10 AnimtionType:A_AnimationType_noEffect]
                 play];
            }
            break;
        case 5:
            if (box) {
                [titleLabel setText:@"Custom oblique animation chain example"];

                [[[[[[[box animateWait:0.5] setLeftOblique:1.0 AnimtionType:A_AnimationType_easeInBack Duraion:1.0]
                     setTopOblique:1.0 AnimtionType:A_AnimationType_easeInQuad Duraion:1.0]
                    setRightOblique:1.0 AnimtionType:A_AnimationType_easeInCirc Duraion:1.0]
                   setBottomOblique:1.0 AnimtionType:A_AnimationType_easeInOutSine Duraion:1.0]
                  setRecoverOblique:A_AnimationType_easeInOutBounce Duraion:1.0]
                 play];

            }
            break;
        case 6:
            if (box) {
                [titleLabel setText:@"Wait, block, and animation chain example"];
                
                [[[[[[[box animateWait:2.0] setScale:1.5 AnimtionType:A_AnimationType_bigSpring Duraion:1.0] wait:1.0] block:^{
                    box.backgroundColor = [UIColor blueColor];
                }] wait:3.0]
                  setBackgroundColor:[UIColor redColor] AnimtionType:A_AnimationType_bigLongSpring Duraion:2.0] play];
            }
            break;
        case 7:
            if (box) {
                [titleLabel setText:@"One-time Effection Animation"];
                
                [box A_AnimationEffect:A_AnimationEffectType_press Repeat:2.5 Duration:1.0];
            }
            break;
        case 8:
            if (box) {
                [titleLabel setText:@"One-time CGLayer Animation"];
                [box.layer A_AnimationSetScaleX:1.5 AnimtionType:A_AnimationType_easeInOutBounce Duraion:1.0];
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
