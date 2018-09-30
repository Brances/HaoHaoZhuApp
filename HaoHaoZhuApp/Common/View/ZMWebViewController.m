//
//  ZMWebViewController.m

//
//  Created by Brances on 2018/6/13.
//  Copyright © 2018年 Brances. All rights reserved.
//

#import "ZMWebViewController.h"
#import <WebKit/WebKit.h>

@interface ZMWebViewController ()<UIWebViewDelegate,WKNavigationDelegate, WKUIDelegate>

@property(nonatomic, strong) WKWebView      *webView;
@property(nonatomic, strong)  UIImageView       *imageView;
@property(nonatomic, strong)  YYLabel           *imageViewTitleLabel;
@property (nonatomic, assign) BOOL                  loadSuccess;

@end

@implementation ZMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
    [self configureUI];
}

- (void)setupNavView{
    [super setupNavView];
    if (self.navTitle.length) {
        [self.navView.centerButton setTitle:self.navTitle forState:UIControlStateNormal];
    }
    self.navView.isHaveLine = YES;
}

- (void)configureUI{
    _webView =[[WKWebView alloc]initWithFrame:CGRectMake(0, self.navView.height, kScreenWidth, kScreenHeight - self.navView.height)];
    [_webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        //1）获取默认userAgent：
        NSString *oldUA = result;   //直接获取为nil
    }];
    [(UIScrollView *)[[_webView subviews] objectAtIndex:0] setBounces:YES];
    [self.view addSubview:_webView];
    
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]
                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                       timeoutInterval:10]];
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"person-load-faild"]];
    self.imageView.hidden = YES;
    self.imageView.frame = CGRectMake(0, self.navView.height, kScreenWidth, kScreenHeight - self.navView.height);
    [self.imageView sizeToFit];
    self.imageView.centerX = self.view.centerX;
    self.imageView.centerY = (kScreenHeight - self.navView.height)/2;
    [self.view addSubview:self.imageView];
    
    self.imageViewTitleLabel = [[YYLabel alloc] initWithFrame:CGRectMake(0, self.imageView.bottom +10, self.view.width, 20)];
    self.imageViewTitleLabel.hidden = YES;
    self.imageViewTitleLabel.text = @"加载失败，请重试";
    self.imageViewTitleLabel.textAlignment = NSTextAlignmentCenter;
//    self.imageViewTitleLabel.font = FONT(21.0);
//    self.imageViewTitleLabel.textColor = HexColor(0x585858, 1.0);
    [self.view addSubview:self.imageViewTitleLabel];
    //[MBProgressHUD showActivityMessageInView:KTipMessageError];
    
    @weakify(self);
    self.imageViewTitleLabel.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [weak_self reload];
    };
    
    
    
}

#pragma mark - 重新加载
- (void)reload{
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]
                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                       timeoutInterval:10]];
}

- (void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error{
    HBLog(@"加载失败");
    self.imageView.hidden = NO;
    self.imageViewTitleLabel.hidden = NO;
}

/// 是否允许加载网页 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    urlString = [urlString stringByRemovingPercentEncoding];
    HBLog(@"urlString=%@",urlString);
    // 用://截取字符串
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    if ([urlComps count]) {
        // 获取协议头
        NSString *protocolHead = [urlComps objectAtIndex:0];
        HBLog(@"protocolHead=%@",protocolHead);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

/// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    self.imageView.hidden = NO;
    self.imageViewTitleLabel.hidden = NO;
    [MBProgressHUD hideHUD];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
        [self.navView.centerButton setTitle:title forState:UIControlStateNormal];
    }];
    self.imageView.hidden = YES;
    self.imageViewTitleLabel.hidden = YES;
    self.loadSuccess = YES;
    [MBProgressHUD hideHUD];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    _webView = nil;
}

- (void)clickPopViewController{
    //判断是否能返回到H5上级页面
    if (self.webView.canGoBack == YES) {
        //返回上级页面
        [self.webView goBack];
    }else{
        //退出控制器
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
