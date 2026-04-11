# 근태관리 매뉴얼 — 팀원 온보딩 가이드

## 이 문서의 목적

근태관리 매뉴얼을 함께 수정·관리하기 위한 환경 세팅과 작업 프로세스를 안내합니다.

---

## 1. 전체 프로세스 요약

```
레포 클론 → 로컬에서 매뉴얼 확인 → Claude에게 수정 요청 → 로컬 확인 → Git push → 자동 배포
```

| 단계 | 도구 | 설명 |
|------|------|------|
| 1. 클론 | Git | GitHub에서 매뉴얼 파일을 내 PC로 가져오기 |
| 2. 확인 | 브라우저 | 로컬 서버로 매뉴얼 미리보기 |
| 3. 수정 | Claude | AI에게 수정 사항을 자연어로 요청 |
| 4. 검토 | 브라우저 | 수정된 결과를 로컬에서 확인 |
| 5. 배포 | Git push | GitHub에 올리면 Vercel이 자동 배포 |

---

## 2. 필요한 도구 설치

### 2.1 Git 설치

Git이 이미 설치되어 있는지 확인:
```
git --version
```

설치 안 되어 있으면:
- Windows: https://git-scm.com/download/win 에서 다운로드 후 설치
- 설치 시 모든 옵션 기본값으로 진행

### 2.2 VS Code 설치 (선택)

Claude Code를 VS Code 확장으로 사용하려면:
- https://code.visualstudio.com 에서 다운로드

### 2.3 Claude 사용 방법 (택 1)

| 방법 | 설명 | 추천 대상 |
|------|------|----------|
| **Claude 앱 (claude.ai)** | 브라우저에서 사용. 파일 첨부로 수정 요청 | 가장 간단 |
| **Claude Code (VS Code 확장)** | VS Code 안에서 직접 파일 수정 | 개발자 |
| **Claude Code (CLI)** | 터미널에서 사용 | 고급 사용자 |

**Claude 앱을 사용하는 경우:**
1. claude.ai 접속 → 로그인
2. 수정할 HTML 파일을 첨부하거나 내용을 붙여넣기
3. 수정 요청 → 결과물을 로컬 파일에 덮어쓰기

**Claude Code (VS Code)를 사용하는 경우:**
1. VS Code에서 Claude Code 확장 설치
2. 매뉴얼 폴더를 VS Code로 열기
3. Claude에게 직접 수정 요청 → 파일이 자동으로 수정됨

### 2.4 로컬 서버 (매뉴얼 미리보기용)

매뉴얼은 iframe을 사용하므로 로컬 서버가 필요합니다.

**방법 A: 포함된 배치 파일 사용**
```
0.근태매뉴얼_보기시작파일.bat
```
더블클릭하면 로컬 서버가 시작됩니다.

**방법 B: VS Code Live Server 확장**
1. VS Code에서 Live Server 확장 설치
2. index.html 우클릭 → "Open with Live Server"

**방법 C: Python (이미 설치된 경우)**
```
cd 매뉴얼폴더
python -m http.server 5500
```
브라우저에서 http://localhost:5500 접속

---

## 3. 최초 세팅 (한 번만)

### 3.1 레포 클론

터미널(또는 VS Code 터미널)에서:
```
git clone https://github.com/9ja9ja/attendance-manual.git
```

내 PC에 `attendance-manual` 폴더가 생성됩니다.

### 3.2 Git 사용자 정보 설정

```
cd attendance-manual
git config user.name "내 이름"
git config user.email "내 이메일@회사.com"
```

### 3.3 폴더 열기

- VS Code: `File → Open Folder → attendance-manual 폴더 선택`
- 또는 터미널에서: `code attendance-manual`

---

## 4. 일상 작업 프로세스

### 4.1 작업 시작 전 — 최신 버전 가져오기

```
git pull
```

다른 팀원이 수정한 내용을 내 PC에 반영합니다.
**매번 작업 시작 전에 반드시 실행하세요.**

### 4.2 수정 요청하기

**Claude 앱 사용 시:**
```
"근로제관리.html 파일에서 검색 영역 설명을 더 상세하게 수정해줘.
검색 드롭다운에 '근무요일' 옵션이 추가되었어."
```
→ Claude가 수정된 HTML을 제공하면 로컬 파일에 붙여넣기

**Claude Code (VS Code) 사용 시:**
```
@근로제관리.html 검색 영역에 '근무요일' 드롭다운 옵션 추가해줘
```
→ Claude가 파일을 직접 수정

### 4.3 로컬에서 확인

1. 로컬 서버 실행 (위 2.4 참고)
2. 브라우저에서 수정된 페이지 확인
3. 문제 있으면 Claude에게 재수정 요청

### 4.4 수정 완료 후 — 배포하기

```
git add .
git commit -m "근로제관리 검색 영역 업데이트"
git push
```

push하면 **Vercel이 자동으로 배포**합니다.
1~2분 후 https://attendance-manual.vercel.app 에서 확인 가능합니다.

---

## 5. Git 명령어 치트시트

| 상황 | 명령어 |
|------|--------|
| 최신 버전 가져오기 | `git pull` |
| 변경된 파일 확인 | `git status` |
| 모든 변경 파일 스테이징 | `git add .` |
| 커밋 (저장) | `git commit -m "변경 내용 설명"` |
| 배포 (GitHub에 올리기) | `git push` |
| 내 변경 되돌리기 | `git checkout -- 파일명` |

### 충돌이 발생했을 때

다른 팀원과 같은 파일을 동시에 수정하면 충돌이 발생할 수 있습니다.

```
git pull    ← 이때 충돌 메시지가 뜨면
```

1. VS Code에서 충돌 파일을 열면 `<<<<<<` 표시가 보입니다
2. 원하는 내용으로 수정 후 저장
3. `git add .` → `git commit -m "충돌 해결"` → `git push`

**팁: 작업 전에 항상 `git pull`을 먼저 하면 충돌을 줄일 수 있습니다.**

---

## 6. 매뉴얼 수정 시 주의사항

### 6.1 CLAUDE.md를 읽어주세요

매뉴얼 폴더에 `CLAUDE.md` 파일이 있습니다. Claude에게 수정을 요청할 때 이 파일을 함께 참조하면 기존 스타일과 규칙을 유지할 수 있습니다.

### 6.2 스타일 규칙

- 다크 테마 배경 (`#0d1117`)
- Pretendard 폰트
- 화면 ID는 넣지 않음 (실제 매뉴얼 어조)
- 피그마 출처 언급 없음

### 6.3 수정 후 체크리스트

- [ ] 로컬 서버에서 수정된 페이지가 정상 표시되는지 확인
- [ ] index.html의 서브탭에서 해당 페이지가 정상 로드되는지 확인
- [ ] 다른 페이지의 "연결 문서" 링크가 깨지지 않았는지 확인
- [ ] 새로운 전문 용어가 추가되었다면 `용어집.html`도 업데이트

---

## 7. 주요 링크

| 항목 | URL |
|------|-----|
| 매뉴얼 (배포본) | https://attendance-manual.vercel.app |
| GitHub 레포 | https://github.com/9ja9ja/attendance-manual |
| Vercel 대시보드 | https://vercel.com/9ja9ja9ja-1760s-projects/attendance-manual |

---

## 8. 문제 해결

| 문제 | 해결 |
|------|------|
| `git push` 권한 오류 | GitHub Collaborator 초대를 수락했는지 확인 |
| push 후 배포 안 됨 | Vercel 대시보드에서 빌드 상태 확인 (1~2분 소요) |
| 로컬 서버 안 됨 | `file://` 프로토콜로는 iframe이 작동하지 않음. 반드시 로컬 서버 사용 |
| 충돌 발생 | `git pull` 후 충돌 표시된 파일 수동 수정 → commit → push |
| Claude가 스타일을 다르게 수정 | `CLAUDE.md` 파일을 함께 참조하도록 요청 |
