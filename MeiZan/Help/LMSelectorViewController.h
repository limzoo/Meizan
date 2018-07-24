//
//  LMSelectorViewController.h
//  LMAddressSelector
//
//  Created by sfs on 2017/12/15.
//  Copyright © 2017年 limzoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LMSelectorViewController;
@protocol LMSelectorDelegate<NSObject>
- (void)selector:(LMSelectorViewController *)selector didFinishSelectWithProvince:(NSString *)province city:(NSString *)city district:(NSString *)district;
- (void)selector:(LMSelectorViewController *)selector didNotFinishSelectAddIndex:(NSUInteger)currentIndex;
@end
@interface LMSelectorViewController : UIViewController
@property (nonatomic, weak) id<LMSelectorDelegate> delegate;
@end
