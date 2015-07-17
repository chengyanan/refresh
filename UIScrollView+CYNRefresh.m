//
//  UIScrollView+CYNRefresh.m
//  YNRefresh
//
//  Created by 农盟 on 15/7/17.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

#import "UIScrollView+CYNRefresh.h"
#import <objc/runtime.h>
#import "YNRefreshHeaderView.h"

static CGFloat const RefreshViewHeight = 60;
static char UIScrollViewPullToRefreshView;

@implementation UIScrollView (CYNRefresh)


- (void)addHeaderRefreshWithActionHandler:(void (^)(void))actionHandler {

    self.showRefresh = YES;
    
     CGFloat yOrigin = -RefreshViewHeight;
    YNRefreshHeaderView *headerRefreshView = [[YNRefreshHeaderView alloc] initWithFrame:CGRectMake(0, yOrigin, self.bounds.size.width, RefreshViewHeight)];
     [self addSubview:headerRefreshView];
    
    self.headerRefreshView = headerRefreshView;
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    [self.headerRefreshView ynRefreshScrollViewDidScroll:self];
    
}
#pragma mark - getters and setters
- (void)setHeaderRefreshView:(YNRefreshHeaderView *)headerRefreshView {
    
    [self willChangeValueForKey:@"YNRefreshHeaderView"];
    objc_setAssociatedObject(self, &UIScrollViewPullToRefreshView, headerRefreshView, OBJC_ASSOCIATION_ASSIGN);
     [self didChangeValueForKey:@"YNRefreshHeaderView"];
    
}
- (YNRefreshHeaderView *)headerRefreshView {
    
    return objc_getAssociatedObject(self, &UIScrollViewPullToRefreshView);
}
- (void)setShowRefresh:(BOOL)showRefresh {
    self.headerRefreshView.hidden = !showRefresh;
    
    if (!showRefresh) {
        //不显示
        
    } else {//显示
       
    
        
    }
}
- (BOOL)showRefresh {
    
    return !self.headerRefreshView.hidden;
}
@end
