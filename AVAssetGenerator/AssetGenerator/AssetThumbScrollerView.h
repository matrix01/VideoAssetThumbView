//
//  AssetThumbScrollerView.h
//  AVAssetGenerator
//
//  Created by Milan Mia on 12/15/17.
//  Copyright © 2017 Milan Mia. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AVFoundation;

#define THUMB_WIDTH 65
#define PIX_PER_SECOND 15

@interface AssetThumbScrollerView : UIView {
    AVAsset *mainAsset;
    NSOperationQueue *myQueue;
}

- (instancetype)initWithFrame:(CGRect)frame andAsset:(AVAsset*)asset;
- (void) cancelThumbGenerating;
@end
