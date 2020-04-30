//
//  NewProjectViewController.swift
//  knitting
//
//  Created by Павел Кузин on 27.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit

class NewProjectViewController: UITableViewController, UINavigationControllerDelegate {

    var imageIsChanged = false
    var editingProject: Project?
    
    
    @IBOutlet weak var segmentedConrol: UISegmentedControl!
    @IBOutlet weak var projectImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var projectName: UITextField!
    @IBOutlet weak var projectTag: UITextField!
    @IBAction func cancelAction(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false
        projectName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        segmentedConrol.setImage(#imageLiteral(resourceName: "crochet"), forSegmentAt: 0)
        segmentedConrol.setImage(#imageLiteral(resourceName: "knitting-2"), forSegmentAt: 1)
        
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
        return 4
    }

    //MARK: Saving new project
    func saveProject() {
        
        var image: UIImage?
        
        //default images
        if imageIsChanged {
            image = projectImage.image
        } else {
            image = #imageLiteral(resourceName: "ball")
        }
        
        let imageData = image?.pngData()
        
        let newProject = Project(name: projectName.text!,
                                 tag: projectTag.text,
                                 imageData: imageData)
        
        if editingProject != nil {
            try! realm.write {
                editingProject?.name = newProject.name
                editingProject?.tag = newProject.tag
                editingProject?.imageData = newProject.imageData
                editingProject?.date = Date()
            }
        } else {
            StorageManager.saveObject(newProject)
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
            projectTag.text = editingProject?.tag
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
        
        if projectName.text?.isEmpty == false {
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
