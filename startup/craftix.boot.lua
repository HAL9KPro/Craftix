--Craftix eBoot Kickstarter

--Define variables
local version = 0.1
local bctPath = "/craftix/boot/bct.conf.lua";
local loaderPath;


--Define settings loader

local function bctLoader (path)
  settings.clear(); -- settings clear
  settings.load(path); -- Load boot configuration table
  loaderPath = settings.get("LOADER_PATH");
end


--Define bootloader loader

local function bootLoader (path)
  term.clear();
  os.run({}, path); --Load the bootloader
end




local function terminateCatch () --catch termination
    while true do
        local event = os.pullEventRaw();
        if event == "terminate" then else end
    end
end


local function boot () --Boot function

    term.clear();
    term.setCursorPos(1, 1);
    term.write("Welcome to Craftix eBoot!");

    --LOAD BCT AND CHECK FOR ERRORS
    if pcall(bctLoader(bctPath)) then
    
    else
        local loop = true;
        term.setCursorPos(0, 4);
        term.write("BOOT: The Boot Configuration Table could not be found. You must provide a valid BCT file to continue booting.");
        while(loop == true) do
            term.setCursorPos(1, 5);
            term.clearLine();
            term.write("path>");
            local newPath = read();
            if pcall(settingsLoader(newPath)) then loop = false else end
        end
   end


    if pcall(bootLoader(loaderPath)) then
  
    else
        local loop = true;
        term.setCursorPos(0, 4);
        term.write("BOOT: The eBoot Loader could not be found. You will need to provide a valid loader image to continue booting.");
        while(loop == true) do
            term.setCursorPos(0, 5);
            term.clearLine();
            term.write("path>");
            local newPath = read();
            if pcall(bootLoader(newPath)) then loop = false else end
        end
   end
end


parallel.waitForAny(boot, terminateCatch); --Execute the boot and terminate catcher


    

