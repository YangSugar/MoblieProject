//
//  FTTableViewController.m
//  MoblieProject
//
//  Created by futang yang on 2018/1/18.
//  Copyright © 2018年 futang yang. All rights reserved.
//

#import "FTTableViewController.h"
#import "FTScrollTable.h"

#import "FTTopTableViewCell.h"
#import "FTMiddleTableViewCell.h"
#import "FTBottomTableViewCell.h"
#import "FTScrollContentControoler.h"


@interface FTTableViewController ()<UITableViewDelegate,UITableViewDataSource,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FTScrollTable *tableView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic, assign) BOOL canScroll;



@end

@implementation FTTableViewController

#pragma mark - life Circle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self renderUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - render UI
- (void)renderUI {
    self.title = @"tableView嵌套tableView手势Demo";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[FTTopTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FTTopTableViewCell class])];
    [self.tableView registerClass:[FTMiddleTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FTMiddleTableViewCell class])];
    [self.tableView registerClass:[FTBottomTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FTBottomTableViewCell class])];
    
    
    self.canScroll = YES;
    
}


#pragma mark notify
- (void)changeScrollStatus {
    self.canScroll = YES;
    FTBottomTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    cell.cellCanScroll = NO;
}

#pragma mark - getter and setter
- (FTScrollTable *)tableView {
    if (!_tableView) {
        _tableView = [[FTScrollTable alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 200;
        } else {
            return 50;
        }
    }
    return CGRectGetHeight(self.view.bounds);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 50;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self.titleView = [[FSSegmentTitleView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 50) titles:@[@"全部",@"服饰穿搭",@"生活百货",@"美食吃货",@"美容护理",@"母婴儿童",@"数码家电"] delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    self.titleView.backgroundColor = [UIColor lightGrayColor];
    return self.titleView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FTTopTableViewCell class])];
            return cell;
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FTMiddleTableViewCell class])];
            return cell;
        }
    }  else {
        
        FTBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FTBottomTableViewCell class])];
        
        NSArray *titles = @[@"全部",@"服饰穿搭",@"生活百货",@"美食吃货",@"美容护理",@"母婴儿童",@"数码家电"];
        NSMutableArray *contentVCs = [NSMutableArray array];
        for (NSString * title in titles) {
            FTScrollContentControoler *vc = [[FTScrollContentControoler alloc] init];
            vc.title = title;
            [contentVCs addObject:vc];
        }
        
        cell.viewControllers = contentVCs;
        cell.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.bounds.size.height - 64) childVCs:contentVCs parentVC:self delegate:self];
        [cell.contentView addSubview:cell.pageContentView];
        return cell;
    }
}

#pragma mark FSSegmentTitleViewDelegate
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    self.titleView.selectIndex = endIndex;
    self.tableView.scrollEnabled = YES;
}

- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    
    FTBottomTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    cell.pageContentView.contentViewCurrentIndex = endIndex;
}

- (void)FSContentViewDidScroll:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress {
    self.tableView.scrollEnabled = NO;
}

#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat bottomCellOffset = [_tableView rectForSection:1].origin.y;
    
    NSLog(@"%f", scrollView.contentOffset.y);
    
    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            
            FTBottomTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
            cell.cellCanScroll = YES;
        }
    }  else {
        if (!self.canScroll) {
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
    
    self.tableView.showsVerticalScrollIndicator = self.canScroll ? YES : NO;
}







@end
