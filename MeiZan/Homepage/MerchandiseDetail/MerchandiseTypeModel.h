//
//  MerchandiseTypeModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/9.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchandiseTypeModel : NSObject
@property (nonatomic, strong) NSString *SPECS_NAME;
@property (nonatomic, strong) NSString *SPECS_ID;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *SPECS_TITLE;
@end
/*
 "SPECS_NAME": "鲜肉馅",规格名称<string>
 "SPECS_ID": "2",id<string>
 "ID": 2,id<number>
 "SPECS_TITLE": "类型"规格参数<string>
*/
