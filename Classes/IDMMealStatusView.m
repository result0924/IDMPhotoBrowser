//
//  IDMMealStatusView.m
//  PhotoBrowserDemo
//
//  Created by justin on 2017/8/25.
//
//

#import "IDMMealStatusView.h"
#import "IDMPhoto.h"
#import "IDMPhotoBrowser.h"

@interface IDMMealStatusView() {
    id<IDMPhoto> _photo;
    UIImageView *_waterDropletsImageView;
    UILabel *_mealChangeLabel;
    UILabel *_mealChangeValueLabel;
}

@end

@implementation IDMMealStatusView

- (instancetype)initWithIDMPhoto:(id<IDMPhoto>)photo {
    self = [super init];
    
    if (self) {
        _photo = photo;
        self.layer.cornerRadius = 15.0f;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        [self setupMealView];
    }

    return self;
}

- (void)setupMealView {
    _mealChangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(75.0f, 6.0f, 80.0f, 19.0f)];
    _mealChangeLabel.text = [NSString stringWithFormat:@""];
    _mealChangeLabel.textColor = [UIColor whiteColor];
    _mealChangeLabel.textAlignment = NSTextAlignmentRight;
    _mealChangeLabel.font = [UIFont systemFontOfSize:16.0f];
    _mealChangeLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_mealChangeLabel];

    if (_photo.meal && (_photo.meal.beforeMeal && _photo.meal.afterMeal)) {
        _waterDropletsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IDMPhotoBrowser.bundle/images/icMediumBg.png"]];
        _waterDropletsImageView.frame = CGRectMake(5.0f, 5.0f, 20.0f, 20.0f);
        [self addSubview:_waterDropletsImageView];

        _mealChangeValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(22.0f, 6.0f, 53.0f, 19.0f)];
        _mealChangeValueLabel.text = [NSString stringWithFormat:@""];
        _mealChangeValueLabel.textColor = [UIColor whiteColor];
        _mealChangeValueLabel.textAlignment = NSTextAlignmentLeft;
        _mealChangeValueLabel.font = [UIFont systemFontOfSize:16.0f];
        _mealChangeValueLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_mealChangeValueLabel];
    }

    if (_photo.meal && (_photo.meal.beforeMeal || _photo.meal.afterMeal)) {
        self.backgroundColor = (_photo.meal.statusColor) ? : [UIColor colorWithRed:0.0f / 255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:0.3f];

        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        [formatter setMaximumFractionDigits:1];
        [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];

        NSString *beforeMealString = [NSString stringWithFormat:@"%@", (_photo.meal.beforeMeal) ? [formatter stringFromNumber:_photo.meal.beforeMeal] : @"?"];
        NSString *afterMealString = [NSString stringWithFormat:@"%@", (_photo.meal.afterMeal) ? [formatter stringFromNumber:_photo.meal.afterMeal] : @"?"];
        NSString *changeString = [NSString stringWithFormat:@"(%@→%@)", beforeMealString, afterMealString];
        _mealChangeLabel.text = changeString;

        double val = _photo.meal.afterMeal.floatValue - _photo.meal.beforeMeal.floatValue;
        NSString *sign = (val < 0) ? [formatter minusSign] : [formatter plusSign];
        NSString *changeNumber = [formatter stringFromNumber:@(fabs(val))]; // avoid double negative
        _mealChangeValueLabel.text = [NSString stringWithFormat:@"%@%@", sign , changeNumber];
        _mealChangeValueLabel.hidden = (!_photo.meal.beforeMeal || !_photo.meal.afterMeal);
        _waterDropletsImageView.hidden = (!_photo.meal.beforeMeal || !_photo.meal.afterMeal);

        if (!_photo.meal.beforeMeal || !_photo.meal.afterMeal) {
            NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:changeString
                                                                                 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f]}];
            _mealChangeLabel.frame = CGRectMake(0.0f, 6.0f, attributedText.size.width + 30.0f, 19.0f);
            _mealChangeLabel.textAlignment = NSTextAlignmentCenter;
        }
    } else {
        _mealChangeLabel.text = @"";
        _mealChangeValueLabel.text = @"";
        self.backgroundColor = [UIColor clearColor];
        _waterDropletsImageView.hidden = YES;
    }
}

@end
