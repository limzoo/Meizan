//
//  UserCommentModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/23.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCommentModel : NSObject
@property (nonatomic, strong) NSString *skuId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSMutableArray<NSString*> *photoUrl;
@property (nonatomic, strong) NSMutableArray<UIImage *> *imgArray;
@end
