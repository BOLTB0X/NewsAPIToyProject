# newsAPIToy02

![벤치마킹](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/gif/%EA%B3%B5%EC%8B%9D%ED%8A%9C%ED%86%A0%EB%A6%AC%EC%96%BC.gif?raw=true) ![newsapi](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/gif/%EB%89%B4%EC%8A%A402_01_%EC%9E%84%EC%8B%9C%EB%A9%94%EC%9D%B8.gif?raw=true)
<br/>

**SwiftUI 공식 튜토리얼 + NewsAPI**
<br/>

TODO 각 기능의 코드 설명을 붙일 예정
<br/>

## View

0. Launch Screen
   <br/>
   ![첫](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/02gif/%EC%95%B1%20%EB%9F%B0%EC%B9%98%EC%8A%A4%ED%81%AC%EB%A6%B0.gif?raw=true)

1. Main
   <br/>
   ![메인1](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/02gif/%EB%A9%94%EC%9D%B81.gif?raw=true) ![메인2](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/02gif/%EB%A9%94%EC%9D%B83.gif?raw=true)

2. BookMark
   <br/>
   ![북마크](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/02gif/%EB%B6%81%EB%A7%88%ED%81%AC.gif?raw=true)

3. HeadLine
   <br/>
   ![해드라인](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/02gif/%ED%97%A4%EB%93%9C%EB%9D%BC%EC%9D%B8.gif?raw=true)

4. Search
   <br/>

   ![검색1](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/02gif/%EA%B2%80%EC%83%89.gif?raw=true) ![검색2](https://github.com/BOLTB0X/NewsAPIToyProject/blob/main/02gif/%EA%B2%80%EC%83%89%20%EC%83%81%EC%84%B8.gif?raw=true)

## 상세 기능

#### 0. Launch Screen

<details><summary>애니메이션</summary>

```swift
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
                // animationAmount가 1이면 불트명이 1이고, 2이면 불투명도가 0
                    .opacity(Double(2 - animationAmount))
                    .animation(Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: false)))
            .onAppear {
                self.animationAmount = 2
            }
    }
}
```

CnimationCircle 으로 이미지 테두리에 선이 퍼저나가는 애니메이션 효과를 적용한 코드
<br/>

```swift
.overlay(
   Circle()
      .stroke(Color.blue, lineWidth: 2)
      .scaleEffect(animationAmount)
      //animationAmount가 1이면 불트명이 1이고, 2이면 불투명도가 0이다
      .opacity(Double(2 - animationAmount))
      .animation(Animation.easeInOut(duration: 1)
      .repeatForever(autoreverses: false)))
   .onAppear {
      self.animationAmount = 2
      }
```

animationAmount 프로퍼티를 통해서 퍼져나가는 테두리 선의 투명도를 표현
<br/>

Animation 효과를 repeatForver 로 지정을 통해 계속 반복 시킴
<br/>

[코드 출처](https://seons-dev.tistory.com/39)
<br/>

</details>
<br/>

<details><summary>데이터 로딩 구분</summary>

```swift
struct ContentView: View {
    @State var isLoading: Bool = true
    @EnvironmentObject var manager: BookMarkManager

    var body: some View {
        ZStack {
            if isLoading { // 로딩 중일때 띄울거
                CnimationCircle()
            } else {
                Main()
                    .environmentObject(manager)
            }
        }
        .onAppear { // 뷰가 나타날 때
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                isLoading.toggle() // 3초 후 프로퍼티 토글
            })
        }
    }
}
```

이제 앱이 첫 로딩이 될 때 **DispatchQueue.main.asyncAfter**을 통해서 3초 정도 지연 시킴
<br/>

if-else 구문으로 나타낼 뷰를 구분 시킴
<br/>

</details>

#### 1. Banner
