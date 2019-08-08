//
//  SelectLanguageVC.m
//  LocalizableDemo
//
//  Created by xiao on 2019/3/12.
//  Copyright © 2019年 xiao. All rights reserved.
//

#import "SelectLanguageVC.h"
#import "LanguageHelper.h"

@interface SelectLanguageVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *languages;
@property (assign, nonatomic) NSInteger selectRow;

@end

@implementation SelectLanguageVC

- (NSArray *)languages{
    if (!_languages) {
        _languages = @[
                       @"简体中文",
                       @"繁體中文",
                       @"English"
                       ];
    }
    return _languages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)prepareUI{
    self.title = [LanguageHelper getString:@"SelectLanguage"];
    
    NSString *userLanguage = [[NSUserDefaults standardUserDefaults]stringForKey:@"userLanguage"];
    if ([userLanguage isEqualToString:@"zh-Hans"]) {
        self.selectRow = 0;
    }else if ([userLanguage isEqualToString:@"zh-Hant"]) {
        self.selectRow = 1;
    }else if ([userLanguage isEqualToString:@"en"]) {
        self.selectRow = 2;
    }else{
        self.selectRow = 2;
    }
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.estimatedRowHeight = 44;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView reloadData];
}

#pragma mark - *******UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.languages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelectLanguageVC"];
    cell.backgroundColor = [UIColor whiteColor];
    
    NSString *title = self.languages[indexPath.row];
    cell.textLabel.text = title;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (self.selectRow == indexPath.row) {
        cell.selectionStyle = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *language = @"en";
    switch (indexPath.row) {
        case 0:
            language = @"zh-Hans";
            break;
        case 1:
            language = @"zh-Hant";
            break;
        case 2:
            language = @"en";
            break;
        default:
            break;
    }
    [[LanguageHelper shareInstance]setUserLanguag:language];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"LanguageChanged" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
