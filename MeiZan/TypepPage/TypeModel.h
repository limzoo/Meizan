//
//  TypeModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/15.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeModel : NSObject
@property (nonatomic, assign) long typeId;
@property (nonatomic, assign) long parentId;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSString *categoryImgPath;
@property (nonatomic, strong) NSString *isIndex;
@end
/*        "id": 3,分类id<number>
 "categoryName": "原料",分类名称<string>
 "categoryImgPath": "",分类图片<string>
 "parentId": 0,上级分类id<number>
 "isIndex": "1",是否显示在首页（0-否，1-是）<string>
 "createTime": "2017-12-26 10:17:36",创建时间<string>
 "lastModifyTime": "2017-12-26 10:17:36"最后修改时间<string>
*/
