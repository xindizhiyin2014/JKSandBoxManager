//
//  JKSandBoxManager.m
//  Pods
//
//  Created by Jack on 2017/7/7.
//
//

#import "JKSandBoxManager.h"

@implementation JKSandBoxManager

+ (nullable NSString *)getPathExtensionWith:(NSString *)filePath
{
    NSString *pathExtension=nil;
    NSRange range = [filePath rangeOfString:@"[^\\.]+$" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        
        pathExtension = [filePath substringWithRange:range];
    }
    
    return pathExtension;
}

+ (nonnull NSArray *)filesWithoutFolderAtPath:(nonnull NSString *)filePath{

    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:filePath];
    //新建数组，存放各个文件路径
    NSMutableArray *files = [NSMutableArray new];
    //遍历目录迭代器，获取各个文件路径
    NSString *filename=nil;
    while (filename = [dirEnum nextObject]) {
        if (![[filename pathExtension] isEqualToString:@""]) {//存在后缀名的文件
            [files addObject:filename];
        }
    }
    return [files copy];
    
}


+ (nonnull NSArray *)filesWithFolderAtPath:(nonnull NSString *)filePath{

    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:filePath];
    //新建数组，存放各个文件路径
    NSMutableArray *files = [NSMutableArray new];
    //遍历目录迭代器，获取各个文件路径
    NSString *filename=nil;
    while (filename = [dirEnum nextObject]) {
        
            [files addObject:filename];
       
    }
    return [files copy];
}

+ (BOOL)isExistsFile:(NSString *)filepath{
    NSFileManager *filemanage = [NSFileManager defaultManager];
    return [filemanage fileExistsAtPath:filepath];
    
}


+ (nonnull NSString *)createDocumentsFilePathWith:(NSString *)fileName{
    
    return [self createDocumentsFilePathWith:nil With:fileName];
}

+ (nonnull NSString *)createDocumentsFilePathWith:(nullable NSString *)nameSpace With:(nullable NSString *)fileName{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    NSString *fileDir =nameSpace?[documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",nameSpace]]:documentsDir;
    NSString *filePath =[fileDir stringByAppendingString:[NSString stringWithFormat:@"/%@",fileName]];
    [[NSFileManager defaultManager]   createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    
    return filePath;


}


+ (NSString *)createCacheFilePathWith:(NSString *)fileName{
    
    return [self createCacheFilePathWith:nil With:fileName];
}

+ (nonnull NSString *)createCacheFilePathWith:(nullable NSString *)nameSpace With:(nullable NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDir = [paths objectAtIndex:0];
    NSString *fileDir =nameSpace?[cacheDir stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",nameSpace]]:cacheDir;
     NSString *filePath=[fileDir stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",fileName]];
    [[NSFileManager defaultManager]   createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
   
    return filePath;
}

+ (BOOL)deleteFile:(nonnull NSString *)filePath{
    NSError *error =nil;
    if (!filePath) {
        return NO;
    }
    
  return [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    
}

+ (BOOL)moveFileFrom:(nonnull NSString *)originFilePath to:(nonnull NSString *)targetFilePath{
    NSError *error = nil;
    if (!(originFilePath&&targetFilePath)) {
        return NO;
    }
    
    if ([self isExistsFile:targetFilePath]) {
        [self deleteFile:targetFilePath];
    }
    
    return [[NSFileManager defaultManager] moveItemAtPath:originFilePath toPath:targetFilePath error:&error];
}


+ (BOOL)copyFileFrom:(nonnull NSString *)originFilePath to:(nonnull NSString *)targetFilePath{
    NSError *error = nil;
    if (!(originFilePath&&targetFilePath)) {
        return NO;
    }
    
    if ([self isExistsFile:targetFilePath]) {
        [self deleteFile:targetFilePath];
    }
    
    return [[NSFileManager defaultManager] copyItemAtPath:originFilePath toPath:targetFilePath error:&error];


}

@end
