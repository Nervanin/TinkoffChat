//
//  DownloadImageViewController.swift
//  TinkoffChat
//
//  Created by Konstantin on 17/04/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation

class DownLoadImageViewController: UICollectionViewController {
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
    var pixelBay: PixabayJson?
    var imageInfoArray = [ImageInfo]()
    
    var page: Int  = {
        var page = 1
        return page
    }()
    var per_page: Int  = {
        var per_page = 20
        return per_page
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSpinner()
    }
    
    func startSpinner() {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
    }
    
    func stopSpinner() {
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pixelBayLoadJson(page: page, per_page: per_page)
    }
    
    
    func pixelBayLoadJson(page: Int, per_page: Int) {
        self.startSpinner()
        
        let session = URLSession.shared
        
        let url = URL(string: "https://pixabay.com/api/?key=12187518-eaf7193f33468ec9e1e33cfdd&q=yellow+flowers&image_type=photo&pretty=true&page=\(page)&per_page=\(per_page)")
        DispatchQueue.global().async {
            let task = session.dataTask(with: url!) { (data, _, error) in
                if error == nil {
                    do {
                        self.pixelBay = try JSONDecoder().decode(PixabayJson.self,
                                                                 from: data!)
                        self.imageInfoArray += self.pixelBay!.hits
                        
                    } catch {
                        print("pixelBay error",error.localizedDescription)
                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.stopSpinner()
                    }
                }
            }
            task.resume()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindProfile" {
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first,
                let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell,
                let profileVC = segue.destination as? ProfileViewController else { return }
            profileVC.userImage.image = cell.image.image
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageInfoArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell",
                                                            for: indexPath) as?
            CollectionViewCell else { return UICollectionViewCell() }
        if let url = URL(string: self.imageInfoArray[indexPath.row].webformatURL) {
            DispatchQueue.main.async {
                cell.image.load(url: url)
            }
        } else {
            print("some problem with url")
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell else { return }
        performSegue(withIdentifier: "unwindProfile",
                     sender: cell.image.image)
    }
    
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension DownLoadImageViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == imageInfoArray.count - 1 {
            if (self.pixelBay!.totalHits / (page * per_page))  >= 1 {
                page += 1
                self.pixelBayLoadJson(page: page,
                                      per_page: per_page)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

