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
        
        it(@"getFileNameWithFilePath", ^{
            NSString *filePath = @"123.png";
            [[[JKSandBoxManager getFileNameWithFilePath:filePath] should] equal:filePath];
            
            NSString *filePath1 = @"temp/123.png";
            [[[JKSandBoxManager getFileNameWithFilePath:filePath1] should] equal:@"123.png"];
        });
        
        it(@"getFileNameWithNoExtWithfilePath", ^{
            NSString *filePath = @"123.png";
            [[[JKSandBoxManager getFileNameWithNoExtWithFilePath:filePath] should] equal:@"123"];
        });
        
        
        
        
        it(@"isExistsFile", ^{
            [[theValue([JKSandBoxManager isExistsFile:@"123.png"]) shouldNot] equal:theValue(YES)];
            
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"abcd.png" ofType:nil];//该图片已经导入到工程中
             [[theValue([JKSandBoxManager isExistsFile:filePath]) should] equal:theValue(YES)];
            
        });
        
        it(@"createDocumentsFilePathWith:", ^{
            NSString *str = @"nnnnnnnnnnnnn";
            NSData *data =[str dataUsingEncoding:kCFStringEncodingUTF8];
            NSString *filePath = [JKSandBoxManager createDocumentsFilePathWithFileName:@"nn.txt" data:data];
            [[filePath shouldNot] beNil];
            [[theValue([JKSandBoxManager isExistsFile:filePath]) should] equal:theValue(YES)];
            
        });
        
        it(@"createCacheFilePathWith:", ^{
            NSString *str = @"mmmmmmmmmmmmmmmmmmmmmmmmmm";
            NSData *data =[str dataUsingEncoding:kCFStringEncodingUTF8];
            NSString *filePath = [JKSandBoxManager createCacheFilePathWithFileName:@"mmm.txt" data:data];
            [[filePath shouldNot] beNil];
            [[theValue([JKSandBoxManager isExistsFile:filePath]) should] equal:theValue(YES)];
            
        });
        
        
        it(@"deleteFile:", ^{
            
            NSString *str = @"mmmmmmmmmmmmmmmmmmmmmmmmmmjjjjjjjjjjjjjjj";
            NSData *data =[str dataUsingEncoding:kCFStringEncodingUTF8];
            NSString *filePath = [JKSandBoxManager createCacheFilePathWithFileName:@"jjj.txt" data:data];
            [[filePath shouldNot] beNil];
            [[theValue([JKSandBoxManager isExistsFile:filePath]) should] equal:theValue(YES)];
            [[theValue([JKSandBoxManager deleteFile:filePath]) should] equal:theValue(YES)];
            [[theValue([JKSandBoxManager isExistsFile:filePath]) shouldNot] equal:theValue(YES)];
            
        });
        
        it(@"moveFielFrom: to:", ^{
            NSString *str = @"mmmmmmmmmmmmmmmmmmmmmmmmmmjjjjjjjjjjjjjjj";
            NSData *data =[str dataUsingEncoding:kCFStringEncodingUTF8];

            NSString *filePath = [JKSandBoxManager createCacheFilePathWithFileName:@"name.txt" data:data];
            [[filePath shouldNot] beNil];
            NSString *nameSpacePath = [JKSandBoxManager createDocumentsFilePathWithFolderName:@"nameSpace"];
            [[nameSpacePath shouldNot] beNil];
            NSString *targetFilePath = [NSString stringWithFormat:@"%@/name.txt",nameSpacePath];
            [[theValue([JKSandBoxManager moveFileFrom:filePath to:targetFilePath]) should] equal:theValue(YES)];
           [[theValue([JKSandBoxManager isExistsFile:filePath]) shouldNot] equal:theValue(YES)];
          [[theValue([JKSandBoxManager isExistsFile:targetFilePath]) should] equal:theValue(YES)];


        });
        
        it(@"copyFielFrom: to:", ^{
            NSString *str = @"mmmmmmmmmmmmmmmmmmmmmmmmmmjjjjjjjjjjjjjjj";
            NSData *data =[str dataUsingEncoding:kCFStringEncodingUTF8];
            NSString *filePath = [JKSandBoxManager createCacheFilePathWithFileName:@"jackName.txt" data:data];
            [[filePath shouldNot] beNil];
            NSString *nameSpacePath = [JKSandBoxManager createDocumentsFilePathWithFolderName:@"nameSpace1"];
            [[nameSpacePath shouldNot] beNil];
            NSString *targetFilePath = [NSString stringWithFormat:@"%@/jackName.txt",nameSpacePath];
            [[theValue([JKSandBoxManager copyFileFrom:filePath to:targetFilePath]) should] equal:theValue(YES)];
            [[theValue([JKSandBoxManager isExistsFile:filePath]) should] equal:theValue(YES)];
            [[theValue([JKSandBoxManager isExistsFile:targetFilePath]) should] equal:theValue(YES)];
            
            
        });
        
        static NSString *folderePath =nil;
beforeEach(^{
    
    folderePath = [JKSandBoxManager createCacheFilePathWithFolderName:@"testfolder"];
    [[folderePath shouldNot] beNil];
    NSString *str = @"mmmmmmmmmmmmmmmmmmmmmmmmmmjjjjjjjjjjjjjjj";
    NSData *data =[str dataUsingEncoding:kCFStringEncodingUTF8];
    NSString *filePath = [JKSandBoxManager createCacheFilePathWithNameSpace:@"testfolder" fileName:@"testFile.txt" data:data];
    [[filePath shouldNot] beNil];
    NSString *folderPath1 = [NSString stringWithFormat:@"%@/folder",folderePath];
    folderPath1 = [JKSandBoxManager createDirectoryWithPath:folderPath1];
    [[folderPath1 shouldNot] beNil];
});
        it(@"filesWithoutFolderAtPath", ^{
            NSArray *files = [JKSandBoxManager filesWithoutFolderAtPath:folderePath];
            [[theValue(files.count) should] equal:theValue(1)];
  
        });
        
        it(@"filesWithFolderAtPath", ^{
            NSArray *files = [JKSandBoxManager filesWithFolderAtPath:folderePath];
            [[theValue(files.count) should] equal:theValue(2)];
        });
        
        it(@"foldersWithFilePath", ^{
            NSArray *folders = [JKSandBoxManager foldersAtPath:folderePath];
            [[theValue(folders.count) should] equal:theValue(1)];
        });
        

        
    });
});

SPEC_END
