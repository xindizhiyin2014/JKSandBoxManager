//
//  JKSandBoxManagerSpec.m
//  JKSandBoxManager
//
//  Created by Jack on 2017/7/7.
//  Copyright 2017年 HHL110120. All rights reserved.
//

#import <Kiwi/Kiwi.h>

#import <JKSandBoxManager/JKSandBoxManager.h>


SPEC_BEGIN(JKSandBoxManagerSpec)

describe(@"JKSandBoxManager", ^{
    context(@"test functions", ^{
       it(@"getPathExtensionWith", ^{
           NSString *filePath = @"123.png";
           [[[JKSandBoxManager getPathExtensionWith:filePath] should] equal:@"png"];
       });
        
        it(@"isExistsFile", ^{
            [[theValue([JKSandBoxManager isExistsFile:@"123.png"]) shouldNot] equal:theValue(YES)];
            
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"abcd.png" ofType:nil];//该图片已经导入到工程中
             [[theValue([JKSandBoxManager isExistsFile:filePath]) should] equal:theValue(YES)];
            
        });
        
        it(@"createDocumentsFilePathWith:", ^{
            NSString *filePath = [JKSandBoxManager createDocumentsFilePathWith:@"nn.txt"];
            [[filePath shouldNot] beNil];
            [[theValue([JKSandBoxManager isExistsFile:filePath]) should] equal:theValue(YES)];
            
        });
        
        it(@"createCacheFilePathWith:", ^{
            NSString *filePath = [JKSandBoxManager createCacheFilePathWith:@"mmm.txt"];
            [[filePath shouldNot] beNil];
            [[theValue([JKSandBoxManager isExistsFile:filePath]) should] equal:theValue(YES)];
            
        });
        
        it(@"deleteFile:", ^{
            
            NSString *filePath = [JKSandBoxManager createCacheFilePathWith:@"jjj.txt"];
            [[filePath shouldNot] beNil];

            [[theValue([JKSandBoxManager deleteFile:filePath]) should] equal:theValue(YES)];
            [[theValue([JKSandBoxManager isExistsFile:filePath]) shouldNot] equal:theValue(YES)];
            
        });
        
        it(@"moveFielFrom: to:", ^{
            NSString *filePath = [JKSandBoxManager createCacheFilePathWith:@"name.txt"];
            [[filePath shouldNot] beNil];
            NSString *nameSpacePath = [JKSandBoxManager createDocumentsFilePathWith:@"nameSpace"];
            [[nameSpacePath shouldNot] beNil];
            NSString *targetFilePath = [NSString stringWithFormat:@"%@/name.txt",nameSpacePath];
            [[theValue([JKSandBoxManager moveFielFrom:filePath to:targetFilePath]) should] equal:theValue(YES)];
           [[theValue([JKSandBoxManager isExistsFile:filePath]) shouldNot] equal:theValue(YES)];
          [[theValue([JKSandBoxManager isExistsFile:targetFilePath]) should] equal:theValue(YES)];


        });
        
    });
});

SPEC_END
