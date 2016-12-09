GC.disable;$f=$<.map &:chomp
def d(y,x)
$f[y][x]!=' '&&return
$f[y][x+1]==?G&&($f[y][x]=?:;puts$f;exit)
$f[y][x]=?:
d(y+1,x)
d(y,x-1)
d(y-1,x)
d(y,x+1)
$f[y][x]=' '
end
$..times{|y|x=0;$f[y].chars{|c|c==?S&&d(y,x+1);x+=1}}
