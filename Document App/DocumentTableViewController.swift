//
//  DocumentTableViewController.swift
//  Document App
//
//  Created by Lucas BILLY on 1/17/24.
//

import UIKit

struct DocumentFile {
    var title : String
    var size : Int
    var imageName : String? = nil
    var url : URL
    var type : String
    
    static var documentFiles : [DocumentFile] = [
        DocumentFile(title: "Document 1", size: 100, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 2", size: 200, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 3", size: 300, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 4", size: 400, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 5", size: 500, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 6", size: 600, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 7", size: 700, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 8", size: 800, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 9", size: 900, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 10", size: 1000, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
    ]
}

extension Int {
    func formattedSize() -> String {
        let formatter = ByteCountFormatter()
        formatter.countStyle = ByteCountFormatter.CountStyle.file
        return formatter.string(fromByteCount: Int64(self))
    }
}

class DocumentTableViewController: UITableViewController {
    var documents: [DocumentFile] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.documents = listFileInBundle()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.title = "📁 Liste des documents"

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.documents.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)
        let documentFile = self.documents[indexPath.row]

        cell.textLabel?.text = documentFile.title
        cell.detailTextLabel?.text = "Size: \(documentFile.size.formattedSize())"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let item = sender as? UITableViewCell else {
            return
        }
        if segue.identifier == "ShowDocumentSegue" {
            if let indexPath = self.tableView.indexPath(for: item) {
                let index = indexPath.row
                let document = documents[index]
                if let vc = segue.destination as? DocumentViewController {
                    vc.imageName = document.imageName
                }
            }
        }
    }
    
    // A mettre dans votre DocumentTableViewController
    func listFileInBundle() -> [DocumentFile] {
        // Initialise la classe de gestion des fichies iOS
        let fm = FileManager.default
        // Récupération du chemin d'accès des image de Bundle.main
        let path = Bundle.main.resourcePath!
        // Récupération de la liste des items de la directory Bundle.main
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        // Initialisation du tableau de retour
        var documentListBundle = [DocumentFile]()
        
        for item in items {
            // Vérification que l'item possède le suffix jpg et n'a pas le suffix DS_Store
            if !item.hasSuffix("DS_Store") && item.hasSuffix(".jpg") {
                // Formatage de l'url du document
                let currentUrl = URL(fileURLWithPath: path + "/" + item)
                // Récupération des valeurs associées à l'URL
                let resourcesValues = try! currentUrl.resourceValues(forKeys: [.contentTypeKey, .nameKey, .fileSizeKey])
                
                // Création d'une instance de DocumentFile avec les informations récupérées
                documentListBundle.append(DocumentFile(
                    title: resourcesValues.name!,
                    size: resourcesValues.fileSize ?? 0,
                    imageName: item,
                    url: currentUrl,
                    type: resourcesValues.contentType!.description)
                )
            }
        }
        return documentListBundle
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
