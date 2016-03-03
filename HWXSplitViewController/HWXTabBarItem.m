//
//
//  Created by 霍文轩 on 15/10/19.
//  Copyright © 2015年 霍文轩. All rights reserved.
//

#import "HWXTabBarItem.h"

@interface HWXTabBarItem()
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;
@end

@implementation HWXTabBarItem
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
        [self addSubview:_imageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20 - 10, self.frame.size.width, 15)];
        self.titleLabel.font = [UIFont fontWithName:@"FZZhunYuan-M02S" size:14];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    if ([_target respondsToSelector:_action]){
//        [_target performSelector:_action withObject:self]; // 只是这样写会有内存泄露警告
        IMP imp = [_target methodForSelector:_action];
        void (*func)(id, SEL, id) = (void *)imp;
        func(_target, _action, self); // 可以传多个参数，要和上面的类型保持一致
    }
}

- (void)addTarget:(id)target action:(SEL)action {
    self.target = target;
    self.action = action;
}

@end
