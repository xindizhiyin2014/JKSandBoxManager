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
+ (nullable NSString *)getPathExtensionWith:(nullable NSString *)filePath;

/**
 获取某一路径下的文件列表，不包含文件夹

 @param filePath 文件的路径
 @return 文件列表
 */
+ (nonnull NSArray *)filesWithoutFolderAtPath:(nonnull NSString *)filePath;


/**
 获取某一路径下的文件列表，包含文件夹

 @param filePath 文件的路径
 @return 文件列表
 */
+ (nonnull NSArray *)filesWithFolderAtPath:(nonnull NSString *)filePath;
/**
 判断某个路径下的文件是否存在

 @param filePath 文件的沙盒路径
 @return 文件是否存在的状态 YES or NO
 */
+ (BOOL)isExistsFile:(nullable NSString *)filePath;


/**
 在沙盒documents文件夹中创建文件的路径

 @param fileName 文件的名字
 @return 文件的沙盒路径
 */
+ (nonnull NSString *)createDocumentsFilePathWith:(nullable NSString *)fileName;


/**
 在沙盒documents文件夹中指定的文件夹下创建文件的路径

 @param nameSpace 指定的文件夹名字
 @param fileName 文件的名字
 @return 文件的沙盒路径
 */
+ (nonnull NSString *)createDocumentsFilePathWith:(nullable NSString *)nameSpace With:(nullable NSString *)fileName;


/**
 在cache文件夹下创建文件的路径

 @param fileName 文件的名字
 @return 文件的沙盒路径
 */
+ (nonnull NSString *)createCacheFilePathWith:(nullable NSString *)fileName;


/**
 在cache文件夹下指定的文件夹下创建文件的路径

 @param nameSpace 指定的文件夹名字
 @param fileName 文件的名字
 @return 文件的沙盒路径
 */
+ (nonnull NSString *)createCacheFilePathWith:(nullable NSString *)nameSpace With:(nullable NSString *)fileName;


/**
 删除指定路径的文件或指定指定文件夹下的所有文件

 @param filePath 文件的路径或文件夹的路径
 */
+ (BOOL)deleteFile:(nonnull NSString *)filePath;


/**
 将某个文件或者文件夹移动到指定的路径下

 @param originFilePath 某个文件或文件夹的路径
 @param targetFilePath 指定的路径
 */
+ (BOOL)moveFileFrom:(nonnull NSString *)originFilePath to:(nonnull NSString *)targetFilePath;

/**
 将某个文件或者文件夹复制到指定的路径下
 
 @param originFilePath 某个文件或文件夹的路径
 @param targetFilePath 指定的路径
 */
+ (BOOL)copyFileFrom:(nonnull NSString *)originFilePath to:(nonnull NSString *)targetFilePath;



@end
