//
//  ViewController.m
//  uidemo
//
//  Created by user on 2021/3/24.
//

#import "ViewController.h"
#import "ClickTextScrollView.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface ViewController ()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) ClickTextScrollView *csView;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.csView = [[ClickTextScrollView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, SCREEN_HEIGHT * 0.25, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.2)];
    
    // init Content
    CSContent *contentModel = [[CSContent alloc] init];
    contentModel.content = [self getTempStr];
    contentModel.fontColor = [UIColor whiteColor];
    contentModel.fontSize = 17.0;
    contentModel.bgColor = [UIColor grayColor];
    contentModel.autoHeight = YES;
    [self.csView setContentText:contentModel];
    
    // add Click Content
    CSClickContent * clickModel = [[CSClickContent alloc] init];
    clickModel.content = @"Baidu";
    clickModel.fontColor = [UIColor blueColor];
    clickModel.coverColor = [UIColor redColor];
    clickModel.withUnderLine = YES;
    clickModel.clickTextViewPartBlock = ^(NSString *clickText) {
        NSLog(@"click=%@", clickText);
    };
    [self.csView addClickText:clickModel];
    
    CSClickContent * clickModel2 = [[CSClickContent alloc] init];
    clickModel2.content = @"Keyboard";
    clickModel2.fontColor = [UIColor greenColor];
    clickModel2.coverColor = [UIColor purpleColor];
    clickModel2.withUnderLine = NO;
    clickModel2.clickTextViewPartBlock = ^(NSString *clickText) {
        NSLog(@"click=%@", clickText);
    };
    [self.csView addClickText:clickModel2];
    
    [self.view addSubview:self.csView];
}

# pragma mark - init

- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        _btn.backgroundColor = [UIColor blueColor];
        [_btn setTitle:@"同意" forState:UIControlStateNormal];
    }
    return _btn;
}

- (NSString *) getTempStr {
    return @"Baidu Global Business Unit (GBU) is responsible for Baidu's international products and services for markets outside of China. Baidu GBU's product portfolio includes keyboard apps Simeji and Facemoji Keyboard, content recommendation platform popIn, augmented reality network OmniAR, Japanese smart projector popIn Aladdin, and ad platform MediaGo, which is focused on Chinese advertisers looking to reach overseas users";
}

@end
