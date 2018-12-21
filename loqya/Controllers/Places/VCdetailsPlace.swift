import UIKit

class VCdetailsPlace: IndicatorViewController  {
    
    //outLets
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var btnSave: customeButton!
    @IBOutlet weak var txtViewplaceDetails: UITextView!
    @IBOutlet weak var pageControlImages: UIPageControl!
    @IBOutlet weak var imagePlace: UIImageView!
    @IBOutlet weak var lblPlaceChairs: UILabel!
    @IBOutlet weak var lblPlaceRooms: UILabel!
    @IBOutlet weak var lblPlaceWorker: UILabel!
    @IBOutlet weak var lblPlaceAddress: UILabel!
    @IBOutlet weak var lblPlaceDate: UILabel!
    @IBOutlet weak var lblPlaceArea: UILabel!
    @IBOutlet weak var lblPlacePrice: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var collectionViewImages: UICollectionView!
    
    //Constarins
    @IBOutlet weak var txtViewHeightConstrain: NSLayoutConstraint!
    
    //Vairables
    var placID : Int?
    var places = Places()
    var countImages : Int = 0
    var timerScroll = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = " "
        navigationItem.backBarButtonItem?.title = " "
        self.collectionViewImages.dataSource = self
        self.collectionViewImages.delegate = self
        self.startIndicatorWithWhiteView()
        
        Api.instance.getDataForSelectedPlace(placeID: placID!) { (error, place) in
            if let placeDetails = place{
                
                self.removeView(place: placeDetails)
                self.places = placeDetails
                self.collectionViewImages.reloadData()
                self.fillPlaceData(place: placeDetails)
                
                if let arrImages = placeDetails.imagesArray {
                    self.pageControlImages.numberOfPages = arrImages.count
                    self.countImages = arrImages.count
                }
                self.endIndicatroWithWhiteView()
            }
        }
    }
    
    func fillPlaceData (place : Places){
        navigationItem.title = place.placeTitle
        self.lblPlaceChairs.text = place.placeChair ?? " "
        self.lblPlaceRooms.text = place.placeRoooms ?? " "
        self.lblPlaceWorker.text = place.placeWorker ?? " "
        self.lblPlaceAddress.text = place.placeAddress ?? " "
        self.lblPlaceArea.text = place.placeArea ?? " "
        self.lblPlacePrice.text  = String(place.placePrice ?? 0 )
        self.lblPlaceDate.text = place.placeAvilable ?? " "
        self.txtViewplaceDetails.text = place.placeDetails ?? " "
        
        self.imagePlace.kf.indicatorType = .activity
        if let imageName = place.placeImageName , let imagePath = place.placeImagePath {
            
            let pathImage = "\(imagePath)\(imageName)"
            
            if let url = URL(string: pathImage){
                self.imagePlace.kf.setImage(with: url)
            }
        }
    }
    func removeView (place : Places){
        
        if let arrImages = place.imagesArray{
            if arrImages.count == 0 {
                
                self.pageControlImages.removeFromSuperview()
                self.collectionViewImages.removeFromSuperview()
                self.viewContainer.removeFromSuperview()
                self.txtViewHeightConstrain.constant = 310
                
            }    }
    }
    
    @IBAction func saveClick(_ sender: Any) {
        if AuthServices.instance.UserToken != ""{
            performSegue(withIdentifier: "seg_SignUp", sender: (self.placID ?? 0))
        }
        else{
            performSegue(withIdentifier: "seg_login", sender: (self.placID ?? 0))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let VCsignUp = segue.destination as? VCreserviedPlace {
            
            VCsignUp.placeID = (sender as! Int)
        }
    }
}

//---------------------------------------Collection view class-------------
extension VCdetailsPlace : UICollectionViewDelegate , UICollectionViewDataSource  ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let arrimages =  self.places.imagesArray{
            return arrimages.count
        }
        else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,  cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if   let cell = collectionViewImages.dequeueReusableCell(withReuseIdentifier: "PlaceDetailsCVC", for: indexPath) as? CVCplaceDetails{
            
            if let arrImages = places.imagesArray {
                let image = arrImages[indexPath.row]
                cell.configrationCell(place: places, imageName: image)
                
                // Timer for auto Scroll Images
                var indexRow = indexPath.row
                if indexRow < self.countImages - 1 {
                    indexRow = indexRow + 1
                }
                else { indexRow = 0 }
                timerScroll = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(VCdetailsPlace.startTimer(timer:)), userInfo: indexRow, repeats: true)
                return cell
            }
            else { return UICollectionViewCell() }
        }
        else { return UICollectionViewCell() }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.viewContainer.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControlImages?.currentPage = Int(scrollView.contentOffset.x)/Int(scrollView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @objc func startTimer (timer  : Timer){
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            self.collectionViewImages.scrollToItem(at: IndexPath(row : timer.userInfo! as! Int, section:0 ), at: .centeredHorizontally, animated: true)
        }, completion: nil)
        pageControlImages?.currentPage = timer.userInfo! as! Int
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewImages.collectionViewLayout.invalidateLayout()
            print("in here")
            if self.pageControlImages.currentPage == 0 {
                self.collectionViewImages.contentOffset = .zero
                print("zeeeeero ")
            }
            else{
                let index = IndexPath(item:self.pageControlImages.currentPage, section: 0)
                
                self.collectionViewImages.scrollToItem(at: index, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
                print("\(index.row  )aaaa")
            }
            
        }) { (aaa) in
            
        }
    }
}

