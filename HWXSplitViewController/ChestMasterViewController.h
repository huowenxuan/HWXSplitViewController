//
//
//  Created by 霍文轩 on 16/3/2.
//  Copyright © 2016年 霍文轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChestMasterViewControllerDelegate
- (void)masterViewController:(UIViewController *)masterViewController didSelectedWithText:(NSString *)text;
@end

@interface ChestMasterViewController : UIViewController
@property (nonatomic, assign) id<ChestMasterViewControllerDelegate> delegate;
@end

