//
//  UIImage+Extension.h
//  xiangcun
//
//  Created by 李孝帅 on 16/9/6.
//  Copyright © 2016年 李孝帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  给定最大的尺寸压缩至指定尺寸
 *
 *  @param length
 *
 *  @return
 */
- (NSData *)cc_imagedataWithMaxLength:(NSUInteger)length;

/**
 *  <#Description#>
 *
 *  @param length <#length description#>
 *
 *  @return <#return value description#>
 */
- (UIImage *)cc_imageWithMaxLength:(NSUInteger)length;

/**
 *  获取圆形图片
 *
 *  @return 圆形图片
 */
- (UIImage*)cc_roundedImageWithImage;

/**
 *  获取指定大小的图片
 *
 *  @param reSize 要得到的大小
 *
 *  @return 指定大小的图片
 */
- (UIImage *)cc_reSizeImageToSize:(CGSize)reSize;

/**
 *  获取该图片中间位置的指定大小图片
 *
 *  @param reSize 要得到的大小
 *
 *  @return 指定大小的图片
 */
- (UIImage *)cc_centreImageWithSize:(CGSize)reSize;

/**
 *  根据指定区域裁剪图片
 *
 *  @param rect 指定的区域
 *
 *  @return 裁剪好的图片
 */
- (UIImage *)gp_clipImageBy:(CGRect)rect;

/**
 *  加载一张不被渲染的图片
 *
 *  @param name 图片名
 *
 *  @return 原图片
 */
+ (instancetype)gp_imageFromOriginalName:(NSString *)name;

/**
 *  创建一个圆环图片
 *
 *  @param name         图片名称
 *  @param boarderWidth 圆环的宽度
 *  @param color        圆环的颜色
 *
 *  @return 所要的图片
 */
+ (instancetype)gp_image:(NSString *)name BoarderWith:(CGFloat)boarderWidth BoardColor:(UIColor *)gp_color;

/**
 *  把一个view显示的内容生成图片
 *
 *  @param view
 *
 *  @return 生成的图片
 */
+ (instancetype)gp_imageWithView:(UIView *)view;

/**  *
 *  @param color     颜色
 *  @param imageSize 尺寸
 *
 *  @return 指定尺寸和颜色的图片
 */
+ (UIImage*)createImageWithColor:(UIColor*)color size:(CGSize)imageSize;

/**
 *  把一个view显示的内容生成图片
 *
 *  @param view
 *
 *  @return 生成的图片
 */
+ (instancetype)gp_imageWithView:(UIView *)view Opaque:(BOOL)opaque;

/**
 *  画一个图片水印到当前图片上
 *
 *  @param img   水印图片
 *  @param frame 水印在该图片中的显示位置
 *
 *  @return 处理好的图片
 */
- (instancetype)gp_waterMarkWith:(UIImage *)gp_img inFrameOfCurImage:(CGRect)frame;

/**
 *  画一个图片水印到当前图片上,默认会显示在图片的右下角
 *
 *  @param img 水印图片
 *
 *  @return 处理好的图片
 */
- (instancetype)gp_waterMarkWith:(UIImage *)gp_img;

/**
 *  画一个文字水印在当前图片上
 *
 *  @param str      图片上的文字
 *  @param frame    文字的位置
 *  @param attrInfo 文字样式的信息
 *
 *  @return 处理后的图片
 */
- (instancetype)gp_waterMarkWith:(NSString *)str InRect:(CGRect)frame withAttributes:(NSDictionary *)attrInfo;

/**
 *  画一个文字水印在当前图片上(默认会显示在右下角),此方法必须于- (instancetype)gp_waterMarkWith:(NSString *)str InRect:(CGRect)frame withAttributes:(NSDictionary *)attrInfo 一起拷贝
 *
 *
 *  @param str      图片上的文字
 *  @param attrInfo 文字样式的信息
 *
 *  @return 处理后的图片
 */
- (instancetype)gp_waterMarkWith:(NSString *)str withAttributes:(NSDictionary *)attrInfo;

/**
 *  获取指定路径的图片
 *
 *  @param urlString      图片路径
 *  @param completeBlokck 获取成功后的操作
 */
+ (void)gp_imageWithURlString:(NSString *)urlString comolete:(void(^)(UIImage *image))completeBlokck;

/**
 *  @author shizhiang, 15-10-20 17:10:18
 *
 *  加载图片,并告诉调用者是否从本地加载
 *
 *  @param urlString
 *  @param completeBlokck
 */
+ (void)gp_imageWithURlString:(NSString *)urlString
      comoleteOrLoadFromCache:(void(^)(UIImage *image, BOOL loadFromLocal))completeBlokck;

/**
 *  下载图片
 *
 *  @param urlString
 *  @param completeBlokck
 */
+ (void)gp_downloadWithURLString:(NSString *)urlString
                        complete:(void(^)(NSData *data))completeBlokck;

/**
 *  获取指定大小带有logo的image
 *
 *  @param size 宽高
 *
 *  @return 带有logo的图片
 */
+ (instancetype)imageWithALogoWithSize:(CGSize)size;

@end


@interface UIImage (CS_Extensions)

/**
 *  旋转图片
 *
 *  @param radians 旋转的角度
 *  @param degrees
 *
 *  @return 旋转后的图片
 */
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/**
 *  把图片切割指定大小
 *
 *  @param boundingSize 切割到的尺寸
 *  @param scale        <#scale description#>
 *
 *  @return <#return value description#>
 */
- (UIImage*)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;
- (UIImage*)resizedImageToSize:(CGSize)dstSize;
- (UIImage *)cropImage:(CGRect) rect;
- (UIImage *)fixOrientation;
+ (UIImage *)scaleImage:(UIImage *)image scaleSize:(CGSize)scaleSize;

@end


@interface UIImage (TintColor)

- (UIImage *)imageWithTintColor:(UIColor *)color;
- (UIImage *)imageWithTintColor:(UIColor *)color alpha:(CGFloat)alpha;

@end
