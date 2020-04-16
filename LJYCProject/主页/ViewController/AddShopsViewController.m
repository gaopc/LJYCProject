//
//  AddShopsViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-10-29.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "AddShopsViewController.h"
#import "AddShopsCell.h"
#import "SelectServiceItemViewController.h"
#import "MemberPhotoViewController.h"
#import "MyRegex.h"
#import "UploadPhotoViewController.h"
#import "DataClass.h"
#import "MemberLoginViewController.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "UIViewController+JASidePanel.h"
#import "SideBarViewController.h"

@interface AddShopsViewController ()

@end

@implementation AddShopsViewController
@synthesize textFieldArray, _imgArray, _itemArr;
@synthesize keyboardbar,bMKMapView;
@synthesize _shopType, _latitude, _longitude, _address, _district, _cityName, _textViewEdit;
@synthesize _introduceView;
@synthesize library;


-(void)dealloc
{
    self.textFieldArray = nil;
    self.keyboardbar = nil;
    self._itemArr = nil;
	//self.bMKMapView = nil;
    self._shopType = nil;
    self._longitude = nil;
    self._latitude = nil;
    self._address = nil;
    self._cityName = nil;
    self._district = nil;
    self._introduceView = nil;
    [library release];
    self.library = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self._shopType = @"-1";
    self.library = [[ALAssetsLibrary alloc] init];
    
    UIButton  * leftButton = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:nil frame:CGRectMake(0, 0, 25, 23) backImage:[UIImage imageNamed:@"侧栏1.png"] target:self action:@selector(sideBar:)];
    [leftButton setImage:[UIImage imageNamed:@"侧栏2.png"] forState:UIControlStateHighlighted];
	UIBarButtonItem * leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
    
    self.title = @"上传商家";
    self._imgArray = [[NSMutableArray alloc] init];
    self._itemArr = [[NSMutableArray alloc] init];
    rowArray = [[NSArray alloc] initWithObjects:@"51", @"60", @"145", @"126", @"90", @"67", @"67", @"67", @"120", @"110", nil];
	self.bMKMapView = [[[BaiduMKMapView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ViewWidth, ViewHeight-44)] autorelease];
	self.bMKMapView.delegate = self;
	self.bMKMapView.addshopdelegate = self;
	self.bMKMapView.tag = 2;
	self.bMKMapView.isLoadView = FALSE;
	//self.bMKMapView.pinTag = 0;
	
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, 320, ViewHeight-44-10) style:UITableViewStylePlain];
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.backgroundColor = [UIColor clearColor];
    myTable.allowsSelection = YES;
    myTable.dataSource = self;
    myTable.delegate = self;
    [self.view_IOS7 addSubview:myTable];

    [myTable release];
    
    UIButton *rightBut = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(createShop) title:@"完成"];
	UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
    
    self.textFieldArray = [NSArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyBroard) name:@"closeKeyBoard" object:nil];
}

#pragma mark-地图定位delegate
-(void)addShopClick:(NSArray*)infoArray{
	
    NSLog(@"定位调用");
		
    if ([infoArray count] == 5) {
        self._cityName = [infoArray objectAtIndex:4];
        self._district = [infoArray objectAtIndex:3];
        self._address = [infoArray objectAtIndex:2];
        self._latitude = [infoArray objectAtIndex:0];
        self._longitude = [infoArray objectAtIndex:1];
        
        NSLog(@"定位数据:%@", infoArray);
        
        [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
}
-(void)infoClick:(NSArray*)infoArray{
	
	AddShopAddressCell * cell = (AddShopAddressCell*)[myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
	[cell.activityIV stopAnimating];
	if (infoArray == nil || [[infoArray objectAtIndex:2] isEqualToString:@"北京市" ]) {
		[UIAlertView alertViewWithMessage:@"定位失败！"];
		return;
	}

	if ([infoArray count] == 5) {
		self._cityName = [infoArray objectAtIndex:4];
		self._district = [infoArray objectAtIndex:3];
		self._address = [infoArray objectAtIndex:2];
		self._latitude = [infoArray objectAtIndex:0];
		self._longitude = [infoArray objectAtIndex:1];
		
		//NSLog(@"定位数据:%@", infoArray);
		
		[myTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
        [UIAlertView alertViewWithMessage:@"定位成功！"];
	}
	
}


-(void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	if([CLLocationManager locationServicesEnabled])
		[self.bMKMapView viewWillDisappear];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
	if([CLLocationManager locationServicesEnabled])
		[self.bMKMapView viewWillAppear];

    
    if (!self._textViewEdit) {
        [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:8 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark - UIActionSheet UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self startCamera];
    }
    else if (buttonIndex == 1) {
        
        [self showImagePickerForPhotoPicker];
    }
}

#pragma mark - textField UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if (self.keyboardbar == nil) {
		myTable.tag = 100;
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:myTable];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
	}
	[keyboardbar showBar:textField];  //显示工具条
	
	return TRUE;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 0;
	
//    NSString *errStr = [[[[textFieldStr stringByReplacingOccurrencesOfString:@"(" withString:@"0"] stringByReplacingOccurrencesOfString:@")" withString:@"0"] stringByReplacingOccurrencesOfString:@"（" withString:@"0"] stringByReplacingOccurrencesOfString:@"）" withString:@"0"];
//    NSArray *errArr = [errStr componentsSeparatedByRegex:SHOP_NAME];
//    if ([errArr count] != 0) {
//         return NO;
//    }
    
	if (nameField == textField) {
		
		textFieldMaxLenth = 30;
	}
    else if (phoneField == textField) {
        
		textFieldMaxLenth = 11;
	}
    
	if(textFieldStrLength >= textFieldMaxLenth)
	{
		textField.text = [textFieldStr substringToIndex:textFieldMaxLenth];
		return NO;
	}
	else {
		return YES;
	}
}

#pragma mark - textView UITextViewDelegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	if (self.keyboardbar == nil) {
        myTable.tag = 100;
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:myTable];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
	}
	[keyboardbar showBar:textView];  //显示工具条
	return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    self._textViewEdit = YES;
    NSString * textFieldStr = [[textView.text stringByReplacingCharactersInRange:range withString:text] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 20;
	
//    if (introduceView == textView) {
//        
//        textFieldMaxLenth = 300;
//        
//        if (textFieldStrLength < 9) {
//            introduceNum.text = [NSString stringWithFormat:@"您还需要输入%d字", textFieldMaxLenth - textFieldStrLength];
//        }
//        else {
//            
//            introduceNum.text = [NSString stringWithFormat:@"您还可以输入%d字", textFieldMaxLenth - textFieldStrLength];
//        }
//	}
//    else if (noticeView == textView) {
//
//        textFieldMaxLenth = 20;
//        noticeNum.text = [NSString stringWithFormat:@"您还可以输入%d字", textFieldMaxLenth - textFieldStrLength];
//	}
    
    textFieldMaxLenth = 300;
    
    if (textFieldStrLength < 9) {
        introduceNum.text = [NSString stringWithFormat:@"您还需要输入%d个字", 9 - textFieldStrLength];
    }
    else {
        
        introduceNum.text = [NSString stringWithFormat:@"您还可以输入%d个字", textFieldMaxLenth - textFieldStrLength < 0 ? 0 : textFieldMaxLenth - textFieldStrLength];
    }
    
	if (textFieldStrLength>=textFieldMaxLenth)
	{
		textView.text =  [textFieldStr substringToIndex:textFieldMaxLenth];
		
		return  NO;
	}
	else
	{
		return YES;
	}
}

#pragma mark - Table view dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [rowArray count] - 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[rowArray objectAtIndex:indexPath.row] intValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = [NSString stringWithFormat:@"identifier%d", indexPath.row];
    if (indexPath.row == 0) {
        AddShopsCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[AddShopsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell._shopNameField.delegate = self;
            nameField = cell._shopNameField;
        }
        return cell;
    }
    else if (indexPath.row == 1) {
        
        AddShopAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[AddShopAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            [cell._locationBut addTarget:self action:@selector(clickLocation) forControlEvents:UIControlEventTouchUpInside];
        }
        cell._shopLocationLab.text = self._address;
        return cell;
    }
    else if (indexPath.row == 2) {
        
        AddShopPhotoCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[AddShopPhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            [cell._addImgBut0 addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
            [cell._addImgBut1 addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
        }
        cell._imgArray = [NSArray arrayWithArray:self._imgArray];
        return cell;
    }
    else if (indexPath.row == 3) {
        
        AddShopTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[AddShopTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.delegate = self;
        }
        
        [cell selectType:[self._shopType intValue]];
        return cell;
    }
    else if (indexPath.row == 4) {
        
        AddShopServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[AddShopServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        cell._serviceArr = self._itemArr;
        
        return cell;
    }
    else if (indexPath.row == 5) {
        
        AddShopScaleCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[AddShopScaleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
            CGRect frame;
            frame.origin.x = 25;
            frame.origin.y = [self getCellHeight:indexPath.row] + 30;
            frame.size.width = 270;
            frame.size.height = 30;
            
            downView1 = [[CoustormPullDownMenuView alloc] initWithFrame:frame];
            downView1.delegate = self;
            downView1.array = [NSArray arrayWithObjects:@"20人以下", @"21人~50人", @"51人~100人", @"100人以上", nil];
            downView1.placeStr = @"请选择人数";
            [myTable addSubview:downView1];
            [downView1 release];
            
//            [cell._unwindBut addTarget:self action:@selector(clickPicker:) forControlEvents:UIControlEventTouchUpInside];
        }
//        cell._shopScaleLab.text = shopScaleStr;
        
        return cell;
    }
    else if (indexPath.row == 6) {
        
        AddShopDateCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[AddShopDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
            if (!downView2 && !downView3) {
                
                CGRect frame;
                frame.origin.x = 25;
                frame.origin.y = [self getCellHeight:indexPath.row] + 30;
                frame.size.width = 120;
                frame.size.height = 30;
                
                CGRect frame2 = frame;
                frame2.origin.x = 175;

                downView2 = [[CoustormPullDownMenuView alloc] initWithFrame:frame];
                downView2.delegate = self;
                downView2.array = [NSArray arrayWithObjects:@"1月", @"2月", @"3月", @"4月", @"5月", @"6月", @"7月", @"8月", @"9月", @"10月", @"11月", @"12月",nil];
                downView2.placeStr = @"请选择时间";
                
                downView3 = [[CoustormPullDownMenuView alloc] initWithFrame:frame2];
                downView3.delegate = self;
                downView3.array = [NSArray arrayWithObjects:@"1月", @"2月", @"3月", @"4月", @"5月", @"6月", @"7月", @"8月", @"9月", @"10月", @"11月", @"12月",nil];
                downView3.placeStr = @"请选择时间";
                
                [myTable addSubview:downView2];
                [myTable addSubview:downView3];
                [downView2 release];
                [downView3 release];
            }
        }
        return cell;
    }
    else if (indexPath.row == 7) {
        
        AddShopPhoneCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[AddShopPhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell._phoneField.delegate = self;
            phoneField = cell._phoneField;
        }
        return cell;
    }
    else if (indexPath.row == 8) {
        
        AddShopIntroduceCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[AddShopIntroduceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
            cell._textView.delegate = self;
        }
        if (!self._textViewEdit) {
            NSString *viewText = @"";
            for (int i = 0; i < [self._itemArr count]; i ++) {
                
                ServiceTag *sTag = [self._itemArr objectAtIndex:i];
                if (i == 0)
                {
                    viewText = sTag._tag_name;
                }
                else {
                    viewText = [viewText stringByAppendingFormat:@"、%@", sTag._tag_name];
                }
            }
            if ([self._itemArr count] == 0) {
                self._introduceView.text = @"";
            }
            else {
                NSLog(@"viewText:%@", viewText);
                NSLog(@"viewText:%@", cell._textView.text);
                cell._textView.text = [NSString stringWithFormat:@"本店提供%@服务", viewText];
            }
            
            cell._endLab.text = [NSString stringWithFormat:@"还可以输入%d字", 300 - cell._textView.text.length];
        }
        
        self._introduceView = cell._textView;
        introduceNum = cell._endLab;
        return cell;
    } else {
        
        AddShopNoticeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[[AddShopNoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
            cell._textView.delegate = self;
            noticeView = cell._textView;
            noticeNum = cell._endLab;
        }
        return cell;
    }
    
    return nil;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        
        SelectServiceItemViewController *serviceItemVC = [[SelectServiceItemViewController alloc] init];
        serviceItemVC._delegate = self;
        serviceItemVC._selectItemArr = self._itemArr;
        [self.navigationController pushViewController:serviceItemVC animated:YES];
        [serviceItemVC release];
    }
}

#pragma mark Camera View Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissModalViewControllerAnimated:YES];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
//    {
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
//    }
//    [self performSelector:@selector(saveImage:)
//               withObject:image
//               afterDelay:0.5];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        [self.library saveImage:image toAlbum:@"辣郊游" withCompletionBlock:^(NSError *error) {
            if (error!=nil) {
                NSLog(@"保存图片失败: %@", [error description]);
            }
        }];
    }
    
    UploadPhotoViewController *uploadVC = [[UploadPhotoViewController alloc] init];
    uploadVC._uploadDelegate = self;
    [self.navigationController pushViewController:uploadVC animated:YES];
    uploadVC._imgModelArr = [NSMutableArray array];
    uploadVC._selfImage = image;
    uploadVC._imgArray = [NSMutableArray array];
    uploadVC._shopId = nil;
    uploadVC._minPicSelect = 2;
    uploadVC._maxPicSelect = 5;
    
    [uploadVC release];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}

#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    UploadPhotoViewController *uploadVC = [[UploadPhotoViewController alloc] init];
    uploadVC._uploadDelegate = self;
    [self.navigationController pushViewController:uploadVC animated:YES];
    uploadVC._imgModelArr = [NSMutableArray array];
    uploadVC._imgArray = [NSMutableArray array];
    uploadVC._shopId = nil;
    uploadVC._minPicSelect = 2;
    uploadVC._maxPicSelect = 5;
    
    for (int i=0; i<assets.count; i++) {
        
        ALAsset *asset=assets[i];
        UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            uploadVC._selfImage = tempImg;
        });
    }
    [uploadVC release];
}

- (void)saveImage:(UIImage *)image {
    
    NSLog(@"保存");
    [self._imgArray addObject:image];
    [myTable reloadData];
}

- (void)uploadPhotos:(NSArray *)imageData
{
    [self._imgArray addObjectsFromArray:imageData];
    
    [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:2 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)createShop
{
    NSString *errStr = [[[[nameField.text stringByReplacingOccurrencesOfString:@"(" withString:@"0"] stringByReplacingOccurrencesOfString:@")" withString:@"0"] stringByReplacingOccurrencesOfString:@"（" withString:@"0"] stringByReplacingOccurrencesOfString:@"）" withString:@"0"];
    
    if (nameField.text.length < 3) {
        [UIAlertView alertViewWithMessage:@"店铺名称您可以输入汉字、英文、数字、括号，至少3个字"];
        return;
    }
    NSArray *errArr = [errStr componentsSeparatedByRegex:SHOP_NAME];
    if (errArr.count > 0) {
        [UIAlertView alertViewWithMessage:@"店铺名称您可以输入汉字、英文、数字、小括号"];
        return;
    }
    if (self._latitude.length == 0) {
        [UIAlertView alertViewWithMessage:@"请定位店铺位置，定位店铺位置以便于上传店铺"];
        return;
    }
    if (self._imgArray.count < 2) {
        [UIAlertView alertViewWithMessage:@"请至少上传两张照片！"];
        return;
    }
    if ([self._shopType intValue] < 0) {
        [UIAlertView alertViewWithMessage:@"请选择店铺类型！"];
        return;
    }
    if ([self._itemArr count] < 1) {
        [UIAlertView alertViewWithMessage:@"请选择服务类型！"];
        return;
    }
    if (downView1.selectedIndex < 0) {
        [UIAlertView alertViewWithMessage:@"请选择接待规模！"];
        return;
    }
    if (downView2.selectedIndex < 0 || downView3.selectedIndex < 0) {
        [UIAlertView alertViewWithMessage:@"请选择营业周期！"];
        return;
    }
    if (phoneField.text.length == 0) {
        [UIAlertView alertViewWithMessage:@"请填写商家的手机号码！"];
        return;
    }
    if (phoneField.text.length != 11) {
        [UIAlertView alertViewWithMessage:@"请输入11位商家手机号码！"];
        return;
    }
    if (![phoneField.text isMatchedByRegex:PHONENO]) {
		[UIAlertView alertViewWithMessage:@"请输入正确的手机号码！"];
		return;
	}
    if (self._introduceView.text.length == 0) {
        [UIAlertView alertViewWithMessage:@"请填写店铺简介，以便于用户了解店铺信息！"];
		return;
    }
    if (self._introduceView.text.length < 9) {
        [UIAlertView alertViewWithMessage:@"请至少填写9字的店铺简介，以便用户更好的了解店铺信息"];
		return;
    }
    
    //农家乐  采摘园 娱乐 其它
    NSString *typeId = nil;
    NSArray *typeArr = [DataClass selectShopType] ;
    ShopType *type = [typeArr objectAtIndex:[self._shopType intValue]];
    typeId = type._Type_id;
    
    NSString *serviceId = @"";
    NSString *otherId = @"";
    NSString *imgId = @"";
    for(ServiceTag *aServiceTag in self._itemArr)
    {
        if ([aServiceTag._tag_type intValue] == 10) {
            otherId = [otherId stringByAppendingFormat:@"&%@", aServiceTag._tag_id];
        }
        else {
            serviceId = [serviceId stringByAppendingFormat:@"&%@", aServiceTag._tag_id];
        }
    }
    
    for (int i = 0; i < self._imgArray.count; i ++) {
        
        PicModel *model = [self._imgArray objectAtIndex:i];
        
        if (i == 0) {
            imgId = model._imgId;
        }
        else {
            
            imgId = [imgId stringByAppendingFormat:@"&%@", model._imgId];
        }
    }
    
    shopData = [[AddShopsData alloc] init];
    shopData._name = nameField.text;
    shopData._userId = [UserLogin sharedUserInfo].userID;
    shopData._cityName = self._cityName;
    shopData._district = self._district;
    shopData._picId = imgId;
    shopData._address = self._address;
    shopData._latitude = self._latitude;
    shopData._longitude = self._longitude;
    shopData._type = typeId;
    shopData._serviceTagId = serviceId.length > 0 ? [serviceId substringFromIndex:1] : nil;
    shopData._otherServiewTagId = otherId.length > 0 ? [otherId substringFromIndex:1] : nil;
    shopData._scale = [NSString stringWithFormat:@"%d", downView1.selectedIndex];
    shopData._cycleStart = [NSString stringWithFormat:@"%d", downView2.selectedIndex + 1];
    shopData._cycleEnd = [NSString stringWithFormat:@"%d", downView3.selectedIndex + 1];
    shopData._telephone = phoneField.text;
    shopData._introduce = self._introduceView.text;
    shopData._notice = noticeView.text;
    

    
    ASIFormDataRequest * theRequest = [InterfaceClass createShop:shopData];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredCreateShopResult:) Delegate:self needUserType:Default];
    [shopData release];
}

- (void)onPaseredCreateShopResult:(NSDictionary *)dic
{
    [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
    
    if ([[dic objectForKey:@"statusCode"] isEqualToString:@"0"]) {
        
        [self clearViews];
        
        UITableView *table = [(SideBarViewController *)self.sidePanelController.leftPanel myTableView];
        [table selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop ];
        
        NSString * rootVCStr =  @"HomeViewController";
        NSUInteger index =[self.sidePanelController.viewControllers indexOfObject:rootVCStr];
        ZXT_NavigationController *class = [self.sidePanelController.rootNavControllers objectAtIndex:index];
        self.sidePanelController.centerPanel = class;
        [self.sidePanelController showCenterPanelAnimated:YES];
    }
}

- (int)getCellHeight:(int)index
{
    int sum = 0;
    for (int i = 0; i < index; i ++) {
        
        sum += [[rowArray objectAtIndex:i] intValue];
    }
    return sum;
}

- (void)changeImage:(UIButton *)sender
{
    [keyboardbar HiddenKeyBoard];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照上传" otherButtonTitles:@"上传手机中的相片", nil];
    actionSheet.tag = 0;
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    [actionSheet release];
}

-(void)startCamera {
    
    UIImagePickerController *camera = [[UIImagePickerController alloc] init];
	
	camera.delegate = self;
	camera.allowsEditing = NO;
	
	//检查摄像头是否支持摄像机模式
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		//UI 显示样式，显示的格式确定
		camera.sourceType = UIImagePickerControllerSourceTypeCamera;
		camera.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
		//mediaTypes用来确定再picker里显示那些类型的多媒体文件，图片？视频？
		//camera.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
	}
	else
	{
		NSLog(@"Camera not exist");
		return;
	}
	//拍摄照片的清晰度，只有在照相机模式下可用
	camera.videoQuality = UIImagePickerControllerQualityTypeHigh;
	[self presentViewController:camera animated:YES completion:nil];
	[camera release];
}

- (void)showImagePickerForPhotoPicker
{
//    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//    imagePicker.delegate = self;
//    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    imagePicker.allowsEditing = NO;
//    [self presentModalViewController:imagePicker animated:YES];
    
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 5;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups=NO;
    picker.delegate=self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)selectedSelf:(CoustormPullDownMenuView *)sender
{
    [myTable bringSubviewToFront:sender];
    if (sender == downView1) {
        [downView2 closeView];
        [downView3 closeView];
    }
    else if (sender == downView2) {
        [downView1 closeView];
        [downView3 closeView];
    }
    else if (sender == downView3) {
        [downView1 closeView];
        [downView2 closeView];
    }
}

- (void)selectedBut:(UIButton *)sender
{
    
    self._shopType = [NSString stringWithFormat:@"%d", sender.tag];
}

- (void)clickLocation
{
	if(![CLLocationManager locationServicesEnabled])
	{
		[UIAlertView alertViewWithMessage:@"请开启定位\n请在“设置>隐私>定位服务”中将“辣郊游”的定位服务设为开启状态"];
		
	}else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied  ||  [CLLocationManager authorizationStatus] ==  kCLAuthorizationStatusRestricted ) {
		
		[UIAlertView alertViewWithMessage:@"请开启定位\n请在“设置>隐私>定位服务”中将“辣郊游”的定位服务设为开启状态"];
	}else
	{
		
		AddShopAddressCell * cell = (AddShopAddressCell*)[myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
		[cell.activityIV startAnimating];
		[self.bMKMapView viewWillAppear];
		self.bMKMapView.tag =1;
		self.bMKMapView.flag = FALSE;
		[UserLogin sharedUserInfo].showMapInfo = FALSE;

	}
}

- (void)changeServiceType:(NSArray *)array
{
    if (self._introduceView.text.length == 0) {
        self._textViewEdit = NO;
    }
    [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:4 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)clearViews
{
    nameField.text = nil;
    self._cityName = nil;
    self._district = nil;
    self._address = nil;
    self._latitude = nil;
    self._longitude = nil;
    [self._imgArray removeAllObjects];
    self._shopType = @"-1";
    [self._itemArr removeAllObjects];
    downView1.selectedString = nil;
    downView2.selectedString = nil;
    downView3.selectedString = nil;
    phoneField.text = nil;
    self._introduceView.text = nil;
    self._textViewEdit = NO;
    
    [myTable reloadData];
}

- (void)closeKeyBroard
{
    [self.keyboardbar HiddenKeyBoard];
}
@end
