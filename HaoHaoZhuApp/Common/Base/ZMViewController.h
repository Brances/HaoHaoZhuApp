//
//  ZMViewController.h
//
//
//  Created by Brances on 2018/3/23.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMNavView.h"

@interface ZMViewController : UIViewController

/** 自定义导航 */
@property (nonatomic, strong) ZMNavView     *navView;

- (void)setupNavView;

- (void)clickPopViewController;

@end
