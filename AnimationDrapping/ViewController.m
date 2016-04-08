//
//  ViewController.m
//  AnimationDrapping
//
//  Created by PC-LiuChunhui on 16/4/7.
//  Copyright © 2016年 Mr.Wendao. All rights reserved.
//

#import "ViewController.h"
#import "DrapLayer.h"
@interface ViewController ()
@property (nonatomic, strong) DrapLayer *drap;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _drap = [DrapLayer layer];
    _drap.frame = CGRectMake(10, 50, 200, 200);
    _drap.backgroundColor = [UIColor grayColor].CGColor;
    [self.view.layer addSublayer:_drap];
    
    
}


- (IBAction)progressChanged:(UISlider *)sender {
    NSLog(@"%f", sender.value);
    _drap.progress = sender.value;
}

@end
