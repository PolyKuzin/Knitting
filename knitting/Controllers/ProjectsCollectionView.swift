//
//  ProjectsTableView.swift
//  knitting
//
//  Created by Павел Кузин on 28.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import Firebase

extension ProjectsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func configureCollectionViewForProjects(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        view.addSubview(collectionViewForProjects)
        view.sendSubviewToBack(collectionViewForProjects)
        collectionViewForProjects.frame                             = cardView.bounds
        collectionViewForProjects.collectionViewLayout              = layout
        collectionViewForProjects.backgroundColor                   = .white
        collectionViewForProjects.delegate                          = self
        collectionViewForProjects.dataSource                        = self
        collectionViewForProjects.bounds = cardView.bounds
        
        collectionViewForProjects.register(ProjectCell.self, forCellWithReuseIdentifier: "ProjectCell")
        
        layout.minimumLineSpacing = 10
        collectionViewForProjects.contentInset                      = UIEdgeInsets(top: 20, left: 20, bottom: 95, right: 20)
        collectionViewForProjects.backgroundColor                   = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionViewForProjects.showsHorizontalScrollIndicator    = false
        collectionViewForProjects.showsVerticalScrollIndicator      = false
        setProjectsCollectionViewConstraints()
        
//Shadows:
        let shadowPath0 = UIBezierPath(roundedRect: collectionViewForProjects.bounds, cornerRadius: 30)
        collectionViewForProjects.layer.shadowPath                  = shadowPath0.cgPath
        collectionViewForProjects.layer.shadowRadius                = 30
        collectionViewForProjects.layer.shadowColor                 = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        collectionViewForProjects.layer.shadowOpacity               = 1
        collectionViewForProjects.layer.bounds                      = collectionViewForProjects.bounds
        collectionViewForProjects.layer.shadowOffset                = CGSize(width: 0, height: 8)
        collectionViewForProjects.layer.position                    = collectionViewForProjects.center
//
        collectionViewForProjects.clipsToBounds                     = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewForProjects.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath)  as! ProjectCell
        let project = projects[indexPath.row]
        cell.setCell(project: project, indexPath : indexPath.row)
        cell.delegate      = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height / 5.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let project = projects[indexPath.row]
        collectionViewForProjects.deselectItem(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "projectLifeController") as! CountersVC
        vc.modalPresentationStyle = .fullScreen
        vc.currentProject = project
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UIView {
    func springAnimation(_ viewToAnimate: UIView){
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    
    func shakeAnimation(){
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
}
    

    //MARK: Delete project
extension ProjectsVC: SwipeableCollectionViewCellDelegate {
    func hiddenContainerViewTapped(inCell cell: UICollectionViewCell) {
        activiryIndicator()
        guard let indexPath = collectionViewForProjects.indexPath(for: cell) else { return }
        let project = projects[indexPath.row]
        project.ref?.removeValue()
        collectionViewForProjects.performBatchUpdates({
            self.collectionViewForProjects.deleteItems(at: [indexPath])
        })
        selfPresentation()
        stopActivityIndicator()
    }
    
    func selfPresentation(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "projectsController") as! ProjectsVC
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func visibleContainerViewTapped(inCell cell: UICollectionViewCell) {
        guard let indexPath = collectionViewForProjects.indexPath(for: cell) else { return }
        let project = projects[indexPath.row]
        collectionViewForProjects.deselectItem(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "projectLifeController") as! CountersVC
        vc.modalPresentationStyle = .fullScreen
        vc.currentProject = project
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
