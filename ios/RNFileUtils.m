//
//  RNFileUtils.m
//  

#import "RNFileUtils.h"

@implementation RNFileUtils

+ (BOOL)ensureDirExistsWithPath:(NSString *)path
{
    BOOL isDir = NO;
    NSError *error;
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    if (!(exists && isDir)) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            return NO;
        }
    }
    return YES;
}

+ (NSString *)generatePathInDirectory:(NSString *)directory withExtension:(NSString *)extension
{
    NSString *fileName = [[[NSUUID UUID] UUIDString] stringByAppendingString:extension];
    [RNFileUtils ensureDirExistsWithPath:directory];
    return [directory stringByAppendingPathComponent:fileName];
}

+ (NSString *)cacheDirectoryPath
{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [array objectAtIndex:0];
}

@end

