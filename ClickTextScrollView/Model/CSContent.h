//
//  CSContent.h
//  uidemo
//
//  Created by user on 2021/4/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CSContent : NSObject
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) UIColor *fontColor;
@property (nonatomic, strong) UIColor *bgColor;
// 是否自动基于字体大小计算字体高度
@property (nonatomic, assign)BOOL autoHeight;
// 当autoHeight为false时，需要指定字体高度
@property (nonatomic, assign) CGFloat textHeight;
@end

NS_ASSUME_NONNULL_END
