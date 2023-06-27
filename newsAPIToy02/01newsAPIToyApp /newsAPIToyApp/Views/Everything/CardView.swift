//
//  CardView.swift
//  newsAPIToyApp
//
//  Created by KyungHeon Lee on 2023/06/27.
//

import SwiftUI

// MARK: - 카드 뷰
struct CardView: View {
    let title:String
    let cate:String
    let imgURL:String
    let date:String
    let time: Int? = nil
    @State private var loading: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: imgURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .onAppear {
                        loading = false // 가리기 취소
                    }
                
            } placeholder: {
                Image("free-icon-gallery")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .onAppear {
                        loading = true // 가리기
                    }
                    .redacted(reason: .placeholder)
            }
            HStack {
                VStack(alignment: .leading) {
                    if loading {
                        Text("Loading....................................................................")
                            .font(.headline)
                            .lineLimit(1)
                            .redacted(reason: .placeholder)
                        
                        Text("Loading.......................")
                            .font(.system(size: 20, weight: .bold))
                            .lineLimit(1)
                            .redacted(reason: .placeholder)
                        
                        Text("Loading...")
                            .lineLimit(1)
                            .font(.subheadline)
                            .redacted(reason: .placeholder)
                        
                    } else {
                        Text("\(cate)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text("\(title.isEmpty ? "???" : title)")
                            .font(.system(size: 20, weight: .bold))
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(2)
                        
                        Text("\(date.isEmpty ? "???" : date)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }
                .layoutPriority(100)
       
            }
            .padding()
        }
        .cornerRadius(10)
          .overlay(
              RoundedRectangle(cornerRadius: 10)
                  .stroke(Color(.sRGB,red: 150/255, green: 150/255, blue: 150/255, opacity: 0.5), lineWidth: 1)
          )
          .padding(.horizontal)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "손오공", cate: "만화",imgURL: "https://t1.daumcdn.net/cfile/tistory/99A90B4D5C5E3D640D", date: "202206")
    }
}
