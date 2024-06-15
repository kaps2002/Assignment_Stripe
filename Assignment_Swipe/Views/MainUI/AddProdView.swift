//
//  AddProdView.swift
//  Assignment_Stripe
//
//  Created by Roro on 13/06/24.
//

import SwiftUI
import PhotosUI

struct AddProdView: View {
    @State private var prodviewModel = ProductViewModal()
    @State private var viewModel = AddProdViewModel()
    @State private var selectedImage: UIImage? = nil
    @State private var showToast = false
    @State private var toastMsg = ""
    @Binding var isAddProdViewActive: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 4) {
                    HStack() {
                        Text("Product Type")
                            .fontWeight(.semibold)
                        Spacer()
                        Picker("Product Type", selection: $viewModel.product_type) {
                            ForEach(ProductType.allCases, id: \.self) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        TextField("Product Name", text: $viewModel.product_name)
                            .padding(.horizontal, 10)
                            .foregroundColor(.black)
                            .frame(height: 45)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(viewModel.isProductNameValid ? Color(.lightGray).opacity(0.5) : .red),
                                alignment: .bottom
                            )
                            .onChange(of: viewModel.product_name) {
                                viewModel.isProductNameValid = true
                            }
                        Text(viewModel.isProductNameValid ? "" : "Please Enter the valid Name")
                            .font(.caption)
                            .foregroundStyle(.red)
                        
                        
                        TextField("Price", text: $viewModel.price)
                            .padding(.horizontal, 10)

                            .frame(height: 45)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(viewModel.isSellingPriceValid ? Color(.lightGray).opacity(0.5) : .red),
                                alignment: .bottom
                            )
                            .onChange(of: viewModel.price) {
                                viewModel.isSellingPriceValid = true
                            }
                        Text(viewModel.isSellingPriceValid ? "" : "Please Enter the valid Price")
                            .font(.caption)
                            .foregroundStyle(.red)
                        
                        
                        TextField("Taxrate", text: $viewModel.tax)
                            .padding(.horizontal, 10)
                            .frame(height: 45)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(viewModel.isTaxRateValid ? Color(.lightGray).opacity(0.5) : .red),
                                alignment: .bottom
                            )
                            .onChange(of: viewModel.tax) {
                                viewModel.isTaxRateValid = true
                            }
                        Text(viewModel.isTaxRateValid ? "" : "Please Enter the valid Tax Rate")
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                    
                    HStack() {
                        Text("Product Image")
                            .fontWeight(.semibold)
                        Spacer()
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width:50, height: 50)
                        } else {
                            Button("Select Image") {
                                viewModel.showImagePicker = true
                            }
                        }
                    }
                    .padding(.top, 10)
                }
                
                Spacer()
                
                Button(action: {
                    submitAction()
                }, label: {
                    Text("Add new Product")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding([.top, .bottom], 15)
                        .padding(.horizontal, 50)
                        .background(.blue)
                        .clipShape(Capsule())
                })
                
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddProdViewActive = false
                    }, label: {
                        Image(systemName: "xmark")
                            .padding(.horizontal, 10)
                            .imageScale(.large)
                            .foregroundColor(.secondary)
                    })
                    
                }
            })
            .padding(.top, 25)
            .padding(.horizontal, 15)
            .navigationTitle("Add Product 🚀")
            .sheet(isPresented: $viewModel.showImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .overlay(
                ToastView(content: {EmptyView()}, dismissAfter: 2, isShowing: $showToast, message: toastMsg), alignment: .bottom
            )
        }
    }
    
    func submitAction() {
        let ans = viewModel.validation(name: viewModel.product_name, price: viewModel.price, tax: viewModel.tax)
        if ans == 1 {
            viewModel.isProductNameValid = false
        } else if ans == 2 {
            viewModel.isSellingPriceValid = false
        } else if ans == 3 {
            viewModel.isTaxRateValid = false
        } else {
            viewModel.submitProduct(type: viewModel.product_type.rawValue, name: viewModel.product_name, price: viewModel.price, tax: viewModel.tax, image: selectedImage) { result in
                if result {
                    showToast = true
                    toastMsg = "Product Added Successfully 🎊"
                    viewModel.product_name = ""
                    viewModel.price = ""
                    viewModel.tax = ""
                }
            }
        }
    }
}

#Preview {
    AddProdView(isAddProdViewActive: .constant(true))
}
