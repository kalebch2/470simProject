playPiece=function(pickupPos, dropPos)
    -- Pickup Piece
    sim.rmlMoveToPosition(target,UR3,-1,nil,nil,v,a,a,{pickupPos[1],pickupPos[2],pickupPos[3]+0.2},nil,v)
    sim.wait(0.5)
    sim.rmlMoveToPosition(target,UR3,-1,nil,nil,v,a,a,pickupPos,nil,v)
    setSuction(1)
    sim.wait(1.0)
    sim.rmlMoveToPosition(target,UR3,-1,nil,nil,v,a,a,{pickupPos[1],pickupPos[2],pickupPos[3]+0.2},nil,v)
    
    sim.rmlMoveToPosition(target,UR3,-1,nil,nil,v,a,a,{dropPos[1],dropPos[2],dropPos[3]+0.2},nil,v)
    sim.wait(0.5)
    sim.rmlMoveToPosition(target,UR3,-1,nil,nil,v,a,a,dropPos,nil,v)
    setSuction(0)
    sim.wait(1.0)
    sim.rmlMoveToPosition(target,UR3,-1,nil,nil,v,a,a,{dropPos[1],dropPos[2],dropPos[3]+0.2},nil,v)
    
    sim.rmlMoveToPosition(target,UR3,-1,nil,nil,v,a,a,home,nil,v)
    sim.switchThread()
end

setSuction=function(data)
    if data==1 then
        sim.setIntegerSignal('suctionPad#0_active',1)
    else
        sim.setIntegerSignal('suctionPad#0_active',0)
    end
end

--shakeHands=function()

--end

function sysCall_threadmain()
    UR3 = sim.getObjectHandle('UR3#0')
    target = sim.getObjectHandle('UR3_target#0')
    tip = sim.getObjectHandle('UR3_tip#0')

    ikTask1 = sim.getIkGroupHandle('UR3_undamped#0')
    ikTask2 = sim.getIkGroupHandle('UR3_damped#0')
    
    home = {0.1265, 0.1125, 0.1495}
    
    -- Game Pieces
    one = {0.4483, 0.2210, -0.0450}
    two = {0.3908, 0.2960, -0.0450}
    three = {0.3333, 0.2210, -0.0450}
    four = {0.2758, 0.2960, -0.0450}
    five = {0.2183, 0.2210,	-0.0450}
    
    -- Game Locations
    A = {0.2183,  0.1150, -0.0450}
    B = {0.3333,  0.1150, -0.0450}
    C = {0.4483,  0.1150, -0.0450}
    D = {0.2183,  0.0000, -0.0450}
    E = {0.3333,  0.0000, -0.0450}
    F = {0.4483,  0.0000, -0.0450}
    G = {0.2183, -0.1150, -0.0450}
    H = {0.3333, -0.1150, -0.0450}
    I = {0.4483, -0.1150, -0.0450}
    
    -- Linear (Velocity and Acceleration)
    v = {0.3,0.3,0.3,0.3}
    a = {10,10,10,10}
    -- Angular
    w = {math.pi*0.6,math.pi*0.6,math.pi*0.6,math.pi*0.6,math.pi*0.6,math.pi*0.6}
    y = {10,10,10,10,10,10}
    
    
    while sim.getSimulationState()~=sim.simulation_advancing_abouttostop do
    
    ----------------------Sensing Gameplay Directions-----------------------
        if sim.getIntegerSignal('UR3_piece#0') == 1 then
            piece = one
        elseif sim.getIntegerSignal('UR3_piece#0') == 2 then
            piece = two
        elseif sim.getIntegerSignal('UR3_piece#0') == 3 then
            piece = three
        elseif sim.getIntegerSignal('UR3_piece#0') == 4 then
            piece = four
        else
            piece = five
        end

        if sim.getIntegerSignal('UR3_place#0') == 1 then
            place = A
        elseif sim.getIntegerSignal('UR3_place#0') == 2 then
            place = B
        elseif sim.getIntegerSignal('UR3_place#0') == 3 then
            place = C
        elseif sim.getIntegerSignal('UR3_place#0') == 4 then
            place = D
        elseif sim.getIntegerSignal('UR3_place#0') == 5 then
            place = E
        elseif sim.getIntegerSignal('UR3_place#0') == 6 then
            place = F
        elseif sim.getIntegerSignal('UR3_place#0') == 7 then
            place = G
        elseif sim.getIntegerSignal('UR3_place#0') == 8 then
            place = H
        elseif sim.getIntegerSignal('UR3_place#0') == 9 then
            place = I
        end
    
    
    -----------------------Checking Instruction-----------------------
        if sim.getIntegerSignal('UR3_instruction#0') == 0 then 
            sim.waitForSignal('UR3_instruction#0')
        elseif sim.getIntegerSignal('UR3_instruction#0') == 1 then
            playPiece(piece, place)
        elseif sim.getIntegerSignal('UR3_instruction#0') == 2 then
            --shakeHands()
        end
    end
end