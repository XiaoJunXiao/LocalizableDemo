//
//  LanguageHelper.h
//  CafeBox
//
//  Created by xiao on 2018/3/10.
//  Copyright © 2018年 Amethystum. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LanguageType){
    Auto = 0,
    English,
    Chinese,
    
};

@interface LanguageHelper : NSObject

@property (strong, nonatomic) NSBundle *bundle;
@property (strong, nonatomic) NSUserDefaults *def;
@property (assign, nonatomic) BOOL isEn;

+ (instancetype)shareInstance;

+ (NSString *)getString:(NSString *)key;

- (void)initUserLanguage;

- (void)setUserLanguag:(NSString*)language;

@end
