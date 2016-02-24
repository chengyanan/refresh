//
//  YNRefreshHeaderView.m
//  YNRefresh
//
//  Created by 农盟 on 15/7/17.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

#import "YNRefreshHeaderView.h"
#import "YNCycleLayer.h"

@interface YNRefreshHeaderView()

@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) YNCycleLayer *cycleLayer;

@property (nonatomic, assign) CGFloat currentY ;

@property (nonatomic, assign) CGFloat newAngle ;
@property (nonatomic, assign) CGFloat startAngle ;


@end


@implementation YNRefreshHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.activityView];
        [self.activityView startAnimating] ;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self.layer addSublayer:self.cycleLayer];
    
    }
    return self;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if ([self.delegate respondsToSelector:@selector(refreshHeaderView:removerMyObserve:)]) {
        [self.delegate refreshHeaderView:self removerMyObserve:NO];
    }
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    if (self.state == YNPullRefreshLoading) {
        
        
        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
        
        UIEdgeInsets currentInsets = scrollView.contentInset;
        
        currentInsets.top = MIN(offset, SelfHeight);
        
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             scrollView.contentInset = currentInsets;
                         }
                         completion:NULL];
    }
    
    
}

#pragma mark - observing
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentOffset"])
        [self scrollViewDidScrolla:[[change valueForKey:NSKeyValueChangeNewKey] CGPointValue]];
}

#pragma mark - custom motheds
- (void)scrollViewDidScrolla:(CGPoint)contentOffset {
    
//    NSLog(@"contentOffset - %@", NSStringFromCGPoint(contentOffset));
      CGFloat top = SelfHeight - OffsetHeight;
  
    if (contentOffset.y >-SelfHeight-4) {
        
        if (contentOffset.y >= -top) {
            self.cycleLayer.hidden = YES;
            self.activityView.hidden = YES;
        }
    
        if (contentOffset.y < -top && contentOffset.y >= -SelfHeight) {
            //开始画圆
            
             self.state = YNPullRefreshPulling;
            
            self.currentY = -contentOffset.y;
            
            CGFloat x = (-contentOffset.y - top) * 2 * M_PI;
            CGFloat y = (RadiusOfCycle * 2);
            
            float angle = x / y - M_PI_2;
            
            self.newAngle = angle;
            
        }
        
    } else {
        self.state = YNPullRefreshLoading;
    }
    
}

- (void)successStopRefresh {
    
    self.state = YNPullRefreshNormal;
    
    [self.activityView  stopAnimating];
    
}

- (void)failureStopRefresh {
    
    //以后也可以加提示
    
    self.state = YNPullRefreshNormal;
    
    [self.activityView  stopAnimating];
}

#pragma mark - getters and setters

- (void)setNewAngle:(CGFloat)newAngle {
    if (_newAngle != newAngle) {
        
        _newAngle = newAngle;
        
        self.cycleLayer.newAngle = newAngle;
        
    }
    
}

- (UIActivityIndicatorView *)activityView {
    if (_activityView == nil) {
        _activityView = [[UIActivityIndicatorView alloc] init];
        _activityView.center = CGPointMake(CycleCenterX, CycleCenterY);
        _activityView.color = [UIColor blackColor];
        _activityView.hidesWhenStopped = YES;
        _activityView.hidden = YES;
    }
    return _activityView;
}

- (void)setState:(YNPullRefreshState)state {
    
    _state = state;
    
    switch (state) {
        case YNPullRefreshPulling:
            
            self.cycleLayer.hidden = NO;
            
            self.activityView.hidden = YES;
            
            break;
        case YNPullRefreshLoading:
            
            self.cycleLayer.hidden = YES;
            self.activityView.hidden = NO;
            [self.activityView startAnimating];
            
            self.refreshActionHandler();
            
            if ([self.delegate respondsToSelector:@selector(refreshHeaderView:removerMyObserve:)]) {
                [self.delegate refreshHeaderView:self removerMyObserve:YES];
            }
            
            break;
        case YNPullRefreshNormal:
            
            if ([self.delegate respondsToSelector:@selector(resetScrollViewContentInset)]) {
                
                [self.delegate resetScrollViewContentInset];
            }
            
            break;
        default:
            break;
    }
}

- (YNCycleLayer *)cycleLayer {
    if (_cycleLayer == nil) {
        _cycleLayer = [[YNCycleLayer alloc] init];
        
        _cycleLayer.frame = self.bounds;
    }
    return _cycleLayer;
}

@end
