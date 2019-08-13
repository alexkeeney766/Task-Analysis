//
//  TaskAnalysisCoreData+CoreDataProperties.swift
//  Task Analysis
//
//  Created by Alexander Keeney on 8/13/19.
//  Copyright © 2019 Alexander Keeney. All rights reserved.
//
//

import Foundation
import CoreData


extension TaskAnalysisCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskAnalysisCoreData> {
        return NSFetchRequest<TaskAnalysisCoreData>(entityName: "TaskAnalysisCoreData")
    }

    @NSManaged public var name: String
    @NSManaged public var nextStepHighlighted: Bool
    @NSManaged public var skippedStepHighlighted: Bool
    @NSManaged public var steps: [String]
    @NSManaged public var stepPhotos: [NSData]

}
