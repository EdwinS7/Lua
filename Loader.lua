-- This note is here because github is being retarded and wouldn't update the raw file!

local LoadScript = function(source_code, whitelist_key)
    whitelist_key = whitelist_key or "nono dont touch me there, thats thats, my nono square!!"

    local Script = string.format([[
        if not getrenv().shared.require then
            return
        end
        
        script_key = '%s';
    ]], whitelist_key) .. source_code

    local GetActors = getactorthreads or getdeletedactors or getactors
    local RunOnParallel = run_on_actor or run_on_thread

    if GetActors and #GetActors() > 0 then
        for _, actor in GetActors() do
            RunOnParallel(actor, Script)
        end
    end
end

return LoadScript
