//
//  ViewController.m
//  SnapShotObject
//
//  Created by 赵张杰 on 2017/9/12.
//  Copyright © 2017年 zhaozhangjie. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
@interface ViewController () {
    UIImageView *_screentView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    _screentView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, self.view.bounds.size.width - 20*2, self.view.bounds.size.height - 20*2)];
    [self.view addSubview:_screentView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(snapShot:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}

- (void)snapShot:(NSNotification *)notification {
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    PHAsset *asset = [assetsFetchResults firstObject];
    // 使用PHImageManager从PHAsset中请求图片
    PHImageManager *imageManager = [[PHImageManager alloc] init];
    [imageManager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result) {
            // result 即为查找到的图片,也是此时的截屏图片
            [_screentView setImage:result];
            self.view.backgroundColor = [UIColor yellowColor];
        }
    }];
}

@end
