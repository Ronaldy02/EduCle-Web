import sys,re,html,glob
for f in sorted(glob.glob('*.html')):
    s=open(f,encoding='utf-8',errors='replace').read()
    t=re.search(r'<title>(.*?)</title>',s,re.S); 
    defs=re.findall(r'<li class="DivisionDefinition">(.*?)</li>',s,re.S)
    print('=====',f,'|',html.unescape(t.group(1).strip()) if t else '')
    for d in defs[:6]:
        d=re.sub(r'<[^>]+>','',d); print(' -',html.unescape(re.sub(r'\s+',' ',d)).strip()[:400])
