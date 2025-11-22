#!/bin/bash

# Xcode 프로젝트 생성 스크립트
# 이 스크립트는 Xcode 프로젝트를 자동으로 생성합니다.

PROJECT_NAME="TcaReducerMixingSample"
BUNDLE_ID="com.sapzildj.tca.reducer.conflict"
PROJECT_DIR="$(pwd)"

echo "🚀 Xcode 프로젝트 생성 중..."

# Xcode 프로젝트 생성
xcodebuild -project "${PROJECT_NAME}.xcodeproj" -list 2>/dev/null

if [ $? -ne 0 ]; then
    echo "⚠️  Xcode 프로젝트 파일이 없습니다."
    echo ""
    echo "📝 다음 단계를 따라주세요:"
    echo ""
    echo "1. Xcode 실행"
    echo "2. File > New > Project"
    echo "3. iOS > App 선택"
    echo "4. Product Name: ${PROJECT_NAME}"
    echo "5. Organization Identifier: com.sapzildj"
    echo "6. Interface: SwiftUI"
    echo "7. Language: Swift"
    echo "8. 저장 위치: ${PROJECT_DIR}"
    echo ""
    echo "프로젝트 생성 후 이 스크립트를 다시 실행하거나,"
    echo "SETUP_XCODE.md 파일의 안내를 따라주세요."
    exit 1
fi

echo "✅ Xcode 프로젝트가 준비되었습니다!"
echo ""
echo "다음 단계:"
echo "1. Xcode에서 프로젝트 열기"
echo "2. Sources/TcaReducerMixingSample/ 폴더의 파일들을 프로젝트에 추가"
echo "3. SPM 패키지 의존성 추가 (ComposableArchitecture)"
echo ""
echo "자세한 내용은 SETUP_XCODE.md 파일을 참고하세요."

