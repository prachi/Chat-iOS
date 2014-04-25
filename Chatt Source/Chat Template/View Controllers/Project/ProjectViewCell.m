
#import "ProjectViewCell.h"


@implementation ProjectViewCell


#pragma mark - Shared Funtions
+ ( ProjectViewCell* ) sharedCell
{
    NSArray* array = [ [ NSBundle mainBundle ] loadNibNamed : @"ProjectViewCell" owner : nil options : nil ] ;
    ProjectViewCell* cell = [ array objectAtIndex : 0 ] ;
    
    return cell ;
}

#pragma mark - ProjectViewCell
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
