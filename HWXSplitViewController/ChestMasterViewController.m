//
//
//  Created by 霍文轩 on 16/3/2.
//  Copyright © 2016年 霍文轩. All rights reserved.
//

#import "ChestMasterViewController.h"
#import "DynamicController.h"
#import "Masonry.h"

@interface ChestMasterViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UITableView * tableView;
@property (nonatomic, retain) NSMutableArray * tableArray;
@end

@implementation ChestMasterViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.tableArray = [NSMutableArray array];
        [_tableArray addObject:@"右边隐藏"];
        [_tableArray addObject:@"左边隐藏"];
        [_tableArray addObject:@"不隐藏"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"好友";

    [self configureTable];
}

- (void)configureTable{
    self.tableView = [UITableView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@44);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = 0;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _tableArray[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:25];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DynamicController * dy = (DynamicController *)self.navigationController.parentViewController;
    dy.dynamiStyle = indexPath.row;
    
    [self.delegate masterViewController:self didSelectedWithText:_tableArray[indexPath.row]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
@end
