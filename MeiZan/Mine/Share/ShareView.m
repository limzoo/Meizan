//
//  ShareView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/30.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "ShareView.h"
#import "WXApi.h"
#import "PopularizeViewController.h"
@interface ShareView()
@property (nonatomic, strong) UIImageView *backGroundIMGV;
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) UIView *shareView;
@end
@implementation ShareView
- (void)createSubview{
    self.backGroundIMGV = [[UIImageView alloc] init];
    [self addSubview:self.backGroundIMGV];
    self.backGroundIMGV.image = [UIImage imageNamed:@"shareBackGround"];
    [self.backGroundIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(-(44 + [[UIApplication sharedApplication] statusBarFrame].size.height));
    }];
    
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];

    
    UIButton *copyButton = [UIButton initCustomTypeButtonWithTextColor:COLOR_RGB16(0xb7905f) backGroudColor:[UIColor whiteColor] cornerRadius:4 fontSize:14 title:@"复制邀请码"];
    [copyButton addTarget:self action:@selector(copyAction) forControlEvents:UIControlEventTouchUpInside];
    copyButton.layer.borderWidth = 1;
    copyButton.layer.borderColor = COLOR_RGB16(0xb7905f).CGColor;
    [self addSubview:copyButton];
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self);
//        make.top.mas_equalTo(userIdLabel).offset(CUSTOM_HEIGHT(24));
        make.width.mas_equalTo(CUSTOM_WIDTH(90));
        make.height.mas_equalTo(CUSTOM_HEIGHT(40));
    }];
    
    UILabel *userIdLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:18]  color:TITLECOLOR  text:[NSString stringWithFormat:@"%ld",config.userInfo.userId]];
    userIdLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:userIdLabel];
    [userIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
                make.bottom.mas_equalTo(copyButton.mas_top).offset(-CUSTOM_HEIGHT(14));
    }];
    
    UIButton *shareButton  = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:COLOR_RGB16(0xb7905f) cornerRadius:0 fontSize:16 title:@"邀请好友"];
    [shareButton addTarget:self action:@selector(showSharePage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self);
        make.height.mas_equalTo(49);
    }];
    
    UIButton *popularizeButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:COLOR_RGB16(0xb7905f) cornerRadius:3 fontSize:16 title:@"推广客户"];
    [popularizeButton addTarget:self action:@selector(popularize) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:popularizeButton];
    [popularizeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(120));
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(shareButton.mas_top).offset(-40);
    }];
    
    
    self.blackView = [[UIView alloc] init];
    self.blackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [self.blackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction)]];
    self.blackView.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:self.blackView];
    [self.blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.bottom.mas_equalTo([UIApplication sharedApplication].keyWindow );
    }];
    
    self.shareView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].keyWindow.bounds.size.height, self.bounds.size.width, 213)];
//    self.shareView.userInteractionEnabled = NO;
    self.shareView.backgroundColor = [UIColor whiteColor];
    [self.blackView addSubview:self.shareView];
    
    UIButton *cancelButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:0 fontSize:16 title:@"取消"];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.mas_equalTo(self.shareView);
        make.height.mas_equalTo(54);
    }];
    
    UILabel *titleLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@"分享给小伙伴"];
    [self.shareView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.shareView);
        make.top.mas_equalTo(self.shareView).offset(20);
    }];
    
    UIButton *wxshareButton = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:14 title:nil];
    wxshareButton.tag = 1;
    [wxshareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView addSubview:wxshareButton];
    [wxshareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo (82);
        make.width.mas_equalTo(60);
        make.leading.mas_equalTo(self.shareView).offset(CUSTOM_WIDTH(80));
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(20);
    }];
    
    UIImageView *wxIMG = [[UIImageView alloc] init];
    wxIMG.image = [UIImage imageNamed:@"微信分享"];
    [wxshareButton addSubview:wxIMG];
    [wxIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo(wxshareButton);
        make.height.mas_equalTo(60);
    }];
    
    UILabel *wxLabel  = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:TEXTCOLOR text:@"微信"];
    wxLabel.textAlignment = NSTextAlignmentCenter;
    [wxshareButton addSubview:wxLabel];
    [wxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(wxshareButton);
        make.height.mas_equalTo(12);
    }];
    
    UIButton *pengyouquanButton = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:14 title:nil];
    pengyouquanButton.tag = 2;
    [pengyouquanButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView addSubview:pengyouquanButton];
    [pengyouquanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo (82);
        make.width.mas_equalTo(60);
        make.trailing.mas_equalTo(self.shareView).offset(-CUSTOM_WIDTH(80));
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(20);
    }];
    
    UIImageView *pyqIMG = [[UIImageView alloc] init];
    pyqIMG.image = [UIImage imageNamed:@"朋友圈分享"];
    [pengyouquanButton addSubview:pyqIMG];
    [pyqIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo(pengyouquanButton);
        make.height.mas_equalTo(60);
    }];
    
    UILabel *pyqLabel  = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:TEXTCOLOR text:@"朋友圈"];
    pyqLabel.textAlignment = NSTextAlignmentCenter;
    [pengyouquanButton addSubview:pyqLabel];
    [pyqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(pengyouquanButton);
        make.height.mas_equalTo(12);
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)shareAction:(UIButton *)sender{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"美赞商城诚邀您";
    message.description = @"诚邀您加入美赞商城大家庭";
    [message setThumbImage:[UIImage imageNamed:@"AppIcon"]];
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
    NSString *str = [NSString stringWithFormat:@"/userInfo/recommend?userId=%ld",config.userInfo.userId];
    webpageObject.webpageUrl = HOME_URL(str);
    message.mediaObject = webpageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    if (sender.tag == 1) {
        req.scene = WXSceneSession;
    }else if(sender.tag == 2){
        req.scene = WXSceneTimeline;
    }
    [WXApi sendReq:req];

}

- (void)showSharePage{
    [[UIApplication sharedApplication].keyWindow  bringSubviewToFront:self.blackView];
    [self bringSubviewToFront:self.shareView];
    [UIView animateWithDuration:0.4 animations:^{
        self.blackView.alpha = 1;
        self.shareView.frame = CGRectMake(0, [UIApplication sharedApplication].keyWindow.bounds.size.height - 213, self.bounds.size.width, 213);
    } completion:^(BOOL finished) {
        ;
    }];
}

- (void)cancelAction{
    [UIView animateWithDuration:0.4 animations:^{
        self.blackView.alpha = 0;
        self.shareView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 213);
    } completion:^(BOOL finished) {
        ;
    }];
}

- (void)copyAction{
    [Tool showMessage:@"复制成功" duration:2];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
    pasteboard.string = [NSString stringWithFormat:@"%ld",config.userInfo.userId];
}

- (void)popularize{
    PopularizeViewController *vc = [[PopularizeViewController alloc] init];
    [self.myViewController.navigationController pushViewController:vc animated:YES];
}
@end
