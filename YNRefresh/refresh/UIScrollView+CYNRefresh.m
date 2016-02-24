//
//  UIScrollView+CYNRefresh.m
//  YNRefresh
//
//  Created by 农盟 on 15/7/17.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

#import "UIScrollView+CYNRefresh.h"
#import <objc/runtime.h>


static CGFloat const RefreshViewHeight = 44;
static char UIScrollViewPullToRefreshView;

@implementation UIScrollView (CYNRefresh)


- (void)addHeaderRefreshWithActionHandler:(void (^)(void))actionHandler {
    
     CGFloat yOrigin = -RefreshViewHeight;
    YNRefreshHeaderView *headerRefreshView = [[YNRefreshHeaderView alloc] initWithFrame:CGRectMake(0, yOrigin, self.bounds.size.width, RefreshViewHeight)];
    headerRefreshView.delegate = self;
     [self addSubview:headerRefreshView];
    headerRefreshView.refreshActionHandler = actionHandler;
    
    self.headerRefreshView = headerRefreshView;
    
    self.delegate = self.headerRefreshView;
    
    self.showRefresh = YES;
}

#pragma mark - YNRefreshHeaderViewDelegate
- (void)refreshHeaderView:(YNRefreshHeaderView *)headerView removerMyObserve:(BOOL)remove {
    self.showRefresh = !remove;
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [self.headerRefreshView successStopRefresh];
//    });
    
}


- (void)resetScrollViewContentInset {
    
    UIEdgeInsets currentInsets = self.contentInset;
    
    currentInsets.top = 0;
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.contentInset = currentInsets;
                     }
                     completion:NULL];

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
    
    if (!showRefresh) {
        //不显示
        
        [self removeObserver:self.headerRefreshView forKeyPath:@"contentOffset"];
        
    } else {//显示
       
         [self addObserver:self.headerRefreshView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    
}

//- (BOOL)showRefresh {
//    
//    return !self.headerRefreshView.hidden;
//}
@end
