//
//  HYConstMacro.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/1/16.
//

#ifndef HYConstMacro_h
#define HYConstMacro_h

#pragma mark - 屏幕相关
#define HYSCREEN_Bounds [UIScreen mainScreen].bounds
#define HYSCREEN_Size   HYSCREEN_Bounds.size
#define HYSCREEN_Width  HYSCREEN_Bounds.size.width
#define HYSCREEN_Height HYSCREEN_Bounds.size.height

// 屏幕适配
// iPhone 4/iPhone 4s：                  3.5英寸 320x480pt @2x 640x960px
// iPhone 5/5s/5c：                      4.0英寸 320x568pt @2x 640x1136px
// iPhone 6/6s/7/8：                     4.7英寸 375x667pt @2x 750x1334px
// iPhone 6 Plus/6s Plus/7 Plus/8 Plus： 5.5英寸 414x736pt @3x 1242x2208px
// iPhone SE：                           4.0英寸 320x568pt @2x 640x1136px
// iPhone X：                            5.8英寸 375x812pt @3x 1125x2436px
// iPhone Xs：                           5.8英寸 375x812pt @3x 1125x2436px
// iPhone XR：                           6.1英寸 414x896pt @2x 828x1792px
// iPhone Xs Max：                       6.5英寸 414x896pt @3x 1242x2688px
// iPhone 11：                           6.1英寸 414x896pt @2x 828x1792px
// iPhone 11 Pro：                       5.8英寸 375x812pt @3x 1125x2436px
// iPhone 11 Pro Max：                   6.5英寸 414x896pt @3x 1242x2688px
// iPhone 12：                           6.1英寸 390x844pt @3x 1170x2532px
// iPhone 12 mini：                      5.4英寸 360x780pt @3x 1080x2340px
// iPhone 12 Pro：                       6.1英寸 390x844pt @3x 1170x2532px
// iPhone 12 Pro Max：                   6.7英寸 428x926pt @3x 1284x2778px
#define HYDEVICE_Type(deviceSize) ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(deviceSize, [[UIScreen mainScreen] currentMode].size) : NO)
#define HYDEVICE_IS_IPHONE_X        HYDEVICE_Type(CGSizeMake(1125, 2436))
#define HYDEVICE_IS_IPHONE_Xr       HYDEVICE_Type(CGSizeMake(828, 1792))
#define HYDEVICE_IS_IPHONE_Xs_Max   HYDEVICE_Type(CGSizeMake(1242, 2688))
#define HYDEVICE_IS_iPhone12_mini   HYDEVICE_Type(CGSizeMake(1080, 2340))
#define HYDEVICE_IS_iPhone12        HYDEVICE_Type(CGSizeMake(1170, 2532))
#define HYDEVICE_IS_iPhone12_Max    HYDEVICE_Type(CGSizeMake(1284, 2778))
// 是否有刘海
#define HYDEVICE_Has_Bang (HYDEVICE_IS_IPHONE_X == YES || HYDEVICE_IS_IPHONE_Xr == YES || HYDEVICE_IS_IPHONE_Xs_Max == YES || HYDEVICE_IS_iPhone12_mini == YES || HYDEVICE_IS_iPhone12 == YES || HYDEVICE_IS_iPhone12_Max == YES)

#define HYSCREEN_Statusbar_Height (HYDEVICE_Has_Bang ? 44.f : 20.f)
#define HYSCREEN_Statusbar_Nav_Height (HYDEVICE_Has_Bang ? 44.f : 20.f)
#define HYSCREEN_Navbar_Height 44.f
#define HYSCREEN_Bottom_Safe_Height (HYDEVICE_Has_Bang ? 34.f : 0.f)
#define HYSCREEN_Tabbar_Height (HYDEVICE_Has_Bang ? (49.f + 34.f) : (49.f))


#endif /* HYConstMacro_h */
