//
//  UIViewController+HYImagePicker.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import "UIViewController+HYImagePicker.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/Photos.h>
#import <objc/runtime.h>

static char photoBlock;

@implementation UIViewController (HYImagePicker)

#pragma mark - 关联属性
//getter
- (ImageCompleteBlock)imagePickCompleteBlock
{
    return objc_getAssociatedObject(self, &photoBlock);
}
- (void)setImagePickCompleteBlock:(ImageCompleteBlock)imagePickCompleteBlock
{
    objc_setAssociatedObject(self, &photoBlock, imagePickCompleteBlock, OBJC_ASSOCIATION_COPY);
}

#pragma mark - 相册/相机
/**
 打开相机/相册
 @param pickerType 打开pickerView类型(参考 PickerType 枚举各个类型注释)
 @param pickerFileType 文件类型(参考 PickerFileType 枚举各个类型注释)
 @param complete 完成回调
 */
- (void)openImagePickerView:(PickerType)pickerType
        pickerFileType:(PickerFileType)pickerFileType
              complete:(ImageCompleteBlock)complete
{
    UIImagePickerController *pc = [[UIImagePickerController alloc]init];
    pc.delegate = self;
    self.imagePickCompleteBlock = complete;
    
    // 设置可选照片和视频
    NSArray *mediaTypes = nil;
    switch (pickerFileType) {
        case PickerFileTypeImage:
            // 只有图片
            mediaTypes = @[(NSString *)kUTTypeImage];
            break;
        case PickerFileTypeVideo:
            // 只有视频
            mediaTypes = @[(NSString *)kUTTypeMovie];
            break;
        case PickerFileTypeImageAndVideo:
            // 图片和视频
            mediaTypes = @[(NSString *)kUTTypeImage,(NSString *)kUTTypeMovie];
            break;
        default:
            break;
    }
    pc.mediaTypes = mediaTypes;
    
    if (pickerType == PickerTypeAlbum) {
        // 相册
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied){
            [self showAlertWithTitle:nil message:@"请开启相册权限" btnTitles:@[@"确定"] btnActionBlocks:@[^{}]];
        }else{
            // 打开相册
            pc.sourceType = pickerType == PickerTypeAlbum ? UIImagePickerControllerSourceTypeSavedPhotosAlbum : UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:pc animated:YES completion:nil];
        }
    }else {
        // 相机
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied)
        {
            [self showAlertWithTitle:nil message:@"请开启相机权限" btnTitles:@[@"确定"] btnActionBlocks:@[^{}]];
        }else{
            // 打开相机
            pc.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:pc animated:YES completion:nil];
        }
    }
}

// 视频导出到自己APP
- (void)startExportVideoWithVideoAsset:(AVURLAsset *)videoAsset completion:(void (^)(NSString *outputPath))completion
{
    // Find compatible presets by video asset.
    NSArray *presets = [AVAssetExportSession exportPresetsCompatibleWithAsset:videoAsset];
    
    NSString *pre = nil;
    if ([presets containsObject:AVAssetExportPreset3840x2160]){
        pre = AVAssetExportPreset3840x2160;
    }else if([presets containsObject:AVAssetExportPreset1920x1080]){
        pre = AVAssetExportPreset1920x1080;
    }else if([presets containsObject:AVAssetExportPreset1280x720]){
        pre = AVAssetExportPreset1280x720;
    }else if([presets containsObject:AVAssetExportPreset960x540]){
        pre = AVAssetExportPreset1280x720;
    }else{
        pre = AVAssetExportPreset640x480;
    }
    
    // Begin to compress video
    // Now we just compress to low resolution if it supports
    // If you need to upload to the server, but server does't support to upload by streaming,
    // You can compress the resolution to lower. Or you can support more higher resolution.
    if ([presets containsObject:AVAssetExportPreset640x480]) {
        AVAssetExportSession *session = [[AVAssetExportSession alloc]initWithAsset:videoAsset presetName:AVAssetExportPreset640x480];
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yy-MM-dd-HH:mm:ss"];
        
        NSString *outputPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", [[formater stringFromDate:[NSDate date]] stringByAppendingString:@".mp4"]];
        NSLog(@"导出视频路径:%@",outputPath);
        
        //删除原来的 防止重复选
//        _timeSecond = 0;
//        [[NSFileManager defaultManager] removeItemAtPath:_filePath error:nil];
//        [[NSFileManager defaultManager] removeItemAtPath:_imagePath error:nil];
//
//        _filePath = outputPath;
        session.outputURL = [NSURL fileURLWithPath:outputPath];
        
        // Optimize for network use.
        session.shouldOptimizeForNetworkUse = true;
        
        NSArray *supportedTypeArray = session.supportedFileTypes;
        if ([supportedTypeArray containsObject:AVFileTypeMPEG4]) {
            session.outputFileType = AVFileTypeMPEG4;
        } else if (supportedTypeArray.count == 0) {
            // 视频类型暂不支持导出
            [self showAlertWithTitle:nil message:@"获取视频失败，请重试" btnTitles:@[@"确定"] btnActionBlocks:@[^{}]];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(nil);
                }
            });
            return;
        } else {
            session.outputFileType = [supportedTypeArray objectAtIndex:0];
        }
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents"]]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents"] withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:outputPath]) {
            [[NSFileManager defaultManager] removeItemAtPath:outputPath error:nil];
        }
        
        // Begin to export video to the output path asynchronously.
        [session exportAsynchronouslyWithCompletionHandler:^(void) {
            switch (session.status) {
                case AVAssetExportSessionStatusUnknown:
                    NSLog(@"视频导出状态未知"); break;
                case AVAssetExportSessionStatusWaiting:
                    NSLog(@"视频等待导出"); break;
                case AVAssetExportSessionStatusExporting:
                    NSLog(@"视频导出中..."); break;
                case AVAssetExportSessionStatusCompleted: {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (completion) {
                            completion(outputPath);
                        }
                    });
                }  break;
                case AVAssetExportSessionStatusFailed:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (completion) {
                            completion(nil);
                        }
                    });
                }
                    break;
                default: break;
            }
        }];
    }
}


// 获取视频时长
- (NSInteger)videoDurationWithPath:(NSString *)videoPath
{
    NSURL *videoUrl = [NSURL fileURLWithPath:videoPath];
    AVURLAsset *asset = [AVURLAsset assetWithURL:videoUrl];
    NSString *duration = [NSString stringWithFormat:@"%0.0f", ceil(CMTimeGetSeconds(asset.duration))];
    return duration.integerValue;
}

#pragma mark - UIImagePickerControllerDelegate
// 照片选择/拍照 结果获取
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    // 类型
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    
    // model
    HYImageVideoModel *imageVideoModel = [HYImageVideoModel model];
    
    if (HYStringEqual(mediaType, (NSString *)kUTTypeImage)) {
        // 子线程处理照片
        [MBProgressHUD showMessage:@"请稍后..." toView:picker.view];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 图片
            UIImage *image = info[UIImagePickerControllerOriginalImage];
            NSData *imgdata;
            
            //判断图片是不是png格式的文件
            if (UIImagePNGRepresentation(image)) {
                // 压缩图片
                UIImage *imagenew = [image imageCompressWithTargetWidth:800];
                imgdata = UIImagePNGRepresentation(imagenew);
            }else {
                //返回为JPEG图像。
                UIImage *imagenew = [image imageCompressWithTargetWidth:800];
                imgdata = UIImageJPEGRepresentation(imagenew, 0.3);
            }
            
            // 选择照片完成 回到主线程执行后续任务
            dispatch_async(dispatch_get_main_queue(), ^{
                DISMISS
                [MBProgressHUD hideHUDForView:picker.view];
                
                imageVideoModel.data = imgdata;
                imageVideoModel.image = image;
                imageVideoModel.video = NO;
                
                if (self.imagePickCompleteBlock) {
                    self.imagePickCompleteBlock(imageVideoModel);
                }
                
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        });
    }else if (HYStringEqual(mediaType, (NSString *)kUTTypeMovie)) {
        // 视频  获取临时路径
        NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        
        // 临时路径不能作为视频路径直接上传，需要把原视频导出到自己的APP内，而后根据这个路径进行上传
        AVURLAsset *asset = [AVURLAsset assetWithURL:videoUrl];
        
//        // 视频数据
//        NSData *videoData = [[NSData alloc]initWithContentsOfURL:videoUrl];
//        // 视频时长
//        NSString *duration = [NSString stringWithFormat:@"%0.0f", ceil(CMTimeGetSeconds(asset.duration))];
//        NSInteger dur = duration.intValue;
//        // 视频封面
//        UIImage *videoCoverImage = [self getImageWithAsset:asset];
        
//        NSLog(@"视频时长:%ld",(long)dur);
//        NSLog(@"视频数据长度:%lu",(unsigned long)videoData.length);
//        NSLog(@"视频封面size:%@",NSStringFromCGSize(videoCoverImage.size));
//        NSLog(@"类型:%@",videoUrl.absoluteString.pathExtension);
        
        
        // 视频导出
        [MBProgressHUD showMessage:@"请稍后..." toView:picker.view];
        [self startExportVideoWithVideoAsset:asset completion:^(NSString *outputPath) {
            // 获取视频信息
            NSURL *fileUrl = [NSURL fileURLWithPath:outputPath];
//            AVURLAsset *asset1 = [AVURLAsset assetWithURL:fileUrl];
            // 第一帧
            UIImage *image = [UIImage getVideoImageWithUrl:fileUrl];
            // 时长
            NSInteger dur = [self videoDurationWithPath:outputPath];
            NSData *data = [[NSData alloc]initWithContentsOfFile:outputPath];
            NSLog(@"视频时长:%ld",(long)dur);
            NSLog(@"视频数据:%lu",(unsigned long)data.length);
            
            [MBProgressHUD hideHUDForView:picker.view];
            
            imageVideoModel.data = data;
            imageVideoModel.image = image;
            imageVideoModel.video = YES;
            imageVideoModel.videoDuration = dur;
            imageVideoModel.fileType = @"mp4";
            
            if (self.imagePickCompleteBlock) {
                self.imagePickCompleteBlock(imageVideoModel);
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

@end
