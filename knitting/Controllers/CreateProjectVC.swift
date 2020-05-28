//
//  NewProjectViewController.swift
//  knitting
//
//  Created by Павел Кузин on 27.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
import Kingfisher

struct MyKeys {
    static let imagesFolder = "imagesFolder"
    static let imagesCollection = "projectsImages"
    static var projectID = "uid"
    static let imageUrl = "imageUrl"
}

class CreateProjectVC: UITableViewController, UINavigationControllerDelegate {

    let currentID = Int(Date().timeIntervalSince1970)

    var user: Users!
    var ref: DatabaseReference!
    var projects = Array<ProjectToKnit>()
    
    var editingProject: ProjectToKnit?
    var counter: CounterToKnit?
    var imageIsChanged = false
    var projectTags: [String?] = []
    
    @IBOutlet weak var projectImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var projectName: UITextField!
    @IBOutlet weak var projectTag1: UITextField!
    @IBOutlet weak var projectTag2: UITextField!
    @IBOutlet weak var projectTag3: UITextField!
    @IBOutlet weak var rowsMaxLabel: UILabel!
    @IBOutlet weak var countersRowsMax: UITextField!
    @IBAction func cancelAction(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyKeys.projectID = String(currentID)
        guard let currentUser = Auth.auth().currentUser else { return }
        user = Users(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid))
        
        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false
        projectName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        countersRowsMax.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setUpEditScreen()
    }
    
    //MARK: TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooesImagePicker(sourse: .camera)
            }
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooesImagePicker(sourse: .photoLibrary)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            present(actionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    //MARK: Saving project
    func saveProject() {
        
        if editingProject == nil {
        var image: UIImage?
        if imageIsChanged {
            image = projectImage.image
        } else {
            image = #imageLiteral(resourceName: "ball")
        }
        let imageData = image?.toString()
        
        if projectTag1.text! != "" {projectTags.append(projectTag1.text!)}
        if projectTag2.text! != "" {projectTags.append(projectTag2.text!)}
        if projectTag3.text! != "" {projectTags.append(projectTag3.text!)}
        
        
        let project = ProjectToKnit(userID      : user.uid,
                                    projectID   : MyKeys.projectID,
                                    name        : projectName.text!,
                                    imageData   : imageData!,
                                    tags        : projectTag1.text!)
        let projectRef = self.ref.child("projects").child(project.name.lowercased())
        projectRef.setValue(project.projectToDictionary())
        }
        if editingProject != nil {
            var image: UIImage?
            if imageIsChanged {
                image = projectImage.image
            } else {
                image = #imageLiteral(resourceName: "ball")
            }
            let imageData = image?.toString()
            editingProject?.ref?.updateChildValues(["name": projectName.text!,
                                                    "tags": projectTag1.text!,
                                                    "imageData" : imageData! ])        }
    }

    //MARK: Save new Counter
    func saveCounter(){
        if editingProject != nil {
            // do nothing yet
        } else {
        
            let counter = CounterToKnit(userID: user.uid,
                                        projectID: MyKeys.projectID,
                                        name: projectName.text!,
                                        rows: 0,
                                        rowsMax: 1000)
        let counterRef = self.ref.child("counters").child(counter.name.lowercased())
        counterRef.setValue(counter.counterToDictionary())
        }
    }
    //MARK: Seting up...
    private func setUpEditScreen(){
        if editingProject != nil {
            setUpNavigationBar()
            imageIsChanged = true
            guard let image = editingProject?.imageData.toImage() else {return}
            projectImage.image = image
            projectName.text = editingProject?.name
            countersRowsMax.isHidden = true
            rowsMaxLabel.isHidden = true
            
            //TODO: Rewrite it switch statement
            if editingProject?.tags.count == 1 {
                projectTag1.text = editingProject?.tags
            }
//            } else if editingProject?.tags.count == 2 {
//                projectTag1.text = editingProject?.tags[0]
//                projectTag2.text = editingProject?.tags[1]
//            } else if editingProject?.tags.count == 3 {
//                projectTag1.text = editingProject?.tags[0]
//                projectTag2.text = editingProject?.tags[1]
//                projectTag3.text = editingProject?.tags[2]
//            } else {
//                projectTag1.text = ""
//                projectTag2.text = ""
//                projectTag3.text = ""
//            }
        }
    }
    
    private func setUpNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = editingProject?.name
        saveButton.isEnabled = true
    }
}

//MARK: TextField Delegate
extension CreateProjectVC: UITextFieldDelegate {

       // Скрываем клавиатуру по нажатию на continue
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
       
        if projectName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}

// MARK: Work with IMAGE
extension CreateProjectVC: UIImagePickerControllerDelegate {
    
    func chooesImagePicker (sourse: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourse) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourse
            present(imagePicker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        projectImage.image = info[.editedImage] as? UIImage
        projectImage.contentMode = .scaleAspectFill
        projectImage.clipsToBounds = true
        imageIsChanged = true
        dismiss(animated: true)
    }
}
