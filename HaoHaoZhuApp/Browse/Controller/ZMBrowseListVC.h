//
//  ZMBrowseListVC.h
//  HaoHaoZhuApp
//
//  Created by ABC on 2018/12/21.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMViewController.h"

@interface ZMBrowseListVC : ZMViewController

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger            selectedIndex;
@property (nonatomic, assign) NSInteger            page;
@property (nonatomic, copy) void(^updateBlock)(NSInteger page);

@end
