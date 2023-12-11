//
//  ViewController.swift
//  TestJob
//
//  Created by Priyanka Sinha on 09/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView?
    
    var viewControllerPresenter : ViewControllerPresenter?
    var items : [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewControllerModel = ViewControllerModel()
        viewControllerPresenter = ViewControllerPresenter(controllerModel: viewControllerModel)
         viewControllerPresenter?.delegate = self
        collectionView?.collectionViewLayout = createLayout()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        viewControllerPresenter?.fetchData()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
            let item = CompositionalLayout.createItem(width: .fractionalWidth(0.5), height: .fractionalHeight(1), spacing: 10);
          
            let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .fractionalHeight(0.3), items: [item, item])
            
            let section = NSCollectionLayoutSection(group: group);
            
            return UICollectionViewCompositionalLayout(section: section);
        }
 }

    
extension ViewController: ViewControllerPresenterDelegate {
    
    func showData(item: [Item]) {
        
        self.items = item
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
       }
  }
}
    
 
 extension ViewController: UICollectionViewDelegate , UICollectionViewDataSource{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(items.count)
        return items.count

    }

    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       print(indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CollectionViewCell
        
        let url = URL(string: items[indexPath.row].url)
            let data = try? Data(contentsOf: url!)
            if let imageData = data {
                let image = UIImage(data: imageData)
                  cell?.imageView1.image = image
            }


        return cell!
    }
 }
