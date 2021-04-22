# ClickTextScrollView

继承了OC的UIScrollView，实现了一个超出显示区后支持滚动的ScrollView，同时支持设置点击文字

~~<font size=2>OC的原生UIScrollView实在是太难用了，光是超出或自动滚动这个在别的语言上很常见的设置，UIScrollView貌似需要手动设置高度，当时折腾了很久</font>~~

### 示例

<img src="https://user-images.githubusercontent.com/35450350/115772093-4bd2b000-a3e1-11eb-819f-77a9c7e8325f.png" style="zoom:50%;" />

## 安装

有几种方式进行安装：

- **[CocoaPods](https://cocoapods.org/)**

在工程的Podfile文件中添加一下语句

```
pod 'ClickTextScrollView'
```

然后执行`pod install`.

- 手动引入

  1、选择一个版本下载它的release，然后把framework拉到工程的 `Frameworks` 文件夹中.

  <img src="https://user-images.githubusercontent.com/35450350/115772221-6e64c900-a3e1-11eb-9b61-85e47387eaca.png" style="zoom:50%;" />

  2、添加frameworks

  <img src="https://user-images.githubusercontent.com/35450350/115772317-89373d80-a3e1-11eb-94df-c5f8c0307689.png" style="zoom:50%;" />

注意动态库引入方式

## API

使用中会涉及到(`ClickTextScrollView`, `CSContent`, `CSClickContent`) 三个对象.

`ClickTextScrollView`为一个view，通过`CSContent`设置显示的内容和整个文字区域的背景色等全局设置，通过`CSClickContent`添加需要进行点击处理的模型，包括内容以及匹配内容的颜色设置等

#### 最开始需要

在要用的文件中引入该头文件

```objective-c
#import <ClickTextScrollView/ClickTextScrollView.h>
```



#### ClickTextScrollView

```objective-c
@interface ClickTextScrollView : UIScrollView
// 基本内容，全局内容及相关配置
- (void) setContentText:(CSContent *)contentMode;
// 添加点击文本即相关配置
- (void) addClickText: (CSClickContent *)clickModel;
@end
```

- 初始化设置

```objective-c
ClickTextScrollView *csView = [[ClickTextScrollView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, SCREEN_HEIGHT * 0.25, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.2)];
```



#### CSContent

```objective-c
@interface CSContent : NSObject
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) UIColor *fontColor;
// 背景色
@property (nonatomic, strong) UIColor *bgColor;
// i是否自动计算文字高度，一般没什么个性化需求这里都是YES
@property (nonatomic, assign)BOOL autoHeight;
// 如果上面的autoHeight指定了NO，那这里就需要进行赋值，否则不用填
@property (nonatomic, assign) CGFloat textHeight;
@end
```



- 设置基本内容

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



支持添加多个CSClickContent对象

- 添加点击对象模型

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

将ClickTextScrollView添加至对应的view中进行展示