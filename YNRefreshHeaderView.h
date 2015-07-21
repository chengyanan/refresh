//
//  YNRefreshHeaderView.h
//  YNRefresh
//
//  Created by 农盟 on 15/7/17.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YNRefreshHeaderView;
@protocol YNRefreshHeaderViewDelegate <NSObject>

@optional
- (void)refreshHeaderView:(YNRefreshHeaderView *)headerView removerMyObserve:(BOOL)remove;
- (void)resetScrollViewContentInset;
@end

typedef enum{
    YNPullRefreshPulling = 0,
    YNPullRefreshNormal,
    YNPullRefreshLoading,
} YNPullRefreshState;

@interface YNRefreshHeaderView : UIView<UIScrollViewDelegate>

@property (nonatomic, copy) void (^refreshActionHandler)(void);

@property (nonatomic, assign) YNPullRefreshState state;

@property (nonatomic, assign) id<YNRefreshHeaderViewDelegate> delegate;



- (void)successStopRefresh;

- (void)failureStopRefresh;
@end
