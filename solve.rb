d=->y,x{f=$f[y];f[x]==?G&&(puts$f;exit);f[x]>?!||(f[x]=?:;d[y+1,x];d[y,x-1];d[y-1,x];d[y,x+1];f[x]=' ')};d[($f=*$<).index{|s|s>?R},1]
