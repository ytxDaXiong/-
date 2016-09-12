//
//  YTXSeeBigViewController.m
//  百思不得姐
//
//  Created by 俞天 on 16/9/9.
//  Copyright © 2016年 sju. All rights reserved.
//

#import "YTXSeeBigViewController.h"
#import "YTXTopic.h"
#import <UIImageView+WebCache.h>

//#import <AssetsLibrary/AssetsLibrary.h> //iOS开始废弃
#import <Photos/Photos.h>
#import <SVProgressHUD.h>
@interface YTXSeeBigViewController () <UIScrollViewDelegate>
/** 图片控件 */
@property (nonatomic, weak) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation YTXSeeBigViewController

static NSString * YTXAssetCollectionTitle = @"百思不得姐";
- (void)viewDidLoad {
    [super viewDidLoad];
    // scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    //imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        self.saveButton.enabled = YES;
    }];
    [scrollView addSubview:imageView];
    imageView.ytx_width = scrollView.ytx_width;
    imageView.ytx_height = self.topic.height * imageView.ytx_width / self.topic.width;
    imageView.ytx_x = 0;
    
    if (imageView.ytx_height >= scrollView.ytx_height) {//图片的高度超过整个屏幕
        imageView.ytx_y = 0;
        //滚动范围
        scrollView.contentSize = CGSizeMake(0, imageView.ytx_height);
    } else {//居中显示
        imageView.ytx_centerY = scrollView.ytx_height * 0.5;
    }
    self.imageView = imageView;
    
    //缩放比例
    CGFloat scale = self.topic.width / imageView.ytx_width;
    if (scale > 1.0) {
        scrollView.maximumZoomScale = scale;
    }
}
- (IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted) {
        // 因为家长控制，导致应该无法访问相册（跟用户的选择没有关系）
        [SVProgressHUD showErrorWithStatus:@"因为系统原因，无法访问相册"];
    } else if (status == PHAuthorizationStatusDenied){
        //用户拒绝当前应用访问相册（用户当初点击了“不允许”）
        YTXLog(@"提醒用户去[设置-隐私-照片-xxx]打开访问开关");
    } else if (status == PHAuthorizationStatusAuthorized){
        //用户允许当前应用访问相册（用户点击了“好”）
        [self saveImage];
    } else if (status == PHAuthorizationStatusNotDetermined){
        //用户还没有做出选择
        //弹框请求用户授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                //点击了好
                [self saveImage];
            }
        }];
    
    }
    
}
- (void)saveImage
{
    //PHAsset : 一个资源，比如一张图片\一段视频
    //PHAssetCollection : 一个相册
    
    //PHAsset的标识，利用这个标识可以找到对应的PHAsset对象（图片对象）
    __block NSString *assetLocalIdentifier = nil;
    
    // 如果想对“相册”进行修改，那么修改代码必须放在[PHPhotoLibrary sharedPhotoLibrary]的performChanges方法的block中
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 1.保存图片A到相机胶卷中
        //创建图片的请求
        assetLocalIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            [self showError:@"保存图片失败"];
            return;
        }
        
        // 2.获得相册
        PHAssetCollection *createdAsserCollection = [self createdAssetCollection];
        if (createdAsserCollection == nil) {
            [self showError:@"创建相薄失败"];
            return;
        }
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            //3.添加"相机胶卷"中的图片A到"相薄"D中
            
            //获得图片
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
            
            //添加图片到相薄中的请求
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAsserCollection];
            // 添加图片给相薄
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success == NO) {
                [self showError:@"保存图片失败！"];
            } else {
                [self showSuccess:@"保存图片成功"];
            }
        }];
    }];
    
}

/**
 *  获得相簿
 */
- (PHAssetCollection *)createdAssetCollection
{
    //从已存在相簿中查找这个应用对应的相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil]
    ;
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:YTXAssetCollectionTitle]) {
            return assetCollection;
        }
    }
    //没有找到对应的相簿，得创建新的相簿
    
    //错误信息
    NSError *error = nil;
    
    //PHAssetCollection的标识，利用这个标识可以直接找到对应的PHAssetCollection对象（相簿对象）
    __block NSString *assetCollectionLocalIdentifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        //创建相簿的请求
        assetCollectionLocalIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:YTXAssetCollectionTitle].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    //如果有错误信息
    if (error) return nil;
    
    //获得刚才创建的相薄
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionLocalIdentifier] options:nil].lastObject;
}

- (void)showSuccess:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:text];
    });
}

- (void)showError:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showErrorWithStatus:text];
    });
}
#pragma mark - <UIScrollViewDelegate>
/**
 *  返回一个scrollView的子控件进行缩放
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
