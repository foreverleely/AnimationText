//
//  RightViewController.m
//  AnimationText
//
//  Created by 李阳 on 16/4/19.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "RightViewController.h"

#import "AnimationTextAPI.h"
#import "LeftTableView.h"
#import "HomePageViewController.h"
#import "BaseCenterViewController.h"

#import "UIColor+Util.h"

#import "Masonry.h"
#import "SWRevealViewController.h"

@implementation RightViewController {
    NSMutableArray *dataArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"右";
    self.view.backgroundColor = [UIColor cyanColor];
    
    NSArray *datasArray = @[@{@"title":@"基础动画",@"imgname":@"chooser-moment-icon-music"},
                           @{@"title":@"关键帧动画",@"imgname":@"chooser-moment-icon-place"},
                           @{@"title":@"组动画",@"imgname":@"chooser-moment-icon-camera"},
                           @{@"title":@"过渡动画",@"imgname":@"chooser-moment-icon-thought"},
                           @{@"title":@"综合动画",@"imgname":@"chooser-moment-icon-sleep"}];
    dataArray = [[NSMutableArray alloc] initWithArray:datasArray];
    [self initSubView];
}

- (void)initSubView {
    
    LeftTableView *leftTableView = [[LeftTableView alloc] init];
    leftTableView.dataArr = dataArray;
    [self.view addSubview:leftTableView];
    [leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(ScreenSize.width);
        make.height.mas_equalTo(50 * dataArray.count);
    }];
    __weak typeof(self) weakself = self;
    leftTableView.leftRowSelect = ^(NSIndexPath *indexpath) {
        [weakself funcCenterItem:indexpath];
    };
}

- (void)funcCenterItem:(NSIndexPath *)indexpath {
    
    SWRevealViewController *revealVC = self.revealViewController;
    BaseCenterViewController *baseVC =  [[BaseCenterViewController alloc] init];
    baseVC.itemindex = indexpath.row;
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:baseVC];
    [revealVC pushFrontViewController:navVC animated:YES];
}

@end
