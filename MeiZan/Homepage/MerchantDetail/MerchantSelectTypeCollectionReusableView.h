//
//  MerchantSelectTypeCollectionReusableView.h
//  JingXuan
//
//  Created by sfs on 2017/12/12.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MerchantSelectTypeDelegate<NSObject>
- (void)selectedViewDidSelectedIndex:(NSUInteger)index lastIndex:(NSUInteger)lastIndex;
@end

@interface MerchantSelectTypeCollectionReusableView : UICollectionReusableView
@property (nonatomic, weak) id<MerchantSelectTypeDelegate> delegate;
@end
