import UIKit
import Alamofire
import Kingfisher
import NVActivityIndicatorView

class VCmain: IndicatorViewController{
    
    //Outlet
    @IBOutlet weak var collectionViewPlaces: UICollectionView!
    
    //Varibles
    var countOfPlaces :Int!
    let cellID = "CVCplaces"
    var viewContainerIndicator : UIView!
    var indicator : NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startIndicatorWithWhiteView()
        self.collectionViewPlaces.dataSource = self
        self.collectionViewPlaces.delegate = self
        self.registercell()
    }
    
    func getDataForSelecetedDept(dept_id : Int){
        Api.instance.getPlacesByDeptId(dept_id: dept_id) { (sucess) in
            if sucess {
                
                self.endIndicatroWithWhiteView()
                self.collectionViewPlaces.reloadData()
                if Api.instance.PlacessArray.count == 0{
                    self.setEmptyMessage("لا توجد بيانات ")
                }
                else{
                    self.restore()
                }
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
    
    func restore() { self.collectionViewPlaces.backgroundView = nil}
    
    func registercell(){
        let cellNib  = UINib(nibName: cellID, bundle: nil)
        collectionViewPlaces.register(cellNib, forCellWithReuseIdentifier: cellID)
    }
}
// ------------------------Collection Vew Class -----------------------------------
extension VCmain : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        countOfPlaces =  Api.instance.PlacessArray.count
        return countOfPlaces
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionViewPlaces.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? CVCplaces {
            let place = Api.instance.PlacessArray[indexPath.row]
            cell.configrationImage(place: place)
            return cell
        }
        else{ return UICollectionViewCell() }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let placeID   =  Api.instance.PlacessArray[indexPath.row].placeID
        self.performSegue(withIdentifier: "segPlaceDetails", sender: placeID)
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionViewPlaces.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width : CGFloat = 150
        if view.frame.size.width <= 415{width = (collectionViewPlaces.frame.size.width - 40)  / 2}
            
        else{width = (collectionViewPlaces.frame.size.width - 40)  / 3}
        return CGSize(width: width, height: 200)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let placeVC = segue.destination as? VCdetailsPlace{
            if let placeid = (sender as? Int){
                placeVC.placID = placeid
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        UIView.animate(withDuration: 0.4) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
        
    }
}
