//
//  ZMHomeTabView.m
//  HaoHaoZhuApp
//
//  Created by Brances on 2018/9/25.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMHomeTabView.h"

@interface ZMHomeTabView()

@end

#define scrollViewContentOffset @"contentOffset"
@implementation ZMHomeTabView

#pragma mark - setter
- (void)setItems:(NSArray *)items selectedItemIndex:(NSInteger)selectedItemIndex{
    if (selectedItemIndex < 0) selectedItemIndex = 0;
    NSAssert(selectedItemIndex <= items.count-1, @"selectedItemIndex 大于了 %ld",items.count-1);
    _items = items.copy;
    _selectedItemIndex = selectedItemIndex;
    NSMutableArray *temp = [NSMutableArray new];
    //添加按钮
    for (int i = 0; i < items.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        NSString *text = [items safeObjectAtIndex:i];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [btn setTitleColor:self.unSelectedItemTitleColor forState:UIControlStateNormal];
        [btn setTitle:text forState:UIControlStateNormal];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(buttonInPageMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        btn.height = self.height;
        btn.top = 0;
        if (i == 0) {
            btn.left = self.width * 0.5 - btn.width - self.buttonMargin * 0.5;
        }else{
            btn.left = self.width * 0.5 + self.buttonMargin * 0.5;
        }
        [temp addObject:btn];
    }
    self.buttonArrray = temp;
    if (self.buttonArrray.count) {
        //默认选中
        UIButton *selectedButton = [self.buttonArrray safeObjectAtIndex:selectedItemIndex];
        [self buttonInPageMenuClicked:selectedButton];
        
        self.tracker = [UIView new];
        self.tracker.width = self.trackerWidth;
        self.tracker.height = self.trackerHeight;
        self.tracker.centerX = ((UIButton *)[self.buttonArrray safeObjectAtIndex:selectedItemIndex]).centerX;
        self.tracker.top = self.height - self.tracker.height;
        self.tracker.backgroundColor = [ZMColor blackColor];
        [self addSubview:self.tracker];
        
        [self resetSetupTrackerFrameWithSelectedButton:selectedButton];
    }
    
}

- (void)setBridgeScrollView:(UIScrollView *)bridgeScrollView {
    NSAssert(bridgeScrollView, @"bridgeScrollView不能为空");
    _bridgeScrollView = bridgeScrollView;
    if (bridgeScrollView) {
        [bridgeScrollView addObserver:self forKeyPath:scrollViewContentOffset options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)setSelectedItemIndex:(NSInteger)selectedItemIndex{
    _selectedItemIndex = selectedItemIndex;
    if (self.buttonArrray.count) {
        UIButton *btn = [self.buttonArrray safeObjectAtIndex:selectedItemIndex];
        [self buttonInPageMenuClicked:btn];
    }
}

- (void)setDelegate:(id<ZMHomeTabViewDelegate>)delegate{
    if (delegate == _delegate) return;
    _delegate = delegate;
    //如果设置代理数据源前面，则不需要下面代码
    if (self.buttonArrray.count) {
        UIButton *btn = [self.buttonArrray safeObjectAtIndex:_selectedItemIndex];
        if ([delegate respondsToSelector:@selector(itemSelectedFromIndex:toIndex:)]) {
            [delegate itemSelectedFromIndex:btn.tag toIndex:btn.tag];
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI{
    self.selectedItemTitleColor = [UIColor blackColor];
    self.unSelectedItemTitleColor = [ZMColor colorWithHexString:@"#B3B3B3"];
    
    self.trackerWidth = 30;
    self.trackerHeight = 3;
    self.buttonMargin = 20;
    
}

#pragma mark - 点击按钮item
- (void)buttonInPageMenuClicked:(UIButton *)sender {
    NSInteger fromIndex = self.selectedButton ? self.selectedButton.tag : sender.tag;
    NSInteger toIndex = sender.tag;
    // 更新下item对应的下标,必须在代理之前，否则外界在代理方法中拿到的不是最新的,必须用下划线，用self.会造成死循环
    _selectedItemIndex = toIndex;
    // 如果sender是新的选中的按钮，则上一次的按钮颜色为非选中颜色，当前选中的颜色为选中颜色
    if (self.selectedButton != sender) {
        [self.selectedButton setTitleColor:_unSelectedItemTitleColor forState:UIControlStateNormal];
        [sender setTitleColor:_selectedItemTitleColor forState:UIControlStateNormal];
        if (fromIndex != toIndex) { // 如果相等，说明是第1次进来或者2次点了同一个，此时不需要动画
            [self moveTrackerWithSelectedButton:sender];
        }
        self.selectedButton = sender;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemSelectedFromIndex:toIndex:)]) {
        [self.delegate itemSelectedFromIndex:fromIndex toIndex:toIndex];
    }
    
}

- (void)moveTrackerWithSelectedButton:(UIButton *)selectedButton{
    [UIView animateWithDuration:0.25 animations:^{
        [self resetSetupTrackerFrameWithSelectedButton:selectedButton];
    }];
}

- (void)resetSetupTrackerFrameWithSelectedButton:(UIButton *)selectedButton{
    CGFloat trackerX;
    CGFloat trackerY;
    CGFloat trackerW;
    CGFloat trackerH;
    CGFloat selectedButtonWidth = selectedButton.frame.size.width;
    
    trackerW = _trackerWidth ? _trackerWidth : (selectedButtonWidth ? selectedButton.titleLabel.font.pointSize : 0); // 没有自定义宽度就固定宽度为字体大小
    trackerH = _trackerHeight;
    trackerX = selectedButton.frame.origin.x;
    trackerY = self.height - trackerH;
    self.tracker.frame = CGRectMake(trackerX, trackerY, trackerW, trackerH);
    
    CGPoint trackerCenter = self.tracker.center;
    trackerCenter.x = selectedButton.center.x;
    self.tracker.center = trackerCenter;
    
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.bridgeScrollView) {
        if ([keyPath isEqualToString:scrollViewContentOffset]) {
            // 当scrolllView滚动时,让跟踪器跟随scrollView滑动
            [self prepareMoveTrackerFollowScrollView:self.bridgeScrollView];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)prepareMoveTrackerFollowScrollView:(UIScrollView *)scrollView {
    
    // 这个if条件的意思是scrollView的滑动不是由手指拖拽产生
    if (!scrollView.isDragging && !scrollView.isDecelerating) {return;}
    
    // 当滑到边界时，继续通过scrollView的bouces效果滑动时，直接return
    if (scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > scrollView.contentSize.width-scrollView.bounds.size.width) {
        return;
    }
    
    // 当前偏移量
    CGFloat currentOffSetX = scrollView.contentOffset.x;
    // 偏移进度
    CGFloat offsetProgress = currentOffSetX / scrollView.bounds.size.width;
    CGFloat progress = offsetProgress - floor(offsetProgress);
    
    NSInteger fromIndex = 0;
    NSInteger toIndex = 0;
    // 初始值不要等于scrollView.contentOffset.x,因为第一次进入此方法时，scrollView.contentOffset.x的值已经有一点点偏移了，不是很准确
    _beginOffsetX = scrollView.bounds.size.width * self.selectedItemIndex;
    
    // 以下注释的“拖拽”一词很准确，不可说成滑动，例如:当手指向右拖拽，还未拖到一半时就松开手，接下来scrollView则会往回滑动，这个往回，就是向左滑动，这也是_beginOffsetX不可时刻纪录的原因，如果时刻纪录，那么往回(向左)滑动时会被视为“向左拖拽”,然而，这个往回却是由“向右拖拽”而导致的
    if (currentOffSetX - _beginOffsetX > 0) { // 向左拖拽了
        // 求商,获取上一个item的下标
        fromIndex = currentOffSetX / scrollView.bounds.size.width;
        // 当前item的下标等于上一个item的下标加1
        toIndex = fromIndex + 1;
        if (toIndex >= self.buttonArrray.count) {
            toIndex = fromIndex;
        }
    } else if (currentOffSetX - _beginOffsetX < 0) {  // 向右拖拽了
        toIndex = currentOffSetX / scrollView.bounds.size.width;
        fromIndex = toIndex + 1;
        progress = 1.0 - progress;
        
    } else {
        progress = 1.0;
        fromIndex = self.selectedItemIndex;
        toIndex = fromIndex;
    }
    
    if (currentOffSetX == scrollView.bounds.size.width * fromIndex) {// 滚动停止了
        progress = 1.0;
        toIndex = fromIndex;
    }
    
    
    // 如果滚动停止，直接通过点击按钮选中toIndex对应的item
    if (currentOffSetX == scrollView.bounds.size.width*toIndex) { // 这里toIndex==fromIndex
        // 这一次赋值起到2个作用，一是点击toIndex对应的按钮，走一遍代理方法,二是弥补跟踪器的结束跟踪，因为本方法是在scrollViewDidScroll中调用，可能离滚动结束还有一丁点的距离，本方法就不调了,最终导致外界还要在scrollView滚动结束的方法里self.selectedItemIndex进行赋值,直接在这里赋值可以让外界不用做此操作
        if (_selectedItemIndex != toIndex) {
            self.selectedItemIndex = toIndex;
        }
        // 要return，点击了按钮，跟踪器自然会跟着被点击的按钮走
        return;
    }
    // 这个方法才开始移动跟踪器
    [self moveTrackerWithProgress:progress fromIndex:fromIndex toIndex:toIndex currentOffsetX:currentOffSetX beginOffsetX:_beginOffsetX];
    
}

// 这个方法才开始真正滑动跟踪器，上面都是做铺垫
- (void)moveTrackerWithProgress:(CGFloat)progress fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex currentOffsetX:(CGFloat)currentOffsetX beginOffsetX:(CGFloat)beginOffsetX {
    
    UIButton *fromButton = self.buttonArrray[fromIndex];
    UIButton *toButton = self.buttonArrray[toIndex];
    
    // 2个按钮之间的距离
    CGFloat xDistance = toButton.center.x - fromButton.center.x;
    // 2个按钮宽度的差值
//    CGFloat wDistance = toButton.frame.size.width - fromButton.frame.size.width;
    
    CGRect newFrame = self.tracker.frame;
//    CGPoint newCenter = self.tracker.center;
    
    // 这种样式的计算比较复杂,有个很关键的技巧，就是参考progress分别为0、0.5、1时的临界值
    // 原先的x值
    CGFloat originX = fromButton.frame.origin.x+(fromButton.frame.size.width-(_trackerWidth ? _trackerWidth : fromButton.titleLabel.font.pointSize))*0.5;
    // 原先的宽度
    CGFloat originW = _trackerWidth ? _trackerWidth : fromButton.titleLabel.font.pointSize;
    if (currentOffsetX - _beginOffsetX >= 0) { // 向左拖拽了
        if (progress < 0.5) {
            newFrame.origin.x = originX; // x值保持不变
            newFrame.size.width = originW + xDistance * progress * 2;
        } else {
            newFrame.origin.x = originX + xDistance * (progress-0.5) * 2;
            newFrame.size.width = originW + xDistance - xDistance * (progress-0.5) * 2;
        }
    } else { // 向右拖拽了
        // 此时xDistance为负
        if (progress < 0.5) {
            newFrame.origin.x = originX + xDistance * progress * 2;
            newFrame.size.width = originW - xDistance * progress * 2;
        } else {
            newFrame.origin.x = originX + xDistance;
            newFrame.size.width = originW - xDistance + xDistance * (progress-0.5) * 2;
        }
    }
    self.tracker.frame = newFrame;
//    [self colorGradientForTitleWithProgress:progress fromButton:fromButton toButton:toButton];
    [fromButton setTitleColor:[self interpolationColorFrom:_selectedItemTitleColor to:_unSelectedItemTitleColor percent:progress] forState:UIControlStateNormal];
    [toButton setTitleColor:[self interpolationColorFrom:_unSelectedItemTitleColor to:_selectedItemTitleColor percent:progress] forState:UIControlStateNormal];
}

- (CGFloat)interpolationFrom:(CGFloat)from to:(CGFloat)to percent:(CGFloat)percent{
    percent = MAX(0, MIN(1, percent));
    return from + (to - from)*percent;
}

- (UIColor *)interpolationColorFrom:(UIColor *)fromColor to:(UIColor *)toColor percent:(CGFloat)percent{
    //获取颜色的方法 UIColor + YYAdd
    CGFloat red = [self interpolationFrom:fromColor.red to:toColor.red percent:percent];
    CGFloat green = [self interpolationFrom:fromColor.green to:toColor.green percent:percent];
    CGFloat blue = [self interpolationFrom:fromColor.blue to:toColor.blue percent:percent];
    CGFloat alpha = [self interpolationFrom:fromColor.alpha to:toColor.alpha percent:percent];
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (void)dealloc{
        [self.bridgeScrollView removeObserver:self forKeyPath:@"contentOffset"];
}



@end
