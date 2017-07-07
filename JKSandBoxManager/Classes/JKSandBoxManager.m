//
//  JKSandBoxManager.m
//  Pods
//
//  Created by Jack on 2017/7/7.
//
//

#import "JKSandBoxManager.h"

@implementation JKSandBoxManager

+(nullable NSString *)getPathExtensionWith:(NSString *)filePath
{
    NSString *pathExtension=nil;
    NSRange range = [filePath rangeOfString:@"[^\\.]+$" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        
        pathExtension = [filePath substringWithRange:range];
    }
    
    return pathExtension;
}

+(BOOL)isExistsFile:(NSString *)filepath{
    NSFileManager *filemanage = [NSFileManager defaultManager];
    return [filemanage fileExistsAtPath:filepath];
    
}


+(NSString *)createDocumentsFilePathWith:(NSString *)fileName{
    
    return [self createDocumentsFilePathWith:nil With:fileName];
}

+(nonnull NSString *)createDocumentsFilePathWith:(nullable NSString *)nameSpace With:(nullable NSString *)fileName{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    NSString *fileDir =nameSpace?[documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",nameSpace]]:documentsDir;
    [[NSFileManager defaultManager]   createDirectoryAtPath:fileDir withIntermediateDirectories:YES attributes:nil error:nil];
    
    [[NSFileManager defaultManager]   createDirectoryAtURL:[NSURL URLWithString:fileDir] withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *filePath =[fileDir stringByAppendingString:[NSString stringWithFormat:@"/%@",fileName]];
    return filePath;


}


+(NSString *)createCacheFilePathWith:(NSString *)fileName{
    
    return [self createCacheFilePathWith:nil With:fileName];
}

+(nonnull NSString *)createCacheFilePathWith:(nullable NSString *)nameSpace With:(nullable NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDir = [paths objectAtIndex:0];
    NSString *fileDir =nameSpace?[cacheDir stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",nameSpace]]:cacheDir;
    [[NSFileManager defaultManager]   createDirectoryAtPath:fileDir withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *filePath=[fileDir stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",fileName]];
    
    return filePath;
}

- (BOOL)deleteFile:(nonnull NSString *)filePath{
    NSError *error =nil;
    if (!filePath) {
        return NO;
    }
  return [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    
}

- (BOOL)moveFielFrom:(nonnull NSString *)originFilePath to:(nonnull NSString *)targetFilePath{
    NSError *error = nil;
    if (!(originFilePath&&targetFilePath)) {
        return NO;
    }
    return [[NSFileManager defaultManager] moveItemAtPath:originFilePath toPath:targetFilePath error:&error];
}

@end
