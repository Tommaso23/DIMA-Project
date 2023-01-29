//
//  ProfileView.swift
//  karma
//
//  Created by Tommaso Bucaioni on 25/12/22.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @State var screenHeight = UIScreen.main.bounds.height
    @State var screenWidth = UIScreen.main.bounds.width
    @State var orientation = UIDevice.current.orientation
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @ObservedObject var viewModel: ProfileViewModel
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State private var showNewCollectionView = false
    @State private var showEditPage = false
    
    let layout = [GridItem(.adaptive(minimum: 400))]
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
        viewModel.fetchUserCollections()
        
    }
    
    var body: some View {
        if UIDevice.isIPad {
                NavigationStack {
                    ZStack(alignment: .top) {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                VStack(alignment: .center) {
                                    HStack {
                                        Spacer()
                                        KFImage(URL(string: viewModel.user.profileImageUrl))
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(Circle())
                                            .frame(width: 150, height: 150)
                                        
                                        Spacer()
                                    }
                                    
                                    
                                    Text("\(viewModel.user.username)")
                                        .font(.title)
                                        .fontWeight(.semibold)
                                    
                                }
                                .padding(.bottom, 24)
                                
                            }
                            
                            HStack {
                                VStack {
                                    Text("\(viewModel.sentPayments.count)")
                                    Text("Donazioni")
                                        .font(.title3)
                                        .fontWeight(.regular)
                                }
                                .frame(width: 150)
                                
                                VStack {
                                    Text("\(viewModel.collections.count)")
                                    Text("Raccolte")
                                        .font(.title3)
                                        .fontWeight(.regular)
                                }
                                .frame(width: 150)
                                VStack {
                                    Text("\(String(viewModel.balance.formatted(.number.precision(.fractionLength(0))))) €")
                                    Text("Bilancio")
                                        .font(.title3)
                                        .fontWeight(.regular)
                                }
                                .frame(width: 150)
                            }
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal, 20)
                            
                            
                            Divider()
                            
                            CollView
                            
                            VStack(alignment: .leading) {
                                Text("Attività recenti")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(.top, 8)
                                
                                LazyVGrid(columns: layout, content: {
                                    ForEach(viewModel.totalPayments) { payment in
                                        RecentUserActivityView(payment: payment, isPositive: payment.isPositive ?? false)
                                            .padding(.bottom, 4)
                                    }
                                    
                                })
//                                Spacer().frame(height: 60)
                            }
                            
                        }
                    }
                    .background(Color.theme.custombackg)
                    .refreshable {
                        viewModel.fetchUserCollections()
                        viewModel.fetchPayments()
                        viewModel.fetchUser()
                    }
                    .toolbar {
                        ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image(systemName: "chevron.backward")
                                    .fontWeight(.semibold)
                            })
                        }
                        
                        ToolbarItem(placement: ToolbarItemPlacement.principal) {
                            
                            Text(viewModel.user.fullname)
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                        }
                        if viewModel.user.id == authViewModel.currentUser?.id {
                            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                                Menu {
                                    NavigationLink {
                                        EditProfileView(user: viewModel.user)
                                    } label: {
                                        Label("Edit profile", systemImage: "pencil")
                                    }
                                    
                                    Button(
                                        role: .destructive,
                                        action: {
                                            authViewModel.signOut()
                                        }, label: {
                                            Label("Sign out", systemImage: "rectangle.portrait.and.arrow.right")
                                        }
                                    )
                                    
                                } label: {
                                    Label (
                                        title: { Text("Add") },
                                        icon: { Image(systemName: "ellipsis") }
                                    )
                                }
                                
                            }
                        }
                        
                    }
                    .navigationBarBackButtonHidden(true)
                    .foregroundColor(.black)
                    
                    
                }
                .onTapGesture {
                    hideTabBar()
                }
            
            
        } else {
            NavigationStack {
                ZStack(alignment: .top) {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            VStack(alignment: .center) {
                                HStack {
                                    Spacer()
                                    KFImage(URL(string: viewModel.user.profileImageUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .frame(width: 100, height: 100)
                                    
                                    Spacer()
                                }
                                
                                
                                Text("\(viewModel.user.username)")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                            }
                            .padding(.bottom, 24)
                            
                        }
                        
                        statsView
                        
                        Divider()
                        
                        CollView
                        
                        RecentActivitiesView
                    }
                }
                .background(Color.theme.custombackg)
                .refreshable {
                    viewModel.fetchUserCollections()
                    viewModel.fetchPayments()
                    viewModel.fetchUser()
                }
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "chevron.backward")
                                .fontWeight(.semibold)
                        })
                    }
                    
                    ToolbarItem(placement: ToolbarItemPlacement.principal) {
                        
                        Text(viewModel.user.fullname)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                    }
                    if viewModel.user.id == authViewModel.currentUser?.id {
                        ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                            Menu {
                                NavigationLink {
                                    EditProfileView(user: viewModel.user)
                                } label: {
                                    Label("Edit profile", systemImage: "pencil")
                                }
                                
                                Button(
                                    role: .destructive,
                                    action: {
                                        authViewModel.signOut()
                                    }, label: {
                                        Label("Sign out", systemImage: "rectangle.portrait.and.arrow.right")
                                    }
                                )
                                
                            } label: {
                                Label (
                                    title: { Text("Add") },
                                    icon: { Image(systemName: "ellipsis") }
                                )
                            }
                            
                        }
                    }
                    
                }
                .navigationBarBackButtonHidden(true)
                .foregroundColor(.black)
                
                
            }
            .onTapGesture {
                hideTabBar()
            }
        }
        
    }
    
    func getHeight() -> CGFloat {
        if orientation.isLandscape{
            return UIScreen.main.bounds.width
        }
        else{
            return UIScreen.main.bounds.height
        }
    }
    
    func getWidth() -> CGFloat {
        if orientation.isLandscape{
            return UIScreen.main.bounds.height
        }
        else{
            return UIScreen.main.bounds.width
        }
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
//        ProfileView(user: User(
//            id: NSUUID().uuidString,
//            username: "tombucaioni",
//            fullname: "Tommaso Bucaioni",
//            profileImageUrl: "",
//            email: "tbucaioni@virgilio.it"))
//        .previewDevice("iPhone 12")
        
        ProfileView(user: User(
            id: NSUUID().uuidString,
            username: "tombucaioni",
            fullname: "Tommaso Bucaioni",
            profileImageUrl: "",
            email: "tbucaioni@virgilio.it"))
        .previewDevice("iPad (10th generation)")
    }
}

extension ProfileView {
    
    
    var statsView: some View {
        
        HStack {
            VStack {
                Text("\(viewModel.sentPayments.count)")
                Text("Donazioni")
                    .fontWeight(.regular)
            }
            .frame(width: UIScreen.main.bounds.width * 0.33)
            
            VStack {
                Text("\(viewModel.collections.count)")
                Text("Raccolte")
                    .fontWeight(.regular)
            }
            .frame(width: UIScreen.main.bounds.width * 0.33)
            VStack {
                Text("\(String(viewModel.balance.formatted(.number.precision(.fractionLength(0))))) €")
                Text("Bilancio")
                    .fontWeight(.regular)
            }
            .frame(width: UIScreen.main.bounds.width * 0.33)
        }
        .font(.title2)
        .fontWeight(.bold)
        .padding(.horizontal, 20)
        
    }
    
    var CollView: some View {
        VStack(alignment: .center) {
            HStack {
                Text("Raccolte")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                if viewModel.user.id == authViewModel.currentUser?.id {
                    Button {
                        showNewCollectionView.toggle()
                    } label: {
                        Text("+ Add New")
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemBlue))
                    }
                }
                
            }
            .padding(.horizontal, 20)
            .fullScreenCover(isPresented: $showNewCollectionView) {
                UploadCollectionView()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.collections){ collection in
                        NavigationLink {
                            SummaryCollectionView(collection: collection)
                        } label: {
                            CollectionView(collection: collection).padding(.horizontal, 18)
                            
                        }
                        
                        
                    }
                    
                }
            }
            
        }
        .padding(.horizontal)
    }
    
    var RecentActivitiesView: some View {
        
        VStack(alignment: .leading) {
            Text("Attività recenti")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 8)
            
            VStack {
                ForEach(viewModel.totalPayments) { payment in
                    RecentUserActivityView(payment: payment, isPositive: payment.isPositive ?? false)
                        .padding(.bottom, 4)
                }
                
            }
            Spacer().frame(height: 60)
        }
        
    }
    
}

