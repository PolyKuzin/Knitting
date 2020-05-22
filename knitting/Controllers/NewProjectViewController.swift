//
//  NewProjectViewController.swift
//  knitting
//
//  Created by Павел Кузин on 27.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class NewProjectViewController: UITableViewController, UINavigationControllerDelegate {

    let currentID = Int(Date().timeIntervalSince1970)

    var editingProject: Project?
    var counter: Counter?
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
        var image: UIImage?
        //default images
        if imageIsChanged {
            image = projectImage.image
        } else {
            image = #imageLiteral(resourceName: "ball")
        }
        if projectTag1.text! != "" {projectTags.append(projectTag1.text!)}
        if projectTag2.text! != "" {projectTags.append(projectTag2.text!)}
        if projectTag3.text! != "" {projectTags.append(projectTag3.text!)}
        
        let size = CGSize(width: 70.0, height: 70.0)
        let slaledImage = image!.af.imageAspectScaled(toFit: size)
        
        let imageData = slaledImage.pngData()
        let newProject = Project(name: projectName.text!,
                                 tags: projectTags,
                                 projectID: currentID,
                                 imageData: imageData)
        
        if editingProject != nil {
            try! realm.write {
                editingProject?.name = newProject.name
                editingProject?.tags.removeAll()
                
                for str in newProject.tags {
                    editingProject?.tags.append(str!)
                }
                editingProject?.imageData = newProject.imageData
                editingProject?.date = Date()
            }
        } else {
            StorageManager.saveObject(newProject)
        }
    }
    //MARK: Save new Counter
    func saveCounter(){
        if editingProject != nil {
            // do nothing yet
        } else {
        
        let newCounter = Counter(name: projectName.text!,
                                 rows: 0,
                                 rowsMax: Int(countersRowsMax.text!)!,
                                 projectID: currentID,
                                 counterID: currentID - 10)
        StorageManager.saveCounter(newCounter)
        }
    }
    //MARK: Seting up...
    private func setUpEditScreen(){
        if editingProject != nil {
            setUpNavigationBar()
            imageIsChanged = true
            guard let data = editingProject?.imageData, let image = UIImage(data: data) else {return}
            projectImage.image = image
            projectName.text = editingProject?.name
            countersRowsMax.isHidden = true
            rowsMaxLabel.isHidden = true
            
            //TODO: Rewrite it switch statement
            if editingProject?.tags.count == 1 {
                projectTag1.text = editingProject?.tags[0]

            } else if editingProject?.tags.count == 2 {
                projectTag1.text = editingProject?.tags[0]
                projectTag2.text = editingProject?.tags[1]
            } else if editingProject?.tags.count == 3 {
                projectTag1.text = editingProject?.tags[0]
                projectTag2.text = editingProject?.tags[1]
                projectTag3.text = editingProject?.tags[2]
            } else {
                projectTag1.text = ""
                projectTag2.text = ""
                projectTag3.text = ""
            }
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
extension NewProjectViewController: UITextFieldDelegate {

       // Скрываем клавиатуру по нажатию на continue
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
       
        if projectName.text?.isEmpty == false && countersRowsMax.text?.isEmpty == false{
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}

// MARK: Work with IMAGE
extension NewProjectViewController: UIImagePickerControllerDelegate {
    
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
