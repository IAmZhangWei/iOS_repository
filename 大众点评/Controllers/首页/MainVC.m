//
//  MainVC.m
//  大众点评
//
//  Created by qianfeng on 3/29/15.
//  Copyright (c) 2015 张维. All rights reserved.
//


#import "MainVC.h"
#import "ZKButton.h"

#import "DPAPI.h"

@interface MainVC () <UITableViewDelegate, UITableViewDataSource, DPRequestDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIPageControl *pageControll;

@end

@implementation MainVC

@synthesize scrollView = _scrollView;
@synthesize pageControll = _pageControll;

- (void)dealloc
{
    self.scrollView = nil;
    self.pageControll = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    [self setTableView];
    
    //测试请求数据
    //    [self testRequestData];
}

/*
 category=美食&city=上海&latitude=31.18268013000488&longitude=121.42769622802734&sort=1&limit=20&offset_type=1&out_offset_type=1&platform=2
 */
- (void)testRequestData {
    NSMutableDictionary *dic = (NSMutableDictionary *)@{@"city": @"上海", @"category":@"美食", @"latitude":@31.18268013000488, @"longitude":@121.42769622802734, @"sort":@1, @"limit":@20, @"offset_type":@1, @"out_offset_type":@1, @"platform":@2};
    
    [[DPAPI alloc] requestWithURL:@"v1/business/find_businesses" params:dic delegate:self];
}

#pragma mark - DPRequestDelegate
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError:%@", error);
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result {
    NSDictionary *dic = (NSDictionary *)result;
    NSLog(@"%@", dic[@"businesses"]);
}




#pragma mark --设置tableView
- (void)setTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setTableHeaderView:[self tableHeaderView]];
}

//自定义整个表的头部
- (UIView *)tableHeaderView {
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 180)] autorelease];
    
    //设置scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:view.frame];
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(view.frame)* 5, 180);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(view.frame), 0);
    [self setButton];
    [view addSubview:self.scrollView];
    
    //设置pageControl
    _pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(_scrollView.frame) - 20, self.view.frame.size.width - 50, 20)];
    self.pageControll.currentPageIndicatorTintColor = [UIColor orangeColor];
    self.pageControll.numberOfPages = 3;
    self.pageControll.pageIndicatorTintColor = [UIColor lightGrayColor];
    [view addSubview:self.pageControll];
    
    return view;
}

#pragma mark --添加tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident] autorelease];
    }
    return cell;
}

#pragma mark --添加scrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //要判断一下 scrollView 是不是 tableView
    if ([scrollView isMemberOfClass:[UIScrollView class]]) {
        if (scrollView.contentOffset.x == 0) {
            [scrollView setContentOffset:CGPointMake(self.view.frame.size.width * 3, 0) animated:NO];
            _pageControll.currentPage = 2;
            return;
        }
        if (scrollView.contentOffset.x == self.view.frame.size.width * 4) {
            [scrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:NO];
            _pageControll.currentPage = 0;
            return;
        }
        _pageControll.currentPage = scrollView.contentOffset.x / self.view.frame.size.width - 1;
    }
}

#pragma mark --添加button
- (void)setButton {
    NSArray *imagesArr = @[@"footer", @"scenicspots_o", @"ktv_u", @"shoppingmall", @"vip", @"marry_u", @"food_u", @"",
                           @"food_u", @"snack_u", @"relax", @"more_o", @"groupon_u", @"hotel_u", @"takeaway_u", @"film_u",
                           @"beauty", @"baby", @"marry", @"jiazhuang", @"booking_u", @"discount_u", @"food_u", @"food_u",
                           @"footer", @"scenicspots_o", @"ktv_u", @"shoppingmall", @"vip", @"marry_u", @"food_u", @"",
                           @"food_u", @"snack_u", @"relax", @"more_o", @"groupon_u", @"hotel_u", @"takeaway_u", @"film_u"];
    
    NSArray *titleArr = @[@"足疗按摩", @"周边游", @"KTV", @"购物商城", @"会员卡",@"拍婚照",@"爱车", @"",
                          @"美食", @"小吃快餐", @"休闲娱乐", @"全部分类", @"团购", @"订酒店", @"订外卖", @"看电影",
                          @"丽人", @"亲子", @"结婚", @"家装", @"订座", @"找优惠", @"有料", @"看演出",
                          @"足疗按摩", @"周边游", @"KTV", @"购物商城", @"会员卡",@"拍婚照",@"爱车", @"",
                          @"美食", @"小吃快餐", @"休闲娱乐", @"全部分类", @"团购", @"订酒店", @"订外卖", @"看电影"];
    
    CGFloat gap = self.view.frame.size.width / 12;
    
    CGFloat btnW = (self.view.frame.size.width - 5 * gap) / 4;
    
    for (int i = 0; i < 5; i++) {//i 表示页数
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * self.view.frame.size.width, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.scrollView.frame))];
        [_scrollView addSubview:view];
        for (int j = 0; j < 8; j++) {
            ZKButton *btn = [ZKButton buttonWithFrame:CGRectMake(gap + (j % 4) * (gap + btnW), (j / 4) * 70 + 15, btnW, btnW) type:UIButtonTypeCustom title:nil backgroundImage:nil andimage:imagesArr[i * 8 + j] andBlock:^(ZKButton *button) {
                
            }];
            
            UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(gap + (j % 4) * (gap + btnW), CGRectGetMaxY(btn.frame), btnW, 20)];
            titleLabel.text = titleArr[i * 8 + j];
            titleLabel.font = [UIFont systemFontOfSize:10];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [view addSubview:titleLabel];
            
            [view addSubview:btn];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
