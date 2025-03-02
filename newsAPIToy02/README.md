# News REST API 활용 Toy Project

| SwiftUI Tutorial                                                                                                                                    | News                                                                                                   |
| --------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| ![SwiftUI Tutorial](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/gif/%EA%B3%B5%EC%8B%9D%ED%8A%9C%ED%86%A0%EB%A6%AC%EC%96%BC.gif?raw=true) | ![News](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/02gif/%EB%A9%94%EC%9D%B83.gif?raw=true) |

**SwiftUI 공식 튜토리얼 + NewsAPI**

## 0.Launch Screen

| 첫 진입                                                                                                                                    |
| ------------------------------------------------------------------------------------------------------------------------------------------ |
| ![첫](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/02gif/%EC%95%B1%20%EB%9F%B0%EC%B9%98%EC%8A%A4%ED%81%AC%EB%A6%B0.gif?raw=true) |

<br/>

<details><summary>애니메이션</summary>

```swift
// in ContentView.swift
struct CnimationCircle: View {
   @State private var animationAmount: CGFloat = 1

   var body: some View {
      Image(systemName: "n.circle.fill")
         .resizable()
         .foregroundColor(.black)
         .frame(width: 200, height: 200)
         .clipShape(Circle())
         .overlay(
            Circle()
               .stroke(Color.blue, lineWidth: 2)
               .scaleEffect(animationAmount)
               .opacity(Double(2 - animationAmount))
               .animation(Animation.easeInOut(duration: 1)
               .repeatForever(autoreverses: false)))
             .onAppear {
                  self.animationAmount = 2
         }
   }
}
```

`CnimationCircle` 으로 이미지 테두리에 선이 퍼저나가는 애니메이션 효과를 적용한 코드

```swift
   .overlay(
      Circle()
         .stroke(Color.blue, lineWidth: 2)
         .scaleEffect(animationAmount)
         .opacity(Double(2 - animationAmount))
         .animation(Animation.easeInOut(duration: 1)
         .repeatForever(autoreverses: false)))
      .onAppear {
         self.animationAmount = 2
      }
```

**`animationAmount`가 1이면 불트명이 1이고, 2이면 불투명도가 0**

- `animationAmount` 프로퍼티를 통해서 퍼져나가는 테두리 선의 투명도를 표현

- Animation 효과를 `repeatForver` 로 지정을 통해 계속 반복 시킴

[참고 - 코드 출처](https://seons-dev.tistory.com/39)

</details>

<details><summary>데이터 로딩 구분</summary>

```swift
struct ContentView: View {
   @State var isLoading: Bool = true
   @EnvironmentObject var manager: BookMarkManager

   var body: some View {
      ZStack {
         if isLoading {
            CnimationCircle()
         } else {
            Main().environmentObject(manager)
         }
      }
      .onAppear {
         DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            isLoading.toggle()
         })
      }
   }
}
```

- 이제 앱이 첫 로딩이 될 때 **DispatchQueue.main.asyncAfter**을 통해서 3초 정도 지연 시킴

- if-else 구문으로 나타낼 뷰를 구분 시킴

[ContentView 코드 보기](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/newsAPIToy02/01newsAPIToyApp%20/newsAPIToyApp/Views/ContentView.swift)

</details>

## 1. Main

| Main 1                                                                                                  | Main 2                                                                                                  |
| ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| ![메인1](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/02gif/%EB%A9%94%EC%9D%B81.gif?raw=true) | ![메인2](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/02gif/%EB%A9%94%EC%9D%B83.gif?raw=true) |

<br/>

<details><summary>배너</summary>

수평 방향으르 스크롤 뷰 구성

```swift
// in Banner.swift
struct Banner: View {
   /* 생략 */
   // ...

   var body: some View {
      VStack(alignment: .leading, spacing: 0) {
         /* 생략 */
         // ....

         /* 베너부분 */
         /* 옆으로 스크롤 뷰 */
         ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 0) {
               ForEach(BannerViewModel.banners.indices, id: \.self) { i in
                  /* 생략 */

                  ZStack {
                     /*사진을 배경으로 설정 */
                     AsyncImage(url: URL(string: banner.urlToImage ?? "")) { image in
                        image
                           .resizable()
                           .frame(width: w, height: h)
                           .aspectRatio(contentMode: .fit)
                           .cornerRadius(15)
                     } placeholder: {
                        Image(systemName: "photo")
                           .resizable()
                           .frame(width: w, height: h)
                           .aspectRatio(contentMode: .fit)
                           .cornerRadius(15)
                           .redacted(reason: .placeholder)
                     }
                     .padding(.horizontal)
                     /* 생략 */
                  }
               }
            }
            .frame(width: w, height: h)
            /* 옆으로 스크롤 */
            .onAppear {
               UIScrollView.appearance().isPagingEnabled = true
            }
            .onDisappear {
               UIScrollView.appearance().isPagingEnabled = false
            }
            /* 생략 */
            // ...
      }
   }
}
```

<br/>

```swift
private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect() /* 타이머 */

// ...

.onReceive(timer) { _ in
   withAnimation {
      currentIndex = (currentIndex + 1) % BannerViewModel.banners.count /* 다음 헤드라인으로 이동 */
   }
}
```

- 타이머 프로퍼티를 통해서 2초의 시간을 잼

- `withAnimation` 을 이용하여 2초마다 배너의 이미지를 넘겨줌
  <br/>

[Banner 코드 보기](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/newsAPIToy02/01newsAPIToyApp%20/newsAPIToyApp/Views/NewsMain/Banner.swift)

</details>

<details><summary>가로 카테고리 스크롤</summary>

```swift
ScrollView(.horizontal, showsIndicators: false) {
   HStack(alignment: .top, spacing: 0) {
      ForEach(recom.prefix(5), id: \.self) { recom in
         NavigationLink(
            destination: NewsDetail(articleDetail: recom, loading: $loading),
            label: {
               CellImage(item: recom, w: 155, h: 155, isTitleDisplay: true, isLoading: $loading)
            })
         }
      }
      .frame(height: 185)
   }
   .onAppear {
      UIScrollView.appearance().isPagingEnabled = true
   }

   .onDisappear {
      UIScrollView.appearance().isPagingEnabled = false
   }
```

- **ScrollView(.horizontal, showsIndicators: false)** 으로 설정 후 `HStack`

- **UIScrollView isPagingEnabled** 을 이용

[참고 원본 소스코드](https://code-algo.tistory.com/14)

뉴스기사 이미지를 클릭 시 해당 뉴스 기사 관련 상세 정보가 나타나는 뷰로 이동

[RecommendRow 코드 보기](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/newsAPIToy02/01newsAPIToyApp%20/newsAPIToyApp/Views/Recommend/RecommendRow.swift)

</details>

<details>
<summary>추천 News</summary>

랜덤 API가 없어 임의로 배열들을 만들어줌

```swift
// in NewsMainViewModel.swift
// 추천 검색어 api는 일단 random으로 대체
let radomArr1 = ["Bitcoin", "MMA", "Meta", "LOL"]
let radomArr2 = ["shinkai makoto", "across the spider verse", "oldboy", "spiderman"]
let radomArr3 = ["Kpop BTS", "Kpop SM", "Aespa", "KPop"] // entertainment
let radomArr4 = ["Nike", "adidas", "Puma", "asics"]
```

뷰모델에서 메인 뷰에 게시할 데이터를 가져올 때 뉴스 기사의 키워드를 랜덤으로 가져옴

```swift
// in NewsMainViewModel.swift

// MARK: - fetchPostRecommend
func fetchPostRecommend(series: Int) async throws {
    if series == 1 { // 번호에 따라 키워드 변경
        query = radomArr1.randomElement()! // 랜덤으로 넣어줌
        print("\(query)")
    } else if series == 2 {
        query = radomArr2.randomElement()!
        print("\(query)")
    } else if series == 3 {
        query = radomArr3.randomElement()!
        print("\(query)")
    } else {
        query = radomArr4.randomElement()!
        print("\(query)")
    }

    // 생략
    // ...
    // ...
```

[NewsMainViewModel.swift 코드 보기](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/newsAPIToy02/01newsAPIToyApp%20/newsAPIToyApp/ViewModels/NewsMainViewModel.swift)

</details>

## 2. BookMark

| 북마크 1                                                                                                         | 북마크 2                                                                                                           |
| ---------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| ![북마크](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/02gif/%EB%B6%81%EB%A7%88%ED%81%AC.gif?raw=true) | ![북마크2](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/02gif/%EB%B6%81%EB%A7%88%ED%81%AC2.gif?raw=true) |

<details><summary>코어 데이터</summary>

코어 데이터 적용

```swift
// in CoreDataManager.swift
// MARK: - CoreDataManager
class CoreDataManager {
    static let shared = CoreDataManager()

    // MARK: - searchContainer
    lazy var searchContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("검색 컨테이너 error: \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - favoriteContainer
    lazy var favoriteContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Favorite")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // 생략
    // ...

    // MARK: - saveFavorite
    func saveFavorite(title: String, url: String, description: String?, author: String?, urlimg: String?, publi: String?, conten: String?) {
        let context = favoriteContainer.viewContext

        // 중복 체크
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)

        do {
            let favoriteResults = try context.fetch(fetchRequest)
            if let pastFavorite = favoriteResults.first {
                // 이미 저장된 좋아요 한 Article이 있으면 패스
                print("이미 저장된 좋아요 한 Article")
                return
            }
        } catch {
            print("중복 체크 실패: \(error)")
            return
        }

        // 저장 로직
        let favorite = Favorite(context: context)

        favorite.id = UUID()
        favorite.title = title
        favorite.url = url
        favorite.desc = description
        favorite.author = author
        favorite.urlimg = urlimg
        favorite.publi = publi
        favorite.conten = conten
        favorite.favorite = true

        do {
            try context.save()
            print("좋아요 한 Article 저장")
        } catch {
            print("실패한 에러: \(error)")
        }
    }

    // 생략
```

**_무료 api로 진행하는 프로젝트의 문제점_**

- Core Data를 사용하여 북마크 데이터를 저장하더라도, API로부터 새로운 데이터를 가져오면 이전에 저장한 북마크 데이터가 업데이트되거나 초기화가 되어버림
- 이는 API로부터 새로운 데이터를 받아올 때, 새로운 데이터로 기존 데이터를 업데이트하게 되는 것이 일반적이기 때문

[CoreDataManager 코드 보기](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/newsAPIToy02/01newsAPIToyApp%20/newsAPIToyApp/Models/CoreData/CoreDataManager.swift)

</details>

<details><summary>북마크 방식</summary>

이 클래스를 활용하여 북마크 전용 클래스를 생성

```swift
// in BookMarkManager
import Foundation
import CoreData

// MARK: - BookMarkManager
// 북마크 관련 처리
class BookMarkManager: ObservableObject {
    @Published var items: [Article] = []

    init() {
        items.append(Article.getDummy())
        items.append(Article.getDummy2())
    }

    // MARK: - fetchFavorite
    // Article에 해당하는 Favorite 엔티티를 가져오는 메소드
    func fetchFavorite(_ article: Article) -> Favorite? {
        let context = CoreDataManager.shared.favoriteContainer.viewContext

        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", article.title)

        do {
            let favorites = try context.fetch(fetchRequest)
            return favorites.first
        } catch {
            print("실패 원인인 에러: \(error)")
            return nil
        }
    }

    // MARK: - isBookmarked
    // 이미 들어가 있는지 체크
    func isBookmarked(_ article: Article) -> Bool {
        return items.contains(article)
    }

    // MARK: - toggleBookmark
    // 토글 메소드
    func toggleBookmark(_ article: Article) {
        if isBookmarked(article) { // 이미 북마크가 되어 있는 경우
            if let favorite = fetchFavorite(article) {
                CoreDataManager.shared.deleteFavorite(favorite: favorite)
            }
            items.removeAll(where: { $0 == article })
        } else {
            // 북마크가 되어 있지 않은 경우
            items.append(article)
            CoreDataManager.shared.saveFavorite(
                title: article.title,
                url: article.url,
                description: article.description,
                author: article.author,
                urlimg: article.urlToImage,
                publi: article.publishedAt,
                conten: article.content
            )
        }
    }
}
```

앱 모든 뷰에 적용 되므로 **environmentObject** 로 적용

```swift
@main
struct newsAPIToyAppApp: App {
   @StateObject var manager = BookMarkManager()

   var body: some Scene {
      WindowGroup {
         ContentView()
            .environmentObject(manager)
      }
   }
}
```

뉴스 상세기사 화면에 버튼을 눌러 저장

```swift
// in FavoriteButton.swift
import SwiftUI

struct FavoriteButton: View {
    @EnvironmentObject var manager: BookMarkManager
    var item: Article

    var isSet: Bool {
        manager.isBookmarked(item)
    }

    var body: some View {
        // 북마크
        Button {
            manager.toggleBookmark(item)
        } label: {
            // 이미지가 변수에 따라 달라지게
            Image(systemName: isSet ? "checkmark.rectangle.portrait.fill" : "checkmark.rectangle.portrait")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.blue)
        }
    }
}
```

[BookMarkManager 코드 보기](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/newsAPIToy02/01newsAPIToyApp%20/newsAPIToyApp/Models/BookMarkManager.swift)

[FavoriteButton 코드 보기](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/newsAPIToy02/01newsAPIToyApp%20/newsAPIToyApp/Views/SubView/FavoriteButton.swift)

</details>

<details><summary>북마크 셀</summary>

- 북마크한 데이터를 나타내는 셀

- 데이터 로딩 중임을 나타내고 싶어 `AsyncImage` 이용

- 텍스트는 `redacted`

```swift
struct BookMarkCell: View {
    let item: Article
    @State private var imgLoading: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: item.urlToImage!)) { image in
            // 생략
            } placeholder: {
               // 생략
            }
            HStack {
                VStack(alignment: .leading) {
                    if !imgLoading {
                        // 생략
                            .redacted(reason: .placeholder)

                    } else {
                        // 생략
                    }
                }
                .layoutPriority(100)

            }
            .padding()
        }
        // 생략
        .padding(.horizontal)
    }
}
```

```swift
// in BookMark.swift
import SwiftUI

struct BookMark: View {
    @EnvironmentObject var manager: BookMarkManager
    @State private var cellClick: Bool = false

    var body: some View {
        NavigationView {
            List { // ForEach로 담겨진 뉴스기사 배열을 깔끔히 처리를 위해 List를 사용
                ForEach(manager.items) { result in
                    NavigationLink(
                        destination: NewsDetail(articleDetail: result, loading: $cellClick),
                        label: {
                            BookMarkCell(item: result)
                        }
                    )
                    .navigationTitle("BookMark")
                }
            }.listStyle(.inset)
        }.navigationTitle("BookMark")
    }
}
```

[BookMark 코드 보기](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/newsAPIToy02/01newsAPIToyApp%20/newsAPIToyApp/Views/BookMark/BookMark.swift)

</details>

## 3. HeadLine

| 해드라인 1                                                                                                                  | 해드라인 2                                                                                                                    |
| --------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| ![해드라인](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/02gif/%ED%97%A4%EB%93%9C%EB%9D%BC%EC%9D%B8.gif?raw=true) | ![헤드라인2](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/02gif/%ED%97%A4%EB%93%9C%EB%9D%BC%EC%9D%B82.gif?raw=true) |

<details><summary>헤드라인 메인 뷰</summary>

`NavigationView`와 리스트로 전체적인 UI 설계

네비게이션 기능으로 이동 시 자동 생성되는 버튼 취소 및 기존 툴바 약간 수정

```swift
// in HeadLine.swift
import SwiftUI

// MARK: - HeadLineView
// 뉴스기사를 보여주는 View
struct HeadLine: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var headlineVM = HeadLineViewModel()
    @State private var showingSheet: Bool = false
    @State private var articleLoading: Bool = false

    var body: some View {
        NavigationView { // navigationTitle 이용 및 뷰 구성을 위해
            List { // ForEach로 담겨진 뉴스기사 배열을 깔끔히 처리를 위해 List를 사용
               /* 생략 */
               // ....

            }
            .listStyle(.grouped)
            .navigationTitle("News HeadLine")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.backward")
                    }
                }
            }
        }
        // 초기 진입시 task로 비동기로 뷰에 나타낼 data를 불러오는 부분
        .task {
         // 생략
         // ....
        }
    }
}
```

[HeadLine 코드 보기](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/newsAPIToy02/01newsAPIToyApp%20/newsAPIToyApp/Views/HeadLine/HeadLine.swift)

</details>

<details><summary>무한스크롤</summary>

스크롤을 내리면 리스트 끝까지 내리면 추가적으로 데이터를 불러오는 것

먼저 ViewModel에서 데이터를 가져옴

```swift
// in HeadLineViewModel.swift
// MARK: - fetchNewsHeadLine
// headline 목록을 가져오는 메소드
func fetchNewsHeadLine() async throws {
   guard let url = NetworkManager.RequestHeadLineURL(country: "us") else {
      throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
   }

   do {
      let (data, response) = try await URLSession.shared.data(for: url)
      guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200        else {
                DispatchQueue.main.async {
                    self.items = [] // 상태 코드가 200이 아닌 경우, 배열을 비워서 초기화
                }
            return
         }

      let apiResult = try JSONDecoder().decode(APIResults.self, from: data)
      DispatchQueue.main.async {
         if self.items.isEmpty {
            self.items = apiResult.articles
         } else {
            self.items += apiResult.articles
         }
            self.currentPage += 1
         }
      } catch {
         throw error
      }
}
```

그런다음 headline 뷰에

```swift
@StateObject var headlineVM = HeadLineViewModel()
```

`StateObject` 프로퍼티를 선언하여 아래 리스트로 표현

```swift
ForEach(headlineVM.items) { result in
      Button(action: {
         showingSheet.toggle()
         headlineVM.detailArticle = result
      }) {
            HeadLineCell(curNews: result, loading: $articleLoading) // 셀 구성
      }
      .padding()
      .sheet(isPresented: self.$showingSheet) {
         NewsDetail(articleDetail: headlineVM.detailArticle, loading: $articleLoading)
      }
      .onAppear { // onAppear를 이용하여 사용자가 터치로 밑으로 내릴때 추가로
         // 뉴스기사(data)가 필요로 하는 지를 판단함
         if result == headlineVM.items.last {
               headlineVM.loadMoreNewsHeadLine(currentItem: result)
         }
      }
   }
```

리스트에 마지막에 도달하면 더 불러올지 말지를 판단후 메소드 호출

```swift
// in HeadLineViewModel.swift
// MARK: - loadMoreNewsHeadLine
// 계속 불러올지 체크용 메소드
func loadMoreNewsHeadLine(currentItem: Article?) {
   guard !isLoading, let currentItem = currentItem, currentItem == items.last else {
      return
   }

   isLoading = true

   Task {
      do {
         try await fetchNewsHeadLine()
      } catch {
         print(error)
      }
      isLoading = false
   }
}
```

[HeadLineViewModel 코드 보기](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/newsAPIToy02/01newsAPIToyApp%20/newsAPIToyApp/ViewModels/HeadLineViewModel.swift)

</details>

<details><summary>Cell</summary>

```swift
    // 이미지
    AsyncImage(url: URL(string: curNews.urlToImage ?? "")) { image in
        image
            .resizable()
            .frame(width: 320, height: 200)
            .aspectRatio(contentMode: .fit)
            .onAppear {
                loading = true
            }
    } placeholder: {
        Image("free-icon-gallery")
            .resizable()
            .frame(width: 320, height: 200)
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.secondary)
            .redacted(reason: .placeholder)
//                    .onAppear {
//                        loading = false
//                    }
}
```

`AsyncImage` 이용, 이미지를 로딩 중일 때는 `redacted` 이용

[HeadLineCell 보기](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/newsAPIToy02/01newsAPIToyApp%20/newsAPIToyApp/Views/HeadLine/HeadLineCell.swift)

</details>

## 4. Search

| 검색 뷰로 이동                                                                                         | 검색                                                                                                    |
| ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------- |
| ![검색1](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/02gif/%EA%B2%80%EC%83%89.gif?raw=true) | ![검색2](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/02gif/%EA%B2%80%EC%83%892.gif?raw=true) |

| 키워드 검색                                                                                                                     | 검색 필터링                                                                                                                                |
| ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| ![검색 기능](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/02gif/%EA%B2%80%EC%83%89%20%EC%83%81%EC%84%B8.gif?raw=true) | ![검색 필터링](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/02gif/%EA%B2%80%EC%83%89%20%ED%95%84%ED%84%B0%EB%A7%81.gif?raw=true) |

<details><summary>검색 View</summary>

기본 `@State`, `@Binding` 과 오픈 소스 이용하여 검색 bar 구현

[참고 코드 보기](https://www.appcoda.com/swiftui-search-bar/)

검색 바에서 검색어를 입력받아 무한스크롤과 동일한 로직으로 데이터를 받아옴

```swift
// in Search
import SwiftUI

struct SearchMain: View {
    // 생략
    @ObservedObject var searchViewModel = SearchViewModel()
    @EnvironmentObject var newsViewModel: NewsMainViewModel
    @ObservedObject var everyViewModel = EverythingViewModel()

    // 생략

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchViewModel.inputText, startSearch: {
                    Task {
                        do {
                           // 검색이 될 때 메소드 호출
                            try await everyViewModel.fetchNewsEverythingOnServer(query: searchViewModel.inputText)
                        } catch {
                            // 오류 처리
                            print("Error: \(error)")
                        }
                        everyViewModel.isTry = true
                    }
                })

                // 생략
            }
        }
    }
}

```

[SearchBar 코드 보기](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/newsAPIToy02/01newsAPIToyApp%20/newsAPIToyApp/Views/Search/SearchBar.swift)

[Search.swift 코드 보기](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/newsAPIToy02/01newsAPIToyApp%20/newsAPIToyApp/Views/Search/SearchMain.swift)

</details>

<details><summary>검색 필터링</summary>

뷰모델에서 입력 받는 문자열을 `lowercased`와 `trimmingCharacters`으로 필터링

```swift
// in SearchViewModel.swift
// MARK: - SearchViewModel
class SearchViewModel: ObservableObject {
    // 생략

    var filteredArticles: [Article] {
        let searchText = inputText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // banners, recom1, recom2, recom3, recom4에서 필터링
        let allArticles = NewsMainViewModel.shared.banners + NewsMainViewModel.shared.recom1 + NewsMainViewModel.shared.recom2 + NewsMainViewModel.shared.recom3 + NewsMainViewModel.shared.recom4

        if searchText.isEmpty {
            // 검색어가 없는 경우 전체 기사 반환
            return allArticles
        } else {
            // 검색어가 있는 경우 기사들 중 제목에 검색어가 포함된 것만 반환
            return allArticles.filter { $0.title.lowercased().contains(searchText) == true }
        }

```

[SearchViewModel.swift 코드 보기](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/newsAPIToy02/01newsAPIToyApp%20/newsAPIToyApp/ViewModels/SearchViewModel.swift)

뷰에서 필터링된 검색관련 퍼블리싱한 배열을 리스트로 나타냄

```swift
// in Search.swift
List(searchViewModel.filteredArticles, id: \.url) { article in
    Button(action: {
        self.click.toggle()
        searchViewModel.detailArticle = article
    }) {
        SearchCell(item: article)
//                        Text(article.title)
//                            .lineLimit(2)
    }
    .sheet(isPresented: self.$click) {
        NewsDetail(articleDetail: searchViewModel.detailArticle, loading: $loading)
        }
    }
}
```

[SearchMain.swift 코드 보기](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/newsAPIToy02/01newsAPIToyApp%20/newsAPIToyApp/Views/Search/SearchMain.swift)

</details>
