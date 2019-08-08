//
//  ViewController.m
//  LocalizableDemo
//
//  Created by Xiao on 2019/8/8.
//  Copyright © 2019 Xiao. All rights reserved.
//

#import "ViewController.h"
#import "LanguageHelper.h"
#import "SelectLanguageVC.h"
#import <Photos/Photos.h>

@interface ViewController ()

@property (weak, nonatomic) UIButton *languageBtn;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation ViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"LanguageChanged" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(selectLanguage) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    btn.frame = CGRectMake(0, 0, 60, 25);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.languageBtn = btn;
    
    [self prepareText];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(prepareText) name:@"LanguageChanged" object:nil];
}

- (void)prepareText{
    self.title = [LanguageHelper getString:@"LocalizableDemo"];
    [self.languageBtn setTitle:[LanguageHelper getString:@"Language"] forState:UIControlStateNormal];
    self.testLabel.text = [LanguageHelper getString:@"TestText"];
    
    [self getPhotosPermission];
}

//权限国际化只能根据系统语言来自动匹配对应的文字，不受App本地设置影响
- (void)getPhotosPermission{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusNotDetermined){
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                NSLog(@"PHAuthorizationStatusAuthorized");
            }else{
                NSLog(@"PHAuthorizationStatusUnknown");
            }
        }];
    }else if(status == PHAuthorizationStatusAuthorized){
        NSLog(@"PHAuthorizationStatusAuthorized");
    }
}

- (void)selectLanguage{
    SelectLanguageVC *vc = [[SelectLanguageVC alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
