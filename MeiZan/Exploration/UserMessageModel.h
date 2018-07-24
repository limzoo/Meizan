//
//  UserMessageModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/15.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserMessageModel : NSObject
@property (nonatomic, assign) long ID;
@property (nonatomic, assign) long USER_ID;
@property (nonatomic, assign) long MESSAGE_BROWSE_COUNT;
@property (nonatomic, strong) NSString *MESSAGE_TITLE;
@property (nonatomic, strong) NSString *STATUS;
@property (nonatomic, strong) NSString *MESSAGE_IMG;
@property (nonatomic, strong) NSString *MESSAGE_TYPE;
@property (nonatomic, strong) NSString *CREATE_TIME;
@property (nonatomic, strong) NSString *UPDATE_TIME;
@property (nonatomic, strong) NSString *SEND_WAY;
@property (nonatomic, strong) NSString *MESSAGE_CONTENT;
@property (nonatomic, strong) NSString *IS_READ;
@end
/*"MESSAGE_TITLE": "aSDS",<string>
 "STATUS": "1",<string>
 "MESSAGE_IMG": "http://localhost:8080/meizan-manager-web/message/faacb153-fe26-44c6-b3c4-ad8aac2c003a.jpg",<string>
 "MESSAGE_TYPE": "3",<string>
 "USER_ID": 10000002,<number>
 "ID": 21,<number>
 "CREATE_TIME": "2018-01-03 15:12:16",<string>
 "UPDATE_TIME": "2018-01-03 15:12:16",<string>
 "MESSAGE_BROWSE_COUNT": 0,<number>
 "SEND_WAY": "2",<string>
 "MESSAGE_CONTENT": "<p>123123<br/></p>"*/
