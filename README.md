# TCA Reducer Scope Routing Issue Sample

TCA(The Composable Architecture)에서 Reducer 프로토콜 기반으로 구현할 때 Scope를 통한 액션 라우팅이 동작하지 않는 문제를 재현하는 샘플 프로젝트입니다.

## 문제 상황

- **Root Counter**: RootFeature 자신의 state를 Reduce 클로저에서 직접 처리 → **정상 동작**
- **New Counter**: 하위 Feature를 Scope를 통해 연결 → **액션이 라우팅되지 않음**

Reducer 프로토콜 기반으로 구현하고 `body`에서 Scope와 Reduce를 조합하면, Scope를 통한 액션 라우팅이 제대로 동작하지 않습니다. Preview뿐만 아니라 실제 앱 실행에서도 동일한 문제가 발생합니다.

## 실행 방법

1. `Package.swift` 파일을 Xcode에서 엽니다
2. `Sources/TcaReducerMixingSample/UI/ContentView.swift` 파일을 엽니다
3. Xcode Preview를 실행하거나 (⌥⌘↩) 앱을 직접 실행합니다
4. 버튼들을 눌러봅니다:
   - **Root Counter**: 정상적으로 카운트가 증가/감소합니다
   - **New Counter**: 버튼을 눌러도 카운트가 변하지 않습니다 (액션이 라우팅되지 않음)

## 코드 구조

```
Sources/TcaReducerMixingSample/
├── RootFeature/
│   └── RootFeature.swift       # Scope를 통한 Reducer 조합
├── NewFeature/
│   └── NewCounterFeature.swift # @Reducer 매크로 기반 Feature
├── LegacyFeature/
│   └── LegacyCounterFeature.swift # Reducer 프로토콜 기반 Feature
├── UI/
│   └── ContentView.swift       # Preview 테스트용 UI
└── TcaReducerMixingSampleApp.swift
```

## 결론

Reducer 프로토콜 기반으로 구현하면서 `body`에서 Scope와 Reduce를 조합하는 방식은 예상대로 동작하지 않습니다. 

**권장 사항**: TCA에서는 `@Reducer` 매크로를 사용하여 일관되게 구현하는 것이 좋습니다. 매크로 기반으로 통일하면 이러한 라우팅 문제를 피할 수 있습니다.

## 환경

- Swift 6.0+
- TCA 1.17.0+
- Xcode 16.0+

