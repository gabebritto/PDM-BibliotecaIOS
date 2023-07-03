//
//  ContentView.swift
//  Lib
//
//  Created by ifpb on 03/07/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Livro.nome, ascending: true)],
        animation: .default)
    private var livros: FetchedResults<Livro>
    
    @State private var isShowingFormView = false
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(livros) {
                        livro in
                        
                        HStack{
                            Image(systemName: "book.circle.fill")
                                .font(.largeTitle)
                            Text("\(livro.nome!) - \(livro.autor!) - \(livro.status!)")
                            Spacer()
                        }
                        .padding()
                    }
                    .onDelete(perform: deleteBooks)
                }
            }.navigationTitle("Biblioteca")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {isShowingFormView = true}) {
                        Image(systemName: "plus")
                    }
                }
            }

        }.sheet(isPresented: $isShowingFormView) {
            FormView(isPresented: $isShowingFormView)
                .environment(\.managedObjectContext, viewContext)
        }
    }

    private func deleteBooks(offsets: IndexSet) {
        withAnimation {
            offsets.map { livros[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
