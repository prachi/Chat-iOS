
#import "NoteViewCell.h"

@implementation NoteViewCell


#pragma mark - Shared Funtions
+ ( NoteViewCell* ) sharedCell
{
    NSArray* array = [ [ NSBundle mainBundle ] loadNibNamed : @"NoteViewCell" owner : nil options : nil ] ;
    NoteViewCell* cell = [ array objectAtIndex : 0 ] ;
    
    return cell ;
}

#pragma mark - NoteViewCell
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

@end
