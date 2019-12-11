function onMouseEvent(ui,id,type,flags,x,y)
    local evt=(type==simUI.mouse.left_button_down and 'down' or 'up')
    
    
    if x >= 145 and x <= 195 and y >= 140 and y <= 190 then 
        sim.setIntegerSignal('play',1)
        play = 1
    elseif x >= 230 and x <= 280 and y >= 140 and y <= 190 then 
        sim.setIntegerSignal('play',2)
        play = 2
    elseif x >= 318 and x <= 368 and y >= 140 and y <= 190 then 
        sim.setIntegerSignal('play',3)
        play = 3
    elseif x >= 145 and x <= 195 and y >= 225 and y <= 275 then 
        sim.setIntegerSignal('play',4)
        play = 4
    elseif x >= 230 and x <= 280 and y >= 225 and y <= 275 then 
        sim.setIntegerSignal('play',5)
        play = 5
    elseif x >= 318 and x <= 368 and y >= 225 and y <= 275 then 
        sim.setIntegerSignal('play',6)
        play = 6
    elseif x >= 145 and x <= 195 and y >= 315 and y <= 365 then 
        sim.setIntegerSignal('play',7)
        play = 7
    elseif x >= 230 and x <= 280 and y >= 315 and y <= 365 then 
        sim.setIntegerSignal('play',8)
        play = 8
    elseif x >= 318 and x <= 368 and y >= 315 and y <= 365 then 
        sim.setIntegerSignal('play',9)
        play = 9
    end
    
    turn = sim.getIntegerSignal('turn')
    
    if turn == 0 then 
        simUI.setLabelText(ui,1000,'Orange clicked location '..play)
    else
        simUI.setLabelText(ui,1000,'Blue clicked location '..play)
    end
    
end

function sysCall_init()
    xml = [[
    <ui closeable="true" on-close="closeEventHandler" resizable="true">
        <label text="Let's play Tic-Tac-Toe" id="1000" wordwrap="true"/>
        <group>
                <label text="Whose turn is it?." wordwrap="true" />
                <radiobutton text="Orange" id="1001" />
                <radiobutton text="Blue" id="1002" />
        </group>
        <image id="5007"
            on-mouse-up="onMouseEvent"
             />/>
        
    </ui>
    ]]
    ui=simUI.create(xml)
    simUI.setTitle(ui, 'ECE 470: Tic-Tac-Toe')
    simUI.setPosition(ui, 1620, 1280)
    simUI.setRadiobuttonValue(ui,1001,0)
    simUI.setRadiobuttonValue(ui,1002,0)
    simUI.setEnabled(ui,1001,false)
    simUI.setEnabled(ui,1002,false)
end

function sysCall_actuation()
    if turn == 0 then 
        simUI.setRadiobuttonValue(ui,1001,1)
    elseif turn == 1 then
        simUI.setRadiobuttonValue(ui,1002,1)
    end
    
    if index == 9 then
        simUI.setLabelText(ui,1000,'Game over! U R gr3at!')
    end
end

function sysCall_sensing()
    s=sim.getObjectHandle("sens")
    img,x,y=sim.getVisionSensorCharImage(s)
    simUI.setImageData(ui,5007,img,x,y)
    
    turn = sim.getIntegerSignal('turn')
end

function sysCall_cleanup()
    simUI.destroy(ui)
end
