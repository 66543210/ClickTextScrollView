//
//  CSClickContent.h
//  uidemo
//
//  Created by user on 2021/4/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CSClickContent : NSObject
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) UIColor *fontColor;
@property (nonatomic, strong) UIColor *coverColor;
@property (nonatomic, assign) BOOL withUnderLine;
@property (nonatomic, strong) void(^clickTextViewPartBlock)(NSString *clickText);
@end

NS_ASSUME_NONNULL_END
