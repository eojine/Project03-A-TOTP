//
//  SearchBarView.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/11/25.
//

import SwiftUI

struct SearchBarView: View {
    
    // MARK: ViewModel
    
    @EnvironmentObject var viewModel: MainViewModel
    
    // MARK: Body
    
    var body: some View {
        HStack {
            TextField("검색", text: $viewModel.searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if viewModel.isSearching {
                            // X버튼
                            Button(action: {
                                viewModel.searchText = ""
                            }, label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            })
                        }
                    }
                )
                .padding(.horizontal, 12)
                .onTapGesture {
                    viewModel.isSearching = true
                }
            
            if viewModel.isSearching {
                // 취소 버튼
                Button(action: {
                    viewModel.isSearching = false
                    viewModel.searchText = ""
                    hideKeyboard()
                }, label: {
                    Text("취소")
                        .foregroundColor(.black)
                })
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
    
}
