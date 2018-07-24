//
//  BaseTapGestureRecognizer.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/23.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTapGestureRecognizer : UITapGestureRecognizer
@property (nonatomic, strong) NSMutableDictionary *userInfoDic;
@end
