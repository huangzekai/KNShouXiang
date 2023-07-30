//
//  KNPrivacyViewController.m
//  KNMorseCode
//
//  Created by kennykhuang on 2023/5/7.
//

#import "KNPrivacyViewController.h"

@interface KNPrivacyViewController ()
@property (nonatomic, strong) UITextView *privacyTextView;
@end

@implementation KNPrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"隐私协议";
    
    UITextView *privacyTextView = [[UITextView alloc] initWithFrame:self.view.bounds];
    privacyTextView.editable = NO; // 不可编辑
    privacyTextView.font = [UIFont systemFontOfSize:14];
    privacyTextView.backgroundColor = [UIColor clearColor];
    self.privacyTextView = privacyTextView;
    
    // 这里是隐私政策的内容，请根据需要修改
    NSString *privacyText = @"  欢迎您访问我们的产品。 APP （包括App等产品提供的服务，以下简称“产品和服务”）是由 iOS （以下简称“我们”）开发并运营的。 确保用户的数据安全和隐私保护是我们的首要任务， 本隐私政策载明了您访问和使用我们的产品和服务时所收集的数据及其处理方式。\n    请您在继续使用我们的产品前务必认真仔细阅读并确认充分理解本隐私政策全部规则和要点， 一旦您选择使用，即视为您同意本隐私政策的全部内容，同意我们按其收集和使用您的相关信息。 如您在在阅读过程中，对本政策有任何疑问，可联系我们的客服咨询， 请通过 kevinkhuang@foxmail.com 或产品中的反馈方式与我们取得联系。 如您不同意相关协议或其中的任何条款的，您应停止使用我们的产品和服务。\n\n   本隐私政策帮助您了解以下内容：\n一、我们如何收集和使用您的个人信息；\n二、我们如何存储和保护您的个人信息；\n三、我们如何共享、转让、公开披露您的个人信息；\n\n一、我们如何收集和使用您的个人信息\n 个人信息是指以电子或者其他方式记录的能够单独或者与其他信息， 结合识别特定自然人身份或者反映特定自然人活动情况的各种信息。 由于我们的产品和服务并不需要此类信息，因此很高兴的告知您， 我们不会收集关于您的任何个人信息。\n\n二、我们如何存储和保护您的个人信息\n作为一般规则，我们仅在实现信息收集目的所需的时间内保留您的个人信息。 我们会在对于管理与您之间的关系严格必要的时间内保留您的个人信息 （例如，当您开立帐户，从我们的产品获取服务时）。 出于遵守法律义务或为证明某项权利或合同满足适用的诉讼时效要求的目的， 我们可能需要在上述期限到期后保留您存档的个人信息，并且无法按您的要求删除。\n\n三、我们如何共享、转让、公开披露您的个人信息\n在管理我们的日常业务活动所需要时，为追求合法利益以更好地服务客户， 我们将合规且恰当的使用您的个人信息。出于对业务和各个方面的综合考虑， 我们仅自身使用这些数据，不与任何第三方分享。\n我们可能会根据法律法规规定，或按政府主管部门的强制性要求，对外共享您的个人信息。 在符合法律法规的前提下，当我们收到上述披露信息的请求时，我们会要求必须出具与之相应的法律文件，如传票或调查函。 我们坚信，对于要求我们提供的信息，应该在法律允许的范围内尽可能保持透明。\n\n在以下情形中，共享、转让、公开披露您的个人信息无需事先征得您的授权同意：\n1、与国家安全、国防安全直接相关的；\n2、与犯罪侦查、起诉、审判和判决执行等直接相关的；\n3、出于维护您或其他个人的生命、财产等重大合法权益但又很难得到本人同意的；\n4、您自行向社会公众公开的个人信息；\n5、从合法公开披露的信息中收集个人信息的，如合法的新闻报道、政府信息公开等渠道。\n6、根据个人信息主体要求签订和履行合同所必需的；\n7、用于维护所提供的产品或服务的安全稳定运行所必需的，例如发现、处置产品或服务的故障；\n8、法律法规规定的其他情形。";
    
    privacyTextView.text = privacyText;
    [self.view addSubview:privacyTextView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.privacyTextView.frame = CGRectInset(self.view.bounds, 15, 15);
}

@end
