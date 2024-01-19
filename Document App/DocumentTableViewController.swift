//
//  DocumentTableViewController.swift
//  Document App
//
//  Created by Lucas BILLY on 1/17/24.
//

import UIKit
import QuickLook

enum Sections: CaseIterable {
    case imported
    case bundle
    
    func toString() -> String {
        switch self{
        case Sections.imported:
            return "Imported"
        case Sections.bundle:
            return "Bundle"
        }
    }
}

struct DocumentFile : Hashable {
    var title : String
    var size : Int
    var imageName : String? = nil
    var url : URL
    var type : String
    var section : Sections
    
    /*static var documentFiles : [DocumentFile] = [
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
    ]*/
}

extension Int {
    func formattedSize() -> String {
        let formatter = ByteCountFormatter()
        formatter.countStyle = ByteCountFormatter.CountStyle.file
        return formatter.string(fromByteCount: Int64(self))
    }
}

class DocumentTableViewController: UITableViewController, QLPreviewControllerDataSource,  UIDocumentPickerDelegate, UISearchBarDelegate {
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {

    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        dismiss(animated: true)

        guard url.startAccessingSecurityScopedResource() else {
            return
        }
        defer {
            url.stopAccessingSecurityScopedResource()
        }
        copyFileToDocumentsDirectory(fromUrl: url)
        var setDocuments = Set(self.documents).union(Set(listFileInDirectory(path: url.deletingLastPathComponent().path)))
        self.documents = Array(setDocuments.sorted(by: {$0.url.absoluteString > $1.url.absoluteString}))
        filteredData = self.documents

        tableView.reloadData()
    }
    
    func copyFileToDocumentsDirectory(fromUrl url: URL) {
        // On récupère le dossier de l'application, dossier où nous avons le droit d'écrire nos fichiers
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // Nous créons une URL de destination pour le fichier
        let destinationUrl = documentsDirectory.appendingPathComponent(url.lastPathComponent)
        
        do {
            // Puis nous copions le fichier depuis l'URL source vers l'URL de destination
            try FileManager.default.copyItem(at: url, to: destinationUrl)
        } catch {
            print(error)
        }
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        guard let file = selectedFile else {
            return self.documents[0].url as QLPreviewItem
        }
        return file.url as QLPreviewItem
    }
    
    var documents: [DocumentFile] = []
    var selectedFile: DocumentFile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.documents = listFileInDirectory(path: Bundle.main.resourcePath!).sorted(by: {$0.url.absoluteString > $1.url.absoluteString})
        filteredData = self.documents
        self.title = "📁 Liste des documents"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self,  action: #selector(addDocument))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func addDocument(){
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.jpeg, .png])
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .overFullScreen
        
        present(documentPicker, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.filter({$0.section == Sections.allCases[section]}).count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Sections.allCases[section].toString()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let file = filteredData.filter({$0.section == Sections.allCases[indexPath.section]})[indexPath.row]
        selectedFile = file
        self.instantiateQLPreviewController(withUrl: file.url)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)
        let documentFile = filteredData.filter({$0.section == Sections.allCases[indexPath.section]})[indexPath.row]
        cell.textLabel?.text = documentFile.title
        cell.detailTextLabel?.text = "Size: \(documentFile.size.formattedSize())"
        return cell
    }
    
    func instantiateQLPreviewController(withUrl url: URL){
        let previewController = QLPreviewController()
        previewController.dataSource = self
        present(previewController, animated: true, completion: nil)
    }
    
    func listFileInDirectory(path: String) -> [DocumentFile] {
        let fm = FileManager.default
        let items = try! fm.contentsOfDirectory(atPath: path)
        var documentList = [DocumentFile]()
        
        for item in items {
            // Vérification que l'item possède le suffix jpg et n'a pas le suffix DS_Store
            if !item.hasSuffix("DS_Store") && (item.hasSuffix(".jpeg") || item.hasSuffix(".JPG")) {
                let currentUrl = URL(fileURLWithPath: path + "/" + item)
                let resourcesValues = try! currentUrl.resourceValues(forKeys: [.contentTypeKey, .nameKey, .fileSizeKey])
                
                var section = Sections.imported
                if path == Bundle.main.resourcePath!{
                    section = Sections.bundle
                }
                
                documentList.append(DocumentFile(
                    title: resourcesValues.name!,
                    size: resourcesValues.fileSize ?? 0,
                    imageName: item,
                    url: currentUrl,
                    type: resourcesValues.contentType!.description,
                    section: section)
                )
            }
        }
        return documentList
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredData: [DocumentFile]!

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? self.documents : self.documents.filter { item in
            return item.title.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    

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
