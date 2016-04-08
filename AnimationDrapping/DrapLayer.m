//
//  DrapLayer.m
//  AnimationDrapping
//
//  Created by PC-LiuChunhui on 16/4/8.
//  Copyright © 2016年 Mr.Wendao. All rights reserved.
//

#import "DrapLayer.h"
@interface DrapLayer()
@property (nonatomic) CGRect currentRect;
@property (nonatomic) CGFloat factor;
@end
@implementation DrapLayer

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}
- (void)setProgress:(CGFloat)progress {
    _factor = fabs(0.5 - progress);
    _progress = progress;
    [self setNeedsDisplay];
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _currentRect = self.bounds;
    _progress = 0.5f;
    [self setNeedsDisplay];
}
- (void)drawInContext:(CGContextRef)ctx {
    BOOL onStation = (_progress - 0.5) > 0;
    CGFloat offset1 = 0.5 * CGRectGetWidth(_currentRect) * 0.552 * (1 + 1.6 * fabs(_progress - 0.5));
    CGFloat offset2 = 0.5 * CGRectGetWidth(_currentRect) * 0.552 * (1 - 1 * fabs(_progress - 0.5));
    CGFloat offset3 = CGRectGetWidth(_currentRect) / 3.6 * (1 - 1.0 * fabs(_progress - 0.5));
    CGFloat offset4 = CGRectGetWidth(_currentRect) / 3.6 * (1 - 1.2 * fabs(_progress - 0.5));
    CGFloat temp;
    if (!onStation) {
        temp = offset1;
        offset1 = offset4;
        offset4 = temp;
        
        temp = offset2;
        offset2 = offset3;
        offset3 = offset2;
    }
    
    
    //设置3.6 出来的弧度最像圆形
    CGPoint rectCenter = CGPointMake(CGRectGetMidX(_currentRect) , CGRectGetMidY(_currentRect));
    
    //8个控制点实际的偏移距离。 The real distance of 8 control points
    CGFloat extra = (CGRectGetWidth(_currentRect) * 2 / 5) * _factor;
    CGPoint pointA = CGPointMake(rectCenter.x ,CGRectGetMinY(_currentRect) + extra);
    CGPoint pointB = CGPointMake(onStation ? rectCenter.x + CGRectGetWidth(_currentRect) / 2 : rectCenter.x + CGRectGetWidth(_currentRect)/2 ,rectCenter.y);
    CGPoint pointC = CGPointMake(rectCenter.x ,rectCenter.y + CGRectGetHeight(_currentRect)/2 - extra);
    CGPoint pointD = CGPointMake(onStation ? CGRectGetMinX(_currentRect) : CGRectGetMinX(_currentRect), rectCenter.y);
    
    
    CGPoint c1 = CGPointMake(pointA.x + offset1, pointA.y);
    CGPoint c2 = CGPointMake(pointB.x, pointB.y - offset2);
    
    CGPoint c3 = CGPointMake(pointB.x, pointB.y + offset2);
    CGPoint c4 = CGPointMake(pointC.x + offset1, pointC.y);
    
    CGPoint c5 = CGPointMake(pointC.x - offset3, pointC.y);
    CGPoint c6 = CGPointMake(pointD.x, pointD.y + offset4);
    
    CGPoint c7 = CGPointMake(pointD.x, pointD.y - offset4);
    CGPoint c8 = CGPointMake(pointA.x - offset3, pointA.y);
    
    // 更新界面
    UIBezierPath *ovalPath = [UIBezierPath bezierPath];
    [ovalPath moveToPoint: pointA];
    [ovalPath addCurveToPoint:pointB controlPoint1:c1 controlPoint2:c2];
    [ovalPath addCurveToPoint:pointC controlPoint1:c3 controlPoint2:c4];
    [ovalPath addCurveToPoint:pointD controlPoint1:c5 controlPoint2:c6];
    [ovalPath addCurveToPoint:pointA controlPoint1:c7 controlPoint2:c8];
    [ovalPath closePath];
    
    CGContextAddPath(ctx, ovalPath.CGPath);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextFillPath(ctx);
}

@end
