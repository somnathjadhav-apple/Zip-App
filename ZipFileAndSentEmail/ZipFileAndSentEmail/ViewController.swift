//
//  ViewController.swift
//  ZipFileAndSentEmail
//
//  Created by Somnath Jadhav on 5/9/22.
//

import UIKit
import ZipArchive

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func zipCreateButton(_ sender: Any) {
        createZipFolder()
    }
    
    func createZipFolder() {
        
        //MARK: FileManager
        let fileManager = FileManager.default
        
        //MARK: Documents Directory
        let Url = fileManager.urls(
            for: .documentDirectory,
            in: .userDomainMask)
        let docUrl = Url[0]
        print("docUrl:\(docUrl)")
        
        
        //MARK: Create Folder
        let folderUrl = docUrl.appendingPathComponent("myFolderNew").path
        print("folderUrl:\(folderUrl)")
        do{
            try fileManager.createDirectory(atPath: folderUrl,withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        //MARK: Create .txt file
        let txtFileUrl = URL(fileURLWithPath: folderUrl).appendingPathComponent("Notes.txt")
        print("txtFileUrl:\(txtFileUrl)")
        
        //Data in the txt file
        let data = "We are creating txt file and this is an example.".data(using: .utf8)
        
        //txt file is created with data
        fileManager.createFile(atPath: txtFileUrl.path,
                               contents: data,
                               attributes: [FileAttributeKey.creationDate: Date()])
        
        //MARK: Create .zip folder
        let zipFolderUrl = folderUrl.appending(".zip")
        SSZipArchive.createZipFile(atPath: zipFolderUrl, withFilesAtPaths: [txtFileUrl.path], withPassword: "1234")
    }
}

