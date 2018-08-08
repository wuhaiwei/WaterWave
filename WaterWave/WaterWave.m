//
//  WaterWave.m
//  WaterWave
//
//  Created by wu on 2018/8/7.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "WaterWave.h"

@interface WaterWave ()

@property (nonatomic, strong) CADisplayLink *waveDisplayLink;
@property (nonatomic, strong) CAShapeLayer *waveLayer;
@property (nonatomic, assign) CGFloat waveAmplitude;           // 波纹振幅
@property (nonatomic, assign) CGFloat waveCycle;               // 波纹周期
@property (nonatomic, assign) CGFloat waveSpeed;               // 波纹速度
@property (nonatomic, assign) CGFloat waveWidth;               // 波纹宽度
@property (nonatomic, assign) CGFloat xOffset;                 // 正弦曲线的初相，反映出在x轴上的移动，
@property (nonatomic, assign) CGFloat originWavePointY;

@end

@implementation WaterWave
#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self startWave];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
        [self startWave];
    }
    return self;
}

- (void)setup
{
    self.waveColor         = [UIColor cyanColor];
    self.percent           = 0.7;
    
    self.waveSpeed         = 0.1/M_PI;
    self.waveWidth         = CGRectGetWidth(self.frame);
    self.xOffset           = 0;
    self.waveAmplitude     = 15;
    self.originWavePointY  = CGRectGetHeight(self.frame) * (1-_percent);
    self.waveCycle         =  1.29 * M_PI / self.waveWidth;
}

#pragma mark - public
- (void)startWave
{
    if (!_waveLayer) {
        [self.layer addSublayer:self.waveLayer];
    }
    [self.waveDisplayLink setPaused:NO];
}

- (void)pauseWave
{
    [self.waveDisplayLink setPaused:YES];
}

- (void)removeWave
{
    [self.waveDisplayLink invalidate];
    [self.waveLayer removeFromSuperlayer];

    self.waveDisplayLink = nil;
    self.waveLayer       = nil;
}

- (void)setPercent:(CGFloat)percent
{
    _percent = (percent >0 && percent <= 1) ? percent : _percent;
}


#pragma mark - event
- (void)changeWave:(CADisplayLink *)displayLink
{
    self.xOffset -= self.waveSpeed;
    
    UIBezierPath *sinPath = [UIBezierPath bezierPath];
    CGFloat sinY = self.originWavePointY;
    [sinPath moveToPoint:CGPointMake(0, sinY)];
    
    for (float x = 0.0f; x <= self.waveWidth; x++) {
        // 正弦波浪
        sinY = self.waveAmplitude * sin(self.waveCycle * x + self.xOffset) + self.originWavePointY;
        [sinPath addLineToPoint:CGPointMake(x, sinY)];
    }
    [sinPath addLineToPoint:CGPointMake(self.waveWidth, CGRectGetHeight(self.frame))];
    
    [sinPath addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [sinPath closePath];
    
    self.waveLayer.path = sinPath.CGPath;
}

#pragma mark - getter
- (CAShapeLayer *)waveLayer
{
    if (!_waveLayer) {
        _waveLayer           = [CAShapeLayer layer];
        _waveLayer.fillColor = _waveColor.CGColor;
    }
    return _waveLayer;
}

- (CADisplayLink *)waveDisplayLink
{
    if (!_waveDisplayLink) {
        _waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeWave:)];
        [_waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _waveDisplayLink;
}
@end
