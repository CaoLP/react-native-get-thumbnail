//
//  RNFileUtils.h
//  

#import <Foundation/Foundation.h>

@interface RNFileUtils : NSObject

+ (BOOL)ensureDirExistsWithPath:(NSString *)path;
+ (NSString *)generatePathInDirectory:(NSString *)directory withExtension:(NSString *)extension;
+ (NSString *)cacheDirectoryPath;

@end

