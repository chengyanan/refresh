//
//  YNCycleLayer.m
//  YNRefresh
//
//  Created by 农盟 on 15/7/20.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

#import "YNCycleLayer.h"


@implementation YNCycleLayer
- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.newAngle = -90 * M_PI / 180;
        self.startAngle = -90 * M_PI / 180;
        
        
    }
    return self;
}

- (void)setNewAngle:(CGFloat)newAngle {
    if (_newAngle != newAngle) {
        
        _newAngle = newAngle;
        
        [self setNeedsDisplay];
        
//        NSLog(@"newAngle - %f",newAngle);
        
    }
}


-(void)drawInContext:(CGContextRef)ctx {
    
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.5);
    //以15为半径围绕圆心画指定角度扇形
    CGContextMoveToPoint(ctx, CycleCenterX, CycleCenterY);
    
    CGContextAddArc(ctx, CycleCenterX, CycleCenterY, RadiusOfCycle,  self.startAngle, self.newAngle, 0);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFill); //绘制内容

}


@end
