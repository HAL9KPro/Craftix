--Startup pointer
term.cear();
term.SetCursorPos(1, 1);
term.write("BOOT: Execution passed. Starting loader...")

os.run("/craftix/boot/loader.lua")
