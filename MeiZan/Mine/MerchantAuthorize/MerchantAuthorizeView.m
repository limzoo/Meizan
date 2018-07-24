//
//  MerchantAuthorizeView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/8.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MerchantAuthorizeView.h"
#import "MerchantAuthorizeViewController.h"
#import "LeftRightLabelTableViewCell.h"
@interface MerchantAuthorizeView()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *const_tableView;
@end
@implementation MerchantAuthorizeView
- (void)configInitial{
    self.section_1_title = @[@"店铺名称",@"店铺住所",@"注册号码",@"法定代表人姓名",@"法定代表人身份证"];
    self.section_1_placeHolder = @[@"请填写营业执照上名称",@"请填写营业执照上地址",@"请填写营业执照上编号",@"请填写代表人姓名",@"请填写代表人身份证"];
    self.section_2_title = @[@"营业执照",@"法人身份证"];
}
- (void)createSubview{
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
    if ([config.userInfo.authenticationStatus isEqualToString:@"1"]) {
         self.backgroundColor = COLOR_RGB16(0xfafafa);
        UIImageView *backGroundIMGV = [[UIImageView alloc] init];
        backGroundIMGV.image = [UIImage imageNamed:@"pic_您已通过实名认证"];
        [self addSubview:backGroundIMGV];
        [backGroundIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.mas_equalTo(self);
            make.height.mas_equalTo(backGroundIMGV.mas_width).multipliedBy(210/375.0);
        }];
        
        self.const_tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        self.const_tableView.delegate = self;
        self.const_tableView.dataSource = self;
        self.const_tableView.scrollEnabled = NO;
        [self addSubview:self.const_tableView];
        [self.const_tableView registerClass:[LeftRightLabelTableViewCell class] forCellReuseIdentifier:@"LeftRightLabelTableViewCell"];
        [self.const_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(self);
            make.top.mas_equalTo(backGroundIMGV.mas_bottom).offset(10);
            make.height.mas_equalTo(48*6);
        }];
    }else{
        self.backgroundColor = [UIColor whiteColor];
        self.announceLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:[UIColor whiteColor] text:@"审核未通过，请重新上传身份证正反面,营业执照。"];
        self.announceLabel.numberOfLines = 2;
        self.announceLabel.backgroundColor = COLOR_RGB16(0xff4444);
        [self addSubview:self.announceLabel];
        self.announceLabel.textAlignment = NSTextAlignmentCenter;
        [self.announceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.mas_equalTo(self);
            if ([config.userInfo.authenticationStatus isEqualToString:@"2"]){
                make.height.mas_equalTo(44);
            }else{
                make.height.mas_equalTo(0);
            }
        }];
        
        self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero];
        self.mainTableView.delegate = self;
        self.mainTableView.dataSource = self;
        [self.mainTableView registerClass:[LeftLabelRightTextfieldTableViewCell class] forCellReuseIdentifier:@"LeftLabelRightTextfieldTableViewCell"];
        [self.mainTableView registerClass:[UploadPicTableViewCell class] forCellReuseIdentifier:@"UploadPicTableViewCell"];
        [self.mainTableView registerClass:[NextStepTableViewCell class] forCellReuseIdentifier:@"NextStepTableViewCell"];
        [self addSubview:self.mainTableView];
        [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.bottom.trailing.mas_equalTo(self);
            make.top.mas_equalTo(self.announceLabel.mas_bottom);
        }];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.mainTableView) {
        return 3;
    }
    if (tableView == self.const_tableView) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.mainTableView) {
        switch (section) {
            case 0:
                return self.section_1_title.count;
                break;
            case 1:
                return self.section_2_title.count;
                break;
            case 2:
                return 1;
                break;
            default:
                break;
        }
    }
    if (tableView == self.const_tableView) {
        return 6;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.mainTableView) {
        switch (indexPath.section) {
            case 0:
                return 49;
                break;
            case 1:
                return 99;
            case 2:
                return 66;
            default:
                break;
        }
    }
    if (tableView == self.const_tableView) {
        return 48;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.mainTableView) {
        switch (indexPath.section) {
            case 0:{
                LeftLabelRightTextfieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftLabelRightTextfieldTableViewCell" forIndexPath:indexPath];
                cell.leftLabel.text = self.section_1_title[indexPath.row];
                NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.section_1_placeHolder[indexPath.row] attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14],NSForegroundColorAttributeName:COLOR_RGB16(0x666666)}];
                cell.rightTextField.attributedPlaceholder = attrStr;
                cell.rightTextField.delegate = self;
                cell.rightTextField.tag = indexPath.row + 100;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.rightTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
                return cell;
                break;
            }
            case 1:{
                UploadPicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UploadPicTableViewCell" forIndexPath:indexPath];
                cell.titleLabel.text = self.section_2_title[indexPath.row];
                if (indexPath.row == 0) {
                    if (self.image_1) {
                        cell.imageViewOne.image = self.image_1;
                    }else{
                        cell.imageViewOne.image = [UIImage imageNamed:@"上传执照"];
                    }
                    cell.imageViewTwo.hidden = YES;
                    cell.imageViewOne.tag = 1;
                    [cell.imageViewOne addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(initAlertVC:)]];
                }else{
                    cell.imageViewOne.tag = 2;
                    cell.imageViewTwo.tag = 3;
                    cell.imageViewTwo.hidden = NO;
                    if (self.image_2) {
                        cell.imageViewOne.image = self.image_2;
                    }else{
                        cell.imageViewOne.image = [UIImage imageNamed:@"上传正面"];
                    }
                    if (self.image_3) {
                        cell.imageViewTwo.image = self.image_3;
                    }else{
                        cell.imageViewTwo.image = [UIImage imageNamed:@"上传反面"];
                    }
                    [cell.imageViewOne addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(initAlertVC:)]];
                    [cell.imageViewTwo addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(initAlertVC:)]];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                break;
            }
            case 2:{
                NextStepTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NextStepTableViewCell"];
                [cell.nextStepButton addTarget:self action:@selector(uploadAction) forControlEvents:UIControlEventTouchUpInside];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
                return cell;
            }
            default:
                break;
        }
    }
    if (tableView == self.const_tableView) {
        NSArray *tempArray = @[@"姓名",@"身份证",@"证件审核",@"店铺名称",@"店铺地址",@"营业执照编号"];
        LeftRightLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftRightLabelTableViewCell"];
        cell.leftLabel.text = tempArray[indexPath.row];
        cell.leftLabel.textColor = TITLECOLOR;
        cell.rightLabel.text = self.const_dataArray[indexPath.row];
        cell.rightLabel.textColor = COLOR_RGB16(0x999999);
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.hasArrow = NO;
        return cell;
    }
   
    return nil;
}
- (void)uploadAction{
    [((MerchantAuthorizeViewController *)self.myViewController) merchantAuthorize];
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
        [((MerchantAuthorizeViewController *)self.myViewController) uploadImg:image tag:picker.view.tag];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
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

- (void)textFieldEditChanged:(UITextField *)textfield{
    self.inputMessageArray[textfield.tag - 100] = textfield.text;
}

- (NSMutableArray *)inputMessageArray{
    if (!_inputMessageArray) {
        _inputMessageArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _inputMessageArray;
}

- (void)setConst_dataArray:(NSArray *)const_dataArray{
    _const_dataArray = const_dataArray;
    [self.const_tableView reloadData];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
