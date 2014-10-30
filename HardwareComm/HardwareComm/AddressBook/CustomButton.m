
#import "CustomButton.h"

@implementation CustomGreenButton
@synthesize isChecked;
- (void)awakeFromNib
{
	UIImage *image = [[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"unchecked.png"]] stretchableImageWithLeftCapWidth:6.0 topCapHeight:0.0];
	[self setBackgroundImage:image forState:UIControlStateNormal];
    isChecked = false;
}

-(void)setChecked:(bool)checked
{
    if(checked)
    {
        [self setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
        [self setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateHighlighted];
    }
    else
    {
        [self setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateSelected];
        [self setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateHighlighted];
    }
    isChecked = checked;
}
@end

