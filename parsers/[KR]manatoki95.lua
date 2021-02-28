Manatoki95=Parser:new("마나토끼","https://manatoki95.net","KOR","MANATOKI95KR",1)Manatoki95.Filters={{Name="장르",Type="check",Tags={"17","BL","SF","TS","개그","게임","도박","드라마","라노벨","러브코미디","먹방","백합","붕탁","순정","스릴러","스포츠","시대","애니화","액션","음악","이세계","일상","전생","추리","판타지","학원","호러"}},{Name="정렬",Type="radio",Tags={"기본","인기순","추천순","댓글순","북마크순","Update"}}}local a={["기본"]="",["인기순"]="as_view",["추천순"]="as_good",["댓글순"]="as_comment",["북마크순"]="as_bookmark",["Update"]="as_update"}local b="/comic?publish=&jaum=&tag=%s&sst=%s&sod=desc&stx=%s&artist="local function c(string)return string:gsub("&#([^;]-);",function(d)local e=tonumber("0"..d)or tonumber(d)return e and u8c(e)or"&#"..d..";"end):gsub("&(.-);",function(d)return HTML_entities and HTML_entities[d]and u8c(HTML_entities[d])or"&"..d..";"end)end;local function f(g)local h={}Threads.insertTask(h,{Type="StringRequest",Link=g,Table=h,Index="text"})while Threads.check(h)do coroutine.yield(false)end;return h.text or""end;function Manatoki95:getManga(g,i)local j=f(g)i.NoPages=true;for k,l,m in j:gmatch('img%-item">.-href="[^"]-comic/(.-)?[^"]-">[^<]-<img src="(.-)".-title white">(.-)</span>')do i[#i+1]=CreateManga(c(m),k,l,self.ID,self.Link.."/comic/"..k)i.NoPages=false;coroutine.yield(false)end end;function Manatoki95:getLatestManga(n,i)self:getManga(self.Link.."/comic/p"..n.."?sst=as_update&sod=desc",i)end;function Manatoki95:getPopularManga(n,i)self:getManga(self.Link.."/comic/p"..n.."?sst=as_view&sod=desc",i)end;function Manatoki95:searchManga(o,n,i,p)local q=b;if p then local r=p["장르"]local s=p["정렬"]local t=""local u=""if r and#r>0 then t=table.concat(r,"%%2C")end;if a[s]then u=a[s]end;q=q:format(t,u,o)else q=q:format("","",o)end;self:getManga(self.Link..q,i)end;function Manatoki95:getChapters(v,i)local j=f(self.Link.."/comic/"..v.Link)local w={}for k,m in j:gmatch('list%-item.-href="[^"]-comic/(.-)?[^"]-".-</span>%s*(.-)%s*<span')do w[#w+1]={Name=c(m),Link=k,Pages={},Manga=v}end;for x=#w,1,-1 do i[#i+1]=w[x]end end;function Manatoki95:prepareChapter(y,i)local j=f(self.Link.."/comic/"..y.Link.."?spage=1")local q=""for z in j:gmatch('html_data%+=\'(.-)\';')do q=q..z end;q=q:gsub("(.-)%.",function(d)return string.char(tonumber("0x"..d))end)for k in q:gmatch('%.gif" data%-[^=]-="([^"]-)"')do i[#i+1]=k end end;function Manatoki95:loadChapterPage(g,i)i.Link=g end