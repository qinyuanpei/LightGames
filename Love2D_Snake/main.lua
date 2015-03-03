--定义窗口宽度和高度
local w=640
local h=640
--定义网格单元大小
local unitSize=20;

--方块的初始位置
local initX=320
local initY=320

--移动方向
local dir=1

--贪吃蛇集合
local snakes={}

--食物状态
--WaitToEat：绘制食物
--BeEated：随机生成食物
local foodState="WaitToEat"

--游戏状态
--0：游戏结束
--1：游戏正常
local gameState=1

--食物的位置
local foodX=0
local foodY=0

--Love2D加载事件
function love.load()
  --设置窗口标题
  love.window.setTitle("Love2D-贪吃蛇游戏")
  --设置窗口大小
  love.window.setMode(w,h)
  --定义字体
  myFont=love.graphics.newFont(30)
  --设置字体
  love.graphics.setFont(myFont)
  --设置背景色
  love.graphics.setBackgroundColor(255,255,255,255)
  --设置线条类型为平滑
  love.graphics.setLineStyle("smooth")
  --设置线宽
  love.graphics.setLineWidth(0.1)

  --蛇的初始化(蛇的长度为5)
  for i=1,5 do
    snake={}
    snake.x=initX +(i-1) * 20
    snake.y=initY
    snakes[i]=snake
  end

  --食物初始化
  foodX=love.math.random(32-1)*20
  foodY=love.math.random(32-1)*20
end


--Love2D绘制事件
function love.draw()
  --绘制竖线
  love.graphics.setColor(0,0,0,255)
  for i=0,w,unitSize do
    love.graphics.line(0,i,h,i)
  end
  --绘制横线
  for j=0,h,unitSize do
    love.graphics.line(j,0,j,w)
  end

  --绘制蛇
  for i=1,table.maxn(snakes) do
    love.graphics.setColor(0,0,255,255)
    love.graphics.rectangle("fill",snakes[i].x,snakes[i].y,20,20)
  end

  --绘制食物
  if(foodState=="WaitToEat") then
    love.graphics.setColor(255,0,0,255)
    love.graphics.rectangle("fill",foodX,foodY,20,20)
  end

  --如果游戏结束则显示GameOver
  if(gameState==0) then
    love.graphics.setColor(255,0,0,255)
    love.graphics.print("Game Over",250,300)
  end
end 

--
function love.update(dt)
  --判断游戏状态
  if(snakes[1].x<=0 or snakes[1].x>=640 or snakes[1].y<=0 or snakes[1].y>=640) then
    gameState=0
  else
    gameState=1
  end

  --如果游戏状态为正常
  if(gameState==1) then
    SnakeUpdate()
    FoodUpdate()
  end
end

--核心算法——蛇的移动
function SnakeUpdate()
  --获取元素个数
  local n=table.maxn(snakes)
  if(table.maxn(snakes)>0) then
    if(getNextPoint().x==foodX and getNextPoint().y==foodY) then
      --将下一个目标点的位置插入表中
      table.insert(snakes, 1, getNextPoint())
      --将食物状态设置为BeEated
      foodState="BeEated"
    else
      --将下一个目标点的位置插入表中
      table.insert(snakes, 1, getNextPoint())
      --移除最后一个元素
      table.remove(snakes,n+1)
    end 
  end
end

--随机生成食物
function FoodUpdate()
  --如果食物被蛇吃掉则重新生成食物
  if(foodState=="BeEated") then
    foodX=love.math.random(32-1)*20
    foodY=love.math.random(32-1)*20
    foodState="WaitToEat"
   end
end

--根据玩家按下的键位定义不同的方向
function love.keypressed(key)
  if(key=="a") then 
    dir=2
  end
  if(key=="d") then 
    dir=3
  end
  if(key=="w") then 
    dir=0
  end
  if(key=="s") then 
    dir=1
  end
end

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


