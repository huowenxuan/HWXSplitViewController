//
//
//  Created by 霍文轩 on 16/3/2.
//  Copyright © 2016年 霍文轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicController : UIViewController

typedef NS_ENUM(NSInteger, DynamiStyle) {
    DynamiStyleHiddenRight = 0, // 右边隐藏
    DynamiStyleHiddenLeft, // 左边隐藏
    DynamiStyleNone // 横屏竖屏左右都不隐藏
};

@property (nonatomic, assign) DynamiStyle dynamiStyle;

@end
