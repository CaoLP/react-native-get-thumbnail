
#import "RNGetThumbnail.h"
#import "RNImageHandle.h"
#import "RNFileUtils.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAsset.h>
#import <UIKit/UIKit.h>

static NSString* const OPTIONS_KEY_QUALITY = @"quality";
static NSString* const OPTIONS_KEY_TIME = @"time";
static NSString* const OPTIONS_KEY_HEADERS = @"headers";

@implementation RNGetThumbnail



- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(getThumbnail:(NSString *)source options: (NSDictionary *)options resolve: (RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
{
  NSURL *url = [NSURL URLWithString:source];
    NSString *responseString;

  long timeInMs = [(NSNumber *)options[OPTIONS_KEY_TIME] integerValue] ?: 0;
  float quality = [(NSNumber *)options[OPTIONS_KEY_QUALITY] floatValue] ?: 1.0;
  NSDictionary *headers = options[OPTIONS_KEY_HEADERS] ?: @{};

  AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:@{@"AVURLAssetHTTPHeaderFieldsKey": headers}];
  AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
  generator.appliesPreferredTrackTransform = YES;

  NSError *err = NULL;
  CMTime time = CMTimeMake(timeInMs, 1000);

  CGImageRef imgRef = [generator copyCGImageAtTime:time actualTime:NULL error:&err];
  if (err) {
    return reject(@"E_THUM_FAIL", err.localizedFailureReason, err);
  }
  UIImage *thumbnail = [UIImage imageWithCGImage:imgRef];
    
    NSString *fullPath = [RNFileUtils generatePathInDirectory:[[RNFileUtils cacheDirectoryPath] stringByAppendingPathComponent:@"Camera"] withExtension:@".jpg"];

    NSData *photoData = UIImageJPEGRepresentation(thumbnail, 1);
    if (![options[@"doNotSave"] boolValue]) {
       responseString = [RNImageHandle writeImage:photoData toPath:fullPath];
    }
    


  resolve(@{
            @"uri" : responseString,
            @"width" : @(thumbnail.size.width),
            @"height" : @(thumbnail.size.height),
            });
}

@end
  
