//
//
//  Created by 霍文轩 on 15/10/19.
//  Copyright © 2015年 霍文轩. All rights reserved.
//

#import "HWXTabBarController.h"
#import "HWXTabBarItem.h"
#import "Masonry.h"

@interface HWXTabBarController ()
@end

@implementation HWXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 删除原有tabBar
    [self.tabBar removeFromSuperview];
    
    [self createSubViews];
    
    // 自定义tabBar
    self.customTabBar = [UIImageView new];
    _customTabBar.userInteractionEnabled = YES;
    [self.view addSubview:_customTabBar];
    _customTabBar.backgroundColor = [UIColor clearColor];
    [_customTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.width.equalTo(@(70));
    }];
    
    [self setViewControllers:self.viewControllers];
    
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
    [super setViewControllers:viewControllers];
    
    for ( int i = 0; i < viewControllers.count; i++) {
        HWXTabBarItem * item = [[HWXTabBarItem alloc] initWithFrame:CGRectMake(0, 0, 40, 75)];
        [_customTabBar addSubview:item];
        if ( i == 1) {
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(_customTabBar);
                make.width.equalTo(@40);
                make.height.equalTo(@75);
            }];
        } else if ( i == 0 ) {
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_customTabBar);
                make.centerY.equalTo(_customTabBar).offset(-80); // 向上移80
                make.width.equalTo(@40);
                make.height.equalTo(@75);
            }];
        } else if ( i == 2 ) {
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_customTabBar);
                make.centerY.equalTo(_customTabBar).offset(80); // 向下移70
                make.width.equalTo(@40);
                make.height.equalTo(@75);
            }];
        }
        
        item.tag = 1000+i;
        [item addTarget:self action:@selector(tabbarItemClick:)];
        
        UIViewController * vc = [viewControllers objectAtIndex:i];
        if ( i == 0) {
            item.imageView.image = vc.tabBarItem.selectedImage;
            item.titleLabel.textColor = [UIColor colorWithRed:243/255.0 green:174/255.0 blue:40/255.0 alpha:1];
        } else {
            item.imageView.image = vc.tabBarItem.image;
        }
        item.titleLabel.text = vc.tabBarItem.title;
    }
}
#pragma mark - 跳转
- (void)tabbarItemClick:(HWXTabBarItem*)item{
    NSInteger tag = item.tag - 1000;
    // 跳转到相应的视图控制器
    self.selectedIndex = tag;
    
    for (int i = 0; i < _customTabBar.subviews.count; i++){
        HWXTabBarItem * subItem = _customTabBar.subviews[i];
        if ([subItem isKindOfClass:[HWXTabBarItem class]]) {
            subItem.imageView.image = self.viewControllers[i].tabBarItem.image;
            subItem.titleLabel.textColor = [UIColor whiteColor];
        }
    }
    item.imageView.image = self.viewControllers[tag].tabBarItem.selectedImage;
    item.titleLabel.textColor = [UIColor colorWithRed:243/255.0 green:174/255.0 blue:40/255.0 alpha:1];
}

#pragma mark - 创建左边的三个图片、状态栏、圆角图片
- (void)createSubViews{
    // 状态栏背景色
    UIView * customStatusBar = [UIView new];
    [self.view addSubview:customStatusBar];
    customStatusBar.backgroundColor = [UIColor colorWithRed:212/255.0 green:49/255.0 blue:49/255.0 alpha:1];
    // 先加入到父视图才能设置Constraints
    [customStatusBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0); // 相对于父视图的距离是0
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(@(20)); // 高度固定20
    }];
    
    // 圆角图片
    UIImageView * cornerImageView = [[UIImageView alloc] init];
    [self.view addSubview:cornerImageView];
    [cornerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(70);
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    cornerImageView.image = [UIImage imageNamed:@"corner"];
    
    UIImageView * middleImageView = [UIImageView new];
    middleImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar_back_middle" ofType:@"png"]];
    [self.view addSubview:middleImageView];
    [middleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(self.view).offset(0);
        make.width.equalTo(@(70));
        make.height.equalTo(self.view);
    }];
    
    UIImageView * upImageView = [UIImageView new];
    upImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar_back_up" ofType:@"png"]];
    [self.view addSubview:upImageView];
    [upImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(@(20));
        make.width.equalTo(@(70));
        make.height.equalTo(@(70 * 3)); // 因为图片的比例是高：宽 = 3：1
    }];
    
    UIImageView * downImageView = [UIImageView new];
    downImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar_back_down" ofType:@"png"]];
    [self.view addSubview:downImageView];
    [downImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(0));
        make.left.equalTo(self.view).offset(0);
        make.width.equalTo(@(70));
        make.height.equalTo(@(70 * 3)); // 因为图片的比例是高：宽 = 3：1
    }];
    
}

@end
