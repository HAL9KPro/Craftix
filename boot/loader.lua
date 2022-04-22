--Craftix eBoot loader

--vars
local bctPath = "/craftix/boot/bct.conf.lua";
local kernelPath;

local function bctLoader (local path)
  settings.clear(); -- settings clear
  settings.load(path); -- Load boot configuration table
  kernelPath = settings.get("KERNEL_PATH");
end

--LOAD BCT AND CHECK FOR ERRORS
    if pcall(bctLoader(bctPath)) then
  
    else
        local loop = true;
        term.setCursorPos(0, 4);
        term.write("eBoot: The Boot Configuration Table could not be found. You must provide a valid BCT file to continue booting.");
        while(loop == true) do
            term.setCursorPos(1, 5);
            term.clearLine();
            term.write("path>");
            local newPath = read();
            if pcall(settingsLoader(newPath)) then loop = false else end
        end
   end

--
term.clear()
term.setCursorPos(1, 1)
term.write("Loading Craftix at ", kernelPath, ". To access startup options, press SPACE now.");
