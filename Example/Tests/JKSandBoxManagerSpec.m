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
            [[theValue([JKSandBoxManager moveFileFrom:filePath to:targetFilePath]) should] equal:theValue(YES)];
           [[theValue([JKSandBoxManager isExistsFile:filePath]) shouldNot] equal:theValue(YES)];
          [[theValue([JKSandBoxManager isExistsFile:targetFilePath]) should] equal:theValue(YES)];


        });
        
        it(@"copyFielFrom: to:", ^{
            NSString *filePath = [JKSandBoxManager createCacheFilePathWith:@"jackName.txt"];
            [[filePath shouldNot] beNil];
            NSString *nameSpacePath = [JKSandBoxManager createDocumentsFilePathWith:@"nameSpace1"];
            [[nameSpacePath shouldNot] beNil];
            NSString *targetFilePath = [NSString stringWithFormat:@"%@/jackName.txt",nameSpacePath];
            [[theValue([JKSandBoxManager copyFileFrom:filePath to:targetFilePath]) should] equal:theValue(YES)];
            [[theValue([JKSandBoxManager isExistsFile:filePath]) should] equal:theValue(YES)];
            [[theValue([JKSandBoxManager isExistsFile:targetFilePath]) should] equal:theValue(YES)];
            
            
        });
        
        static NSString *folderePath =nil;
beforeEach(^{
    folderePath = [JKSandBoxManager createCacheFilePathWith:@"testfolder"];
    [[folderePath shouldNot] beNil];
    
    NSString *filePath = [JKSandBoxManager createCacheFilePathWith:@"testfolder" With:@"testFile.txt"];
    [[filePath shouldNot] beNil];
    
    NSString *folderePath1 = [JKSandBoxManager createCacheFilePathWith:@"testfolder" With:@"folder"];
    [[folderePath1 shouldNot] beNil];
});
        it(@"filesWithoutFolderAtPath", ^{
            NSArray *files = [JKSandBoxManager filesWithoutFolderAtPath:folderePath];
            [[theValue(files.count) should] equal:theValue(1)];
  
        });
        
        it(@"filesWithFolderAtPath", ^{
            NSArray *files = [JKSandBoxManager filesWithFolderAtPath:folderePath];
            [[theValue(files.count) should] equal:theValue(2)];
        });

        
    });
});

SPEC_END
