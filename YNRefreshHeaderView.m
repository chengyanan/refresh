//
//  YNRefreshHeaderView.m
//  YNRefresh
//
//  Created by 农盟 on 15/7/17.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

#import "YNRefreshHeaderView.h"

#define OffsetHeight 30

#define RadiusOfCycle 15

#define CycleCenterX [UIApplication sharedApplication].keyWindow.frame.size.width /2.0
#define CycleCenterY (60 - RadiusOfCycle)

@interface YNRefreshHeaderView()

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, assign) CGFloat currentY;

@property (nonatomic, assign) CGFloat newAngle;

@end


@implementation YNRefreshHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.activityView];
        
        self.backgroundColor = [UIColor redColor];
        
    }
    return self;
}


#pragma mark - custom motheds
- (void)ynRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y < -CycleCenterY) {
        //开始画圆
        
         self.newAngle = ((scrollView.contentOffset.y + CycleCenterY)/(RadiusOfCycle * 2) * M_PI)/(180);
        
        [self setNeedsDisplay];
        
    }
}

-(void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //        CGContextSetRGBFillColor (context,  1, 0, 0, 1.0);//设置填充颜色
    //
    //        //填充圆，无边框
    //        CGContextAddArc(context, CycleCenterX, CycleCenterY, RadiusOfCycle, 0, M_2_PI, 0); //添加一个圆
    //        CGContextDrawPath(context, kCGPathFill);//绘制填充
    
    UIColor *aColor = [UIColor colorWithRed:1 green:0.0 blue:0 alpha:1];
    aColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1];
    
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    //以10为半径围绕圆心画指定角度扇形
    CGContextMoveToPoint(context, CycleCenterX, CycleCenterY);

    CGContextAddArc(context, CycleCenterX, CycleCenterY, RadiusOfCycle,  -90 * M_PI / 180, self.newAngle, 0);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
        
 }

#pragma mark - getters and setters
- (UIActivityIndicatorView *)activityView {
    if (_activityView == nil) {
        _activityView = [[UIActivityIndicatorView alloc] init];
    }
    return _activityView;
}

- (void)setState:(YNPullRefreshState)state {
    switch (state) {
        case YNPullRefreshPulling:
            
            break;
        case YNPullRefreshLoading:
            
            break;
        case YNPullRefreshNormal:
            
            break;
        default:
            break;
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
@end
