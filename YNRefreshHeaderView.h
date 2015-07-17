//
//  YNRefreshHeaderView.h
//  YNRefresh
//
//  Created by 农盟 on 15/7/17.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    YNPullRefreshPulling = 0,
    YNPullRefreshNormal,
    YNPullRefreshLoading,
} YNPullRefreshState;

@interface YNRefreshHeaderView : UIView

@property (nonatomic, assign) YNPullRefreshState state;

- (void)ynRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
//- (void)ynRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
//- (void)ynRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end
