//
//  UIScrollView+CYNRefresh.h
//  YNRefresh
//
//  Created by 农盟 on 15/7/17.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YNRefreshHeaderView;
@interface UIScrollView (CYNRefresh)

- (void)addHeaderRefreshWithActionHandler:(void (^)(void))actionHandler;


@property (nonatomic, strong, readonly) YNRefreshHeaderView *headerRefreshView;
@property (nonatomic, assign) BOOL showRefresh;

@end
