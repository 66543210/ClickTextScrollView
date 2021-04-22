//
//  ClickTextScrollView.m
//  ClickTextViewPart
//
//  Created by TT on 2020/4/23.
//  Copyright © 2020 TT. All rights reserved.
//

#import "ClickTextScrollView.h"
#import "ClickTextView.h"
#import <CoreText/CoreText.h>

@interface ClickTextScrollView()

@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)ClickTextView *clickTextView;
@property (nonatomic, strong) void(^clickTextViewPartBlock)(NSString *clickText);

@end


@implementation ClickTextScrollView

@dynamic delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:_clickTextView];
        self.contentSize = _clickTextView.contentSize;
    }
    return self;
}


#pragma mark -init

-(ClickTextView *)ClickTextView {
    if (!_clickTextView) {
        _clickTextView = [[ClickTextView alloc] initWithFrame:self.frame];
    }
    return _clickTextView;
}

#pragma mark -private

/**
 计算文本高度
 @param str         文本内容
 @param width       lab宽度
 @param lineSpacing 行间距(没有行间距就传0)
 @param font        文本字体大小
 @return 文本高度
 */
-(CGFloat)getTextHeightWithStr:(NSString *)str
                     withWidth:(CGFloat)width
               withLineSpacing:(CGFloat)lineSpacing
                      withFont:(CGFloat)font
{
    if (!str || str.length == 0) {
        return 0;
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing =  lineSpacing;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:[UIFont systemFontOfSize:font]}];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attStr);
    CGSize attSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, 0), NULL,CGSizeMake(width, CGFLOAT_MAX), NULL);
    CFRelease(frameSetter);
    return attSize.height;
}

- (CGFloat) heightForString:(UITextView *)textView andWidth:(CGFloat)width{
     CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}

- (NSArray*)rangeOfSubString:(NSString*)subStr inString:(NSString*)string {
      NSMutableArray *rangeArray = [NSMutableArray array];
    
    NSRange range = [string rangeOfString:subStr];
    if (range.location == NSNotFound) {
        return rangeArray;
    }
    [rangeArray addObject:[NSValue valueWithRange:range]];
    while (![string isEqualToString:@""]) {
        string = [string substringFromIndex:range.length];
        range = [string rangeOfString:subStr];
        if (range.location != NSNotFound) {
            range.location = range.location + rangeArray.count * range.length;
            [rangeArray addObject:[NSValue valueWithRange:range]];
        } else {
            break;
        }
    }
      return rangeArray;
}

#pragma mark -export

- (void) setContentText:(CSContent *)contentMode {
    [self setContent:contentMode.content withFontSize:contentMode.fontSize withFontcolor:contentMode.fontColor withBackgroundColor:contentMode.bgColor withAutoHeight:contentMode.autoHeight withTextHeight:contentMode.textHeight];
}

- (void) addClickText: (CSClickContent *)clickModel {
    [self addClickText:clickModel.content withTextColor:clickModel.fontColor withClickCoverColor:clickModel.coverColor withUnderLine:clickModel.withUnderLine withBlock:clickModel.clickTextViewPartBlock];
}

#pragma mark -public

/**
设置文本内容
@param content         文本内容
@param fontSize       字体大小
@param fontColor     字体颜色
@param bgColor         文本背景色
@param autoHeight  是否自动计算高度
@param textHeight  当自动计算高度为否时指定内容高度
*/
- (void)setContent:(NSString *)content withFontSize:(CGFloat)fontSize withFontcolor:(UIColor*) fontColor withBackgroundColor:(UIColor*)bgColor withAutoHeight:(BOOL) autoHeight withTextHeight:(CGFloat)textHeight{
    if (!content) {
        return;
    }
    if (!_clickTextView) {
        _clickTextView = [[ClickTextView alloc] initWithFrame:self.frame];
        _clickTextView.editable = NO;
        _clickTextView.selectable = NO;
    }
    _content = content;
    _clickTextView.font = [UIFont systemFontOfSize:fontSize];
    _clickTextView.textColor = fontColor;
    _clickTextView.backgroundColor = bgColor;
    _clickTextView.text = content;
    CGFloat height = [self heightForString:_clickTextView andWidth:self.frame.size.width];
    _clickTextView.frame = CGRectMake(0, 0, self.frame.size.width, height);
    self.contentSize = CGSizeMake(0, height);
    [self addSubview:_clickTextView];
}

- (void) addClickText:(NSString *)text withTextColor:(UIColor*)color withClickCoverColor:(UIColor *)coverColor withUnderLine:(BOOL)withUnderLine withBlock:(clickTextViewPartBlock)block {
    NSArray *arr = [self rangeOfSubString:text inString:self.content];
    if (arr.count == 0) {
        return;
    }
    for (NSInteger i = 0;i < arr.count;i++) {
        if (withUnderLine) {
            [_clickTextView setUnderlineTextWithRange:[arr[i] rangeValue] withUnderlineColor:color withClickCoverColor:coverColor withBlock:block];
        } else {
            [_clickTextView setClickTextWithRange:[arr[i] rangeValue] withTextColor:(UIColor *)color withClickCoverColor:coverColor withBlock:block];
        }
    }
}

@end
