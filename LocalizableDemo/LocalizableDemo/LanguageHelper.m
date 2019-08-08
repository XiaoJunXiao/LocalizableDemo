//
//  LanguageHelper.m
//  LocalizableDemo
//
//  Created by xiao on 2018/3/10.
//  Copyright © 2018年 xiao. All rights reserved.
//

#import "LanguageHelper.h"

@implementation LanguageHelper

static LanguageHelper *instance = nil;

+ (instancetype)shareInstance {
    @synchronized(self){
        if (nil == instance) {
            instance = [[LanguageHelper alloc] init];
            instance.def = [NSUserDefaults standardUserDefaults];
        }
    }
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:zone] init];
    });
    return instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return instance;
}

+ (NSString *)getString:(NSString *)key{
    NSBundle *bundle = [LanguageHelper shareInstance].bundle;
    NSString *str = [bundle localizedStringForKey:key value:nil table:@"Localizable"];
    return str;
}

- (void)initUserLanguage{
    NSString *string = [self.def valueForKey:@"userLanguage"];
    if (string == nil || string.length == 0) {
        NSArray *languages = [self.def arrayForKey:@"AppleLanguages"];
        if (languages.count != 0) {
            NSString *current = [languages objectAtIndex:0];
            if (current != nil) {
                string = current;
            }
        }
        if ([string hasPrefix:@"en"]) {//英文
            string = @"en";
            self.isEn = YES;
        }else if ([string hasPrefix:@"zh-Hans"]) {//简体
            string = @"zh-Hans";
            self.isEn = NO;
        }else if ([string hasPrefix:@"zh-Hant"]) {//繁体
            string = @"zh-Hant";
            self.isEn = NO;
        }else{
            string = @"en";
            self.isEn = YES;
        }
        [self.def setValue:string forKey:@"userLanguage"];
        [self.def synchronize];
    }else{
        self.isEn = [string isEqualToString:@"en"];
    }
    NSString *path = [[NSBundle mainBundle]pathForResource:string ofType:@"lproj"];
    self.bundle = [NSBundle bundleWithPath:path];
}

//设置用户选择的语言类型
- (void)setUserLanguag:(NSString*)language{
    NSString *path = [[NSBundle mainBundle]pathForResource:language ofType:@"lproj"];
    self.bundle = [NSBundle bundleWithPath:path];
    [self.def setValue:language forKey:@"userLanguage"];
    [self.def synchronize];
}

@end
