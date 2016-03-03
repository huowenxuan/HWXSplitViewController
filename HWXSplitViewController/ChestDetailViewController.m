//
//
//  Created by 霍文轩 on 16/3/2.
//  Copyright © 2016年 霍文轩. All rights reserved.
//

#import "ChestDetailViewController.h"
#import "Masonry.h"

@interface ChestDetailViewController ()

@end

@implementation ChestDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:253/255.0 green:240/255.0 blue:222/255.0 alpha:0.5];
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    self.detailLabel = [UILabel new];
    [self.view addSubview:_detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@80);
    }];
    _detailLabel.textColor = [UIColor whiteColor];
    _detailLabel.font = [UIFont boldSystemFontOfSize:35];
    _detailLabel.textAlignment = NSTextAlignmentCenter;
}
@end
