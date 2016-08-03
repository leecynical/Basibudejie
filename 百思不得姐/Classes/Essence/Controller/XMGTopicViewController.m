//
//  XMGTopicViewController.m
//  百思不得姐
//
//  Created by 李金钊 on 16/7/22.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGTopicViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "XMGTopic.h"
#import "XMGTopicCell.h"

@interface XMGTopicViewController ()
@property (nonatomic,strong) NSMutableArray *topics;
@property (nonatomic, copy) NSString *maxtime;
@property (nonatomic,strong) NSMutableDictionary *params;
/**
 *  当前页码
 */
@property (nonatomic, assign) NSInteger page;
@end

@implementation XMGTopicViewController

-(NSArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array] ;
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  初始化表格
     */
    [self setupTableView];
    /**
     *  设置刷新控件
     */
    [self setupRefresh];
}
/**
 * 初始化表格
 */
static NSString * const XMGTopicCellID = @"topic";
-(void)setupTableView
{
    //设置内边距(inset)
    CGFloat top = XMGTitlesViewY + XMGTitlesViewH;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //注册nib
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGTopicCell class]) bundle:nil] forCellReuseIdentifier:XMGTopicCellID];
}

-(void)setupRefresh
{
    //设置header
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    // Set title
    [header setTitle:@"刷新成功" forState:MJRefreshStateIdle];
    [header setTitle:@"下拉刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    
    // Set font
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // Hide the time
    //    header.lastUpdatedTimeLabel.hidden = YES;
    header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
    
    // Set textColor
    //    header.stateLabel.textColor = [UIColor redColor];
    //    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    //设置footer
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    // Set title
    [footer setTitle:@"点击或下拉刷新" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载更多 ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多的数据" forState:MJRefreshStateNoMoreData];
    
    // Set font
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    self.tableView.mj_footer = footer;
}

-(void)loadNewTopics
{
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject){
        if (self.params != params) return;
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        //清空页码
        self.page = 0;
    }failure:^(NSURLSessionDataTask *task, id responseObject){
        if (self.params != params) return;
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)loadMoreTopics
{
    [self.tableView.mj_header endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"maxtime"] = self.maxtime;
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject){
        if (self.params != params) return;
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *newTopics = [XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:newTopics];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        //保存当前页码
        self.page = page;
    }failure:^(NSURLSessionDataTask *task, id responseObject){
        if (self.params != params) return;
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGTopicCellID];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}
#pragma mark - <UITableViewDelegate>
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
@end
