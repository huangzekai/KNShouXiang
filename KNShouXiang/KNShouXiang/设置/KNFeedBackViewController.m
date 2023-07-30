//
//  KNFeedBackViewController.m
//  KNMorseCode
//
//  Created by kenny on 2023/5/4.
//

#import "KNFeedBackViewController.h"
#import "KNGlobalDefine.h"
#import "UIView+JKFrame.h"
#import <Bugly/Bugly.h>
#import "KNToast.h"

#define USER_REPORT_KEY @"userReportKey"

@interface KNFeedBackViewController ()<UITextViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UILabel *placeHolderLabel;
@end

@implementation KNFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    
    [self addTapGesture];
    
    [self.view addSubview:self.textView];
    
    [self.view addSubview:self.textField];

    [self.view addSubview:self.submitButton];
}

- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self endEidting];
}

#pragma mark - 属性

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 20, self.view.jk_width - 30, self.view.jk_height / 3)];
        _textView.layer.cornerRadius = 8;
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.textColor = [UIColor blackColor];
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.scrollEnabled = YES;
        _textView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _textView.delegate = self;
        _textView.editable = YES;
        _textView.returnKeyType = UIReturnKeyDone;
        self.placeHolderLabel.jk_left = 5;
        self.placeHolderLabel.jk_top = 6;
        [_textView addSubview:self.placeHolderLabel];
    }
    return _textView;
}

- (UITextField *)textField {
    if (!_textField) {
        UITextField *contactTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.textView.frame) + 20, CGRectGetWidth(self.view.frame) - 30, 40)];
        contactTextField.borderStyle = UITextBorderStyleRoundedRect;
        contactTextField.placeholder = @"请输入您的联系方式(可选)";
        contactTextField.font = [UIFont systemFontOfSize:14];
        contactTextField.textColor = [UIColor blackColor];
        contactTextField.returnKeyType = UIReturnKeyDone;
        contactTextField.delegate = self;
        _textField = contactTextField;
    }
    return _textField;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        // 创建提交按钮
        _submitButton = [[UIButton alloc] initWithFrame:CGRectMake(20, self.textField.jk_bottom + 20, [UIScreen mainScreen].bounds.size.width - 40, 40)];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        _submitButton.layer.cornerRadius = 20;
        _submitButton.titleLabel.textColor = [UIColor whiteColor];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_submitButton setBackgroundColor:[UIColor colorWithRed:0.1058 green:0.722 blue:0.302 alpha:1]];
    }
    return _submitButton;
}

- (UILabel *)placeHolderLabel {
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc] init];
        _placeHolderLabel.font = [UIFont systemFontOfSize:14];
        _placeHolderLabel.textColor = [UIColor jk_colorWithWholeRed:153 green:153 blue:153];
        _placeHolderLabel.text = @"请输入您的宝贵意见";
        [_placeHolderLabel sizeToFit];
        _placeHolderLabel.jk_top = 6;
        _placeHolderLabel.jk_left = 4;
    }
    return _placeHolderLabel;
}

#pragma mark - 点击事件

- (void)submitButtonTapped {
    NSString *content =  [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (content.length > 0) {
        NSInteger value = [[[NSUserDefaults standardUserDefaults] objectForKey:USER_REPORT_KEY] intValue];
        if (value == 0) {
            value = arc4random_uniform(1000);
        } else {
            value = value + 1;
        }
        NSString *contact = self.textField.text ? : @"";
        NSString *domain = [NSString stringWithFormat:@"userReport%ld", value];
        NSError *error = [[NSError alloc] initWithDomain:domain code:value userInfo:@{@"userInfo":self.textView.text, @"contact" :contact}];
        [Bugly reportError:error];
        
        [[NSUserDefaults standardUserDefaults] setObject:@(value) forKey:USER_REPORT_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSLog(@"用户反馈value:%ld", value);
        
        [KNToast showSuccessToastWithText:@"提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [KNToast showFailToastWithText:@"请输入反馈内容"];
    }
}

- (void)singleTapAction {
    [self endEidting];
}

- (void)endEidting {
    [self.textView endEditing:YES];
    [self.textField endEditing:YES];
    [self.textView resignFirstResponder];
    [self.textField resignFirstResponder];
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length <= 0) {
        self.placeHolderLabel.hidden = NO;
    } else {
        self.placeHolderLabel.hidden = YES;
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    self.placeHolderLabel.hidden = textView.text.length > 0;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
    }
    return YES;
}
@end
