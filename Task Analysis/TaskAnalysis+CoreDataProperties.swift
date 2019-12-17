//
//  TaskAnalysis+CoreDataProperties.swift
//  Task Analysis
//
//  Created by Alexander Keeney on 8/25/19.
//  Copyright © 2019 Alexander Keeney. All rights reserved.
//
//

import Foundation
import CoreData


extension TaskAnalysis {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<TaskAnalysis> {
        return NSFetchRequest<TaskAnalysis>(entityName: "TaskAnalysis")
    }

    @NSManaged public var name: String
    @NSManaged public var nextStepHighlighted: Bool
    @NSManaged public var skippedStepHighlighted: Bool
    @NSManaged public var steps: NSOrderedSet?

}

// MARK: Generated accessors for steps
extension TaskAnalysis {

    @objc(insertObject:inStepsAtIndex:)
    @NSManaged public func insertIntoSteps(_ value: Step, at idx: Int)

    @objc(removeObjectFromStepsAtIndex:)
    @NSManaged public func removeFromSteps(at idx: Int)

    @objc(insertSteps:atIndexes:)
    @NSManaged public func insertIntoSteps(_ values: [Step], at indexes: NSIndexSet)

    @objc(removeStepsAtIndexes:)
    @NSManaged public func removeFromSteps(at indexes: NSIndexSet)

    @objc(replaceObjectInStepsAtIndex:withObject:)
    @NSManaged public func replaceSteps(at idx: Int, with value: Step)

    @objc(replaceStepsAtIndexes:withSteps:)
    @NSManaged public func replaceSteps(at indexes: NSIndexSet, with values: [Step])

    @objc(addStepsObject:)
    @NSManaged public func addToSteps(_ value: Step)

    @objc(removeStepsObject:)
    @NSManaged public func removeFromSteps(_ value: Step)

    @objc(addSteps:)
    @NSManaged public func addToSteps(_ values: NSOrderedSet)

    @objc(removeSteps:)
    @NSManaged public func removeFromSteps(_ values: NSOrderedSet)

}
