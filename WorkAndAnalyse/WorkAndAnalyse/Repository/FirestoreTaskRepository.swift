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
    
    static let shared = FirestoreTaskRepository()
    
    private var db = Firestore.firestore()
    private var encoder = JSONEncoder()
    
    private var currentUser: User? {
        return Auth.auth().currentUser
    }
    
    // MARK: - CRUD
    
    func loadData(filter: ((Task) -> Bool)?, completion: @escaping (Result<[Task], Error>) -> Void) {
        guard let uid = currentUser?.uid else {
            return // some error
        }
        
        let docsRef = db
            .collection("users").document(uid)
            .collection("tasks").order(by: "startTime", descending: false)
        
        var tasks: [Task] = []
        
        docsRef.getDocuments { querySnapshot, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    do {
                        if let task = try document.data(as: Task.self) {
                            if let filter = filter {
                                if filter(task) {
                                    tasks.append(task)
                                }
                            } else {
                                tasks.append(task)
                            }
                        }
                    } catch {
                        completion(.failure(error))
                    }
                }
                
                completion(.success(tasks))
            }
        }
    }
    
    func addTask(_ task: Task, completion: @escaping (Error?) -> Void) {
        guard let uid = currentUser?.uid else {
            return // some error
        }
        
        let documentRef = db
            .collection("users").document(uid)
            .collection("tasks")
        
        do {
            print(try documentRef.addDocument(from: task))
        } catch {
            completion(error)
        }
    }
    
    func removeTask(_ task: Task, completion: @escaping (Error?) -> Void) {
        db.collection("tasks").document(task.id ?? "").delete { (error) in // (1)
            if let error = error {
                completion(error)
                return
            }
        }
    }
    
    func updateTask(_ task: Task, completion: @escaping (Error?) -> Void) {
        guard let uid = currentUser?.uid, let id = task.id else {
            return // some error
        }
        
        do {
            try db.collection("users").document(uid)
            .collection("tasks").document(id).setData(from: task)
        } catch {
            completion(error)
        }
    }
    
    func removeAllTasks(completion: ((Error?) -> Void)?) {
        let batchSize = 100
        
        guard let uid = currentUser?.uid else {
            return // some error
        }
        
        let documentRef = db
            .collection("users").document(uid)
            .collection("tasks").limit(to: batchSize)
        
        documentRef.getDocuments { [weak self] querySnapshot, error in
            guard error == nil else {
                completion?(error!)
                return
            }
            
            let batch = documentRef.firestore.batch()
            querySnapshot?.documents.forEach { batch.deleteDocument($0.reference) }
            
            completion?(nil)
            
            batch.commit {_ in
                self?.removeAllTasks(completion: nil)
            }
        }
    }
}
