//
//  ZWOAuthViewController.m
//  Weibo
//
//  Created by qianfeng on 15/4/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZWOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "ZWAccount.h"
#import "ZWAccountTool.h"
#import "ZWWeiboTool.h"

#define APPKEY @"484545400"
#define APPSECRET @"0a66a2c63f54361d15615c9618ed7ef8"
#define REDIRECT_URI @"https://api.weibo.com/oauth2/default.html"

@interface ZWOAuthViewController () <UIWebViewDelegate>

@end

@implementation ZWOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.添加webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    
    //2.加载授权页面(新浪提供的登录页面)
    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", APPKEY, REDIRECT_URI];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark - webView代理方法
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showMessage:@"哥正在帮你加载中。。。"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideHUD];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *urlStr = request.URL.absoluteString;
    
    NSRange range = [urlStr rangeOfString:@"code="];
    
    if (range.length) {
        int loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        
        //发送POST请求给新浪，通过code换取一个accessToken
        [self accessTokenWithCode:code];
    }
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code {
    //创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = APPKEY;
    params[@"client_secret"] = APPSECRET;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = REDIRECT_URI;
    
    //发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //先将字典转为模型
        
        ZWAccount *account = [ZWAccount accountWithDict:responseObject];
        
        //存储模型数据
        [ZWAccountTool saveAccount:account];

        //选择去 新特性/首页
        [ZWWeiboTool chooseRootController];
        
        [MBProgressHUD hideHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
