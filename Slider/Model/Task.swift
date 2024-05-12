//
//  Task.swift
//  Slider
//
//  Created by Sarthak on 26/04/24.
//

import SwiftUI
import SwiftData

let dateFormatter = DateFormatter()

@Model
class Task: Identifiable {
    var id: UUID 
    var taskTitle: String
    var creationDate: Date
    var isCompleted: Bool
    var tint: String
    
    init(id: UUID = .init(), taskTitle: String, creationDate: Date = .init(), isCompleted: Bool = false, tint: String) {
        self.id = id
        self.taskTitle = taskTitle
        self.creationDate = creationDate
        self.isCompleted = isCompleted
        self.tint = tint
    }
    
    var tintColor: Color {
        switch tint{
        case "TaskColor1": return .taskcolor1
        case "TaskColor2": return .taskcolor2
        case "TaskColor3": return .taskcolor3
        case "TaskColor4": return .taskcolor4
        case "TaskColor5": return .taskcolor5
        default: return .blue
        }
    }
    
    
 }

func createSampleTasks() -> [Task] {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm" // Specify the date format here
    
    return [
        Task(taskTitle: "Record Video", creationDate: dateFormatter.date(from: "01/05/2024 12:30")!, isCompleted: true, tint: "taskcolor1"),
        Task(taskTitle: "Redesign Website", creationDate: dateFormatter.date(from: "01/05/2024 11:30")!, tint: "taskcolor2"),
        Task(taskTitle: "Go for a Walk", creationDate: dateFormatter.date(from: "01/05/2024 10:30")!, tint: "taskcolor3"),
        Task(taskTitle: "Edit Video", creationDate: dateFormatter.date(from: "01/05/2024 09:30")!, isCompleted: true, tint: "taskcolor4"),
        Task(taskTitle: "Publish Video", creationDate: dateFormatter.date(from: "30/04/2024 11:30")!, isCompleted: true, tint: "taskcolor5"),
        Task(taskTitle: "Tweet about new Video!", creationDate: dateFormatter.date(from: "30/04/2024 010:30")!, tint: "taskcolor1"),
        Task(taskTitle: "Custom Task", creationDate: dateFormatter.date(from: "30/04/2024 09:30")!, tint: "taskcolor2")
    ]
}


extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
    
//    static func parseCustomDate(_ dateString: String) -> Date {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
//            return dateFormatter.date(from: dateString) ?? .init()
//        }
}



//var sampleTasks: [Task] = [
//    .init(taskTitle: "Record Video", creationDate: .updateHour(-5), isCompleted: true, tint: .blue.opacity(0.3)),
//    .init(taskTitle: "Redesign Website", creationDate: .updateHour(-3), tint: .yellow.opacity(0.3)),
//    .init(taskTitle: "Go for a Walk", creationDate: .updateHour(-4), tint: .red.opacity(0.3)),
//    .init(taskTitle: "Edit Video", creationDate: .updateHour (0), isCompleted: true, tint: .green.opacity(0.3) ),
//    .init(taskTitle: "Publish Video", creationDate: .updateHour(2), isCompleted: true, tint: .green.opacity(0.3)),
//    .init(taskTitle: "Tweet about new Video!", creationDate: .updateHour(1), tint: .orange.opacity(0.3)),
//
// ]
