//
//  StudyManager.swift
//  PlanoDeEstudos
//
//  Created by Gabriel Carvalho Guerrero on 28/03/19.
//  Copyright © 2019 Eric Brito. All rights reserved.
//

import Foundation
import UserNotifications

class StudyManager {
    
    static let shared = StudyManager()
    let userDefaults = UserDefaults.standard
    var studyPlans: [StudyPlan] = []
    
    private init() {
        if let data = userDefaults.data(forKey: "studyPlans"), let plans = try? JSONDecoder().decode([StudyPlan].self, from: data) {
            self.studyPlans = plans
        }
    }
    
    func savePlans() {
        if let data = try? JSONEncoder().encode(studyPlans) {
            userDefaults.set(data, forKey: "studyPlans")
        }
    }
    
    func addPlan(_ studyPlan: StudyPlan) {
        studyPlans.append(studyPlan)
        savePlans()
    }
    
    func removePlan(at index: Int) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [studyPlans[index].id])
        
        studyPlans.remove(at: index)
        savePlans()
    }
    
    func setPlanDone(id: String) {
        if let studyPlan = studyPlans.first(where: {$0.id == id}) {
            studyPlan.done = true
            savePlans()
        }
    }
}
