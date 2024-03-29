//
//  JKSandBoxManager.m
//  Pods
//
//  Created by Jack on 2017/7/7.
//
//

#import "JKSandBoxManager.h"
#import <CommonCrypto/CommonDigest.h>   //算法 md5

@implementation JKSandBoxManager

+ (NSString *)tempPath
{
    return NSTemporaryDirectory();
}

+ (NSString *)cachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)documentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)getPathExtensionWith:(NSString *)filePath
{
    NSString *ext = [filePath pathExtension];
    return ext;
}

+ (NSString *)getFileNameWithFilePath:(NSString *)filePath
{
    NSString *fileName = [filePath lastPathComponent];
    return fileName;
}

+ (NSString *)getFileNameWithNoExtWithFilePath:(NSString *)filePath
{
    NSString *fileName = [filePath stringByDeletingPathExtension];
    return fileName;
}

+ (NSString *)getDirectoryWithFilePath:(NSString *)filePath
{
    NSString *directory = [filePath stringByDeletingLastPathComponent];
    return directory;
}

+ (NSArray *)filesWithoutFolderAtPath:(NSString *)folderPath
{
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:folderPath];
    //新建数组，存放各个文件路径
    NSMutableArray *files = [NSMutableArray new];
    //遍历目录迭代器，获取各个文件路径
    NSString *fileName=nil;
    while (fileName = [dirEnum nextObject]) {
        NSString *tempFilePath = [NSString stringWithFormat:@"%@/%@",folderPath,fileName];
        BOOL isDirectory = [self isExistDirectory:tempFilePath];
        if (isDirectory == YES) {
            [dirEnum skipDescendants];
            continue;
        } else {
            if (![fileName containsString:@"/"]) {
                [files addObject:fileName];
            }
        }
        
    }
    return [files copy];
}

+ (NSArray *)filesWithoutFolderAtPath:(NSString *)folderPath
                           extensions:(NSArray <NSString *>*)exts
{
    NSArray *array = [self filesWithoutFolderAtPath:folderPath];
    NSMutableArray *files = [NSMutableArray new];
    for (NSString *fileName in array) {
        NSString *ext = [self getPathExtensionWith:folderPath];
        if ([exts containsObject:ext]) {
            [files addObject:fileName];
        }
    }
    return [files copy];
}

+ (NSArray *)filesWithFolderAtPath:(NSString *)folderPath
{
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:folderPath];
    //新建数组，存放各个文件路径
    NSMutableArray *files = [NSMutableArray new];
    //遍历目录迭代器，获取各个文件路径
    NSString *fileName=nil;
    while (fileName = [dirEnum nextObject]) {
        NSString *path = [NSString stringWithFormat:@"%@/%@",folderPath,fileName];
        if ([JKSandBoxManager isExistDirectory:path]) {
            [dirEnum skipDescendants];
        }
        
        if (![fileName isEqualToString:@".DS_Store"]) {//存在后缀名的文件
            [files addObject:fileName];
        }
        
    }
    return [files copy];
}

+ (NSArray *)foldersAtPath:(NSString *)folderPath
{
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:folderPath];
    //新建数组，存放各个文件路径
    NSMutableArray *files = [NSMutableArray new];
    //遍历目录迭代器，获取各个文件路径
    NSString *fileName=nil;
    while (fileName = [dirEnum nextObject]) {
        NSString *tempFilePath = [NSString stringWithFormat:@"%@/%@",folderPath,fileName];
        BOOL isDirectory = [self isExistDirectory:tempFilePath];
        if (isDirectory) {
            [dirEnum skipDescendants];
            [files addObject:fileName];
        }
    }
    return [files copy];
}

+ (BOOL)isExistsFile:(NSString *)filepath
{
    NSFileManager *filemanage = [NSFileManager defaultManager];
    return [filemanage fileExistsAtPath:filepath];
    
}

+ (BOOL)isExistDirectory:(NSString *)filePath
{
    BOOL isDirectory = NO;
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    return isExist && isDirectory;
}


+ (NSString *)createDocumentsFilePathWithFileName:(NSString *)fileName
                                             data:(NSData *)data
{
    
    return [self createDocumentsFilePathWithNameSpace:nil
                                             fileName:fileName
                                                 data:data];
}

+ (NSString *)createDocumentsFilePathWithNameSpace:(NSString *)nameSpace
                                          fileName:(NSString *)fileName
                                              data:(NSData *)data
{
    
    if (!data) {
        return nil;
    }
    
    NSString *fileDir =[self createDocumentsFilePathWithFolderName:nameSpace];
    NSString *filePath =[fileDir stringByAppendingString:[NSString stringWithFormat:@"/%@",fileName]];
    [data writeToFile:filePath atomically:YES];
    return filePath;
}


+ (NSString *)createCacheFilePathWithFileName:(NSString *)fileName
                                         data:(NSData *)data
{
    
    return [self createCacheFilePathWithNameSpace:nil fileName:fileName data:data];
}

+ (NSString *)createCacheFilePathWithNameSpace:(NSString *)nameSpace
                                      fileName:(NSString *)fileName
                                          data:(NSData *)data
{
    if (!data) {
        return nil;
    }
    
    NSString *fileDir =[self createCacheFilePathWithFolderName:nameSpace];
    NSString *filePath =[fileDir stringByAppendingString:[NSString stringWithFormat:@"/%@",fileName]];
    [data writeToFile:filePath atomically:YES];
    return filePath;
}

+ (NSString *)createFileAtFolderPath:(NSString *)folerPath
                            fileName:(NSString *)fileName
                                data:(NSData *)data
{
    if (!data) {
        return nil;
    }
    
    if(![JKSandBoxManager isExistDirectory:folerPath]){
        [JKSandBoxManager createDirectoryWithPath:folerPath];
    }
    NSString *filePath =[NSString stringWithFormat:@"%@/%@",folerPath,fileName];
    if([data writeToFile:filePath atomically:YES]){
        return filePath;
    }
    return nil;
}

+ (NSString *)createCacheFilePathWithFolderName:(NSString *)folderName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDir = [paths objectAtIndex:0];
    NSString *folderPath=folderName?[cacheDir stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",folderName]]:cacheDir;
    if ([self isExistsFile:folderPath]) {
        return folderPath;
    }
    [[NSFileManager defaultManager]   createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    return folderPath;
    
}

+ (NSString *)createDocumentsFilePathWithFolderName:(NSString *)folderName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    NSString *folderPath =folderName?[documentsDir stringByAppendingString:[NSString stringWithFormat:@"/%@",folderName]]:documentsDir;
    if ([self isExistsFile:folderPath]) {
        return folderPath;
    }
    [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    return folderPath;
}

+ (NSString *)createDirectoryWithPath:(NSString *)filePath
{
    if ([self isExistsFile:filePath]) {
        return filePath;
    }
    
    [[NSFileManager defaultManager]   createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    return filePath;
}

+ (BOOL)deleteFile:(NSString *)filePath
{
    NSError *error =nil;
    if (!filePath) {
        return NO;
    }
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
}

+ (BOOL)moveFileFrom:(NSString *)originFilePath
                  to:(NSString *)targetFilePath
{
    NSError *error = nil;
    if (!(originFilePath&&targetFilePath)) {
        return NO;
    }
    
    if ([self isExistsFile:targetFilePath]) {
        [self deleteFile:targetFilePath];
    }
    
    return [[NSFileManager defaultManager] moveItemAtPath:originFilePath toPath:targetFilePath error:&error];
}


+ (BOOL)copyFileFrom:(NSString *)originFilePath
                  to:(NSString *)targetFilePath
{
    NSError *error = nil;
    if (!(originFilePath&&targetFilePath)) {
        return NO;
    }
    
    if ([self isExistsFile:targetFilePath]) {
        [self deleteFile:targetFilePath];
    }
    return [[NSFileManager defaultManager] copyItemAtPath:originFilePath toPath:targetFilePath error:&error];
}

+ (NSString *)appendDocumentsFilePathWithFileName:(NSString *)fileName
{
    return [self appendDocumentsFilePathWithFolderName:nil
                                              fileName:fileName];
}

+ (NSString *)appendDocumentsFilePathWithFolderName:(NSString *)folderName fileName:(NSString *)fileName
{
    if (!folderName || [folderName isEqualToString:@""]) {
        return [NSString stringWithFormat:@"%@/%@",JKSandBoxPathDocument,fileName];
    }
    
    return [NSString stringWithFormat:@"%@/%@",[self createDocumentsFilePathWithFolderName:folderName],fileName];
}

+ (NSString *)appendCacheFilePathWithFileName:(NSString *)fileName
{
    return [self appendCacheFilePathWithFolderName:nil
                                          fileName:fileName];
}

+ (NSString *)appendCacheFilePathWithFolderName:(NSString *)folderName
                                       fileName:(NSString *)fileName
{
    if (!folderName || [folderName isEqualToString:@""]) {
        return [NSString stringWithFormat:@"%@/%@",JKSandBoxPathCache,fileName];
    }
    return [NSString stringWithFormat:@"%@/%@",[self createCacheFilePathWithFolderName:folderName],fileName];
}

+ (NSString *)appendTemporaryFilePathWithFileName:(NSString *)fileName
{
    return [NSString stringWithFormat:@"%@/%@",JKSandBoxPathTemp,fileName];
}

+ (NSString *)appendFilePathWithFolderPath:(NSString *)folderPath
                                  fileName:(NSString *)fileName
{
    if ([folderPath hasSuffix:@"/"]) {
        return [NSString stringWithFormat:@"%@%@",folderPath,fileName];
    }
    return [NSString stringWithFormat:@"%@/%@",folderPath,fileName];
}

+ (nullable NSString *)relativePath:(NSString *)targetPath
                    toPath:(NSString *)path
{
    if (targetPath.length < path.length) {
#if DEBUG
        NSAssert(NO, @"targetPath.length < path.length");
#endif
        return nil;
    }
    if (![targetPath hasPrefix:path]) {
#if DEBUG
        NSAssert(NO, @"has no same prefix");
#endif
        return nil;
    }
  NSString *relativePath = [targetPath substringFromIndex:path.length];
    return relativePath;
}

+ (NSString *)pathWithFileName:(NSString *)fileName
                       podName:(NSString *)podName ofType:(NSString *)ext
{
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

+ (NSBundle *)bundleWithPodName:(NSString *)podName
{
    if (!podName) {
        return [NSBundle mainBundle];
    }
    NSBundle * bundle = [NSBundle bundleForClass:NSClassFromString(podName)];
    NSURL * url = [bundle URLForResource:podName withExtension:@"bundle"];
    if (!url) {
        NSArray *frameWorks = [NSBundle allFrameworks];
        for (NSBundle *tempBundle in frameWorks) {
            url = [tempBundle URLForResource:podName withExtension:@"bundle"];
            if (url) {
                bundle =[NSBundle bundleWithURL:url];
                if (!bundle.loaded) {
                    [bundle load];
                }
                return bundle;
            }
        }
    }else{
        bundle =[NSBundle bundleWithURL:url];
        return bundle;
    }
    return nil;
}

+ (NSBundle *)bundleWithBundleName:(NSString *)bundleName
{
    if (!bundleName) {
        return [NSBundle mainBundle];
    }
    
    NSString *bundlePath = [NSBundle mainBundle].bundlePath;
    bundlePath = [NSString stringWithFormat:@"%@/%@.bundle",bundlePath,bundleName];
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"file://%@",bundlePath] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSBundle *bundle =[NSBundle bundleWithURL:url];
    return bundle;
}

+ (NSString *)filePathWithBundleName:(NSString *)bundleName
                            fileName:(NSString *)fileName
                             podName:(NSString *)podName
{
    if (!podName) {
        NSBundle *bundle = [self bundleWithBundleName:bundleName];
        NSString *filePath = [bundle pathForResource:fileName ofType:nil];
        return filePath;
    }
    
    NSBundle *pod_bundle = [self bundleWithPodName:podName];
    if (!bundleName) {
        NSString *filePath = [pod_bundle pathForResource:fileName ofType:nil];
        return filePath;
    }
    
    NSString *bundlePath = pod_bundle.bundlePath;
    bundlePath = [NSString stringWithFormat:@"%@/%@.bundle",bundlePath,podName];
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"file://%@/%@.bundle",bundlePath,bundleName] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSBundle *bundle =[NSBundle bundleWithURL:url];
    if (bundle) {
        NSString *filePath = [bundle pathForResource:fileName ofType:nil];
        return filePath;
    }
    return nil;
}

+ (NSURL *)fileURLWithBundleName:(NSString *)bundleName
                        fileName:(NSString *)fileName
                         podName:(NSString *)podName
{
    NSString *filePath = [self filePathWithBundleName:bundleName fileName:fileName podName:podName];
    NSString *fileURLStr = [NSString stringWithFormat:@"file://%@",filePath];
    NSURL *fileURL = [NSURL URLWithString:fileURLStr];
    if (!fileURL) {
       fileURLStr = [fileURLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        fileURL = [NSURL URLWithString:fileURLStr];
    }
    return fileURL;
}

+ (id)loadNibName:(NSString *)nibName
          podName:(NSString *)podName
{
    NSBundle *bundle =[self bundleWithPodName:podName];
    if (!bundle) {
        return nil;
    }
    id object = [[bundle loadNibNamed:nibName owner:nil options:nil] lastObject];
    return object;
}

+ (UIStoryboard *)storyboardWithName:(NSString *)name
                             podName:(NSString *)podName
{
    NSBundle *bundle =[self bundleWithPodName:podName];
    if (!bundle) {
        return nil;
    }
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name bundle:bundle];
    return storyBoard;
}

+ (UIImage *)imageWithName:(NSString *)imageName
                   podName:(NSString *)podName
{
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

+ (NSString*)fileMD5HashStringWithPath:(NSString*)filePath
{
   return [self fileMD5HashStringWithPath:filePath
                                 withSize:1024 *8];
}

+ (NSString*)fileMD5HashStringWithPath:(NSString*)filePath
                              withSize:(size_t)chunkSizeForReadingData
{
    NSMutableString *result=nil;
    CFReadStreamRef readStream = NULL;
    
    // Get the file URL
    CFURLRef fileURL =
    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                  (CFStringRef)filePath,
                                  kCFURLPOSIXPathStyle,
                                  (Boolean)false);
    
    CC_MD5_CTX hashObject;
    bool hasMoreData = true;
    bool didSucceed;
    
    if (!fileURL) goto done;
    
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,
                                            (CFURLRef)fileURL);
    if (!readStream) goto done;
    didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) goto done;
    
    // Initialize the hash object
    CC_MD5_Init(&hashObject);
    
    // Make sure chunkSizeForReadingData is valid
    if (!chunkSizeForReadingData) {
        chunkSizeForReadingData = 1024*8;
    }
    
    // Feed the data to the hash object
    while (hasMoreData) {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCount = CFReadStreamRead(readStream,
                                                  (UInt8 *)buffer,
                                                  (CFIndex)sizeof(buffer));
        if (readBytesCount == -1)break;
        if (readBytesCount == 0) {
            hasMoreData =false;
            continue;
        }
        CC_MD5_Update(&hashObject,(const void *)buffer,(CC_LONG)readBytesCount);
    }
    
    // Check if the read operation succeeded
    didSucceed = !hasMoreData;
    
    // Compute the hash digest
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    
    // Abort if the read operation failed
    if (!didSucceed) goto done;
    result = [NSMutableString string];
    for(int i=0;i<CC_MD5_DIGEST_LENGTH;i++){
        [result appendFormat:@"%02x",digest[i]];
    }
    
done:
    
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
}
+ (NSString *)localizedStringForKey:(NSString *)key
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *language = [languages objectAtIndex:0];
    if ([language hasPrefix:@"zh"]){
        language = @"zh-Hans";
    } else {
        language = @"en";
    }
    return [self localizedStringForKey:key
                              language:language];
}

+ (NSString *)localizedStringForKey:(NSString *)key
                           language:(NSString *)language
{
    return [self localizedStringForKey:key language:language podName:nil];
}

+ (NSString *)localizedStringForKey:(NSString *)key
podName:(NSString *)podName
{
 NSArray *languages = [NSLocale preferredLanguages];
    NSString *language = [languages objectAtIndex:0];
    if ([language hasPrefix:@"zh"]){
        language = @"zh-Hans";
    } else {
        language = @"en";
    }
    return [self localizedStringForKey:key
                              language:language
                               podName:podName];
}

+ (NSString *)localizedStringForKey:(NSString *)key
                           language:(NSString *)language
                            podName:(NSString *)podName
{
    if (podName) {
        NSBundle *bundle = [NSBundle bundleWithPath:[[JKSandBoxManager bundleWithPodName:podName] pathForResource:language ofType:@"lproj"]];
        NSString *value = [bundle localizedStringForKey:key value:nil table:podName];
        return value;
    }
    return [[NSBundle mainBundle] localizedStringForKey:key value:nil table:nil];
}

@end
