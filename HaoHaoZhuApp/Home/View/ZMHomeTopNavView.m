//
//  ZMHomeTopNavView.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/23.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMHomeTopNavView.h"

@interface ZMHomeTopNavView()

@property (nonatomic, strong) UIView    *bottomLine;

@end

@implementation ZMHomeTopNavView
{
    CGFloat marginSpace;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI{

    marginSpace = 5;
    self.backgroundColor = [ZMColor whiteColor];
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.titleLabel.font = [ZMFont defaultAppFontWithSize:10];
    [self.leftBtn setTitleColor:[ZMColor blackColor] forState:UIControlStateNormal];
    [self.leftBtn setImage:[UIImage imageNamed:@"ich_top_JRTJ"] forState:UIControlStateNormal];
    [self addSubview:self.leftBtn];
    
    
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setImage:[UIImage imageNamed:@"ich_top_LD"] forState:UIControlStateNormal];
    [self addSubview:self.rightBtn];
    
    self.bottomLine = [UIView new];
    self.bottomLine.backgroundColor = [ZMColor appSeparatorLineColor];
    [self addSubview:self.bottomLine];
    
    self.leftBtn.width = 50;
    self.leftBtn.height = self.height - UIView.sc_statusBarHeight;
    self.leftBtn.left = 0 + marginSpace;
    self.leftBtn.top = UIView.sc_statusBarHeight;
    
    self.rightBtn.width = 50;
    self.rightBtn.height = self.height - UIView.sc_statusBarHeight;
    self.rightBtn.left = self.width - self.rightBtn.width - marginSpace;
    self.rightBtn.top = UIView.sc_statusBarHeight;
    
    self.bottomLine.width = kScreenWidth;
    self.bottomLine.height = 0.5;
    self.bottomLine.left = 0;
    self.bottomLine.top = self.height - self.bottomLine.height;
    
    //当前日期
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags fromDate:dt];
    // 获取各时间字段的数值
    NSLog(@"现在是%ld日" , comp.day);
    UILabel *currenDay = [UILabel new];
    currenDay.text = [NSString stringWithFormat:@"%ld",comp.day];
    currenDay.font = [ZMFont boldGothamWithSize:10];
    currenDay.textColor = [ZMColor blackColor];
    [currenDay sizeToFit];
    currenDay.left = (self.leftBtn.width - currenDay.width) * 0.5;
    currenDay.top = (self.leftBtn.height - currenDay.height) * 0.5 + 3;
    [self.leftBtn addSubview:currenDay];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)dealloc{
}

@end
