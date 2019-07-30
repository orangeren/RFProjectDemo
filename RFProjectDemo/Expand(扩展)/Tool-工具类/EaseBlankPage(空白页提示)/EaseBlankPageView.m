//
//  EaseBlankPageView.m
//  RFProjectDemo
//
//  Created by 任 on 2019/7/30.
//  Copyright © 2019 ZXKJ. All rights reserved.
//

#import "EaseBlankPageView.h"

@implementation EaseBlankPageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}



- (void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
    
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    
    self.alpha = 1.0;
    
    // 图片
    if (!_blankImageV) {
        _blankImageV = [[UIImageView alloc] init];
        [self addSubview:_blankImageV];
    }
    [_blankImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_top).with.offset(140);
        make.height.mas_equalTo(157);
        make.width.mas_equalTo(155);
    }];
    // 文字
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = FONT_Regular(fitW(12));
        _tipLabel.textColor = K_666Color;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
    }
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerX.equalTo(self);
        make.top.equalTo(self.blankImageV.mas_bottom);
        make.height.mas_equalTo(60);
    }];
    
    // 按钮
    _reloadButtonBlock = nil;
    if (!_reloadButton) {
        _reloadButton = [[UIButton alloc] initWithFrame:CGRectZero];
        //[_reloadButton setImage:[UIImage imageNamed:@"blankpage_button_reload"] forState:UIControlStateNormal];
        _reloadButton.backgroundColor = K_MainColor;
        [_reloadButton setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
        _reloadButton.adjustsImageWhenHighlighted = NO;
        [_reloadButton addTarget:self action:@selector(reloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_reloadButton];
        
        [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.mas_equalTo(self.tipLabel.mas_bottom).mas_offset(20);
            make.size.mas_equalTo(CGSizeMake(fitW(228), fitW(44)));
        }];
        _reloadButton.layer.cornerRadius = fitW(22);
        _reloadButton.layer.masksToBounds = YES;
    }
    _reloadButton.hidden = NO;
    _reloadButtonBlock = block;
    
    
    if (hasError) {
        /** 加载失败 */
        [_blankImageV setImage:[UIImage imageNamed:@"blankpage_image_loadFail"]];
        _tipLabel.text = @"貌似出了点差错";
        
        if (blankPageType == EaseBlankPageTypeLoadFail) {
            _reloadButton.hidden = YES;
        }
    }
    else {
        /** 空白数据 */
        if (_reloadButton) {
            _reloadButton.hidden = NO;
        }
        NSString *imageName, *tipStr;
        switch (blankPageType) {
            case EaseBlankPageTypeProject: {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"当前还未有数据";
                if (_reloadButton) {
                    [_reloadButton setImage:[UIImage imageNamed:@"blankpage_button_reload"] forState:UIControlStateNormal];
                }
            } break;
            case EaseBlankPageTypeNoButton: {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"当前还未有数据";
                if (_reloadButton) {
                    _reloadButton.hidden = YES;
                }
            } break;
                
            default: {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"当前还未有数据";
                if (_reloadButton) {
                    [_reloadButton setImage:[UIImage imageNamed:@"blankpage_button_reload"] forState:UIControlStateNormal];
                }
            } break;
        }
        [_blankImageV setImage:[UIImage imageNamed:imageName]];
        NSDictionary *dic = @{NSKernAttributeName:@.5f};
        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:tipStr attributes:dic];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setAlignment:NSTextAlignmentCenter];
        [paragraphStyle setLineSpacing:5];//行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [tipStr length])];
        
        _tipLabel.attributedText = attributedString;
        
        
        //        _tipLabel.text = tipStr;
    }
}

- (void)reloadButtonClicked:(id)sender {
    /** 1.0.0 -1.2.2 */
    //    self.hidden = YES;
    //    [self removeFromSuperview];
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        if (_reloadButtonBlock) {
    //            _reloadButtonBlock(sender);
    //        }
    //    });
    /** 134修改 */
    if (_reloadButtonBlock) {
        _reloadButtonBlock(sender);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
        [self removeFromSuperview];
    });
    
}


@end
