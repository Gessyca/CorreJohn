local composer = require("composer")
local scene = composer.newScene()
--Variaveis
local origemx = display.contentWidth
local origemy = display.contentHeight
local meiox = display.contentCenterX
local  meioy = display.contentCenterY

--Imagem de background
local background = display.newImage("background.png")

gameOver = display.newImage("gameover.png",meiox,meioy)
gameOver:scale(.15,.15)
playButton = display.newImage("play.png",meiox - 230,meioy + 110);
playButton:scale(.14,.14);

menu = display.newImage("menu.png", meiox + 230, meioy + 110)
menu:scale(.14,.14);

function scene:createScene(event)
			local scenegroup = self.view;
			scene.view:insert(background);
			scene.view:insert(gameOver);
			scene.view:insert(menu);
			scene.view:insert(playButton);	
end

function irParaMenu(event)
pontuacao = 150
composer.gotoScene("menu")
display.remove(menu)
display.remove(background)
display.remove(gameOver)
display.remove(playButton)
end

function irParaGame(event)
pontuacao = 150
composer.gotoScene("game")
display.remove(menu)
display.remove(background)
display.remove(gameOver)
display.remove(playButton)
end

function moverBotaoMenu()
				transition.to ( menu, {time = 1000 ,xScale=0.1 , yScale=0.1, onComplete =move} )
			end
			function move()
				transition.to ( menu, {time = 1000 ,xScale=0.15 , yScale=0.15, onComplete =moverBotaoMenu} )
			end
			
function moverBotaoPlay()
		transition.to ( playButton, {time = 1000 ,xScale=0.1 , yScale=0.1, onComplete =movePlay} )
end
function movePlay()
		transition.to ( playButton, {time = 1000 ,xScale=0.15 , yScale=0.15, onComplete =moverBotaoPlay} )
end

function scene:show( event )
    local sceneGroup = self.view
	local phase = event.phase
	composer.removeScene("game")
	composer.removeScene("menu")
	if (phase == "will") then		
	elseif (phase == "did") then
	menu:addEventListener( "tap", irParaMenu )
	playButton:addEventListener( "tap", irParaGame )
	moverBotaoMenu()
	moverBotaoPlay()
	end
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
	if (phase == "will") then
	transition.cancel(menu)
	transition.cancel(playButton)
	playButton:removeEventListener( "tap", irParaGame )
	end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
			
return scene