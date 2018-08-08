//
//  ViewController.m
//  WaterWave
//
//  Created by wu on 2018/8/7.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "ViewController.h"
#import "WaterWave.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet WaterWave *waveView;

@end

@implementation ViewController
#pragma mark - event
- (IBAction)startWave:(id)sender {
    [self. waveView startWave];
}

- (IBAction)pauseWave:(id)sender {
    [self.waveView pauseWave];
}


@end
