//
//  Step+CoreDataProperties.swift
//  Task Analysis
//
//  Created by Alexander Keeney on 8/25/19.
//  Copyright © 2019 Alexander Keeney. All rights reserved.
//
//

import Foundation
import CoreData


extension Step {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Step> {
        return NSFetchRequest<Step>(entityName: "Step")
    }

    @NSManaged public var finished: Bool
    @NSManaged public var image: NSData?
    @NSManaged public var title: String
    @NSManaged public var task: TaskAnalysis

}
