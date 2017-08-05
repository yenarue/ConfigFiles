""""""""""""""""""""""""""""""""""""""""""""""""""""
"" General
""""""""""""""""""""""""""""""""""""""""""""""""""""
set enc=utf-8                           "인코딩을 utf-8로
colo zenburn                            "colorshceme  -  /usr/share/vim/vim74/colors (http://vimcolors.com/)

set history=1000
set nobackup                            "백업파일 생성 안함

filetype on                             "파일의 종류를 자동으로 인식
filetype plugin on
filetype plugin indent on

syntax on                               "구문 강조 ON


""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Vim UI
""""""""""""""""""""""""""""""""""""""""""""""""""""
set title                               "타이틀바에 현재 편집중인 파일명 표시하기
set cursorline                          "현재 커서가 위치한 라인 강조
"set cursorcolumn                       "현재 커서가 위치한 컬럼 강조
set laststatus=2                        "상태바 항상 표시하기
set ruler                               "상태바 우측에 현재 커서의 위치(줄,칸)을 표시하기

set number                              "줄 넘버 보이기
"hi LineNr ctermfg=Yellow               "줄 넘버 색깔 지정

set incsearch                           "검색시(/, ?) 구문 하이라이트
set hlsearch                            "검색어 하이라이트
"set smartcase                          "검색 시 대소문자 구별하기                                  

set showmode                            "모드 변환 시 화면에 표시
set showcmd                             "명령어 보이기
set showmatch                           "일치하는 괄호 하이라이팅


""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Text Formatting/Layout
""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent                          "자동 들여쓰기
set cindent                             "C 스타일의 자동 들여쓰기
set smartindent
"set expandtab                          "TAP을 입력하면 공백문자로 변환하기
set shiftwidth=4                        ">>, << 로 자동 들여쓰기 시 너비 설정
setg softtabstop=4                      "keyboard에서 tab키 선택 시 너비 설정
set tabstop=4                           "\t의 너비 설정
set paste                              "붙여넣기 시 들여쓰기 해제 (set paste! : 해제)
 

""""""""""""""""""""""""""""""""""""""""""""""""""""
"각 파일별 설정 다르게 해주고싶을때는 아래 사용
""""""""""""""""""""""""""""""""""""""""""""""""""""
"au BufNewFile,BufReadPost *.c,*.h set cindent shiftwidth=4 number tapstop=4
"au BufNewFile,BufReadPost *.c,*.h syntax on
"au BufNewFile,BufReadPost *.cpp,*.cc set cindent shiftwidth=4 number tapstop=4
"au BufNewFile,BufReadPost *.cpp,*.cc syntax on
"au BufNewFile,BufReadPost *.java set cindent shiftwidth=4
"au BufNewFile,BufReadPost *.php3 set cindent shiftwidth=4
"au BufNewFile,BufReadPost *.php set cindent shiftwifth=4
"au BufNewFile,BufReadPost *.pl set cinent shiftwidth=4
"au BufNewFile,BufReadPost *.tex set autoindent 
