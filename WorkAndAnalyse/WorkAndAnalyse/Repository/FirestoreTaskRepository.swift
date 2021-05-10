//
//  FirestoreTaskRepository.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 27.04.2021.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreTaskRepository: TaskRepository {
    
    var db = Firestore.firestore()
    
    var tasks: [Task] = []
    
    init() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.loadData()
        }
    }
    
    // MARK: - CRUD
    
    func loadData() {
        let docsRef = db.collection("tasks").whereField("userId", in: [Auth.auth().currentUser?.uid]).order(by: "startTime")
        
        docsRef.getDocuments { [unowned self] querySnapshot, error in
            guard error == nil else { return }
            
            if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    do {
                        let task = try document.data(as: Task.self)
                        
                        if let task = task {
                            tasks.append(task)
                        }
                    } catch {
                        print("Some tasks did not load.")
                    }
                }
            }
            
        }
    }
    
    func addTask(_ task: Task, completion: @escaping (Error?) -> Void) {
        let collectionRef = db.collection("tasks")
        do {
            try collectionRef.addDocument(from: task)
        } catch {
            completion(error)
        }
    }
    
    func removeTask(_ task: Task, completion: @escaping (Error?) -> Void) {
        guard let taskId = task.id else {
            //completion(.failure())
            return
        }
        
        db.collection("tasks").document(taskId).delete { (error) in // (1)
            if let error = error {
                completion(error)
                return
            }
        }
    }
}
