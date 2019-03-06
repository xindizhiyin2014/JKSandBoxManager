
//
//  JKSandBoxManager.h
//  Pods
//
//  Created by Jack on 2017/7/7.
//
//

#import <Foundation/Foundation.h>

//文件目录
//temp文件夹沙盒路径
#define JKSandBoxPathTemp                   NSTemporaryDirectory()

//document文件夹沙盒路径
#define JKSandBoxPathDocument               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//cache文件夹文件夹沙盒路径
#define JKSandBoxPathCache                  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface JKSandBoxManager : NSObject

/**
 获取文件的后缀名
 
 @param filePath 文件的沙盒路径
 @return 文件的后缀名
 */
+ (NSString *)getPathExtensionWith:(NSString *)filePath;

/**
 获取文件的名字 包含后缀名

 @param filePath 文件的沙盒路径
 @return 文件的名字，包含后缀名
 */
+ (NSString *)getFileNameWithFilePath:(NSString *)filePath;

/**
 获取文件的名字 不含后缀名

 @param filePath 文件的沙盒路径
 @return 文件的名字 不含后缀名
 */
+ (NSString *)getFileNameWithNoExtWithFilePath:(NSString *)filePath;

/**
 获取文件所在文件夹的沙盒路径

 @param filePath 文件的沙盒路径
 @return 文件夹的沙盒路径
 */
+ (NSString *)getDirectoryWithFilePath:(NSString *)filePath;

/**
 获取某一路径下的文件列表，不包含文件夹
 
 @param filePath 文件的路径
 @return 文件列表
 */
+ (NSArray *)filesWithoutFolderAtPath:(NSString *)filePath;

/**
 获取某一路径下的符合一定要求后缀名的文件列表，不包含文件夹，
 
 @param filePath 文件的路径
 @param exts 符合要求的后缀名列表
 @return 文件名列表
 */
+ (NSArray *)filesWithoutFolderAtPath:(NSString *)filePath extensions:(NSArray <NSString *>*)exts;

/**
 获取某一路径下的文件列表，包含文件夹
 
 @param filePath 文件的路径
 @return 文件列表
 */
+ (NSArray *)filesWithFolderAtPath:(NSString *)filePath;

/**
 获取某一路径下的文件夹列表

 @param filePath 文件的沙盒路径
 @return 文件夹列表
 */
+ (NSArray *)foldersAtPath:(NSString *)filePath;

/**
 判断某个路径下的文件是否存在
 
 @param filePath 文件的沙盒路径
 @return 文件是否存在的状态 YES or NO
 */
+ (BOOL)isExistsFile:(NSString *)filePath;

/**
 判断某个路径是否是文件夹

 @param filePath 文件的沙盒路径
 @return 是否是文件夹
 */
+ (BOOL)isDirectory:(NSString *)filePath;

/**
 在沙盒documents文件夹中创建文件的路径
 
 @param fileName 文件的名字
 @param data 要写入的二进制数据
 @return 文件的沙盒路径
 */
+ (NSString *)createDocumentsFilePathWithFileName:(NSString *)fileName data:(NSData *)data;

/**
 在沙盒documents文件夹中指定的文件夹下创建文件的路径
 
 @param nameSpace 指定的文件夹名字
 @param fileName 文件的名字
 @param data 要写入的二进制数据
 @return 文件的沙盒路径
 */
+ (NSString *)createDocumentsFilePathWithNameSpace:(NSString *)nameSpace fileName:(NSString *)fileName data:(NSData *)data;

/**
 在cache文件夹下创建文件的路径
 
 @param fileName 文件的名字
 @param data 要写入的二进制数据
 @return 文件的沙盒路径
 */
+ (NSString *)createCacheFilePathWithFileName:(NSString *)fileName data:(NSData *)data;

/**
 在cache文件夹下指定的文件夹下创建文件的路径
 
 @param nameSpace 指定的文件夹名字
 @param fileName 文件的名字
 @param data 要写入的二进制数据
 @return 文件的沙盒路径
 */
+ (NSString *)createCacheFilePathWithNameSpace:(NSString *)nameSpace fileName:(NSString *)fileName data:(NSData *)data;

/**
 在指定的文件夹路径下创建文件

 @param folerPath 文件夹路径
 @param fileName 文件的名字
 @param data 二进制数据
 @return 创建成功的文件沙盒路径
 */
+ (NSString *)createFileAtFolderPath:(NSString *)folerPath fileName:(NSString *)fileName data:(NSData *)data;

/**
 在cache文件夹下创建文件夹
 
 @param folderName 文件夹的名字
 @return 创建的文件夹沙盒路径
 */
+ (NSString *)createCacheFilePathWithFolderName:(NSString *)folderName;
/**
 在documents文件下创建文件夹
 
 @param folderName 文件夹名字
 @return 创建的文件夹沙盒路径
 */
+ (NSString *)createDocumentsFilePathWithFolderName:(NSString *)folderName;
/**
 根据沙盒路径创建文件夹路径
 
 @param folderPath 文件夹路径
 @return 文件夹的路径
 */
+ (NSString *)createDirectoryWithPath:(NSString *)folderPath;
/**
 删除指定路径的文件或指定指定文件夹下的所有文件
 
 @param filePath 文件的路径或文件夹的路径
 */
+ (BOOL)deleteFile:(NSString *)filePath;

/**
 将某个文件或者文件夹移动到指定的路径下
 
 @param originFilePath 某个文件或文件夹的路径
 @param targetFilePath 指定的路径
 */
+ (BOOL)moveFileFrom:(NSString *)originFilePath to:(NSString *)targetFilePath;

/**
 将某个文件或者文件夹复制到指定的路径下
 
 @param originFilePath 某个文件或文件夹的路径
 @param targetFilePath 指定的路径
 */
+ (BOOL)copyFileFrom:(NSString *)originFilePath to:(NSString *)targetFilePath;

/**
 根据文件的名字拼接文件在沙盒documents的路径，实际不创建文件
 
 @param fileName 文件的名字
 @return 文件的沙盒路径
 */
+ (NSString *)appendDocumentsFilePathWithFileName:(NSString *)fileName;

/**
 根据文件的名字拼接文件在沙盒documents的路径，实际不创建文件
 
 @param folderName 子文件夹名字
 @param fileName 文件的名字
 @return 沙盒的路径
 */
+ (NSString *)appendDocumentsFilePathWithFolderName:(NSString *)folderName FileName:(NSString *)fileName;

/**
 根据文件的名字拼接文件在沙盒Cache的路径，实际不创建文件
 
 @param fileName 文件的名字
 @return 文件的沙盒路径
 */
+ (NSString *)appendCacheFilePathWithFileName:(NSString *)fileName;

/**
 根据文件的名字拼接文件在沙盒Cache的路径，实际不创建文件
 
 @param folderName 子文件夹名字
 @param fileName 文件的名字
 @return 沙盒的路径
 */
+ (NSString *)appendCacheFilePathWithFolderName:(NSString *)folderName FileName:(NSString *)fileName;

/**
 根据文件的名字拼接文件在沙盒Temporary的路径，实际不创建文件
 
 @param fileName 文件的名字
 @return 文件的沙盒路径
 */
+ (NSString *)appendTemporaryFilePathWithFileName:(NSString *)fileName;

/**
 获取某个Bundle下的文件的路径
 
 @param fileName 文件的名字，可以带后缀名
 @param podName pod组件的名字 podName为nil的话，默认为MainBundle
 @param ext 文件的后缀名
 @return 文件的路径
 */
+ (NSString *)pathWithFileName:(NSString *)fileName podName:(NSString *)podName ofType:(NSString *)ext;

/**
 获取某个podName对象的bundle对象
 
 @param podName pod的名字 podName为nil的话，默认为MainBundle
 @return 对应的bundle对象
 */
+ (NSBundle *)bundleWithPodName:(NSString *)podName;

/**
 根据bundle名字获取bundle对象，只能获取mainBundle下的bundle

 @param bundleName bundleName
 @return bundle instance
 */
+ (NSBundle *)bundleWithBundleName:(NSString *)bundleName;

/**
 根据fileName、bundleName、podName、获取文件的组件化路径

 @param bundleName bundleName
 @param fileName fileName
 @param podName podName
 @return filePath
 */
+ (NSString *)filePathWithBundleName:(NSString *)bundleName fileName:(NSString *)fileName podName:(NSString *)podName;

/**
 根据fileName、bundleName、podName、获取文件的组件化路径URL
 
 @param bundleName bundleName
 @param fileName fileName
 @param podName podName
 @return filePath
 */
+ (NSURL *)fileURLWithBundleName:(NSString *)bundleName fileName:(NSString *)fileName podName:(NSString *)podName;

/**
 获取某个podName下的nib文件并创建对象
 
 @param nibName xib文件的名字
 @param podName pod库名 podName为nil的话，默认为MainBundle
 @return 创建好的对象
 */
+ (id)loadNibName:(NSString *)nibName podName:(NSString *)podName;

/**
 获取某个pod下的UIStoryboard文件的对象
 
 @param name UIStoryboard 的名字
 @param podName pod库名  podName为nil的话，默认为MainBundle
 @return UIStoryboard 对象
 */
+ (UIStoryboard *)storyboardWithName:(NSString *)name podName:(NSString *)podName;

/**
 在模块内查找UIImage的方法
 
 @param imageName 图片的名字，如果是非png格式的话，要带上后缀名
 @param podName pod库名 podName为nil的话，默认为MainBundle
 @return UIImage对象
 */
+ (UIImage *)imageWithName:(NSString *)imageName podName:(NSString *)podName;

/**
 对文件进行md5哈希操作 默认取文件的size为 1024 *8

 @param filePath 文件的沙盒路径
 @return 哈希字符串
 */
+ (NSString*)fileMD5HashStringWithPath:(NSString*)filePath;

/**
 对文件进行md5哈希操作 默认取文件的size为 1024 *8
 
 @param filePath 文件的沙盒路径
 @param chunkSizeForReadingData 进行哈希的指定的片段文件的大小
 @return 哈希字符串
 */
+ (NSString*)fileMD5HashStringWithPath:(NSString*)filePath WithSize:(size_t)chunkSizeForReadingData;

@end

