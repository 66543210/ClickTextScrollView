//
//  ClickTextScrollView.h
//  ClickTextViewPart
//
//  Created by TT on 2020/4/23.
//  Copyright © 2020 TT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSContent.h"
#import "CSClickContent.h"
//typedef void(^clickTextViewPartBlock)(NSString *clickText);

NS_ASSUME_NONNULL_BEGIN
@interface ClickTextScrollView : UIScrollView

- (void) setContentText:(CSContent *)contentMode;

- (void) addClickText: (CSClickContent *)clickModel;
@end

NS_ASSUME_NONNULL_END
