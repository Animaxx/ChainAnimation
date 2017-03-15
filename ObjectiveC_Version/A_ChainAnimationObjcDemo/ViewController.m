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
    if (box) {
        [[[UIView addAnimationWithDuration:1.0 aniamtion:^{
            [box setAlpha:0.0];
        }] addAnimationWithDuration:1.0 aniamtion:^{
            [box setAlpha:1.0];
        }] run];
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
