//
//  UploadVoucherView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/18.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "UploadVoucherView.h"
#import <AVFoundation/AVFoundation.h>
#import "UploadVoucherViewController.h"
@interface UploadVoucherView()<UINavigationControllerDelegate, UIPickerViewDelegate>

@end
@implementation UploadVoucherView
- (void)createSubview{
    self.backgroundColor = COLOR_RGB16(0xfafafa);
    
    UIView *nameView = [[UIView alloc] init];
    nameView.backgroundColor = [UIColor whiteColor];
    [self addSubview:nameView];
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(15);
        make.height.mas_offset(49);
    }];
    
    UILabel *const_name = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:@"收款人姓名"];
    [nameView addSubview:const_name];
    [const_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(nameView);
    }];
    
    self.name = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:nil];
    self.name.textAlignment = NSTextAlignmentRight;
    [nameView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(const_name);
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
    }];
    
    UIView *lineView_1 = [[UIView alloc] init];
    lineView_1.backgroundColor = INSETCOLOR;
    [self addSubview:lineView_1];
    [lineView_1 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.trailing.mas_equalTo(self);
        make.top.mas_equalTo(nameView.mas_bottom);
        make.height.mas_offset(1);
    }];
    
    UIView *cardNumView = [[UIView alloc] init];
    cardNumView.backgroundColor = [UIColor whiteColor];
    [self addSubview:cardNumView];
    [cardNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(lineView_1.mas_bottom);
        make.height.mas_offset(49);
    }];
    
    UILabel *const_cardNum = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:@"收款卡号"];
    [cardNumView addSubview:const_cardNum];
    [const_cardNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(cardNumView);
    }];
    
    self.bankCard = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:nil];
    self.bankCard.textAlignment = NSTextAlignmentRight;
    [cardNumView addSubview:self.bankCard];
    [self.bankCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(const_cardNum);
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
    }];
    
    UIView *lineView_2 = [[UIView alloc] init];
    lineView_2.backgroundColor = INSETCOLOR;
    [self addSubview:lineView_2];
    [lineView_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(cardNumView.mas_bottom);
        make.height.mas_offset(1);
    }];
    
    UIView *bankName = [[UIView alloc] init];
    bankName.backgroundColor = [UIColor whiteColor];
    [self addSubview:bankName];
    [bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(lineView_2.mas_bottom);
        make.height.mas_offset(49);
    }];
    
    UILabel *const_bank = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:@"开户行"];
    [bankName addSubview:const_bank];
    [const_bank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(bankName);
    }];
    
    self.bankName = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:nil];
    self.bankName.textAlignment = NSTextAlignmentRight;
    [bankName addSubview:self.bankName];
    [self.bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(const_bank);
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
    }];
    
    UIView *lineView_3 = [[UIView alloc] init];
    lineView_3.backgroundColor = INSETCOLOR;
    [self addSubview:lineView_3];
    [lineView_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(bankName.mas_bottom);
        make.height.mas_offset(1);
    }];
    
    UIView *photoView = [[UIView alloc] init];
    photoView.backgroundColor = [UIColor whiteColor];
    [self addSubview:photoView];
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(lineView_3.mas_bottom).offset(14);
        make.height.mas_offset(100);
    }];
    
    UILabel *const_photo = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:@"上传银行\n汇款凭证"];
    const_photo.numberOfLines = 2;
    [photoView addSubview:const_photo];
    [const_photo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(photoView).offset(CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(photoView);
    }];
    
    self.photo = [[UIImageView alloc] init];
    self.photo.image = [UIImage imageNamed:@"上传凭证"];
    self.photo.userInteractionEnabled = YES;
    [self.photo addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(initAlertVC:)]];
    
    [photoView addSubview:self.photo];
    [self.photo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(72);
        make.centerY.mas_equalTo(photoView);
        make.leading.mas_equalTo(const_photo.mas_trailing).offset(CUSTOM_WIDTH(20));
    }];
    
    UIView *lineView_4 = [[UIView alloc] init];
    lineView_4.backgroundColor = INSETCOLOR;
    [self addSubview:lineView_4];
    [lineView_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(photoView.mas_bottom);
        make.height.mas_offset(1);
    }];
    
    UIButton *savePicButton = [UIButton initCustomTypeButtonWithTextColor:STYLECOLOR backGroudColor:[UIColor whiteColor] cornerRadius:4.0f fontSize:16 title:@"保存图片"];
    [savePicButton addTarget:self action:@selector(savePicAction:) forControlEvents:UIControlEventTouchUpInside];
    savePicButton.layer.borderWidth = 0.5f;
    savePicButton.layer.borderColor = STYLECOLOR.CGColor;
    [self addSubview:savePicButton];
    
    UIButton *confirmButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:4.0f fontSize:16 title:@"提交"];
    [confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmButton];
    
    [savePicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(photoView.mas_bottom).offset(20);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(CUSTOM_WIDTH(120)); make.trailing.mas_equalTo(confirmButton.mas_leading).offset(-CUSTOM_WIDTH(14));
    }];
    
     [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(photoView.mas_bottom).offset(20);
          make.height.mas_equalTo(44);
         make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
    }];
}

- (void)initAlertVC:(UITapGestureRecognizer *)tap{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"获取照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self initCameraPickerController:tap.view.tag];
    }];
    [alertVC addAction:actionCamera];
    UIAlertAction *actionPhotoLibrary = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self initPhotoLibraryPickerController:tap.view.tag];
    }];
    [alertVC addAction:actionPhotoLibrary];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        ;
    }];
    [alertVC addAction:actionCancel];
    [self.myViewController presentViewController:alertVC animated:YES completion:^{
        ;
    }];
}
- (void)initCameraPickerController:(NSInteger)tag{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.view.tag = tag;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //先检查相机可用是否
        BOOL cameraIsAvailable = [self checkCamera];
        if (YES == cameraIsAvailable) {
            [self.myViewController presentViewController:picker animated:YES completion:nil];
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在iPhone的“设置-隐私-相机”选项中，允许本应用程序访问你的相机。" delegate:self cancelButtonTitle:@"好，我知道了" otherButtonTitles:nil];
            [alert show];
        }
        
    }
}

- (BOOL)checkCamera{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(AVAuthorizationStatusRestricted == authStatus ||
       AVAuthorizationStatusDenied == authStatus)
    {
        //相机不可用
        return NO;
    }
    //相机可用
    return YES;
}

- (void)initPhotoLibraryPickerController:(NSInteger)tag{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.view.tag = tag;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self.myViewController presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    NSLog(@"%ld",picker.view.tag);
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        NSString *key = nil;
        
        if (picker.allowsEditing)
        {
            key = UIImagePickerControllerEditedImage;
        }
        else
        {
            key = UIImagePickerControllerOriginalImage;
        }
        //获取图片
        UIImage *image = [info objectForKey:key];
        
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            // 固定方向
            //            image = [image fixOrientation];//这个方法是UIImage+Extras.h中方法
            //压缩图片质量
            image = [self reduceImage:image percent:0.1];
            CGSize imageSize = image.size;
            imageSize.height = 320;
            imageSize.width = 320;
            //压缩图片尺寸
            image = [self imageWithImageSimple:image scaledToSize:imageSize];
        }
        [((UploadVoucherViewController *)self.myViewController) uploadVoucherImg:image];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
- (void)confirm:(UIButton *)sender{
    [((UploadVoucherViewController *)self.myViewController) uploadVoucher];
}

//压缩图片质量
-(UIImage *)reduceImage:(UIImage *)image percent:(float)percent
{
    NSData *imageData = UIImageJPEGRepresentation(image, percent);
    UIImage *newImage = [UIImage imageWithData:imageData];
    return newImage;
}
//压缩图片尺寸
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)savePicAction:(UIButton *)sender{
    UIImage *image = [self snapshot];
    UIImageWriteToSavedPhotosAlbum(image/*你要保存到本地相册的图片对象，当然此处更多的需求可能是长按保存，那你就写个长按收拾UILongPressGestureRecognizer手势，给手势加个触发方法不就行了嘛*/, self, nil, nil);
}
- (void)setModel:(MyOrderModel *)model{
    _model = model;
}

- (UIImage *)snapshot{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1);
    [self drawViewHierarchyInRect:self.frame afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGFloat scale = [UIScreen mainScreen].scale;
    CGRect cutRect = CGRectMake(0, 15, self.bounds.size.width, 100);
    CGFloat x= cutRect.origin.x*scale,y=cutRect.origin.y*scale,w=cutRect.size.width*scale,h=cutRect.size.height*scale;
    CGRect dianRect = CGRectMake(x, y, w, h);
    
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    return newImage;
}

@end
