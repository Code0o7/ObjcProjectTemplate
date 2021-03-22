//
//  UIViewController+HYImagePicker.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// pickerView类型
typedef NS_ENUM(NSInteger, PickerType) {
    PickerTypeAlbum,         // 打开相册
    PickerTypeCamera         // 打开相机
};

/**
 相册/相机 文件类型
 */
typedef NS_ENUM(NSInteger, PickerFileType) {
    PickerFileTypeImage,         // 只有图片
    PickerFileTypeVideo,         // 只有视频
    PickerFileTypeImageAndVideo  // 同时有图片和视频
};

@interface UIViewController (HYImagePicker)<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

/**
 照片/视频选择完成回调
 imageData 图片二进制
 image 图片对象
 isVideo 是否是视频
 videoDuration 视频时长
 extension 后缀类型
 */
@property (nonatomic, copy) void (^ _Nullable imagePickCompleteBlock)(NSData  * _Nullable imageData,UIImage * _Nullable image, BOOL isVideo, NSInteger videoDuration, NSString * _Nullable extension);

#pragma mark - 相册/相机
/**
 打开相机/相册
 @param pickerType 打开pickerView类型(参考 PickerType 枚举各个类型注释)
 @param pickerFileType 文件类型(参考 PickerFileType 枚举各个类型注释)
 */
- (void)openPickerView:(PickerType)pickerType
        pickerFileType:(PickerFileType)pickerFileType;

@end

NS_ASSUME_NONNULL_END