//
//  FTScrollContentControoler.m
//  MoblieProject
//
//  Created by futang yang on 2018/1/19.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import "FTScrollContentControoler.h"

/**
 * 随机数据
 */
#define RandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

@interface FTScrollContentControoler ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation FTScrollContentControoler

#pragma mark - life Circle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self renderUI];
    
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - render UI
- (void)renderUI {
    [self.view addSubview:self.tableView];
}



#pragma mark - private methods
- (void)loadData {
    for (int i = 0; i < 150; i++) {
        [self.data insertObject:RandomData atIndex:i];
    }
    
    [self.tableView reloadData];
}

#pragma mark - getter and setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)data {
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@--%@",self.title,self.data[indexPath.row]];
    return cell;
}

#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        
        // 到顶通知父视图改变状态
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];
    }
    self.tableView.showsVerticalScrollIndicator = self.vcCanScroll ? YES : NO;
}


@end
