//
//  ViewController.m
//  YNRefresh
//
//  Created by 农盟 on 15/7/17.
//  Copyright (c) 2015年 农盟. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+CYNRefresh.h"


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    
    [self.tableView addHeaderRefreshWithActionHandler:^{

           
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           
                   [weakSelf.tableView.headerRefreshView successStopRefresh];
               });

    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *idenfy = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenfy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenfy];
    }
    cell.textLabel.text = @"rose";
    
    return cell;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = self.view.bounds;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
@end
