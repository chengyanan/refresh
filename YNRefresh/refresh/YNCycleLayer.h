//
//  YNCycleLayer.h
//  YNRefresh
//
//  Created by 农盟 on 15/7/20.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

//#define SelfHeight 64//高度
//
//#define OffsetHeight 30 //整个view还没出来的高度
//
//#define RadiusOfCycle 15//半径
//
//#define CycleCenterX self.bounds.size.width/2//圆形X
//
//#define CycleCenterY  OffsetHeight+RadiusOfCycle//圆形Y

#define SelfHeight 44//高度

#define OffsetHeight 22 //整个view还没出来的高度

#define RadiusOfCycle OffsetHeight*0.5//半径

#define CycleCenterX self.bounds.size.width/2//圆形X

#define CycleCenterY  OffsetHeight+RadiusOfCycle//圆形Y



@interface YNCycleLayer : CALayer

@property (nonatomic, assign) CGFloat newAngle ;
@property (nonatomic, assign) CGFloat startAngle ;

@end
