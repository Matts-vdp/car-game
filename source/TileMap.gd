extends TileMap

export var length = 4
var curlen = 0
var pos = Vector2()
var prev = Vector2()
var prevc = ''
var options = ['l','r','u','d'] # used for random direction selection
var optd = {'l':Vector2(-1,0), 'r':Vector2(1,0), 'u':Vector2(0,-1), 'd':Vector2(0,1)}
var c = ''
var l = []
var end = null


func _ready():
    randomize()
    prev = pos
    prevc = 'u'
    set_cell(pos.x,pos.y,0)
    pos += Vector2(0,-1)
    makestreet()
    
# generates a random street path that stops when len is reached or it runs into itself
func makestreet():
    curlen =1
    while curlen < length:
        while true:
            l = getoptions(prevc)
            if l == []:
                break
            c = l[randi() % l.size()]
            if not (pos+optd[c] == prev):
                break
        if l == []:
            break
        setblock(c, prevc, pos)
        curlen += 1
        prev = pos
        prevc = c
        pos += optd[c]
    set_cell(pos.x, pos.y, 2)
    end = pos
        
# finds all next possible options without going onto a previous track
func getoptions(prevc):
    var li = []
    var v
    for i in options:
        v = pos+optd[i]
        if get_cell(v.x, v.y) == -1:
            li.append(i)
    return li


# converts the chosen direction into the right tile of the tileset

#straight up
#set_cell(0,0,0, false, false, false)
#straith side
#set_cell(0,0,0, false, false, true)
#curve down to right
#set_cell(0,0,1, false, false, false)
#curve down left
#set_cell(0,0,1, true, false, false)
#curve up right
#set_cell(0,0,1, false, true, false)
#curve up left
#set_cell(0,0,1, true, true, false)

func setblock(c, prevc, pos):
    if (c=='u' && prevc=='u')||(c=='d'&&prevc=='d'):
        set_cell(pos.x,pos.y,0, false, false, false)
    elif (c=='l' && prevc=='l')||(c=='r'&&prevc=='r'):
        set_cell(pos.x,pos.y,0, false, false, true)
    elif (prevc=='l' && c=='d')||(prevc=='u' && c=='r'):
        set_cell(pos.x,pos.y,1, false, false, false)
    elif (prevc=='r' && c=='d')||(prevc=='u' && c=='l'):
        set_cell(pos.x,pos.y,1, true, false, false)
    elif (prevc=='d' && c=='r')||(prevc=='l' && c=='u'):
        set_cell(pos.x,pos.y,1, false, true, false)
    elif (prevc=='d' && c=='l')||(prevc=='r' && c=='u'):
        set_cell(pos.x,pos.y,1, true, true, false)
