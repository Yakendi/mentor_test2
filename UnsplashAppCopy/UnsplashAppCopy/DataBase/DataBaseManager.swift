//
//  DataBaseManager.swift
//  UnsplashAppCopy
//
//  Created by Soslan-Bek on 04.02.2023.
//

import Foundation
import CoreData

// TODO: - Реализовать метод удаления из избранных в data manager
final class DataBaseManager: NSObject {
	
	private var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "PhotosModel")
		container.loadPersistentStores { storeDescription, error in
			if let error = error as NSError? {
				fatalError("Unresilved error \(error), \(error.userInfo)")
			}
			
			print("Core Data stack has been initialized with description: \(storeDescription)")
		}
		
		return container
	}()
	
	
	// MARK: - Constructor
	override init() {
		
	}
	
	func fetchFavouritesArray() -> [PresentPhotoModel] {
		var array: [PresentPhotoModel] = []
		
		let viewContext = persistentContainer.viewContext
		let _ = persistentContainer.newBackgroundContext()
		
		let request: NSFetchRequest<PresentPhotoEntity> = PresentPhotoEntity.fetchRequest()
		
		do {
			let takedData = try viewContext.fetch(request)
			array = takedData.map {
				return PresentPhotoModel(id: $0.id,
										 image: $0.image ?? "",
										 thumbImage: $0.thumbImage ?? "",
										 userAvatar: $0.userAvatar ?? "",
										 userName: $0.userName ?? "",
										 instagram: $0.instagram ?? "")
			}
		} catch {
			print(error.localizedDescription)
		}
		
		return array
	}
	
	func saveFavouriteModel(_ model: PresentPhotoModel) {
		let viewContext = persistentContainer.viewContext
		let _ = persistentContainer.newBackgroundContext()
		
		let toSaveEntity = NSEntityDescription.insertNewObject(forEntityName: "PresentPhotoEntity",
															   into: viewContext) as! PresentPhotoEntity
		toSaveEntity.id = model.id
		toSaveEntity.image = model.image
		toSaveEntity.thumbImage = model.thumbImage
		toSaveEntity.userAvatar = model.userAvatar
		toSaveEntity.userName = model.userName
		toSaveEntity.instagram = model.instagram
		toSaveEntity.isFavourites = model.isFavourite
		
		do {
			try viewContext.save()
		} catch {
			print(error.localizedDescription)
		}
	}
}
