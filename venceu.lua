local composer = require("composer")
local scene = composer.newScene()
--Variaveis
local origemx = display.contentWidth
local origemy = display.contentHeight
local meiox = display.contentCenterX
local  meioy = display.contentCenterY

--Imagem de background
local background = display.newImage("background.png")

local voceVenceu = display.newImage("venceu.png",meiox,meioy - 50)
voceVenceu:scale(.14,.14)

playButton = display.newImage("play.png",meiox - 230,meioy + 110);
playButton:scale(.14,.14);
botao = audio.loadSound('sons/botao.mp3');
menu = display.newImage("menu.png", meiox + 230, meioy + 110)
menu:scale(.14,.14);

local hotDog = display.newImage("comidas/s2.png")
hotDog.alpha = 0
hotDog:scale(.05,.05)

local sorvete = display.newImage("comidas/s3.png")
sorvete.alpha = 0
sorvete:scale(.1,.1)

local bolo = display.newImage("comidas/s5.png")
bolo.alpha = 0
bolo:scale(.02,.02)

function scene:createScene(event)
			local scenegroup = self.view;
			scene.view:insert(background);
			scene.view:insert(voceVenceu);
			scene.view:insert(menu);
			scene.view:insert(playButton);
				alimentos:insert( cerveja )
	alimentos:insert( hotDog )
	alimentos:insert( sorvete )
	alimentos:insert( bolo )
end

function mostrarAlimentos(event)
	hotDog.x = 0
	hotDog.alpha=1
	hotDog.y = meioy-110
	transition.to( hotDog, {time = 5000, x = origemx*2, y = hotDog.y})
	sorvete.x = origemx*2
	sorvete.alpha=1
	sorvete.y = meioy-20
	transition.to( sorvete, {time = 5000, x = 0, y = sorvete.y})
	bolo.x = 0
	bolo.alpha=1
	bolo.y = meioy+50
	transition.to( bolo, {time = 5000, x = origemx*2, y = bolo.y})
end

function irParaMenu(event)
audio.play(botao);
pontuacao = 150
composer.gotoScene("menu")
display.remove(menu)
display.remove(background)
display.remove(voceVenceu)
display.remove(playButton)
display.remove(sorvete)
display.remove(bolo)
display.remove(hotDog)
end

function irParaGame(event)
audio.play(botao);
pontuacao = 150
composer.gotoScene("game")
display.remove(menu)
display.remove(background)
display.remove(voceVenceu)
display.remove(playButton)
display.remove(sorvete)
display.remove(bolo)
display.remove(hotDog)
end
local tm
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
	if (phase == "will") then		
	elseif (phase == "did") then
	menu:addEventListener( "tap", irParaMenu )
	playButton:addEventListener( "tap", irParaGame )
	tm = timer.performWithDelay( 5000,mostrarAlimentos ,0)
	moverBotaoMenu()
	moverBotaoPlay()
	end
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
	if (phase == "will") then
	timer.cancel(tm)
	transition.cancel(menu)
	transition.cancel(playButton)
	playButton:removeEventListener( "tap", irParaGame )
	menu:removeEventListener( "tap", irParaMenu )
	end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
			
return scene