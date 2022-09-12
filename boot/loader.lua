--Craftix eBoot loader

--vars
local bctPath = "/craftix/boot/ebcfg.ect";
local kernelPath;

local function bctLoader (local path)
  settings.clear(); -- settings clear
  settings.load(path); -- Load boot configuration table
  kernelPath = settings.get("KERNEL_PATH");
end

local function kldLoader (local path)
  
  os.run(path)
  
end

local function terminateCatch () --catch termination
    while true do
        local event = os.pullEventRaw();
        if event == "terminate" then else end
    end
end
  
  
 --boot command functions
  

--LOAD BCT AND CHECK FOR ERRORS

local function boot() 
    if pcall(bctLoader(bctPath)) then
  
    else
        local loop = true;
        term.setCursorPos(0, 4);
        term.write("BOOT: Invalid boot configuration table. Type a valid BCT path, or type 'reboot' to reboot the system.");
        while(loop == true) do
            term.setCursorPos(1, 5);
            term.clearLine();
            term.write("path>");
            local newPath = read();
    
            if newPath = "reboot" then
              os.reboot();
      
            elseif pcall(bctLoader(newPath)) then loop = false 
    
            else 
              term.write("invalid path!");
              sleep(3)
            end
    
        end
   end
  
  term.clear()
term.setCursorPos(1, 1)
term.write("Loading Craftix at ", kernelPath, "...");

if pcall(kldLoader(kernelPath)) then
  
else
 
term.setCursorPos(1, 2)
term.write("BOOT: Couldn't load the Craftix kernel. System halted.");
end
end
--
parallel.WaitForAll(boot, terminateCatch)


