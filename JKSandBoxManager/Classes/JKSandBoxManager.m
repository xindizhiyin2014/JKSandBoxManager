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
        if (![filename isEqualToString:@".DS_Store"]) {//存在后缀名的文件
            [files addObject:filename];
        }
       
    }
    return [files copy];
}

+ (BOOL)isExistsFile:(NSString *)filepath{
    NSFileManager *filemanage = [NSFileManager defaultManager];
    return [filemanage fileExistsAtPath:filepath];
    
}


+ (nullable NSString *)createDocumentsFilePathWithFileName:(nullable NSString *)fileName data:(nullable NSData *)data{
    
    return [self createDocumentsFilePathWithNameSpace:nil fileName:fileName data:data];
}

+ (nullable NSString *)createDocumentsFilePathWithNameSpace:(NSString *)nameSpace fileName:(NSString *)fileName data:(NSData *)data{

    if (!data) {
        return nil;
    }
    
    NSString *fileDir =[self createDocumentsFilePathWithFolderName:nameSpace];
    NSString *filePath =[fileDir stringByAppendingString:[NSString stringWithFormat:@"/%@",fileName]];
    [data writeToFile:filePath atomically:YES];
    return filePath;
}


+ (nullable NSString *)createCacheFilePathWithFileName:(NSString *)fileName data:(NSData *)data{
    
    return [self createCacheFilePathWithNameSpace:nil fileName:fileName data:data];
}

+ (nullable NSString *)createCacheFilePathWithNameSpace:(NSString *)nameSpace fileName:(NSString *)fileName data:(NSData *)data{
    if (!data) {
        return nil;
    }
    
    NSString *fileDir =[self createCacheFilePathWithFolderName:nameSpace];
    NSString *filePath =[fileDir stringByAppendingString:[NSString stringWithFormat:@"/%@",fileName]];
    [data writeToFile:filePath atomically:YES];
    return filePath;
}

+ (nullable NSString *)createCacheFilePathWithFolderName:(nullable NSString *)folderName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDir = [paths objectAtIndex:0];
    NSString *folderPath=folderName?[cacheDir stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",folderName]]:cacheDir;
    if ([self isExistsFile:folderPath]) {
        return folderPath;
    }
    [[NSFileManager defaultManager]   createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    return folderPath;
    
}


+ (nullable NSString *)createDocumentsFilePathWithFolderName:(nullable NSString *)folderName{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    NSString *folderPath =folderName?[documentsDir stringByAppendingString:[NSString stringWithFormat:@"/%@",folderName]]:documentsDir;
    if ([self isExistsFile:folderPath]) {
        return folderPath;
    }
    [[NSFileManager defaultManager]   createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    return folderPath;
}

+ (nonnull NSString *)createDirectoryWithPath:(nonnull NSString *)filePath{
    if ([self isExistsFile:filePath]) {
        return filePath;
    }
    
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

+ (nonnull NSString *)appendDocumentsFilePathWithFileName:(nullable NSString *)fileName{

    return [self appendDocumentsFilePathWithFolderName:nil FileName:fileName];
}

+ (nonnull NSString *)appendDocumentsFilePathWithFolderName:(nullable NSString *)folderName FileName:(nullable NSString *)fileName;{
    
    if (!folderName || [folderName isEqualToString:@""]) {
     return [NSString stringWithFormat:@"%@/%@",JKSandBoxPathDocument,fileName];
    }
    
    return [NSString stringWithFormat:@"%@/%@",[self createDocumentsFilePathWithFolderName:folderName],fileName];
}

+ (nonnull NSString *)appendCacheFilePathWithFileName:(nullable NSString *)fileName{
    
    return [self appendCacheFilePathWithFolderName:nil FileName:fileName];
}

+ (nonnull NSString *)appendCacheFilePathWithFolderName:(nullable NSString *)folderName FileName:(nullable NSString *)fileName{
   
    if (!folderName || [folderName isEqualToString:@""]) {
        return [NSString stringWithFormat:@"%@/%@",JKSandBoxPathCache,fileName];
    }
    
    return [NSString stringWithFormat:@"%@/%@",[self createCacheFilePathWithFolderName:folderName],fileName];

}


+ (nonnull NSString *)appendTemporaryFilePathWithFileName:(nullable NSString *)fileName{
return [NSString stringWithFormat:@"%@/%@",JKSandBoxPathTemp,fileName];
}
    
    + (nullable NSString *)pathWithFileName:(nonnull NSString *)fileName podName:(nonnull NSString *)podName ofType:(nullable NSString *)ext{
        
        if (!fileName ) {
            return nil;
        }
        
        NSBundle * pod_bundle =[self bundleWithPodName:podName];
        if (!pod_bundle.loaded) {
            [pod_bundle load];
        }
        NSString *filePath =[pod_bundle pathForResource:fileName ofType:ext];
        return filePath;
    }
    
    
+ (nullable NSBundle *)bundleWithPodName:(nonnull NSString *)podName{
    
    if (!podName) {
        return nil;
    }
    
    NSBundle * bundle = [NSBundle bundleForClass:NSClassFromString(podName)];
    NSURL * url = [bundle URLForResource:podName withExtension:@"bundle"];
    NSArray *frameWorks = [NSBundle allFrameworks];
    if (!url) {
        for (NSBundle *tempBundle in frameWorks) {
            url = [tempBundle URLForResource:podName withExtension:@"bundle"];
            if (url) {
                break;
            }
        }
    }
    NSBundle * pod_bundle =[NSBundle bundleWithURL:url];
    if (!pod_bundle.loaded) {
        [pod_bundle load];
    }
    
    return pod_bundle;
}
    
+ (nullable id)loadNibName:(nonnull NSString *)nibName podName:(nonnull NSString *)podName{
    NSBundle *bundle =[self  bundleWithPodName:podName];
    id object = [[bundle loadNibNamed:nibName owner:nil options:nil] lastObject];
    return object;
}
    
+ (nullable UIStoryboard *)storyboardWithName:(nonnull NSString *)name podName:(nonnull NSString *)podName{
    NSBundle *bundle =[self  bundleWithPodName:podName];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name bundle:bundle];
    return storyBoard;
}
    
+ (nullable UIImage *)imageWithName:(nonnull NSString *)imageName podName:(nonnull NSString *)podName {
    NSBundle * pod_bundle =[self bundleWithPodName:podName];
    if (!pod_bundle.loaded) {
        [pod_bundle load];
    }
    UIImage *image = [UIImage imageNamed:imageName inBundle:pod_bundle compatibleWithTraitCollection:nil];
    return image;
}

@end
