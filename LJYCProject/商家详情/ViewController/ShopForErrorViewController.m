//
//  ShopForErrorViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-7.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForErrorViewController.h"
#import "SelectCityViewController.h"
#import "DataClass.h"
#import "MyRegex.h"

@interface ShopForErrorViewController ()

@end

@implementation ShopForErrorViewController
@synthesize _cityLab;
@synthesize textFieldArray, keyboardbar;
@synthesize _errorData;
@synthesize _preBtn, _btnArr;

- (void)dealloc
{
    self._cityLab = nil;
    self.keyboardbar = nil;
    self.textFieldArray = nil;
    self._errorData = nil;
    
    self._btnArr = nil;
    self._preBtn = nil;

    [phone1View release];
    [phone2View release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"店铺报错";
    viewhight = 0;
    phoneViewNum = 0;
    
    myScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, 320, ViewHeight-44-15)];
    
    titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    [self initSubTitleView];
    
    typeView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 320, 100)];
    [self initSubTypeView];
    
    addressView = [[UIView alloc] initWithFrame:CGRectMake(0, 140, 320, 80)];
    [self initSubAddressView];
    
    phoneVIew = [[UIView alloc] initWithFrame:CGRectMake(0, 220, 320, 40)];
    [self initSubPhoneView];
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 260, 320, 120)];
    [self initSubBottomView];
    
    [myScroll addSubview:titleView];
    [myScroll addSubview:typeView];
    [myScroll addSubview:addressView];
    [myScroll addSubview:phoneVIew];
    [myScroll addSubview:bottomView];
    
    [self.view_IOS7 addSubview:myScroll];
    
    [titleView release];
    [typeView release];
    [addressView release];
    [phoneVIew release];
    [bottomView release];
    
    self.textFieldArray = [NSArray array];
    
    UIButton *rightBut = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(errorSubmit) title:@"提交"];
	UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
    
    for (int i = 1; i< [[self._errorData._telephone componentsSeparatedByString:@"&"] count]; i++) {
        [self addPhone];
    }
}

- (void)errorSubmit
{
    NSString *errStr = [[[[nameField.text stringByReplacingOccurrencesOfString:@"(" withString:@"0"] stringByReplacingOccurrencesOfString:@")" withString:@"0"] stringByReplacingOccurrencesOfString:@"（" withString:@"0"] stringByReplacingOccurrencesOfString:@"）" withString:@"0"];
    
    if (nameField.text.length == 0) {
        [UIAlertView alertViewWithMessage:@"请填写店铺名称"];
        return;
    }
    NSArray *errArr = [errStr componentsSeparatedByRegex:SHOP_NAME];
    if (errArr.count > 0) {
        [UIAlertView alertViewWithMessage:@"店铺名称您可以输入汉字、英文、数字、小括号"];
        return;
    }
    if (addressField.text.length == 0) {
        [UIAlertView alertViewWithMessage:@"请填写店铺地址"];
        return;
    }
    if (phoneField1.text.length == 0) {
        [UIAlertView alertViewWithMessage:@"请添加店铺的手机号码"];
        return;
    }
    else if (![phoneField1.text isMatchedByRegex:PHONENO]) {
        [UIAlertView alertViewWithMessage:@"请添加正确的11位的手机号码"];
        return;
    }
    if (phoneField2.text.length > 0 && ![phoneField2.text isMatchedByRegex:PHONENO] ) {
        
        [UIAlertView alertViewWithMessage:@"请填写正确的手机号码！"];
        return;
    }
    if (phoneField3.text.length > 0 && ![phoneField3.text isMatchedByRegex:PHONENO] ) {
        
        [UIAlertView alertViewWithMessage:@"请填写正确的手机号码！"];
        return;
    }
    
    if (emailField.text.length > 0 && ![emailField.text isMatchedByRegex:EMAIL] ) {
        
        [UIAlertView alertViewWithMessage:@"请填写正确的邮箱！"];
        return;
    }
    
    if (phoneField.text.length > 0 && ![phoneField.text isMatchedByRegex:PHONENO] ) {
        
        [UIAlertView alertViewWithMessage:@"请填写正确的手机号码！"];
        return;
    }
    
    NSString *phoneStr = phoneField1.text;
    if (phoneField2.text.length > 0) {

        phoneStr = [phoneStr stringByAppendingFormat:@"&%@", phoneField2.text];
    }
    if (phoneField3.text.length > 0) {
        
        phoneStr = [phoneStr stringByAppendingFormat:@"&%@", phoneField3.text];
    }
    
    //农家乐  采摘园 娱乐 其它
    NSString *typeId = nil;
    NSArray *typeArr = [DataClass selectShopType] ;
    ShopType *type = [typeArr objectAtIndex:typeSelect];
    typeId = type._Type_id;
    
    shopData = [[ShopForErrorData alloc] init];
    shopData._userId = [UserLogin sharedUserInfo].userID;
    shopData._name = nameField.text;
    shopData._shopId = self._errorData._shopId;
    shopData._type = typeId;
    shopData._district = self._errorData._district;
    shopData._address = addressField.text;
    shopData._phone = phoneStr;
    shopData._email = emailField.text;
    shopData._telephone = phoneField.text;
    
    ASIFormDataRequest * theRequest = [InterfaceClass shopError:shopData];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredShopErrorResult:) Delegate:self needUserType:Default];
}

- (void)onPaseredShopErrorResult:(NSDictionary *)dic
{
    [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"] tag:0 delegate:self];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initSubTitleView
{
    UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 39) image:[UIImage imageNamed:@"背景-中.png"]];
    
    UIImageView *textView = [UIImageView ImageViewWithFrame:CGRectMake(90, 5, 205, 30) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    
    UIImageView *logoView = [UIImageView ImageViewWithFrame:CGRectMake(100, 18, 4, 4) image:[UIImage imageNamed:@"必要标识.png"]];
    
    UISubLabel *shopTitle = [UISubLabel labelWithTitle:@"店铺名称" frame:CGRectMake(20, 0, 80, 40) font:FontSize28 color:FontColor000000 alignment:NSTextAlignmentLeft];
    
    nameField = [UITextField TextFieldWithFrame:CGRectMake(110, 5, 190, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入店铺名称" font:FontSize24];
    nameField.delegate = self;
    nameField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameField.text = self._errorData._name;
    
    [titleView addSubview:backView];
    [titleView addSubview:textView];
    [titleView addSubview:shopTitle];
    [titleView  addSubview:logoView];
    [titleView addSubview:nameField];
}

- (void)initSubTypeView
{
    UISubLabel *shopTitle = [UISubLabel labelWithTitle:@"类      型" frame:CGRectMake(20, 5, 80, 25) font:FontSize28 color:FontColor000000 alignment:NSTextAlignmentLeft];
    UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 100) image:[UIImage imageNamed:@"背景-中.png"]];
    
    [typeView addSubview:backView];
    [typeView addSubview:shopTitle];
    
    UIScrollView * scroollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 105)];
    [typeView addSubview:scroollV];
    [scroollV release];
    
    int typeIndex = -1;
    NSMutableArray * _mArr = [NSMutableArray array];
    NSArray *typeArr = [DataClass selectShopType] ;
    for (int i = 0; i < [typeArr count]; i++) {
        UIButton * btn =[UIButton buttonWithTag:i image:[UIImage imageNamed:@"单选-01.png"] title:nil imageEdge:UIEdgeInsetsMake(0, 0, 0, 0) frame:CGRectMake(22+i*60, 35, 35, 35) font:nil color:nil target:self action:@selector(clickBut:)];
        [scroollV addSubview:btn];
        [_mArr addObject:btn];
        ShopType * type = [typeArr objectAtIndex:i];
        [scroollV addSubview:[UISubLabel labelWithTitle:type._Type_name frame:CGRectMake(9.5+i*60, 70, 60, 30) font:FontSize20 color:FontColor000000 alignment:NSTextAlignmentCenter]];
        
        if ([type._Type_name isEqualToString:_errorData._type]) {
            typeIndex = i;
        }
        
        scroollV.contentSize = CGSizeMake(9.5+i*60+60, 105);
    }
    self._btnArr = _mArr;
    
    [self selectType:typeIndex];
}

- (void)initSubAddressView
{
    UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 40) image:[UIImage imageNamed:@"店铺报错-00.png"]];
    UISubLabel *adressTitle = [UISubLabel labelWithTitle:@"地      区" frame:CGRectMake(20, 0, 80, 40) font:FontSize28 color:FontColor000000 alignment:NSTextAlignmentLeft];
    self._cityLab = [UISubLabel labelWithTitle:[NSString stringWithFormat:@"%@", self._errorData._district] frame:CGRectMake(100, 0, 200, 40) font:FontSize20 color:FontColor454545 alignment:NSTextAlignmentLeft];
//    UIImageView *pointView = [UIImageView ImageViewWithFrame:CGRectMake(280, 17, 5, 8) image:[UIImage imageNamed:@"箭头-向右.png"]];
    
    UIImageView *addressBackView = [UIImageView ImageViewWithFrame:CGRectMake(13, 40, 294, 40) image:[UIImage imageNamed:@"背景-中.png"]];
    
    UIImageView *addressTextView = [UIImageView ImageViewWithFrame:CGRectMake(90, 45, 205, 30) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    
    UIImageView *logoView = [UIImageView ImageViewWithFrame:CGRectMake(100, 58, 4, 4) image:[UIImage imageNamed:@"必要标识.png"]];
    
    UISubLabel *shopTitle = [UISubLabel labelWithTitle:@"地      址" frame:CGRectMake(20, 40, 80, 40) font:FontSize28 color:FontColor000000 alignment:NSTextAlignmentLeft];
    
    addressField = [UITextField TextFieldWithFrame:CGRectMake(110, 45, 190, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入该店铺详细地址" font:FontSize24];
    addressField.keyboardType = UIKeyboardTypeNumberPad;
    addressField.clearButtonMode = UITextFieldViewModeWhileEditing;
    addressField.delegate = self;
    addressField.text = self._errorData._address;

    [addressView addSubview:backView];
    [addressView addSubview:adressTitle];
    [addressView addSubview:self._cityLab];
    [addressView addSubview:addressBackView];
    [addressView addSubview:addressTextView];
    [addressView addSubview:logoView];
    [addressView addSubview:shopTitle];
    [addressView addSubview:addressField];
}

- (void)initSubPhoneView
{
    UIImageView *phoneBackView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, phoneVIew.frame.size.height) image:[UIImage imageNamed:@"背景-中.png"]];
    
    UIImageView *phoneTextView = [UIImageView ImageViewWithFrame:CGRectMake(90, 5, 205, 30) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    
    UIImageView *logoView = [UIImageView ImageViewWithFrame:CGRectMake(100, 18, 4, 4) image:[UIImage imageNamed:@"必要标识.png"]];
    
    UISubLabel *shopTitle = [UISubLabel labelWithTitle:@"手      机" frame:CGRectMake(20, 0, 80, 40) font:FontSize28 color:FontColor000000 alignment:NSTextAlignmentLeft];
    
    phoneField1 = [UITextField TextFieldWithFrame:CGRectMake(110, 5, 190, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入店铺手机号码" font:FontSize24];
    phoneField1.keyboardType = UIKeyboardTypeNumberPad;
    phoneField1.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneField1.delegate = self;
    phoneField1.text = [[self._errorData._telephone componentsSeparatedByString:@"&"] objectAtIndex:0];

    [phoneVIew addSubview:phoneBackView];
    [phoneVIew addSubview:phoneTextView];
    [phoneVIew addSubview:logoView];
    [phoneVIew addSubview:shopTitle];
    [phoneVIew addSubview:phoneField1];
}

- (void)initSubBottomView
{
    UIImageView *backView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 37) image:[UIImage imageNamed:@"背景-中.png"]];
    UIImageView *backView1 = [UIImageView ImageViewWithFrame:CGRectMake(13, 40, 294, 39) image:[UIImage imageNamed:@"背景-中.png"]];
    UIImageView *backView2 = [UIImageView ImageViewWithFrame:CGRectMake(13, 80, 294, 40) image:[UIImage imageNamed:@"背景-中.png"]];
    
    UIButton *addPhoneBut = [UIButton buttonWithTag:0 frame:CGRectMake(190, 0, 100, 30) target:self action:@selector(addPhone)];
    addPhoneBut.titleLabel.font = FontSize22;
    [addPhoneBut setTitleColor:FontColor000000 forState:UIControlStateNormal];
    [addPhoneBut setTitle:@"添加手机号码" forState:UIControlStateNormal];
    [addPhoneBut setImage:[UIImage imageNamed:@"添加.png"] forState:UIControlStateNormal];
    [addPhoneBut setBackgroundImage:[UIImage imageNamed:@"增加手机-00.png"] forState:UIControlStateNormal];
    [addPhoneBut setBackgroundImage:[UIImage imageNamed:@"增加手机-01.png"] forState:UIControlStateHighlighted];
    [addPhoneBut setImageEdgeInsets:UIEdgeInsetsMake(10, 5, 10, 85)];
    
    UISubLabel *emailLab = [UISubLabel labelWithTitle:@"您的Email" frame:CGRectMake(20, 40, 260, 40) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
    UISubLabel *phoneLab = [UISubLabel labelWithTitle:@"您的手机" frame:CGRectMake(20, 80, 260, 40) font:FontSize26 color:FontColor000000 alignment:NSTextAlignmentLeft];
    
    UIImageView *emailView = [UIImageView ImageViewWithFrame:CGRectMake(90, 45, 205, 30) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    UIImageView *phoneView = [UIImageView ImageViewWithFrame:CGRectMake(90, 85, 205, 30) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    
    emailField = [UISubTextField TextFieldWithFrame:CGRectMake(100, 45, 190, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入正确的邮箱地址" font:FontSize24];
    emailField.keyboardType = UIKeyboardTypeEmailAddress;
    emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailField.delegate = self;
    phoneField = [UISubTextField TextFieldWithFrame:CGRectMake(100, 85, 190, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入正确的11位手机号码" font:FontSize24];
    phoneField.keyboardType = UIKeyboardTypePhonePad;
    phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneField.delegate = self;
    
    [bottomView addSubview:backView];
    [bottomView addSubview:backView1];
    [bottomView addSubview:backView2];
    [bottomView addSubview:addPhoneBut];
    [bottomView addSubview:emailLab];
    [bottomView addSubview:phoneLab];
    [bottomView addSubview:emailView];
    [bottomView addSubview:phoneView];
    [bottomView addSubview:emailField];
    [bottomView addSubview:phoneField];
}

- (void)selectType:(NSInteger)index
{
    UIButton * btn = [self._btnArr objectAtIndex:index];
    [btn setImage:[UIImage imageNamed:@"单选-00.png"] forState:UIControlStateNormal];
    self._preBtn = btn;
    typeSelect = index;
}

- (void)clickBut:(UIButton *)sender
{
    [self._preBtn setImage:[UIImage imageNamed:@"单选-01.png"] forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:@"单选-00.png"] forState:UIControlStateNormal];
    self._preBtn = sender;
}

- (void)selectCity
{
    
}
- (void)deleteBut:(UIButton *)sender
{
    if (sender.tag == 1) {
        [phone1View removeFromSuperview];
        phoneField2.text = Nil;
        phone2View.frame = CGRectMake(0, 40, 320, 40);
    }
    else if (sender.tag == 2)
    {
        [phone2View removeFromSuperview];
        phoneField3.text = nil;
        phone1View.frame = CGRectMake(0, 40, 320, 40);
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    CGRect tempFrame = phoneVIew.frame;
    tempFrame.size.height = tempFrame.size.height - viewhight;
    phoneVIew.frame = tempFrame;
    
    CGRect bFrame = bottomView.frame;
    bFrame.origin.y = bFrame.origin.y - viewhight;
    bottomView.frame = bFrame;
    
    [UIView commitAnimations];
    
    myScroll.contentSize = CGSizeMake(320, bottomView.frame.origin.y + 120);
    phoneViewNum--;
}
- (void)addPhone
{
    if (phoneViewNum == 2) {
        return;
    }
    
    phoneViewNum++;
    
    viewhight = 40;
    CGRect view1Frame = CGRectMake(0, 40, 320, 40);
    CGRect view2Frame = CGRectMake(0, 80, 320, 40);
    NSArray * telphoneArray = [self._errorData._telephone componentsSeparatedByString:@"&"];
    if (!phone1View) {
        phone1View = [[UIView alloc] initWithFrame:view1Frame];
        
        UIImageView *phoneBackView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 40) image:[UIImage imageNamed:@"背景-中.png"]];
        UIImageView *phoneTextView = [UIImageView ImageViewWithFrame:CGRectMake(90, 5, 205, 30) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        phoneField2 = [UITextField TextFieldWithFrame:CGRectMake(110, 5, 155, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入店铺其它手机号码" font:FontSize24];
        phoneField2.keyboardType = UIKeyboardTypeNumberPad;
        phoneField2.clearButtonMode = UITextFieldViewModeWhileEditing;
        phoneField2.delegate = self;
        phoneField2.text = [telphoneArray count]>1?[telphoneArray objectAtIndex:1]:nil;
        
        UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"删除" backImage:[UIImage imageNamed:@"删除.png"] frame:CGRectMake(265, 5, 30, 30) font:FontSize24 color:FontColorFFFFFF target:self action:@selector(deleteBut:)];
        
        [phone1View addSubview:phoneBackView];
        [phone1View addSubview:phoneTextView];
        [phone1View addSubview:phoneField2];
        [phone1View addSubview:but1];
    }
    
    if (!phone2View) {
        phone2View = [[UIView alloc] initWithFrame:view2Frame];
        
        UIImageView *phoneBackView = [UIImageView ImageViewWithFrame:CGRectMake(13, 0, 294, 40) image:[UIImage imageNamed:@"背景-中.png"]];
        UIImageView *phoneTextView = [UIImageView ImageViewWithFrame:CGRectMake(90, 5, 205, 30) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        phoneField3 = [UITextField TextFieldWithFrame:CGRectMake(110, 5, 155, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入店铺其它手机号码" font:FontSize24];
        phoneField3.keyboardType = UIKeyboardTypeNumberPad;
        phoneField3.clearButtonMode = UITextFieldViewModeWhileEditing;
        phoneField3.delegate = self;
        phoneField3.text = [telphoneArray count]>2?[telphoneArray objectAtIndex:2]:nil;

        
        UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom tag:2 title:@"删除" backImage:[UIImage imageNamed:@"删除.png"] frame:CGRectMake(265, 5, 30, 30) font:FontSize24 color:FontColorFFFFFF target:self action:@selector(deleteBut:)];
        
        [phone2View addSubview:phoneBackView];
        [phone2View addSubview:phoneTextView];
        [phone2View addSubview:phoneField3];
        [phone2View addSubview:but2];
    }
    
    if (phoneViewNum == 1) {
        phone1View.frame = view1Frame;
        [phoneVIew addSubview:phone1View];
    }
    else if (phoneViewNum == 2)
    {
        if (phone1View.superview) {
            phone2View.frame = view2Frame;
            [phoneVIew addSubview:phone2View];
        }
        else
        {
            phone1View.frame = view2Frame;
            [phoneVIew addSubview:phone1View];
        }
    }

    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    CGRect tempFrame = phoneVIew.frame;
    tempFrame.size.height = tempFrame.size.height + viewhight;
    phoneVIew.frame = tempFrame;
    
    CGRect bFrame = bottomView.frame;
    bFrame.origin.y = bFrame.origin.y + viewhight;
    bottomView.frame = bFrame;
    
    [UIView commitAnimations];

    myScroll.contentSize = CGSizeMake(320, bottomView.frame.origin.y + 120);
}

#pragma mark - textField UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if (self.keyboardbar == nil) {
		
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view_IOS7];
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
//        return NO;
//    }
	
	if (nameField == textField) {
		
		textFieldMaxLenth = 20;
	}
    else if (addressField == textField) {
    
        textFieldMaxLenth = 40;
    }
    else if (phoneField == textField || phoneField1 == textField || phoneField1 == textField || phoneField2 == textField || phoneField3 == textField ) {
        
		textFieldMaxLenth = 11;
	}
    else if (emailField == textField) {
        
        textFieldMaxLenth = 30;
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


@end
