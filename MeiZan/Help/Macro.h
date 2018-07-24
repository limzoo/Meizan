//
//  Macro.h
//  OilLife
//
//  Created by sfs on 2017/10/27.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#ifndef Macro_h
#define Macro_h
#define COLOR_RGB16(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])
#define CUSTOM_WIDTH(floatValue) floatValue
#define CUSTOM_HEIGHT(floatValue) floatValue

#define STYLECOLOR COLOR_RGB16(0xF6AB00)
#define TITLECOLOR COLOR_RGB16(0x333333)
#define BACKGROUNDREDCOLOR  COLOR_RGB16(0xF7767B)
#define INSETCOLOR COLOR_RGB16(0xe5e5e5)
#define INSETCOLOR_F5 COLOR_RGB16(0xf5f5f5)
#define TEXTCOLOR COLOR_RGB16(0x666666)



#pragma mark - 访问地址

//#define HOME_URL(url) [NSString stringWithFormat:@"http://192.168.0.102:8062%@",url] // 荣镇
////
//#define HOME__URL(url) [NSString stringWithFormat:@"http://192.168.0.141:8091%@",url] // 荣镇

//#define HOME_URL(url) [NSString stringWithFormat:@"http://192.168.0.62:8087%@",url] // 俊琪
//
//#define HOME__URL(url) [NSString stringWithFormat:@"http://192.168.0.62:8087%@",url] // 俊琪


//#define HOME_URL(url) [NSString stringWithFormat:@"http://192.168.0.104:8087%@",url] // 俊琪

//#define HOME_URL(url) [NSString stringWithFormat:@"http://192.168.0.107:8070%@",url] // 元彬

//#define HOME_URL(url) [NSString stringWithFormat:@"http://192.168.0.170:8080/qr-api-web%@",url] // 测试快捷支付

// 正式网
#define HOME_URL(url) [NSString stringWithFormat:@"http://mz.ronghes.com%@",url]
//
//#define HOME__URL(url) [NSString stringWithFormat:@"https://api.payrong.com/shop-api-web%@",url]

// 测试网
//#define HOME_URL(url) [NSString stringWithFormat:@"https://m.payrong.com/qr-api-web%@",url]

//#define HOME__URL(url) [NSString stringWithFormat:@"https://m.payrong.com/shop-api-web%@",url]// 添加参数cookie进行加密


#define URL_ToKen(url)                                                                                               \
({                                                                                                                                            \
url = [NSString stringWithFormat:@"%@&user_token=%@%@",url,DEF_PERSISTENT_GET_OBJECT(RHBToken),DEF_PERSISTENT_GET_OBJECT(RHBPHONEINFOMATION)];\
})

#endif /* Macro_h */
