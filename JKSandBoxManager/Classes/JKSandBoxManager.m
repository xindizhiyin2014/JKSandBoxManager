//
//  JKSandBoxManager.m
//  Pods
//
//  Created by Jack on 2017/7/7.
//
//

#import "JKSandBoxManager.h"

@implementation JKSandBoxManager

+ (NSString *)getPathExtensionWith:(NSString *)filePath
{
//    NSString *pathExtension=nil;
//    NSRange range = [filePath rangeOfString:@"[^\\.]+$" options:NSRegularExpressionSearch];
//    if (range.location != NSNotFound) {
//
//        pathExtension = [filePath substringWithRange:range];
//    }
    NSString *ext = [filePath pathExtension];
    return ext;
}

+ (NSString *)getFileNameWithFilePath:(NSString *)filePath{
    NSString *fileName = [filePath lastPathComponent];
    return fileName;
}

+ (NSString *)getFileNameWithNoExtWithFilePath:(NSString *)filePath{
    NSString *fileName = [filePath stringByDeletingPathExtension];
    return fileName;
}

+ (NSArray *)filesWithoutFolderAtPath:(NSString *)filePath{
    
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:filePath];
    //新建数组，存放各个文件路径
    NSMutableArray *files = [NSMutableArray new];
    //遍历目录迭代器，获取各个文件路径
    NSString *fileName=nil;
    while (fileName = [dirEnum nextObject]) {
        NSString *tempFilePath = [NSString stringWithFormat:@"%@/%@",filePath,fileName];
        BOOL isDirectory = [self isDirectory:tempFilePath];
        if (!isDirectory && ![fileName containsString:@"/"]) {
            [files addObject:fileName];
        }
    }
    return [files copy];
    
}

+ (NSArray *)filesWithoutFolderAtPath:(NSString *)filePath extensions:(NSArray <NSString *>*)exts{
    NSArray *array = [self filesWithoutFolderAtPath:filePath];
    NSMutableArray *files = [NSMutableArray new];
    for (NSString *fileName in array) {
        NSString *ext = [self getPathExtensionWith:filePath];
        if ([exts containsObject:ext]) {
            [files addObject:fileName];
        }
    }
    return [files copy];
}


+ (NSArray *)filesWithFolderAtPath:(NSString *)filePath{
    
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:filePath];
    //新建数组，存放各个文件路径
    NSMutableArray *files = [NSMutableArray new];
    //遍历目录迭代器，获取各个文件路径
    NSString *fileName=nil;
    while (fileName = [dirEnum nextObject]) {
        if (![fileName isEqualToString:@".DS_Store"]) {//存在后缀名的文件
            [files addObject:fileName];
        }
        
    }
    return [files copy];
}

+ (NSArray *)foldersAtPath:(NSString *)filePath{
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:filePath];
    //新建数组，存放各个文件路径
    NSMutableArray *files = [NSMutableArray new];
    //遍历目录迭代器，获取各个文件路径
    NSString *fileName=nil;
    while (fileName = [dirEnum nextObject]) {
        NSString *tempFilePath = [NSString stringWithFormat:@"%@/%@",filePath,fileName];
        BOOL isDirectory = [self isDirectory:tempFilePath];
        if (isDirectory) {
            [files addObject:fileName];
        }
    }
    return [files copy];
}

+ (BOOL)isExistsFile:(NSString *)filepath{
    NSFileManager *filemanage = [NSFileManager defaultManager];
    return [filemanage fileExistsAtPath:filepath];
    
}

+ (BOOL)isDirectory:(NSString *)filePath{
    BOOL isDirectory = NO;
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    return isDirectory;
}


+ (NSString *)createDocumentsFilePathWithFileName:(NSString *)fileName data:(NSData *)data{
    
    return [self createDocumentsFilePathWithNameSpace:nil fileName:fileName data:data];
}

+ (NSString *)createDocumentsFilePathWithNameSpace:(NSString *)nameSpace fileName:(NSString *)fileName data:(NSData *)data{
    
    if (!data) {
        return nil;
    }
    
    NSString *fileDir =[self createDocumentsFilePathWithFolderName:nameSpace];
    NSString *filePath =[fileDir stringByAppendingString:[NSString stringWithFormat:@"/%@",fileName]];
    [data writeToFile:filePath atomically:YES];
    return filePath;
}


+ (NSString *)createCacheFilePathWithFileName:(NSString *)fileName data:(NSData *)data{
    
    return [self createCacheFilePathWithNameSpace:nil fileName:fileName data:data];
}

+ (NSString *)createCacheFilePathWithNameSpace:(NSString *)nameSpace fileName:(NSString *)fileName data:(NSData *)data{
    if (!data) {
        return nil;
    }
    
    NSString *fileDir =[self createCacheFilePathWithFolderName:nameSpace];
    NSString *filePath =[fileDir stringByAppendingString:[NSString stringWithFormat:@"/%@",fileName]];
    [data writeToFile:filePath atomically:YES];
    return filePath;
}

+ (NSString *)createCacheFilePathWithFolderName:(NSString *)folderName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDir = [paths objectAtIndex:0];
    NSString *folderPath=folderName?[cacheDir stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",folderName]]:cacheDir;
    if ([self isExistsFile:folderPath]) {
        return folderPath;
    }
    [[NSFileManager defaultManager]   createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    return folderPath;
    
}


+ (NSString *)createDocumentsFilePathWithFolderName:(NSString *)folderName{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    NSString *folderPath =folderName?[documentsDir stringByAppendingString:[NSString stringWithFormat:@"/%@",folderName]]:documentsDir;
    if ([self isExistsFile:folderPath]) {
        return folderPath;
    }
    [[NSFileManager defaultManager]   createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    return folderPath;
}

+ (NSString *)createDirectoryWithPath:(NSString *)filePath{
    if ([self isExistsFile:filePath]) {
        return filePath;
    }
    
    [[NSFileManager defaultManager]   createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    
    return filePath;
}

+ (BOOL)deleteFile:(NSString *)filePath{
    NSError *error =nil;
    if (!filePath) {
        return NO;
    }
    
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    
}

+ (BOOL)moveFileFrom:(NSString *)originFilePath to:(NSString *)targetFilePath{
    NSError *error = nil;
    if (!(originFilePath&&targetFilePath)) {
        return NO;
    }
    
    if ([self isExistsFile:targetFilePath]) {
        [self deleteFile:targetFilePath];
    }
    
    return [[NSFileManager defaultManager] moveItemAtPath:originFilePath toPath:targetFilePath error:&error];
}


+ (BOOL)copyFileFrom:(NSString *)originFilePath to:(NSString *)targetFilePath{
    NSError *error = nil;
    if (!(originFilePath&&targetFilePath)) {
        return NO;
    }
    
    if ([self isExistsFile:targetFilePath]) {
        [self deleteFile:targetFilePath];
    }
    return [[NSFileManager defaultManager] copyItemAtPath:originFilePath toPath:targetFilePath error:&error];
}

+ (NSString *)appendDocumentsFilePathWithFileName:(NSString *)fileName{
    
    return [self appendDocumentsFilePathWithFolderName:nil FileName:fileName];
}

+ (NSString *)appendDocumentsFilePathWithFolderName:(NSString *)folderName FileName:(NSString *)fileName;{
    
    if (!folderName || [folderName isEqualToString:@""]) {
        return [NSString stringWithFormat:@"%@/%@",JKSandBoxPathDocument,fileName];
    }
    
    return [NSString stringWithFormat:@"%@/%@",[self createDocumentsFilePathWithFolderName:folderName],fileName];
}

+ (NSString *)appendCacheFilePathWithFileName:(NSString *)fileName{
    
    return [self appendCacheFilePathWithFolderName:nil FileName:fileName];
}

+ (NSString *)appendCacheFilePathWithFolderName:(NSString *)folderName FileName:(NSString *)fileName{
    
    if (!folderName || [folderName isEqualToString:@""]) {
        return [NSString stringWithFormat:@"%@/%@",JKSandBoxPathCache,fileName];
    }
    
    return [NSString stringWithFormat:@"%@/%@",[self createCacheFilePathWithFolderName:folderName],fileName];
    
}


+ (NSString *)appendTemporaryFilePathWithFileName:(NSString *)fileName{
    return [NSString stringWithFormat:@"%@/%@",JKSandBoxPathTemp,fileName];
}

+ (NSString *)pathWithFileName:(NSString *)fileName podName:(NSString *)podName ofType:(NSString *)ext{
    
    if (!fileName ) {
        return nil;
    }
    
    NSBundle * pod_bundle =[self bundleWithPodName:podName];
    if (!pod_bundle) {
        return nil;
    }
    if (!pod_bundle.loaded) {
        [pod_bundle load];
    }
    NSString *filePath =[pod_bundle pathForResource:fileName ofType:ext];
    return filePath;
}


+ (NSBundle *)bundleWithPodName:(NSString *)podName{
    
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
    if (!url) {
        return nil;
    }
    NSBundle * pod_bundle =[NSBundle bundleWithURL:url];
    if (!pod_bundle.loaded) {
        [pod_bundle load];
    }
    
    return pod_bundle;
}

+ (id)loadNibName:(NSString *)nibName podName:(NSString *)podName{
    NSBundle *bundle =[self  bundleWithPodName:podName];
    if (!bundle) {
        return nil;
    }
    id object = [[bundle loadNibNamed:nibName owner:nil options:nil] lastObject];
    return object;
}

+ (UIStoryboard *)storyboardWithName:(NSString *)name podName:(NSString *)podName{
    NSBundle *bundle =[self  bundleWithPodName:podName];
    if (!bundle) {
        return nil;
    }
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name bundle:bundle];
    return storyBoard;
}

+ (UIImage *)imageWithName:(NSString *)imageName podName:(NSString *)podName {
    NSBundle * pod_bundle =[self bundleWithPodName:podName];
    if (!pod_bundle) {
        return nil;
    }
    if (!pod_bundle.loaded) {
        [pod_bundle load];
    }
    UIImage *image = [UIImage imageNamed:imageName inBundle:pod_bundle compatibleWithTraitCollection:nil];
    return image;
}

@end
