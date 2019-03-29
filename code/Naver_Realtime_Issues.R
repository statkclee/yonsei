
# --------------------------------------------------------------------------------
# 네이버 실시간 검색어 수집
# --------------------------------------------------------------------------------

# 필요한 패키지를 불러옵니다.
library(tidyverse)
library(httr)
library(rvest)


# 네이버 실시간 검색어가 포함된 웹 페이지의 URL을 복사하여 붙입니다. 
'https://www.naver.com'

# HTTP 요청을 실행합니다. 
res <- GET(url = 'https://www.naver.com')

# res 객체를 출력합니다. 
print(x = res) 

# HTTP 응답 상태코드를 확인합니다. 
status_code(x = res)
## [1] 200

# res 객체에 포함된 HTML을 텍스트로 출력합니다. 
# 계층 구조로 출력하기 위해 cat() 함수로 씌워줍니다. 
cat(content(x = res, as = 'text', encoding = 'UTF-8'))


# --------------------------------------------------------------------------------

# 크롬 개발자도구에서 HTML 요소를 찾고 실시간 검색어를 추출합니다. 

# HTTP 응답 객체에서 HTML을 읽습니다.
html <- read_html(x = res) 

# HTML에서 CSS로 필요한 요소만 선택합니다.
span <- html_nodes(x = html, css = 'div.ah_roll_area > ul.ah_l > li.ah_item > a > span.ah_k') 

# 실시간 검색어만 추출합니다.
searchWords <- html_text(x = span)

# 최종 결과를 출력하여 확인합니다. 
print(x = searchWords)


# 파이프 연산자를 사용하여 코드를 간단하게 정리해보겠습니다. 
searchWords <- res %>% 
  read_html() %>% 
  html_nodes(css = 'div.ah_roll_area > ul.ah_l > li.ah_item > a > span.ah_k') %>% 
  html_text()

# 결과를 출력합니다.
print(x = searchWords)


# --------------------------------------------------------------------------------

# 원하는 형태로 저장하기 

# RDS로 저장합니다.
saveRDS(object = searchWords, file = './yeonsei/data/searchWords.RDS')

# Rdata로 저장합니다.
save(searchWords, file = './yeonsei/data/searchWords.Rdata')

# csv로 저장합니다.
write.csv(x = searchWords, file = './yeonsei/data/searchWords.csv')

# txt로 저장합니다.
write.table(x = searchWords, file = './yeonsei/data/searchWords.txt')

# xlsx로 저장합니다. 
writexl::write_xlsx(x = data.frame(searchWords), 
                    path = './yeonsei/data/searchWords.xlsx')


## End of Document
