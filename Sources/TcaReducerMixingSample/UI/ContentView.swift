import SwiftUI
import ComposableArchitecture

/// TCA Reducer 프로토콜 기반 구현 시 Scope 라우팅 문제 재현을 위한 메인 UI
struct ContentView: View {
    let store: StoreOf<RootFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 40) {
                Text("TCA Scope 라우팅 문제")
                    .font(.title)
                    .fontWeight(.bold)

                // Root Counter 섹션
                // Reduce 클로저에서 직접 처리되므로 정상 동작함
                VStack(spacing: 16) {
                    Text("Root Counter")
                        .font(.headline)
                        .foregroundColor(.purple)

                    Text("Count: \(viewStore.counter)")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    HStack(spacing: 20) {
                        Button("-") {
                            viewStore.send(.rootDecrement)
                        }
                        .buttonStyle(.bordered)
                        .tint(.red)

                        Button("Reset") {
                            viewStore.send(.rootReset)
                        }
                        .buttonStyle(.bordered)
                        .tint(.gray)

                        Button("+") {
                            viewStore.send(.rootIncrement)
                        }
                        .buttonStyle(.bordered)
                        .tint(.green)
                    }
                }
                .padding()
                .background(Color.purple.opacity(0.1))
                .cornerRadius(12)

                // New Counter 섹션
                // Scope를 통해 연결되어 있지만 액션이 라우팅되지 않음
                VStack(spacing: 16) {
                    Text("New Counter (Scope 연결)")
                        .font(.headline)
                        .foregroundColor(.green)

                    Text("Count: \(viewStore.new.count)")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    HStack(spacing: 20) {
                        Button("-") {
                            viewStore.send(.new(.decrement))
                        }
                        .buttonStyle(.bordered)
                        .tint(.red)

                        Button("Reset") {
                            viewStore.send(.new(.reset))
                        }
                        .buttonStyle(.bordered)
                        .tint(.gray)

                        Button("+") {
                            viewStore.send(.new(.increment))
                        }
                        .buttonStyle(.bordered)
                        .tint(.green)
                    }
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(12)

                // 문제 설명
                VStack(alignment: .leading, spacing: 8) {
                    Text("Reducer 프로토콜 기반 구현 시 문제:")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Text("• Root Counter: Reduce 클로저에서 직접 처리 → 정상 동작")
                        .font(.caption)
                        .foregroundColor(.purple)

                    Text("• New Counter: Scope를 통해 연결 → 라우팅 안 됨")
                        .font(.caption)
                        .foregroundColor(.green)

                    Divider()

                    Text("해결 방법: @Reducer 매크로로 통일하여 구현")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView(
        store: Store(
            initialState: RootFeature.State(),
            reducer: { RootFeature() }
        )
    )
}
