//
//
//  Created by 霍文轩 on 16/3/2.
//  Copyright © 2016年 霍文轩. All rights reserved.
//

#import "DynamicController.h"
#import "ChestDetailViewController.h"
#import "ChestMasterViewController.h"
#import "Masonry.h"

@interface DynamicController () <ChestMasterViewControllerDelegate>
@property (nonatomic, retain) UINavigationController * masterNav;
@property (nonatomic, retain) UINavigationController * detailNav;
@end

@implementation DynamicController

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initializationData];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initializationData];
    }
    return self;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initializationData];
    }
    return self;
}
- (void)initializationData{
    self.dynamiStyle = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 这个代码原理很简单，创建一个RootViewController，再创建两个ChildViewController，加到Root上添加约束就可以了

    ChestMasterViewController * masterVC = [ChestMasterViewController new];
    self.masterNav = [[UINavigationController alloc] initWithRootViewController:masterVC];
    [self addChildViewController:_masterNav];
    [self.view addSubview:_masterNav.view];
    masterVC.view.backgroundColor = [UIColor whiteColor];
    
    ChestDetailViewController * detailVC = [ChestDetailViewController new];
    self.detailNav = [[UINavigationController alloc] initWithRootViewController:detailVC];
    [self addChildViewController:_detailNav];
    [self.view addSubview:_detailNav.view];
    
    masterVC.delegate = self;
}

#pragma mark - Chest Master ViewController Delegate
- (void)masterViewController:(UIViewController *)masterViewController didSelectedWithText:(NSString *)text{
    ChestDetailViewController * detailVC = (ChestDetailViewController *)[_detailNav.viewControllers firstObject];
    detailVC.detailLabel.text = text;
}

#warning 核心代码，自动布局
- (void)viewWillLayoutSubviews{
    float scale = 0.4;
    if (self.view.frame.size.width > self.view.frame.size.height) {
        // 横屏
        CGFloat detailWidth = (self.view.frame.size.width - 70) * (1-scale);
        CGFloat masterWidth = (self.view.frame.size.width - 70) * scale; // master的宽度
        [_masterNav.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.left.equalTo(@70);
            make.width.equalTo(@(masterWidth));
            make.bottom.equalTo(@0);
        }];
        [_detailNav.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.right.equalTo(@0);
            make.width.equalTo(@(detailWidth));
            make.bottom.equalTo(@0);
        }];
    } else {
        // 竖屏
        switch (_dynamiStyle) {
            case DynamiStyleHiddenRight:{
                // master全屏，detail在右边屏幕外
                CGFloat detailWidth = (self.view.frame.size.width - 70) * (1-scale);
                CGFloat masterWidth = self.view.frame.size.width - 70; // master的宽度
                [_masterNav.view mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(@20);
                    make.left.equalTo(@70);
                    make.width.equalTo(@(masterWidth));
                    make.bottom.equalTo(@0);
                }];
                [_detailNav.view mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(@20);
                    make.right.equalTo(@(masterWidth));
                    make.width.equalTo(@(detailWidth));
                    make.bottom.equalTo(@0);
                }];
            }
                break;
            case DynamiStyleHiddenLeft:{
                // detail全屏，master在右边屏幕外
                CGFloat masterWidth = self.view.frame.size.width - 70; // master的宽度
                CGFloat detailWidth = (self.view.frame.size.width - 70) * (1-scale);
                [_detailNav.view mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(@20);
                    make.left.equalTo(@70);
                    make.width.equalTo(@(masterWidth));
                    make.bottom.equalTo(@0);
                }];
                [_masterNav.view mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(@20);
                    make.right.equalTo(@(-masterWidth));
                    make.width.equalTo(@(detailWidth));
                    make.bottom.equalTo(@0);
                }];
            }
                break;
            case DynamiStyleNone:{
                CGFloat detailWidth = (self.view.frame.size.width - 70) * (1-scale);
                CGFloat masterWidth = (self.view.frame.size.width - 70) * scale; // master的宽度
                [_masterNav.view mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(@20);
                    make.left.equalTo(@70);
                    make.width.equalTo(@(masterWidth));
                    make.bottom.equalTo(@0);
                }];
                [_detailNav.view mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(@20);
                    make.right.equalTo(@0);
                    make.width.equalTo(@(detailWidth));
                    make.bottom.equalTo(@0);
                }];
            }
                break;
            default:
                break;
        }

    }
}
@end
