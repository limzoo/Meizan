//
//  MerchantAuthorizeView.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/8.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "LeftLabelRightTextfieldTableViewCell.h"
#import "UploadPicTableViewCell.h"
#import "NextStepTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
@interface MerchantAuthorizeView : BaseView
@property (nonatomic, assign) NSInteger status;// 1未审核 2审核中 3已审核 4未完成

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UILabel *announceLabel;
@property (nonatomic, strong) NSArray *section_1_title;
@property (nonatomic, strong) NSArray *section_1_placeHolder;
@property (nonatomic, strong) NSArray *section_2_title;

@property (nonatomic, strong) NSMutableArray *inputMessageArray;
@property (nonatomic, strong) UIImage *image_1;
@property (nonatomic, strong) UIImage *image_2;
@property (nonatomic, strong) UIImage *image_3;
@property (nonatomic, strong) UIImagePickerController *pickerController;


@property (nonatomic, strong) NSArray *const_dataArray;
@end
