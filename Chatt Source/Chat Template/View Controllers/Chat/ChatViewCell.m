
#import "ChatViewCell.h"


@implementation ChatViewCell

@synthesize chatMessages = _chatMessages;
@synthesize lblForTitle = _lblForTitle;
@synthesize lblForTitleR = _lblForTitleR;

#pragma mark - ChatViewCell
- ( id ) initWithStyle : ( UITableViewCellStyle ) style reuseIdentifier : ( NSString* ) reuseIdentifier
{
    self = [ super initWithStyle : style reuseIdentifier : reuseIdentifier ] ;
    if( self )
    {
       [[NSBundle mainBundle] loadNibNamed:@"ChatViewCell" owner:self options:nil];
    }
    
    return self ;
}

- ( void ) layoutSubviews
{
    [ super layoutSubviews ] ;
}

#pragma mark - Set
- ( void ) setSelected : ( BOOL ) selected animated : ( BOOL ) animated
{
    [ super setSelected : selected animated : animated ] ;
}



- (void)dealloc {
    [_imgForThumbnail release];
    [_lblForTitle release];
    [_delivered release];
    [_lblForTitleR release];
    [super dealloc];
}
@end
