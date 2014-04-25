
#import "ChatRoomCell.h"


@implementation ChatRoomCell


#pragma mark - Shared Funtions
+ ( ChatRoomCell* ) sharedCell
{
    NSArray* array = [ [ NSBundle mainBundle ] loadNibNamed : @"ChatRoomCell" owner : nil options : nil ] ;
    ChatRoomCell* cell = [ array objectAtIndex : 0 ] ;
    return cell ;
}

#pragma mark - ChatRoomCell
- ( id ) initWithStyle : ( UITableViewCellStyle ) style reuseIdentifier : ( NSString* ) reuseIdentifier
{
    self = [ super initWithStyle : style reuseIdentifier : reuseIdentifier ] ;
    
    if( self )
    {
        
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

- ( void ) setThumbnail : ( UIImage* ) thumbnail
{
    [ imgForThumbnail setImage : thumbnail ] ;
}

- ( void ) setTitle : ( NSString* ) title
{
    [ lblForTitle setText : title ] ;
}

- (void)dealloc {
    [date release];
    [lastMessage release];
    [super dealloc];
}
@end



