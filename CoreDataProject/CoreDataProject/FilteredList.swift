//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Giorgio Latour on 5/1/23.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(filterKey: String, filterValue: String, filterType: FilterType, sortDescriptors: [NSSortDescriptor], @ViewBuilder content: @escaping(T) -> Content) {
        var filterName = ""
        
        switch filterType {
        case .beginsWith:
            filterName = "BEGINSWITH"
        case .contains:
            filterName = "CONTAINS"
        case .endsWith:
            filterName = "ENDSWITH"
        case .like:
            filterName = "LIKE"
        case .matches:
            filterName = "MATCHES"
        }
        
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(filterName) %@", filterKey, filterValue))
        self.content = content
    }
    
    
}

enum FilterType {
    case beginsWith
    case contains
    case endsWith
    case like
    case matches
}
