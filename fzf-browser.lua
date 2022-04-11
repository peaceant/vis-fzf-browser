local module = {}
module.fzf_browser_path = 'echo "..\n$(ls -Ap)" | fzf'
module.fzf_browser_args = ""

local cwd = ""
local function remember_cwd()
    local handle = io.popen("pwd")
    local output = handle:read()
    handle:close()
    cwd = output
end

local function is_dir(path)
    return path:sub(-1) == "/" or path == ".."
end

local function browse(argv, dir)
    local command = module.fzf_browser_path .. " " .. module.fzf_browser_args .. " " .. table.concat(argv, " ")
    local file = io.popen(command)
    local output = file:read()
    local success, msg, status = file:close()

    if status == 0 then 
        if is_dir(output) then
            -- change directory
            vis:command(string.format("cd %s", output))
            vis:feedkeys("<vis-redraw>")
            browse(argv, output)
            return true
        end
        vis:command(string.format("e '%s'", output))
    elseif status == 1 then
        vis:info(string.format("fzf-browser: No match. Command %s exited with return value %i." , command, status))
    elseif status == 2 then
        vis:info(string.format("fzf-browser: Error. Command %s exited with return value %i." , command, status))
    elseif status == 130 then
        vis:info(string.format("fzf-browser: Interrupted. Command %s exited with return value %i" , command, status))
    else
        vis:info(string.format("fzf-browser: Unknown exit status %i. command %s exited with return value %i" , status, command, status, status))
    end

    -- reset cwd
    vis:command(string.format("cd %s", cwd))

    vis:feedkeys("<vis-redraw>")
end

vis:command_register("fzfbrowser", function(argv, force, win, selection, range)
    remember_cwd()
    browse(argv, ".")
    return true;
end)

return module
