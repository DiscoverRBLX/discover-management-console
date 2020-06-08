-- The spinner.
-- Since for WHATEVER reason adding this to the main core script doesn't work correctly. :sob:
BF = script.Parent
		repeat 
				wait(1/44) 
				local bg = BF
				bg.cframe = bg.cframe * CFrame.Angles(0,math.rad(30),0)
					until not bg