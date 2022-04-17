--Craftix Kickstarter

--Define variables
local bctPath = "/craftix/boot/boot.conf";
local loaderPath;
--Define settings loader

function settingsLoader (local path)
  settings.clear(); -- settings clear
  settings.load(path); -- Load boot configuration table
  loaderPath = settings.get("LOADER_PATH");
end


--

function bootLoader (local path)
  term.clear();
  term.write("Craftix Kickstarter");
  os.run({}, path); --Load the bootloader
end



if pcall bootLoader(loaderPath) then
  
else
  local loop = true;
  term.setCursorPos(0, 4);
  term.write("FATAL: The loader image pointed to by the BCT is not valid. To start Craftix, you will need to provide a valid loader image.");
  while(loop == true) do
    term.setCursorPos(0, 5);
    term.clearLine();
    term.write("path>");
    local newPath = read();
    if pcall bootLoader(newPath) then loop = false else end
  end
end
    

