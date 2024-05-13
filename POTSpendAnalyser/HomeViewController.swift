//
//  ViewController.swift
//  POTSpendAnalyser
//
//  Created by Shanthakumar Vm on 11/05/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let itemsPerRow: CGFloat = 2
    let numberOfItems = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
              layout.minimumInteritemSpacing = 10
              layout.minimumLineSpacing = 10
              
              let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
              collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
              collectionView.backgroundColor = .white
              collectionView.dataSource = self
              collectionView.delegate = self
            
    }

    @IBAction func onPaymentButtonAction(_ sender: Any) {
        let paymentVC = Storyboard.main.instantiateVC(PaymentViewController.self)
        navigationController?.pushViewController(paymentVC, animated: true)
    }
    
    @IBAction func onTransactionButtonAction(_ sender: Any) {
        let transactionVC = Storyboard.main.instantiateVC(TransactionViewController.self)
        navigationController?.pushViewController(transactionVC, animated: true)
        
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath)
          cell.backgroundColor = .blue
          return cell
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
                    return CGSize.zero
                }
                let paddingSpace = layout.minimumInteritemSpacing * (itemsPerRow - 1)
                let availableWidth = view.frame.width - paddingSpace
                let widthPerItem = availableWidth / itemsPerRow
                return CGSize(width: widthPerItem, height: widthPerItem)
      }
    
    func calcSizeCell() -> CGSize {
        let aspectRatioCell: CGFloat = 0.93
        let countCellInRow: CGFloat = 2
        let distanceBetweenCell: CGFloat = 2.0 // 2.0
        let borderWidth: CGFloat = 2.0

        var resultSize = CGSize.zero
        resultSize.width = (UIScreen.main.bounds.width - borderWidth) / countCellInRow - distanceBetweenCell
        resultSize.height = resultSize.width / aspectRatioCell

        return resultSize
    }

}
