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
 @param data 要写入的二进制数据
 @return 文件的沙盒路径
 */
+ (nullable NSString *)createDocumentsFilePathWithFileName:(nullable NSString *)fileName data:(nullable NSData *)data;


/**
 在沙盒documents文件夹中指定的文件夹下创建文件的路径

 @param nameSpace 指定的文件夹名字
 @param fileName 文件的名字
 @param data 要写入的二进制数据
 @return 文件的沙盒路径
 */
+ (nullable NSString *)createDocumentsFilePathWithNameSpace:(nullable NSString *)nameSpace fileName:(nullable NSString *)fileName data:(nullable NSData *)data;


/**
 在cache文件夹下创建文件的路径

 @param fileName 文件的名字
 @param data 要写入的二进制数据
 @return 文件的沙盒路径
 */
+ (nullable NSString *)createCacheFilePathWithFileName:(nullable NSString *)fileName data:(nullable NSData *)data;


/**
 在cache文件夹下指定的文件夹下创建文件的路径

 @param nameSpace 指定的文件夹名字
 @param fileName 文件的名字
 @param data 要写入的二进制数据
 @return 文件的沙盒路径
 */
+ (nullable NSString *)createCacheFilePathWithNameSpace:(nullable NSString *)nameSpace fileName:(nullable NSString *)fileName data:(nullable NSData *)data;

/**
 在cache文件夹下创建文件夹

 @param folderName 文件夹的名字
 @return 创建的文件夹沙盒路径
 */
+ (nullable NSString *)createCacheFilePathWithFolderName:(nullable NSString *)folderName;
/**
 在documents文件下创建文件夹

 @param folderName 文件夹名字
 @return 创建的文件夹沙盒路径
 */
+ (nullable NSString *)createDocumentsFilePathWithFolderName:(nullable NSString *)folderName;
/**
 根据沙盒路径创建文件夹路径

 @param folderPath 文件夹路径
 @return 文件夹的路径
 */
+ (nonnull NSString *)createDirectoryWithPath:(nonnull NSString *)folderPath;
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


/**
 根据文件的名字拼接文件在沙盒documents的路径，实际不创建文件

 @param fileName 文件的名字
 @return 文件的沙盒路径
 */
+ (nonnull NSString *)appendDocumentsFilePathWithFileName:(nullable NSString *)fileName;

/**
 根据文件的名字拼接文件在沙盒documents的路径，实际不创建文件

 @param folderName 子文件夹名字
 @param fileName 文件的名字
 @return 沙盒的路径
 */
+ (nonnull NSString *)appendDocumentsFilePathWithFolderName:(nullable NSString *)folderName FileName:(nullable NSString *)fileName;

/**
 根据文件的名字拼接文件在沙盒Cache的路径，实际不创建文件
 
 @param fileName 文件的名字
 @return 文件的沙盒路径
 */
+ (nonnull NSString *)appendCacheFilePathWithFileName:(nullable NSString *)fileName;

/**
 根据文件的名字拼接文件在沙盒Cache的路径，实际不创建文件
 
 @param folderName 子文件夹名字
 @param fileName 文件的名字
 @return 沙盒的路径
 */
+ (nonnull NSString *)appendCacheFilePathWithFolderName:(nullable NSString *)folderName FileName:(nullable NSString *)fileName;

/**
 根据文件的名字拼接文件在沙盒Temporary的路径，实际不创建文件
 
 @param fileName 文件的名字
 @return 文件的沙盒路径
 */
+ (nonnull NSString *)appendTemporaryFilePathWithFileName:(nullable NSString *)fileName;

/**
 获取某个Bundle下的文件的路径
 
 @param fileName 文件的名字，可以带后缀名
 @param podName pod组件的名字
 @param ext 文件的后缀名
 @return 文件的路径
 */
+ (nullable NSString *)pathWithFileName:(nonnull NSString *)fileName podName:(nonnull NSString *)podName ofType:(nullable NSString *)ext;
    
/**
 获取某个podName对象的bundle对象
 
 @param podName pod的名字
 @return 对应的bundle对象
 */
+ (nullable NSBundle *)bundleWithPodName:(nonnull NSString *)podName;
    
/**
 获取某个podName下的nib文件并创建对象
 
 @param nibName xib文件的名字
 @param podName pod库名
 @return 创建好的对象
 */
+ (nullable id)loadNibName:(nonnull NSString *)nibName podName:(nonnull NSString *)podName;
    
/**
 获取某个pod下的UIStoryboard文件的对象
 
 @param name UIStoryboard 的名字
 @param podName pod库名
 @return UIStoryboard 对象
 */
+ (nullable UIStoryboard *)storyboardWithName:(nonnull NSString *)name podName:(nonnull NSString *)podName;
    
/**
 在模块内查找UIImage的方法
 
 @param imageName 图片的名字，如果是非png格式的话，要带上后缀名
 @param podName pod库名
 @return UIImage对象
 */
+ (nullable UIImage *)imageWithName:(nonnull NSString *)imageName podName:(nonnull NSString *)podName;

@end
