
import UIKit
import Alamofire
import Kingfisher

class VCmain: UIViewController {
    
    //Outlet
    @IBOutlet weak var collectionViewPlaces: UICollectionView!
    
    
    //Varibles
    var countOfPlaces :Int!
    let cellID = "CVCplaces"

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.collectionViewPlaces.dataSource = self
        self.collectionViewPlaces.delegate = self
        self.registercell()
    }
    
    // My Function
     func getDataForSelecetedDept(dept_id : Int){
        
        Api.instance.getPlacesByDeptId(dept_id: dept_id) { (sucess) in
            if sucess {
                
                self.collectionViewPlaces.reloadData()
            }
        }
    }
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "Avenir", size: 25)
        messageLabel.sizeToFit()
        
        self.collectionViewPlaces.backgroundView = messageLabel
    }
    
    func restore() {
        self.collectionViewPlaces.backgroundView = nil
    }
    
    func registercell(){
        let cellNib  = UINib(nibName: cellID, bundle: nil)
        collectionViewPlaces.register(cellNib, forCellWithReuseIdentifier: cellID)
    }
}


// ------------------------Collection Vew Class -----------------------------------
extension VCmain : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        countOfPlaces =  Api.instance.PlacessArray.count
        if countOfPlaces == 0{
                self.setEmptyMessage("لا توجد بيانات ")
        }
        else{
            self.restore()
        }
        return countOfPlaces
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionViewPlaces.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? CVCplaces {
            let place = Api.instance.PlacessArray[indexPath.row]
            cell.configrationImage(place: place)
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // var placeSeleted : Places
        let placeID   =  Api.instance.PlacessArray[indexPath.row].placeID
        self.performSegue(withIdentifier: "segPlaceDetails", sender: placeID)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let placeVC = segue.destination as? DetailsPlaceVC{
            
            if let placeid = (sender as? Int){
            placeVC.placID = placeid
            
            }
        }
    }
}

