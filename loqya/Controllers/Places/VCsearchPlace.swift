
import UIKit

class VCsearchPlace: UIViewController , UITextFieldDelegate  {
    
    //Outlets
    @IBOutlet weak var txtSearch: customeText!
    @IBOutlet weak var collectionViewPlaces: UICollectionView!
    
    //Variables
    fileprivate  var arrFilterPlaces = [Places]()
    fileprivate let cellID = "CVCplaces"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionViewPlaces.dataSource = self
        self.collectionViewPlaces.delegate = self
        
        //Regiseter Cell
        let cellNib = UINib(nibName: cellID, bundle: nil)
        self.collectionViewPlaces.register(cellNib, forCellWithReuseIdentifier: cellID)
    }
    
    // Functions
    private func filetrData(placeName : String){
        
        arrFilterPlaces = Api.instance.PlacessArray.filter({
            $0.placeTitle.lowercased().hasPrefix(placeName)
        })
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool{
        txtSearch.resignFirstResponder()
        return false
    }
    
    @IBAction func txtChanged(_ sender: Any) {
        if let search = txtSearch.text , search.count != 0 {
            
            self.arrFilterPlaces.removeAll()
            arrFilterPlaces = Api.instance.PlacessArray.filter({
                $0.placeTitle.lowercased().hasPrefix(search)
            })
            self.collectionViewPlaces.reloadData()
        }
    }
}
extension VCsearchPlace : UICollectionViewDelegateFlowLayout ,UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  arrFilterPlaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionViewPlaces.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? CVCplaces {
            let place  = arrFilterPlaces[indexPath.row]
            cell.configrationImage(place: place)
            return cell
        }
        else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width : CGFloat = 150
        if view.frame.size.width <= 415{width = (collectionViewPlaces.frame.size.width - 40)  / 2}
            
        else{width = (collectionViewPlaces.frame.size.width - 40)  / 3}
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let placeID   =  Api.instance.PlacessArray[indexPath.row].placeID
        self.performSegue(withIdentifier: "seg_search_details", sender: placeID)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        UIView.animate(withDuration: 0.4) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let placeVC = segue.destination as? VCdetailsPlace{
            if let placeid = (sender as? Int){
                placeVC.placID = placeid
            }
        }
    }
}
