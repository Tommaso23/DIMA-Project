//
//  Collection2View.swift
//  karma
//
//  Created by Tommaso Bucaioni on 26/12/22.
//

import SwiftUI
import Kingfisher
import Firebase
import FirebaseFirestore

struct CollectionView: View {
    @ObservedObject var viewModel: CollectionViewModel
    
    
    //    private var percentage: Float = 0.0
//    private let numberFormatter: NumberFormatter
    
    @State private var showPaymentView = false
    //
    init(collection: Collection) {
        self.viewModel = CollectionViewModel(collection: collection, service: CollectionService())
//        numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .decimal
//        numberFormatter.maximumFractionDigits = 2
    }
    
    
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 20) {
                KFImage(URL(string: viewModel.collection.collectionImageUrl))
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: 80, height: 50)
                
                Text(viewModel.collection.title)
                    .foregroundColor(.black)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            Text(viewModel.collection.caption)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(Color(.systemGray))
                .frame(maxHeight: 80)
            
            HStack {
                Text("\(viewModel.collection.timestamp.dateValue().formatted(date: .abbreviated, time: .omitted))")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                
                ProgressView(value:  viewModel.collection.currentAmount/viewModel.collection.amount)
                    .frame(width: 75)
                
                if (viewModel.collection.currentAmount == viewModel.collection.amount) {
                    Image(systemName: "checkmark.circle.fill").foregroundColor(Color(.systemGreen))
                } else {
                    Text("\(String((viewModel.collection.currentAmount*100/viewModel.collection.amount).formatted(.number.precision(.fractionLength(0)))))%")
                        .foregroundColor(.black)
                }

                Spacer()
                
            }
            .padding(.bottom, 16)
            
            HStack {
                Button(action: {
                    viewModel.collection.didLike ?? false ? viewModel.removeFromFavourite() : viewModel.addToFavourite()
                }, label: {
                    Image(systemName: viewModel.collection.didLike ?? false ? "bookmark.fill" : "bookmark")
                        
                        
                })
                .padding(.trailing, 6)
                
//                Image(systemName: "square.and.arrow.up")
//                    .padding(.trailing, 6)
//                Image(systemName: "ellipsis")
//                    .padding(.trailing, 6)
                Spacer()
                Button {
                    showPaymentView.toggle()
                } label: {
                    Text("Donate")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 90, height: 30)
                        .background(Color(.black))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }
                .sheet(isPresented: $showPaymentView) { PaymentView(collection: viewModel.collection).presentationDetents([.medium])
                }
//                .fullScreenCover(isPresented: $showPaymentView) {
//                    PaymentView(collection: viewModel.collection)
                
            }
            .foregroundColor(.black)
            
        }
        .padding()
        .frame(width: UIDevice.isIPad ? 310 : 350, height: 230)
        .background(Color.theme.custombackg)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(collection: Collection(title: "Regalo di laurea ", caption: "Questa è una descrizione di prova per vedere se riesco a creare una collection View decente che mi possa piacere", amount: 30, currentAmount: 20, favourites: 0, participants: 6, collectionImageUrl: "ciao", timestamp: FirebaseFirestore.Timestamp(date: Date.init()) , uid: "useridprova"))
    }
}
