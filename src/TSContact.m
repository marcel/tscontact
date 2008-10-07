#import "TSContact.h"

@interface TSContact (PrivateMethods)
- (ABRecordRef)record;
- (void)loadRecordRef;
- (void)guardedReleaseForReference:(CFTypeRef)reference;
- (BOOL)recordIsLoaded;
- (void)setRecordRef:(ABRecordRef)recordRef;
- (void)setRecordId:(ABRecordID)recordId;
@end

@implementation TSContact
- (id) init
{
    self = [super init];
    if (self != nil) {
        _addressBook = ABAddressBookCreate();
        _recordRef = nil;
    }
    return self;
}

- (id)initWithId:(ABRecordID)recordId
{
    Contact *contact = [self init];
    [contact setRecordId: recordId];
    return contact;
}

- (id)initWithRef:(ABRecordRef)recordRef
{
    Contact *contact = [self init];
    [contact setRecordRef:recordRef];
    return contact;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ fullName: '%@'>", [self class], [self fullName]];
}

#pragma mark Core Foundation Lookup Wrappers

- (void)setRecordRef:(ABRecordRef)recordRef
{
    [self guardedReleaseForReference:_recordRef];
    _recordRef = recordRef;
    _recordId = ABRecordGetRecordID(_recordRef);
}

- (void)setRecordId:(ABRecordID)recordId
{
    _recordId = recordId;
}

- (BOOL)recordIsLoaded
{
    return _recordRef != nil;
}

- (ABRecordRef)record 
{
    if (![self recordIsLoaded]) {
        [self loadRecordRef];
    }
    return _recordRef;
}

- (void)loadRecordRef
{
    _recordRef = ABAddressBookGetPersonWithRecordID(_addressBook, _recordId);
}

#pragma mark Property Wrappers

- (NSString *)fullName
{
    if (_fullName == nil) {
        _fullName = (NSString *)ABRecordCopyCompositeName([self record]);
    }
    
    return _fullName;
}

#pragma mark Comparisson

- (BOOL)isEqual:(id)anObject
{
    return [self hash] == [anObject hash];
}

- (NSUInteger)hash
{
    return (NSUInteger)_recordId;
}

#pragma mark Resource management

- (void)guardedReleaseForReference:(CFTypeRef)reference
{
    if (reference) {
        CFRelease(reference);
    }
}

- (void)dealloc 
{
    CFRelease(_addressBook);
    [self guardedReleaseForReference:_recordRef];
    if (_fullName != nil) {
        [_fullName release];
        _fullName = nil;
    }
    [super dealloc];
}

@end
