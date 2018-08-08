//
//  WaterWave.h
//  WaterWave
//
//  Created by wu on 2018/8/7.
//  Copyright © 2018年 wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterWave : UIView

@property (nonatomic, strong, nullable)UIColor *waveColor;   // 波浪颜色

/**
 default is 0.7   [0,1]
 */
@property (nonatomic, assign)CGFloat percent;      // 波浪百分比

- (void)startWave;

- (void)pauseWave;

- (void)removeWave;

@end
