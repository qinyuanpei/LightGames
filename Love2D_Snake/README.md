# Love2D_Snake

使用Love2D引擎编写的贪吃蛇小游戏

## 核心算法
```Lua
--计算下一个目标点
function getNextPoint()
  --计算下一个目标点
  snake={}
  if(dir==0) then
    snake.x=snakes[1].x
    snake.y=snakes[1].y-20
  end
  if(dir==1) then
    snake.x=snakes[1].x
    snake.y=snakes[1].y+20
  end
  if(dir==2) then
    snake.x=snakes[1].x-20
    snake.y=snakes[1].y
  end
  if(dir==3) then
    snake.x=snakes[1].x+20
    snake.y=snakes[1].y
  end

  return snake
end
```

###蛇的移动

使用getNextPoint()方法计算下一个目标点，并将该位置添加到蛇的头部，同时移除最后一个元素。

###食物判定

使用getNextPoint()方法计算下一个目标点，并将该位置和食物的位置进行比较，如果相同，则将该位置添加到头部，保留最后一个元素，否则按移动来处理。

## 游戏截图

![游戏界面](http://pic.conn.cc/bs.png)
![游戏结束](http://pic.conn.cc/Zr.png)

##Bugs

如何能让蛇沿着格子移动且降低其移动速度？
