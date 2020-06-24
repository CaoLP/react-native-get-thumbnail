//
//  RNImageHandle.h
//

#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>
#import <Foundation/Foundation.h>

@interface RNImageHandle : NSObject

+ (UIImage *)generatePhotoOfSize:(CGSize)size;
+ (UIImage *)cropImage:(UIImage *)image toRect:(CGRect)rect;
+ (UIImage *)mirrorImage:(UIImage *)image;
+ (UIImage *)forceUpOrientation:(UIImage *)image;
+ (NSString *)writeImage:(NSData *)image toPath:(NSString *)path;
+ (UIImage *) scaleImage:(UIImage*)image toWidth:(NSInteger)width;
+ (void)updatePhotoMetadata:(CMSampleBufferRef)imageSampleBuffer withAdditionalData:(NSDictionary *)additionalData inResponse:(NSMutableDictionary *)response;
+ (UIImage *)invertColors:(UIImage *)image;

@end

