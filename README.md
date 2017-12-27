# VideoAssetThumbView
Generate a thumb view from AVAsset.

It's easy to use.

Please see the example or follow the instruction below:

1. Download the project.
2. Drag and drop "AssetGenerator" folder inside your project.
3. Import "AssetThumbScrollerView.h" header
4.  To add thumb view write following code in your viewDidLoad method:

    `AVAsset *asset = [AVAsset assetWithURL:url];
    UIView *view = [[AssetThumbScrollerView alloc] initWithFrame:_thumbScroller.bounds andAsset:asset];
    [_thumbScroller addSubview:view];
    _thumbScroller.contentSize = view.frame.size;`

Where _thumbScroller is a scroll View.
