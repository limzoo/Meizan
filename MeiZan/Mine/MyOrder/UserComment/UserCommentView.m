//
//  UserCommentView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/22.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "UserCommentView.h"
#import "UserCommentTotalTableViewCell.h"
#import "UserCommentMerchandiseTableViewCell.h"
#import "UserCommentModel.h"
#import "BaseTapGestureRecognizer.h"
#import "UserCommentViewController.h"
#import "OrderMerchandiseModel.h"
#import <AVFoundation/AVFoundation.h>
@interface UserCommentView()<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIPickerViewDelegate>
@property (nonatomic, strong) UITableView *mainTabelView;
@property (nonatomic, strong) NSMutableArray<UserCommentModel *> *commentArray;
@property (nonatomic, assign) NSInteger currentFocusRow;
@property (nonatomic, assign) NSInteger curretnFocusIMGVTag;

@property (nonatomic, strong) UserCommentTotalTableViewCell *totalCell;
@property (nonatomic, assign) BOOL isAnony;
@end
@implementation UserCommentView
- (void)configInitial{
    self.currentFocusRow = -1;
    self.curretnFocusIMGVTag = -1;
    self.isAnony = NO;
}
- (void)createSubview{
    self.mainTabelView = [[UITableView alloc] init];
    self.mainTabelView.delegate = self;
    self.mainTabelView.dataSource = self;
    [self.mainTabelView registerClass:[UserCommentTotalTableViewCell class] forCellReuseIdentifier:@"UserCommentTotalTableViewCell"];
     [self.mainTabelView registerClass:[UserCommentMerchandiseTableViewCell class] forCellReuseIdentifier:@"UserCommentMerchandiseTableViewCell"];
    [self addSubview:self.mainTabelView];
    [self.mainTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.bottom.mas_equalTo(self);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return self.model.goodsList.count;
            break;
        case 1:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 276;
            break;
        case 1:
            return 282;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            UserCommentMerchandiseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCommentMerchandiseTableViewCell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            __weak typeof(self) weakSelf = self;
            [cell.textView addTextDidChangeHandler:^(FSTextView *textView) {
                UserCommentModel *model = weakSelf.commentArray[indexPath.row];
                model.content = textView.text;
            }];
            cell.model = self.model.goodsList[indexPath.row];
            cell.commentModel = self.commentArray[indexPath.row];
            cell.buttonSelectAction = ^(NSInteger type) {
                UserCommentModel *model = weakSelf.commentArray[indexPath.row];
                model.type = type;
                [weakSelf.mainTabelView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
            for (int i = 10; i <13; i++) {
                UIImageView *imgView = [cell viewWithTag:i];
                BaseTapGestureRecognizer *tapRec = [[BaseTapGestureRecognizer alloc] initWithTarget:self action:@selector(initAlertVC:)];
                [tapRec.userInfoDic setObject:indexPath forKey:@"indexPath"];
                [tapRec.userInfoDic setObject:[NSNumber numberWithInt:i] forKey:@"tag"];
                [imgView addGestureRecognizer:tapRec];
            }
//            UITapGestureRecognizer *tapRec = [UITapGestureRecognizer alloc] initWithTarget:self action:load
            return cell;
            break;
        }
        case 1:{
            UserCommentTotalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCommentTotalTableViewCell"];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.isAnony = self.isAnony;
            [cell.anonymityView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(anonyAction:)]];
            self.totalCell = cell;
            [cell.confirmButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            break;
        }
        default:
            break;
    }
    return nil;
}
- (void)confirmAction:(UIButton *)sender{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (UserCommentModel *model in self.commentArray) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *tempStr;
        for (NSString *photoUrl in model.photoUrl) {
            if (tempStr.length == 0) {
                tempStr = photoUrl;
            }else{
                tempStr = [tempStr stringByAppendingString:[NSString stringWithFormat: @",%@",photoUrl]];
            }
        }
        if (model.content == nil || [model.content isEqualToString:@""]) {
            [Tool showMessage:@"评论不能为空" duration:3 atCenter:YES];
            return;
        }
        [dic setObject:model.content forKey:@"content"];
        
        if (tempStr != nil) {
            [dic setObject:tempStr forKey:@"appraisesAnnex"];
        }
        
        if (model.type == -1) {
            [Tool showMessage:@"请选择评价" duration:3 atCenter:YES];
            return;
        }
        [dic setObject:[NSString stringWithFormat:@"%ld",model.type] forKey:@"type"];
        [dic setObject:model.skuId forKey:@"goodsSkuId"];
        [tempArray addObject:dic];
    }
    NSDictionary *dic = @{@"orderId":self.model.orderId,
                          @"serviceScore":[NSNumber numberWithInteger: self.totalCell.rateBar_3.starNumber],
                          @"timeScore":[NSNumber numberWithInteger: self.totalCell.rateBar_2.starNumber],
                          @"goodsScore":[NSNumber numberWithInteger: self.totalCell.rateBar_1.starNumber],
                          @"isShow":[NSString stringWithFormat:@"%d",self.isAnony],
                          @"mEvaluateList":tempArray,
                          };
    NSString *paramStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    [((UserCommentViewController *)self.myViewController) confirmComment:paramStr];
}
- (void)anonyAction:(UITapGestureRecognizer *)tap{
    self.isAnony = !self.isAnony;
    [self.mainTabelView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}
             
- (void)insertPhotoUrlInCommentArray:(NSString *)photoUrl image:(UIImage *)image{
    UserCommentModel *model = self.commentArray[self.currentFocusRow];
    [model.imgArray setObject:image atIndexedSubscript:self.curretnFocusIMGVTag - 10];
    [model.photoUrl setObject:photoUrl atIndexedSubscript:self.curretnFocusIMGVTag - 10];
    [self.mainTabelView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.currentFocusRow inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    self.currentFocusRow = -1;
    self.curretnFocusIMGVTag = -1;
}
- (void)initAlertVC:(BaseTapGestureRecognizer *)tap{
    NSIndexPath *indexPath = [tap.userInfoDic objectForKey:@"indexPath"];
    NSInteger imgVTag = ((NSNumber *)[tap.userInfoDic objectForKey:@"tag"]).integerValue;
    self.currentFocusRow = indexPath.row;
    self.curretnFocusIMGVTag = imgVTag;
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
        [((UserCommentViewController *)self.myViewController) uploadImg:image withRow:self.currentFocusRow];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
- (void)confirm:(UIButton *)sender{
//    [((UserCommentViewController *)self.myViewController) uploadVoucher];
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setModel:(MyOrderModel *)model{
    _model = model;
    self.commentArray = [NSMutableArray array];
    for (int i=0; i < model.goodsList.count; i++) {
        UserCommentModel *commentModel = [[UserCommentModel alloc] init];
        commentModel.skuId = ((OrderMerchandiseModel *)model.goodsList[i]).skuId;
        [self.commentArray addObject:commentModel];
    }
    [self.mainTabelView reloadData];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (![[super hitTest:point withEvent:event] isKindOfClass:[UITextField class]]) {
        [self endEditing:YES];
    }
     return [super hitTest:point withEvent:event];
}
@end
