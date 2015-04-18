//
//  ZWHomeViewController.m
//  Weibo
//
//  Created by qianfeng on 15/4/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZWHomeViewController.h"
#import "UIBarButton+MJ.h"
#import "ZWTitleButton.h"
#import "AFHTTPRequestOperationManager.h"
#import "ZWAccountTool.h"
#import "ZWAccount.h"
#import "ZWStatus.h"
#import "MJExtension.h"
#import "ZWUser.h"
#import "UIImageView+WebCache.h"
#import "ZWStatusCell.h"
#import "ZWStatusFrame.h"

@interface ZWHomeViewController ()
@property(nonatomic, strong) NSArray *statusFrames;

@end

@implementation ZWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置导航栏的内容
    [self setupNavBar];
    
    //2.加载微博数据
    [self setupStatusData];
}

- (void)setupStatusData {
    //1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [ZWAccountTool account].access_token;
    
    //3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //将字典数组转为模型数组(里面放的就是ZWStatus模型)
        NSArray *statusArray = [ZWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        //创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (ZWStatus *status in statusArray) {
            ZWStatusFrame *statusFrame = [[ZWStatusFrame alloc] init];
            //传递微博模型数据
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        //赋值
        self.statusFrames = statusFrameArray;
        
        //刷新表格
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
}

- (void)setupNavBar {
    //左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    
    //右边的按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    //中间的按钮
    ZWTitleButton *titleButton = [ZWTitleButton titleButton];
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setTitle:@"哈哈哈哈" forState:UIControlStateNormal];
    
    titleButton.frame = CGRectMake(0, 0, 100, 40);
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}

- (void)titleClick:(ZWTitleButton *)titleButton {
    static BOOL flag = true;
    if (flag) {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        flag = false;
    } else {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        flag = true;
    }
}

- (void)pop {
    NSLog(@"pop");
}

- (void)findFriend {
    MyLog(@"findFriend");
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1.创建cell
    ZWStatusCell *cell = [ZWStatusCell cellWithTableView:tableView];
    
    //2.传递frame模型
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
