//
//  JKSandBoxManagerSwift.swift
//  JKSandBoxManagerSwift
//
//  Created by JackLee on 2021/8/24.
//
import Foundation

extension String {
    var `extension`:String {
        if let index = self.lastIndex(of: ".") {
            return String(self[index...])
        } else {
            return ""
        }
    }
}

public class JKSandBoxManagerSwift {
    
    /// 沙盒temp文件夹路径
    /// - Returns: 文件路径
    public class func tempPath() -> String {
      return NSTemporaryDirectory()
    }
    
    /// 沙盒cache文件夹路径
    /// - Returns: 文件路径
    public class func cachePath() -> String {
        let cachePaths:Array<String> = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        return cachePaths[0]
    }
    
    /// 沙盒document路径
    /// - Returns: 文件路径
    public class func documentPath() -> String {
        let documentPaths:Array<String> = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                                FileManager.SearchPathDomainMask.userDomainMask, true)
        return documentPaths[0]
    }
    
    /// 获取文件的后缀名
    /// - Parameter filePath: 文件的沙盒路径
    /// - Returns: 文件的后缀名
    public class func pathExtension(filePath:String) -> String? {
        if isExistDirectory(folderPath: filePath) == true {
            return nil
        }
        return filePath.extension
    }
    
    /// 获取文件的名字 包含后缀名
    /// - Parameter filePath: 文件路径，包含字母，数字之前的字符需要先执行URLEncode
    /// - Returns: 文件的名字
    public class func fileNameWithExtension(filePath:String) -> String? {
        if isExistDirectory(folderPath: filePath) == true {
            return nil
        }
        let url = URL.init(fileURLWithPath: filePath)
        return url.lastPathComponent
    }
    
    /// 获取文件的名字 不包含后缀名
    /// - Parameter filePath: 文件路径，包含字母，数字之前的字符需要先执行URLEncode
    /// - Returns: 文件的名字
    public class func fileNameWithoutExtension(filePath:String) -> String? {
        if isExistDirectory(folderPath: filePath) == true {
            return nil
        }
        let url = URL.init(fileURLWithPath: filePath)
       return url.deletingPathExtension().lastPathComponent
    }
    
    /// 文件所在的文件夹路径
    /// - Parameter filePath: 文件路径，包含字母，数字之前的字符需要先执行URLEncode
    /// - Returns: 文件夹路径
    public class func directory(filePath:String) -> String? {
        if isExistDirectory(folderPath: filePath) == true {
            return nil
        }
        let url = URL.init(fileURLWithPath: filePath)
        let path = url.deletingLastPathComponent().path
        return path
    }
    
    ///  获取某一路径下的文件路径列表，不包含文件夹
    /// - Parameter folderPath: 文件夹路径
    /// - Returns: 文件路径数组
    public class func filesWithoutFolder(at folderPath:String) -> Array<String>? {
        filesWithoutFolder(at: folderPath, extensions: nil)
    }
    
    /// 获取某一路径下指定后缀名的文件路径列表，不包含文件夹
    /// - Parameters:
    ///   - folderPath: 文件夹路径
    ///   - extensions: 文件后缀数组
    /// - Returns: 文件路径数组
    public class func filesWithoutFolder(at folderPath:String, extensions:Array<String>?) -> Array<String>? {
        if isExistDirectory(folderPath: folderPath) == false {
            return nil
        }
        guard let dirEnum:FileManager.DirectoryEnumerator = FileManager.default.enumerator(atPath: folderPath) else {
            return nil
        }
        var files:[String] = []
        while let fileName:String = dirEnum.nextObject() as? String {
            let filePath = "\(folderPath)/\(fileName)"
            if isExistDirectory(folderPath: filePath) == true {
                continue
            }
            if isExistFile(filePath: filePath) == false {
                continue
            }
            
            let pathExtension = filePath.extension
            if extensions == nil {
                files.append(filePath)
            } else {
                if extensions?.contains(pathExtension) == true {
                    files.append(filePath)
                }
            }
        }
        return files
    }
    
    /// 获取某一路径下的文件夹列表
    /// - Parameter folderPath: 文件夹路径
    /// - Returns: 文件夹路径列表
    public class func folders(at folderPath:String) -> Array<String>? {
        if isExistDirectory(folderPath: folderPath) == false {
            return nil
        }
        guard let dirEnum:FileManager.DirectoryEnumerator = FileManager.default.enumerator(atPath: folderPath) else {
            return nil
        }
        var folders:[String] = []
        while let fileName:String = dirEnum.nextObject() as? String {
            let tmpFolderPath = "\(folderPath)/\(fileName)"
            if isExistDirectory(folderPath: tmpFolderPath) == false {
                continue
            }
            folders.append(tmpFolderPath)
        }
        return folders
    }
    
    /// 判断某个路径下的文件是否存在
    /// - Parameter filePath: 文件路径
    /// - Returns: 文件是否存在的状态
    public class func isExistFile(filePath:String) -> Bool {
        FileManager.default.fileExists(atPath: filePath)
    }
    
    /// 判断某个路径下文件夹是否存在
    /// - Parameter folderPath: 文件夹路径
    /// - Returns: 是否存在文件夹
    public class func isExistDirectory(folderPath:String) -> Bool {
        var isDirectory = ObjCBool.init(false)
        let isExist = FileManager.default.fileExists(atPath: folderPath, isDirectory: &isDirectory)
        return isExist && isDirectory.boolValue
    }
    
    /// 在沙盒document目录下创建文件
    /// - Parameters:
    ///   - fileName: 文件名字
    ///   - data: shuju
    /// - Returns: 文件路径
    public class func createDocumentFile(fileName:String, data:Data) -> String? {
        createDocumentFile(folderName: nil, fileName: fileName, data: data)
    }
    
    /// 在沙盒document下指定子文件夹内创建文件
    /// - Parameters:
    ///   - folderName: 子文件夹名字
    ///   - fileName: 文件名字
    ///   - data: 数据
    /// - Returns: 文件路径
    public class func createDocumentFile(folderName:String?, fileName:String, data:Data) ->String? {
        let documentDictory = documentPath()
        var currentFolderPath = documentDictory
        if folderName != nil {
            currentFolderPath = "\(documentDictory)/\(fileName)"
        }
       return createFile(folderPath: currentFolderPath, fileName: fileName, data: data)
    }
    
    /// 在沙盒cache目录下创建文件
    /// - Parameters:
    ///   - fileName: 文件名字
    ///   - data: 数据
    /// - Returns: 文件路径
    public class func createCacheFile(with fileName:String, data:Data) -> String? {
        createCacheFile(folderName: nil, fileName: fileName, data: data)
    }
    
    /// 在沙盒cache目录下指定子文件夹内创建文案
    /// - Parameters:
    ///   - folderName: 子文件夹名字
    ///   - fileName: 文件名字
    ///   - data: 数据
    /// - Returns: 文件路径
    public class func createCacheFile(folderName:String?, fileName:String, data:Data) -> String? {
        let cacheDictory = cachePath()
        var currentFolderPath = cacheDictory
        if folderName != nil {
            currentFolderPath = "\(cacheDictory)/\(fileName)"
        }
       return createFile(folderPath: currentFolderPath, fileName: fileName, data: data)
    }
    
    /// 创建文件夹
    /// - Parameter folderPath: 文件夹路径
    /// - Returns: 是否创建成功
    public class func createDirectory(folderPath:String) -> Bool {
       let result = isExistDirectory(folderPath: folderPath)
        if result == false {
            do {
                let url = URL.init(fileURLWithPath: folderPath)
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
               return false
            }
        }
        return true
    }
    
    /// 创建文件
    /// - Parameters:
    ///   - folderPath: 文件夹路径
    ///   - fileName: 文件名字
    ///   - data: 数据
    /// - Returns: 文件路径
    public class func createFile(folderPath:String, fileName:String, data:Data) -> String? {
        
       let result = createDirectory(folderPath: folderPath)
        if result == false {
            return nil
        }
        let filePath = "\(folderPath)/\(fileName)"
        do {
            let url = URL.init(fileURLWithPath: filePath)
            try data.write(to: url, options: .atomic)
        } catch  {
            return nil
        }
        return filePath
    }
    
    /// 删除文件
    /// - Parameter filePath: 文件路径
    /// - Returns: 是否成功
    public class func deleteFile(filePath:String) -> Bool {
        var result = true
        do {
            try FileManager.default.removeItem(atPath: filePath)
        } catch {
            result = false
        }
        return result
    }
    
    /// 移动文件
    /// - Parameters:
    ///   - originFilePath: 原来的路径
    ///   - targetFilePath: 目标路径
    /// - Returns: 是否成功
    public class func move(from originFilePath:String, to targetFilePath:String) -> Bool {
        if isExistFile(filePath: targetFilePath) {
           let result = deleteFile(filePath: targetFilePath)
            if result == false {
                return false
            }
        }
        do {
            try FileManager.default.moveItem(atPath: originFilePath, toPath: targetFilePath)
        } catch {
            return false
        }
        return true
    }
    
    /// 复制文件
    /// - Parameters:
    ///   - originFilePath: 原来的路径
    ///   - targetFilePath: 目标路径
    /// - Returns: 是否成功
    public class func copy(from originFilePath:String, to targetFilePath:String) -> Bool {
        if isExistFile(filePath: targetFilePath) {
           let result = deleteFile(filePath: targetFilePath)
            if result == false {
                return false
            }
        }
        do {
            try FileManager.default.copyItem(atPath: originFilePath, toPath: targetFilePath)
        } catch {
            return false
        }
        return true
    }
    
    /// 获取文件的相对路径
    /// - Parameters:
    ///   - targetPath: 目标路径
    ///   - path: 被比较的路径
    /// - Returns: 相对路径
    public class func relativePath(targetPath:String, to path:String) -> String? {
        if targetPath.count < path.count {
            return nil
        }
        if targetPath.count == path.count {
            return ""
        }
        if targetPath.hasPrefix(path) == false {
            return nil
        }
        let startIndex = path.endIndex
        let endIndex = targetPath.endIndex
        let relativePath:String = String(targetPath[startIndex..<endIndex])
        return relativePath
    }
    
    /// 获取bundle对象，bundle名字和pod库名字相同
    /// - Parameter podName: pod库名字
    /// - Returns: bundle对象
    public class func bundle(podName:String?) -> Bundle? {
       return bundle(podName: podName, bundleName: podName)
    }
    
    /// 获取bundle对象
    /// - Parameters:
    ///   - podName: pod库名字,没有的话默认是mainBundle
    ///   - bundleName: bundle名字
    /// - Returns: bundle对象
    public class func bundle(podName:String?, bundleName:String?) -> Bundle? {
        var bundleInstance:Bundle?
        if podName == nil {
            bundleInstance = .main
        } else {
            let bundleClass: AnyClass? = NSClassFromString(podName!)
            if bundleClass != nil {
                bundleInstance = Bundle.init(for: bundleClass!)
            } else {
                let frameworks = Bundle.allFrameworks
                for tempBundle:Bundle in frameworks {
                    let url = URL.init(fileURLWithPath: tempBundle.bundlePath)
                    let frameworkName = url.deletingPathExtension().lastPathComponent
                    if frameworkName == podName {
                        bundleInstance = tempBundle
                        break
                    }
                }
            }
        }
        
        let url:URL? = bundleInstance?.url(forResource: bundleName, withExtension: "bundle")
        if url == nil {
            return nil
        }
        bundleInstance = Bundle.init(url: url!)
        if bundleInstance?.isLoaded == false {
            bundleInstance?.load()
        }
        return bundleInstance
    }
    
    /// 获取文件路径,文件在pod库同名的bundle下
    /// - Parameters:
    ///   - podName: pod库名字
    ///   - fileName: 文件名字
    /// - Returns: 文件路径
    public class func path(podName:String, fileName:String) -> String? {
        path(fileName: fileName, podName: podName, type: nil)
    }
    
    /// 获取文件路径,文件在pod库同名的bundle下
    /// - Parameters:
    ///   - fileName: 文件名字
    ///   - podName: pod库的名字
    ///   - type: 文件类型
    /// - Returns: 文件路径
    public class func path(fileName:String, podName:String, type:String?) -> String? {
        path(podName: podName, bundleName: podName, fileName: fileName, type: type)
    }
    
    /// 获取文件路径
    /// - Parameters:
    ///   - podName: pod库名字
    ///   - bundleName: bundle名字
    ///   - fileName: 文件名字
    ///   - type: 文件类型
    /// - Returns: 文件路径
    public class func path(podName:String, bundleName:String?, fileName:String, type:String?) -> String? {
        let bundleInstance:Bundle? = bundle(podName: podName, bundleName: bundleName)
        let filePath = bundleInstance?.path(forResource: fileName, ofType: type)
        return filePath
    }
    
    /// 创建nib对象
    /// - Parameters:
    ///   - podName: pod库名字
    ///   - nibName: nib文件名字
    /// - Returns: nib对象
    public class func nib(podName:String, nibName:String) -> UINib? {
        let bundleInstance:Bundle? = bundle(podName: podName)
        if bundleInstance == nil {
            return nil
        }
        let nib = bundleInstance!.loadNibNamed(nibName, owner: nil, options: nil)?.last
        if nib == nil {
            return nil
        }
        if (nib! as AnyObject).isKind(of: UINib.self) {
            return (nib as! UINib)
        }
        return nil
    }
    
    /// 创建storyboard对象
    /// - Parameters:
    ///   - podName: pod库名字
    ///   - name: storyboard文件名字
    /// - Returns: storyboard对象
    public class func storyboard(podName:String, name:String) -> UIStoryboard? {
        let bundleInstance:Bundle? = bundle(podName: podName)
        if bundleInstance == nil {
            return nil
        }
        let storyboard:UIStoryboard? = UIStoryboard.init(name: name, bundle: bundleInstance)
        return storyboard
    }
    
    /// 创建UIImage，文件在pod库同名的bundle内
    /// - Parameters:
    ///   - podName: pod库名字
    ///   - imageName: 图片的名字
    /// - Returns: UIImage对象
    public class func image(podName:String, imageName:String) -> UIImage? {
      return image(podName: podName, bundleName: podName, imageName: imageName)
    }
    
    /// 创建UIImage,文件在pod库指定名字的bundle内
    /// - Parameters:
    ///   - podName: pod库名字
    ///   - bundleName: bundle名字
    ///   - imageName: 文件名字
    /// - Returns: UIImage对象
    public class func image(podName:String, bundleName:String, imageName:String) -> UIImage? {
        let image:UIImage? = UIImage.init(named: imageName, in: bundle(podName: podName, bundleName: bundleName), compatibleWith: nil)
        return image
    }
    
    /// 根据key获取多语言文案，当前系统语言
    /// - Parameter key: 多语言对应的key
    /// - Returns: 对应的多语言文案
    public class func localizedString(key:String) -> String? {
        localizedString(key: key, podName: nil)
    }
    
    /// 根据key，指定的语言获取多语言文案
    /// - Parameters:
    ///   - key: 多语言文案对应的key
    ///   - language: 指定的语言
    /// - Returns: 对应的多语言文案
    public class func localizedString(key:String, language:String) -> String? {
        localizedString(key: key, podName: nil, language: language)
    }
    
    /// 根据key，podName获取组件内的多语言文案
    /// - Parameters:
    ///   - key: 多语言文案对应的key
    ///   - podName: pod库的名字
    /// - Returns: 对应的多语言文案
    public class func localizedString(key:String, podName:String?) -> String? {
        let languages = Locale.preferredLanguages
        var language = languages.first
        if language?.hasPrefix("zh") == true {
            language = "zh-Hans"
        } else {
            language = "en"
        }
       return localizedString(key: key, podName: podName, language: language!)
    }
    
    /// 根据key，language，podName获取对应的多语言文案
    /// - Parameters:
    ///   - key: 多语言文案对应的key
    ///   - podName: pod库的名字，没有的话默认在mainBundle下查找
    ///   - language: 指定的语言
    /// - Returns: 对应的多语言文案
    public class func localizedString(key:String, podName:String?, language:String) -> String? {
        if podName == nil {
            return Bundle.main.localizedString(forKey: key, value: nil, table: nil)
        }
        let bundleInstance:Bundle? = bundle(podName: podName)
        let value = bundleInstance?.localizedString(forKey: key, value: nil, table: podName)
        return value
    }
}
