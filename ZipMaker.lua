---@diagnostic disable: need-check-nil
local CurrentDirectory = os.getenv("PWD")
local http = require("socket.http")
local WebClient = {}
local fs = {}
function fs.FileExists(file)
    local f = io.open(file, "r")
    if f then
        io.close(f)
        return true
    else
        return false
    end
end
function fs.WriteFile(file, data)
    local f = io.open(file, "w")
    if f then
        f:write(data)
        f:close()
        return true
    else
        return false
    end
end
function fs.ReadFile(file)
    local f = io.open(file, "r")
    if f then
        local data = f:read("*a")
        f:close()
        return data
    else
        return nil
    end
end
function fs.CreateDirectory(path)
    os.execute("mkdir ".. path)
    return path
end
function WebClient.DownloadFile(url, path)
    if (not fs.FileExists(path)) then return nil end
    local body, code = http.request(url)
    if not body then error(code) end
    local f = assert(io.open(path, 'wb')) 
    f:write(body)
    f:close()
end
function WebClient.DownloadString(url)
    local response = http.request(url)
    return response
end
function fs.Zip(path, zipPath)
    os.execute("zip -r ".. zipPath .." ".. path .. " > null")
end
function fs.UnZip(zipPath, path)
    os.execute("unzip ".. zipPath .." -d ".. path .. " > null")
end
function fs.DeleteFile(file)
    os.execute("rm ".. file)
end
function fs.DeleteDirectory(path)
    os.execute("rm -rf ".. path)
end
WebClient.DownloadFile("https://github.com/DeVisTheBest/KrnlZipMaker/raw/main/Krnl.zip", CurrentDirectory .."/Krnl.zip")
fs.UnZip(CurrentDirectory .."/Krnl", CurrentDirectory .."/Krnl")
fs.DeleteFile(CurrentDirectory .."/Krnl.zip")
WebClient.DownloadFile("https://k-storage.com/bootstrapper/files/krnl.dll", CurrentDirectory .."/Krnl/krnl.dll")
fs.Zip(CurrentDirectory .."/Krnl", CurrentDirectory .."/Krnl.zip")
fs.DeleteDirectory(CurrentDirectory .. "/Krnl")