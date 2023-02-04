//
//  PresentPhotoEntity+CoreDataProperties.swift
//  
//
//  Created by Soslan-Bek on 04.02.2023.
//
//

import Foundation
import CoreData


extension PresentPhotoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PresentPhotoEntity> {
        return NSFetchRequest<PresentPhotoEntity>(entityName: "PresentPhotoEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var image: String?
    @NSManaged public var thumbImage: String?
    @NSManaged public var userAvatar: String?
    @NSManaged public var userName: String?
    @NSManaged public var instagram: String?
    @NSManaged public var isFavourites: Bool

}
