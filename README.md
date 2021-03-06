# ClickTextScrollView
[使用说明](https://github.com/66543210/ClickTextScrollView/blob/master/README.CN.md)

its inherited from UIScrollView to show a clickable content and display like Rich Text.

### Demo

<img src="https://user-images.githubusercontent.com/35450350/115772093-4bd2b000-a3e1-11eb-819f-77a9c7e8325f.png" style="zoom:25%;" />

## Intalling

There are a few options. Choose one, or just figure it out:

- **[CocoaPods](https://cocoapods.org/)**

Add the following line to your Podfile:

```
pod 'ClickTextScrollView'
```

Run `pod install`, and you are all set.

- Copy the framework into Project

  1、Download the release, and copy into your project under the `Frameworks` dir.

  <img src="https://user-images.githubusercontent.com/35450350/115772221-6e64c900-a3e1-11eb-9b61-85e47387eaca.png" style="zoom:30%;" />

  2、Add the framework

  <img src="https://user-images.githubusercontent.com/35450350/115772317-89373d80-a3e1-11eb-94df-c5f8c0307689.png" style="zoom:50%;" />



## API

There are three Object(`ClickTextScrollView`, `CSContent`, `CSClickContent`) you will be use.

#### First need

import the header in your page

```objective-c
#import <ClickTextScrollView/ClickTextScrollView.h>
```



#### ClickTextScrollView

```objective-c
@interface ClickTextScrollView : UIScrollView
// set the display content
- (void) setContentText:(CSContent *)contentMode;
// add the clicktext block during the content
- (void) addClickText: (CSClickContent *)clickModel;
@end
```

- init

```objective-c
ClickTextScrollView *csView = [[ClickTextScrollView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, SCREEN_HEIGHT * 0.25, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.2)];
```



#### CSContent

```objective-c
@interface CSContent : NSObject
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) UIColor *fontColor;
// the scrollview backgroundcolor
@property (nonatomic, strong) UIColor *bgColor;
// if need to calculate font height auto, normall set YES
@property (nonatomic, assign)BOOL autoHeight;
// if autoHeight is NO, you should appoint this value
@property (nonatomic, assign) CGFloat textHeight;
@end
```

This object contain the content text and some features of how to display



- add to ClickTextScrollView

```objective-c
CSContent *contentModel = [[CSContent alloc] init];
contentModel.content = [self getTempStr];
contentModel.fontColor = [UIColor whiteColor];
contentModel.fontSize = 17.0;
contentModel.bgColor = [UIColor grayColor];
contentModel.autoHeight = YES;
[csView setContentText:contentModel];
```



#### CSClickContent

```objective-c
@interface CSClickContent : NSObject
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) UIColor *fontColor;
@property (nonatomic, strong) UIColor *coverColor;
@property (nonatomic, assign) BOOL withUnderLine;
// when you click this content the block will be called
@property (nonatomic, strong) void(^clickTextViewPartBlock)(NSString *clickText);
@end
```



You can add multiple CSClickContent into ClickTextScrollView, but only set CSContent once.

- add to ClickTextScrollView

```objective-c
CSClickContent * clickModel = [[CSClickContent alloc] init];
clickModel.content = @"Keyboard";
clickModel.fontColor = [UIColor blueColor];
clickModel.coverColor = [UIColor redColor];
clickModel.withUnderLine = YES;
clickModel.clickTextViewPartBlock = ^(NSString *clickText) {
NSLog(@"click=%@", clickText);
};
[csView addClickText:clickModel];
```



#### The end

add the csView into your view which you want show this

