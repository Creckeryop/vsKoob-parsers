SeriManga=Parser:new("SeriManga","https://serimanga.com","TUR","SERIMANGATR",2)local function a(b)return b:gsub("&#([^;]-);",function(c)local d=tonumber("0"..c)or tonumber(c)return d and u8c(d)or"&#"..c..";"end):gsub("&(.-);",function(c)return HTML_entities and HTML_entities[c]and u8c(HTML_entities[c])or"&"..c..";"end)end;local function e(f)local g={}Threads.insertTask(g,{Type="StringRequest",Link=f,Table=g,Index="text"})while Threads.check(g)do coroutine.yield(false)end;return g.text or""end;function SeriManga:getManga(f,h)local i=e(f)h.NoPages=true;for j,k,l in i:gmatch('mangas%-item">.-href="[^"]-(/manga/[^"]-)".-url%(\'([^"]-)\'%).-"mlb%-name">([^<]-)</span>')do h[#h+1]=CreateManga(a(l),j,k,self.ID,self.Link..j)h.NoPages=false;coroutine.yield(false)end end;function SeriManga:getPopularManga(m,h)self:getManga(self.Link.."/mangalar?filtrele=goruntulenme&sirala=DESC&page="..m,h)end;function SeriManga:searchManga(n,m,h)self:getManga(self.Link.."/mangalar?search="..n.."&page="..m,h)end;function SeriManga:getChapters(o,h)local p={}local q=self.Link..o.Link;local r=nil;repeat local i=e(q)if r==nil then r=(i:match('class="demo1">(.-)</p>')or""):gsub("<br>","\n"):gsub("<.->",""):gsub("\n+","\n"):gsub("^%s+",""):gsub("%s+$","")h.Description=a(r)end;for j,l in i:gmatch('spl%-list%-item">[^"]-href="[^"]-(/manga/[^"]-)" title="([^"]-)"')do p[#p+1]={Name=a(l):gsub("^"..o.Name,""):gsub("^[ -]+",""),Link=j,Pages={},Manga=o}end;q=i:match('"page%-link" href="([^"]-)" rel="next"')until not q;for s=#p,1,-1 do h[#h+1]=p[s]end end;function SeriManga:prepareChapter(t,h)local i=e(self.Link..t.Link)for j in i:gmatch('<img class="chapter%-pages__[^<]-src="([^"]-)"')do h[#h+1]=j end end;function SeriManga:loadChapterPage(f,h)h.Link=f end