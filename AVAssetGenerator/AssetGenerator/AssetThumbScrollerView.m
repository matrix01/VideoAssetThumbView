//
//  AssetThumbScrollerView.m
//  AVAssetGenerator
//
//  Created by Milan Mia on 12/15/17.
//  Copyright © 2017 Milan Mia. All rights reserved.
//

#import "AssetThumbScrollerView.h"
@import AVFoundation;

@implementation AssetThumbScrollerView

- (instancetype)initWithFrame:(CGRect)frame andAsset:(AVAsset*)asset {
    self = [super initWithFrame:frame];
    if (self) {
        mainAsset = asset;
        [self generateThumbView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)cancelThumbGenerating {
    [myQueue cancelAllOperations];
}

-(void)dealloc{
    [myQueue cancelAllOperations];
}
/* Make your own time calculation according to your need...*/
-(void) generateThumbView {
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:mainAsset];
    imageGenerator.requestedTimeToleranceAfter = kCMTimeZero;
    imageGenerator.requestedTimeToleranceBefore = kCMTimeZero;
    
    CMTime time = kCMTimeZero;
    CMTime duration = mainAsset.duration;
    CGFloat fullDuration = CMTimeGetSeconds(duration);
    CGFloat fullWidth = fullDuration * PIX_PER_SECOND;
    CGFloat thumbWidth = PIX_PER_SECOND * 3;
    
    CGSize maxSize = CGSizeMake(128 * [UIScreen mainScreen].scale, 128 * [UIScreen mainScreen].scale);
    imageGenerator.maximumSize = maxSize;
    
    NSUInteger noOfThumb = fullWidth / thumbWidth;
    CGFloat avgTime= fullDuration / noOfThumb;
    CMTime avgCMTime = CMTimeMakeWithSeconds(avgTime, duration.timescale);
    
    myQueue = [[NSOperationQueue alloc] init];
    myQueue.maxConcurrentOperationCount = 1;
    UIImage *placeholder = [UIImage imageNamed:@"loading.png"];
    for(NSUInteger i = 0; i< noOfThumb; i++) {
        UIImageView *thumbLayer = [[UIImageView alloc] initWithFrame:CGRectMake(i*THUMB_WIDTH, 0, THUMB_WIDTH, self.frame.size.height)];
        [self addSubview:thumbLayer];
        thumbLayer.tag = i + 100;
        thumbLayer.image = placeholder;
        thumbLayer.contentMode= UIViewContentModeScaleAspectFit;
        thumbLayer.clipsToBounds = YES;
    }
    time = CMTimeMakeWithSeconds(avgTime/2, duration.timescale);
    for(NSUInteger i = 0; i< noOfThumb; i++) {
        NSOperation *op =  [NSBlockOperation blockOperationWithBlock:^{
            CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
            UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                UIImageView *thView = [self viewWithTag:i+100];
                thView.contentMode= UIViewContentModeScaleAspectFill;
                thView.image = thumbnail;
                CGImageRelease(imageRef);
            }];
        }];
        [myQueue addOperation:op];
        time = CMTimeAdd(time, avgCMTime);
    }
    self.frame = CGRectMake(0, 0, noOfThumb*THUMB_WIDTH, self.frame.size.height);
}



@end
