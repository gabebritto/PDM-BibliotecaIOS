//
//  FormView.swift
//  Lib
//
//  Created by ifpb on 03/07/23.
//

import SwiftUI
import CoreData

struct FormView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var isPresented: Bool
    
    @State private var nome: String = ""
    @State private var autor: String = ""
    @State private var status: String = ""
    @State private var emprestado: Bool = false
    @State private var editora: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nome", text: self.$nome)
                TextField("Autor", text: self.$autor)
                TextField("Editora", text: self.$editora)
                Toggle("emprestado", isOn: self.$emprestado)
                Picker("Status", selection: self.$status) {
                    Text("novo").tag("n")
                    Text("lendo").tag("l")
                    Text("concluido").tag("c")
                }
                
                Button(action: {addBook()}) {
                    Image(systemName: "plus")
                }
            }.navigationTitle("Adicionar Livro")
            .toolbar {
                ToolbarItem {
                    Button(action: {isPresented = false}) {
                        Text("Cancelar")
                    }
                }
            }
        }
    }
    
    private func addBook() {
        withAnimation {
            let newBook = Livro(context: viewContext)
            
            newBook.nome = nome
            newBook.autor = autor
            newBook.status = status
            newBook.emprestado = emprestado
            newBook.editora = editora
            
            do {
                try viewContext.save()
                isPresented = false
            } catch {
                print("Persistence failed")
            }
        }
    }
}
