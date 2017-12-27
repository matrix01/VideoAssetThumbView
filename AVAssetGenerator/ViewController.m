//
//  ViewController.m
//  AVAssetGenerator
//
//  Created by Milan Mia on 12/15/17.
//  Copyright © 2017 Milan Mia. All rights reserved.
//

#import "ViewController.h"
#import "AssetThumbScrollerView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *thumbScroller;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TestingVideo" ofType:@".mp4"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    AVAsset *asset = [AVAsset assetWithURL:url];
    UIView *view = [[AssetThumbScrollerView alloc] initWithFrame:_thumbScroller.bounds andAsset:asset];
    [_thumbScroller addSubview:view];
    _thumbScroller.contentSize = view.frame.size;
}
-(void)viewDidAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
